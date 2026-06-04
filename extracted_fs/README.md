# Embedded filesystem (`extracted_fs/`)

The boot ROM carries a small in-ROM filesystem (a directory at file offset `0xB4`)
holding five members, extracted here with `MANIFEST.json`. The three `.EXE` files
are genuine MS-DOS **MZ executables** that the boot kernel loads and runs via its
`INT 21h` (DOS-style) + `INT 40h` (terminal/comm) service interface.

## Members

| File | What it is / does |
|------|-------------------|
| `MFGTEST.EXE` | **Manufacturing self-test.** Initialises the Zilog Z8530 SCC (a loopback self-test) at I/O `0x300-0x303`, programs and reads back the 80C188EB timers / PCB I/O ports, computes a ROM checksum, and checks keyboard and video; prints status via `INT 10h`/`INT 21h`. Carries the keyboard scancode tables and the setup-menu UI string as data. |
| `EMULATOR.EXE` | **The boot ROM's built-in terminal / display engine (v0.177).** Fetches display "records" from the host via `INT 40h` and paints them into dual-plane VRAM (character + attribute planes), honouring 80/132-column mode; draws screen test patterns; handles keyboard (`INT 16h`) and printer (`INT 17h`). This is *not* the production T 27 / VT220 personality — those live in the 256 KiB main flash. |
| `DOWNLOAD.EXE` | **Serial file-download utility** ("File Transfer v0.3"). An XMODEM-style *receiver*: allocates a ~240 KiB RAM staging buffer (`INT 21h AH=48h`), runs a block-protocol receive loop over the serial line via `INT 40h` (the other end is a host PC running an XMODEM *send*), and shows a live "Blocks/Bytes Received" status screen. It stages the file in RAM; it does not itself program flash. |
| `CONFIG.BLK` | 856-byte binary configuration block (not an executable). |
| `CONFIG.SYS` | A single `0x1A` byte (DOS EOF marker) — effectively empty. |

## Disassembly views (per `.EXE`)

For each module there are three views; **read the `.labeled.asm`** — it is the
human-readable one:

- `NAME.asm` — MZ header parsed + straight linear disassembly of the load module.
- `NAME.full.asm` — code/data separated (strings and tables shown as hex, not
  mis-decoded as instructions).
- `NAME.labeled.asm` — **the annotated view.** Starts with a header explaining the
  module's purpose; has symbolic labels at call/jump targets; inline comments
  decode every `INT 21h`/`INT 40h`/`INT 10h/16h/17h` call by function and every
  serial/video port access by device/register (and, in MFGTEST, the Z8530 WR-register
  init sequence); and `;>>>>` lines are cross-verified per-instruction notes.

Addresses in the disassemblies are **MZ load-module offsets** (the 512-byte MZ
header is stripped); entry is at offset `0x0000`.
