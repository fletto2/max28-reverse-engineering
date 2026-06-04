# Writing a custom boot ROM for the LT300 / Link MAX28 SBC

A practical, human-facing guide to building and running your own code on the
80C188EB single-board computer inside this terminal. It uses the `flashdump.asm`
dumper in this directory as the worked example. Everything here is grounded in
the reverse-engineering in `CLAUDE.md` / `KERNEL_API.md`.

> SAFETY FIRST: the boot ROM is a **socketed DIP-28 27C512**. Before anything,
> **read out and archive the original** (you already have `M27C512@DIP28.BIN`).
> A custom boot ROM that only *reads* the flash and talks serial cannot brick the
> machine — pop the original back in to restore. Don't write the flash unless you
> mean to.

---

## 1. What you need

- **Assembler:** NASM (`nasm -f bin`). Any 16-bit x86 assembler works; examples
  here are NASM syntax.
- **EPROM programmer + blank parts:** a 27C512 / 27SF512 / 28C512 (64 KiB, DIP-28,
  pin-compatible with the original M27C512). A cheap TL866-class programmer is fine.
- **Serial capture:** a PC with a real or USB RS-232 port and a terminal program
  that can log to a file (minicom, PuTTY, `cu`, TeraTerm). Wire it to **AUX SERIAL**
  (that is the async port; the DATA-U ports are the synchronous T27 host link).
- **The original ROM image** (backup + reference for the init sequence).
- Optional but recommended: a **logic analyzer / scope** for serial baud, and
  `srec_cat` (the SRecord tools) for converting/merging S-records on the host.

---

## 2. The hardware you are programming

- **CPU:** Intel **80C188EB** (16-bit core, 8-bit external bus, real mode).
- **ROM:** 64 KiB at physical **0xF0000-0xFFFFF** (your code).
- **RAM:** 256 KiB DRAM at **0x00000-0x7FFFF** (needs the refresh controller running
  before you rely on it — e.g. for a stack).
- **Flash:** two 28F001 at **0x80000-0xBFFFF** (the main app; read-array by default).
- **Peripherals (I/O ports):** Z8530 SCC serial at **0x300-0x303**, the OKI M76V020
  video/keyboard gate array at **0x340-0x343**, and the 80C188EB on-chip PCB at
  **0xFF00-0xFFFF** (chip-selects, timers, interrupt unit). See CLAUDE.md tables.

---

## 3. The two things that make ROM code different from a DOS .EXE

**(a) Reset and the "only the top of ROM is mapped" rule.**
On power-up the CPU jumps to physical **0xFFFF0** and starts executing. But the
80C188EB only maps a small **upper chip-select (UCS) window** (~top 1 KiB) at reset.
The *rest* of your ROM is invisible until you program UCS. So a ROM must be built in
two stages, exactly like the stock firmware:

```
reset vector @0xFFF0  ->  JMP FFE0:0000          (5 bytes: EA 00 00 E0 FF)
init stub     @0xFE00  ->  program chip-selects   (runs from the reset-mapped top)
                           then JMP F000:0000      (far jump to the main body)
main body     @0x0000  ->  everything else        (now mapped, CS=0xF000)
```

Put your small init stub in the top region (file `0xFE00-0xFFEF`), and the bulk of
your code lower in the ROM (file `0x0000+`). The init stub's only job is to bring up
the chip-selects (and DRAM refresh) so the rest becomes reachable, then far-jump to it.

**(b) Segments and addressing — get this wrong and it crashes silently.**
There is no loader to relocate you. Pick a fixed `CS` per region and make your
labels match. The clean trick used in `flashdump.asm`:

- Assemble the **main body with `org 0`** and enter it as `F000:0000`. Then a label's
  file offset == its IP offset (because `CS=0xF000` has base = file 0). `mov si,msg`
  and relative `call`/`jmp` all just work, and `DS=CS=0xF000` makes `[si]` resolve.
- The init stub runs as `CS=0xFFE0` (file 0xFE00). Keep it tiny and use **only
  immediates, far jumps, and relative branches** there — no absolute data loads —
  so you don't fight the segment base.
- Relative `call`/`jmp` are position-independent (the encoded delta is correct
  regardless of base). Only **absolute** loads (`mov reg, label`) and far jumps care
  about the base. This is the single most common ROM bug.

---

## 4. Bringing up the hardware (in the init stub)

Copy the **stock chip-select OUT stream verbatim** — it is proven to boot this exact
board. Each register is written as `mov ax,VALUE ; out dx,al` (the on-chip PCB latches
the full 16-bit AX even on a byte `out`):

- **UCS** (`0xFFA4/A6`) — expands the ROM window so low ROM becomes visible.
- **LCS** (`0xFFA0/A2`) — DRAM at 0.
- **GCS0/1** (`0xFF80-86`) — the flash window `0x80000-0xBFFFF`.
- **GCS I/O windows** (`0xFF90-96`) — decode the `0x300` SCC and `0x340` video. **You
  must set these or your peripherals won't answer.**
- **Refresh** (`0xFFB0-B4`) — required before you use DRAM (e.g. a stack).
- **Timers** (`0xFF54-66`) — among other things the serial baud clock source.

(The exact values are in `flashdump.asm` and in CLAUDE.md's boot-flow section.)
Then set a stack in DRAM (`SS:SP = 0000:FFFE`) and far-jump to the main body.

---

## 5. Talking to the world

You have three output paths; pick by what you can capture:

- **Serial (Z8530 SCC) — recommended.** Async 8N1 TX, register values
  (datasheet-verified): `WR9=0xC0` reset, then `WR4=0x44` (x16 clk, 1 stop, no
  parity), `WR3=0xC1` (Rx 8-bit+enable), `WR5=0x68` (Tx 8-bit+enable), `WR11=0x00`
  (clock from the external RTxC pin), `WR14=0x00`. Write a register by sending its
  number then its value to the channel **control** port (`0x301` or `0x303`).
  Transmit: poll **RR0 bit 2** (Tx buffer empty) on the control port, then write the
  **data** port (`0x300`/`0x302`). The two channels are A/B; which one is AUX SERIAL
  is uncertain, so init and send on **both**.
  - **THE GOTCHA — baud.** The SCC is clocked externally (RTxC) from a timer off the
    single **49.423 MHz** crystal, so the exact bit rate isn't obvious from software.
    Target is **9600 8N1**. De-risk it: emit a long **`0x55` ('U') preamble** first —
    `0x55` is a perfect alternating bit pattern, so you can lock the host baud or
    measure the bit period on a scope before the real data. This is the one part not
    guaranteed first-try; everything else is deterministic.
- **Video (M76V020):** write characters to VRAM at `0xC0000` (char plane) and
  `0xC0000-0x8000` for the attribute plane; control via port `0x343`. Useful for a
  visible heartbeat even when serial is silent.
- **Parallel printer port:** no baud to guess, but you need a parallel capture rig.

For dumping data, format **Motorola S-records** (`S0` header, `S2` 24-bit-address
data, `S8` terminator; byte-count and one's-complement checksum) — or just emit raw
bytes and convert on the host with `srec_cat`. Simpler is more reliable.

---

## 6. Build, burn, run

```
nasm -f bin flashdump.asm -o flashdump.bin     # must be exactly 65536 bytes
wc -c flashdump.bin                            # verify 65536
```
Burn `flashdump.bin` to the blank 27C512, **note which way the original sat**, power
the terminal off, swap the ROM, power on. Watch for the **video heartbeat** (proof it
booted) and capture **AUX SERIAL**. Convert the capture:
```
srec_cat capture.s19 -o flash.bin -binary                 # image @0x80000
srec_cat capture.s19 -offset -0x80000 -o flash.bin -binary # 0-based 256 KiB
```
When done, **put the original ROM back**.

---

## 7. Debugging without JTAG (you're flying blind, so build in feedback)

- **Heartbeat:** drive port `0x343` at start, between phases, and at completion, so
  the screen tells you which stage reached. (flashdump.asm flickers it per 64 KiB block.)
- **Calibration preamble:** the `0x55` burst lets you fix baud empirically.
- **Validate the logic in an emulator first.** A *full* machine emulator is not worth
  it (the M76V020 is an undocumented custom gate array). But a tiny harness — an
  80188 core (Unicorn Engine, ~80 lines, or MAME's `i80188`) + a stub that hooks the
  SCC data-port writes and presents a synthetic 256 KiB blob at `0x80000` — will
  verify your addressing, loops, and S-record checksums before you burn anything. It
  cannot verify the serial *baud* (that's physical), which is why the preamble exists.
- **Iterate cheaply:** use an erasable/flash EPROM so a re-burn is minutes.

---

## 8. Pitfall checklist (the bugs that actually bite)

1. **Code doesn't fit above 0xFE00.** Only ~496 bytes sit between the init entry and
   the reset vector — put the bulk at file 0x0000 and far-jump to it.
2. **Jumping to low ROM before programming UCS** — it isn't mapped yet at reset.
3. **Absolute `mov reg,label` with the wrong segment base** — use `org 0` + `CS=0xF000`
   for the main body, or subtract the base; relative branches are fine either way.
4. **Using DRAM (a stack) before enabling refresh.**
5. **Forgetting the GCS I/O windows** — then the SCC/video silently don't decode.
6. **Z8530: writing a register value without first writing its pointer**, or polling
   the wrong RR0 bit.
7. **A subroutine clobbering a caller's loop counter** (e.g. using `CX` inside a hex
   formatter called from a `loop`). Pick your scratch registers deliberately.
8. **Output image not exactly 65536 bytes** — pad with `times (0x10000-($-$$)) db 0xFF`.

---

## 9. Going further: running code *under* the kernel instead of replacing it

If you don't want to replace the boot ROM, the machine also runs MS-DOS **MZ `.EXE`**
modules via the kernel's `INT 21h AH=4Bh` EXEC, built against `INT 21h` (DOS-style) +
`INT 40h` (the terminal kernel API — see `KERNEL_API.md`) + `INT 10h/16h/17h`. Writing
such a module is easier (no chip-select/reset dance — the kernel set all that up), but
*getting it loaded/run* requires installing it into the flash filesystem, which needs
the flash dump first. That's the circular dependency the custom boot ROM breaks:
**dump the flash → understand the FS → then you can add and autorun modules.**
