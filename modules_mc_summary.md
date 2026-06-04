# LT300 / UT200 Terminal Firmware — Embedded Module Analysis Summary

Three embedded MZ executables run by the resident kernel on the LT300/UT200 terminal (Intel 80C188EB, real-mode x86). Hardware: Zilog Z8530 SCC @0x300-0x303 (synchronous host link), OKI M76V020 gate array (dual-plane VRAM, char plane / attribute plane 0x8000 apart), kernel API via INT 40h.

---

## MFGTEST.EXE — Manufacturing self-test (77 findings)

**What it does:** Power-on/diagnostic self-test. After the standard MZ startup (resize at `0x19`), it builds a version/ID string, runs a top-level self-test dispatcher (`0x99`), exercises every subsystem, and renders a result-indicator grid on the setup-menu screen.

**Most confident findings:**
- **Version/ID string build (`0x1B`–`0x4C`):** reads config byte `[0x13f]`, calls INT 40h AH=0x1E then AH=0x26, and converts results to ASCII via repeated `idiv dh` (DH=10) into `[0x19f..0x1a1]`/`[0x19d]`.
- **ROM checksum self-test (`0x5B`–`0x97`):** 16-bit additive sum (LODSB) over 0x1000-byte banks to BX=0xE000, compared at `0x7F` (`cmp cx,dx`), then rendered as 4 hex digits via the nibble table at `[0x185]`.
- **SCC (Z8530) tests** dominate `0x1A5`–`0x4DD`: WR0..WR15 init burst via helper `0xeb5` (`out reg; xchg; out data`); write/read-back integrity loop (triple-OUT bus-settle + IN, sum compared to `0x78` at `0x211`); RR0 status polls via helper `0xeba`; per-test failures recorded into strided error masks `[0x4a]/[0x6a]/[0xaa]`.
- **80C188EB PCB timer tests (`0x380`–`0x592`):** read/write timer registers `0xFF5A/0xFF5E/0xFF60/0xFF64/0xFF66/0xFF68`, failures into mask `[0x2a]`.
- **IVT hook installation (`0x118D`–`0x127F`):** saves & installs handlers for INT 0Ch/0Eh/14h/15h, then programs PCB ports `0xFF1C`, `0xFF60/0xFF64`.
- **Keyboard test (`0x60A`–`0x620`):** `repe cmpsb` of a 54-byte (`0x36`) scancode region against a reference table.
- **Result-grid renderer (`0x644`–`0x8C6`) + blink state machine (`0x8CA`–`0x900`):** walks 32-bit error masks (`[0xa]/[0x2a]`), byte-swaps screen offsets, paints dual-plane VRAM cells.
- **Delay helpers:** `0xE99` (spin), `0x107c` (INT 1Ah tick delay).

---

## EMULATOR.EXE — CDC-200/UT200 terminal emulator, v0.177 (66 findings)

**What it does:** The main interactive terminal emulator. After startup banner (INT 21h AH=9) and memory resize, it runs a poll loop fetching host display records and servicing the keyboard, painting an 80/132-column screen.

**Most confident findings:**
- **Main service loop (`0x2C`–`0x3D`):** alternates INT 40h AH=0 (poll char/status) and AH=4 (get-host-record → ES:BX), null-tested via `or ax,bx`. Loop back-edge `jmp 0x2c` from `0x3D/0x119/0x14D/0x179`.
- **Host-record VRAM paint (`0x53`–`0x87`):** 30-row (`0x1E`) dual-plane clear/paint; reads big-endian screen-offset words from the record, byte-swaps (`xchg al,ah`), writes char + attribute (`[es:di-0x8000]`) planes.
- **Column-ruler test pattern (`0x91`–`0xAA`):** repeating 1-9-0 digits; CX = 0x50/0x84 selected by the 80/132 flag `[0x14]`.
- **80/132-column select (`0x71`–`0x7B`, `0x123`):** `[0x14]` compared to '0'; INT 10h AH=0 mode set.
- **Keyboard (`0xC7`–`0xCF`):** INT 16h AH=1 status then AH=0 read; dispatch chain.
- **Host TX (`0x13A`–`0x14B`):** counter `[0x6f]` adjusted then sent via INT 40h AH=0x20 (put-char to SCC).
- **Printer self-test (`0x150`–`0x199`):** INT 17h AH=2 status (`test ah,0xa9`), then AH=0 prints the parallel-port test string until `$`.
- **Exit path (`0x12E`–`0x138`):** prints "Terminating." then INT 21h AH=4Ch.

---

## DOWNLOAD.EXE — XMODEM-style firmware/file loader (75 findings)

**What it does:** File-transfer utility. Allocates a 0x1C00-paragraph receive buffer (INT 21h AH=48h, registered to kernel via INT 40h AH=0x2E), then runs a state-machine receiver driven by INT 40h AH=0x2C polling, drawing a "Blocks/Bytes Received" status screen.

**Most confident findings:**
- **Buffer alloc & registration (`0x3E`–`0x45`):** CX=0x1C00, INT 40h AH=0x2E; error-exit path INT 21h AH=4Ch code 1 at `0x5E`.
- **Receive state machine** via dispatch vector `call [0x12]`: STX detect (`cmp al,0x2` at `0x7A`), header handler (`0x85`/`0x88`: byte count → `[0x18]`, ptr `[0x1a]=0x14a`), payload byte-store loop (`0xB1`–`0xCE`: store, `add [0x18]`, `dec [0x13c]`), trailer/CRC checks (`0xE6` ETX, `[0x18]`/`[0x19]` field verifies at `0xF1`/`0xFE`), end-of-block markers `0x0C`/`0x0F` (`0x111`/`0x11B`).
- **Counter reset on new transfer (`0x129`–`0x143`):** zeroes block seq `[0x139]`, block count `[0x26]`, 32-bit byte counter `[0x1e]/[0x20]`.
- **Buffer-pointer normalization (`0x186`–`0x195`):** seg:off renormalize after each `rep movsb`.
- **ACK/NAK TX (`0x1FC`–`0x218`):** sends `[0x138]` OR'd with low nibble of seq `[0x139]` via INT 40h AH=0x30 to SCC; status codes `0x20/0x30/0x40/0x50/0x60/0x70`.
- **INT 40h AH=6 receive handler (`0x1D6`–`0x1FB`):** passes 32-bit byte count in CX:DX; success/timeout set state vector `[0x16]` and `[0x138]`.
- **Status screen (`0x25F`–`0x3BB`):** far-pointer layout descriptor `[0xe]`, label emit loop `0x301`, 32-bit decimal printer (`0x307`/`0x319`/`0x32F`) with leading-zero suppression via BP flag, dual-plane box drawing.

---

## Contradictions surfaced by the adversarial pass

The campaign flagged several initial readings as **corrected**:

1. **MFGTEST `0x371`** — originally tagged Tx-Buffer-Empty; corrected: RR0 bit6 here is **Tx Underrun/EOM**, and the preceding `cx=0x14` toggle loop targets **PCB timer register `0xFF56`, not the SCC port**. A genuine instrument-vs-peripheral mis-attribution.
2. **MFGTEST `0x122` / `0x46B`** — fail-flag branch polarity corrected: `0x46B` fail path is taken when `0xFF0E` **bit4 is SET** (no jump), skipped via `jz 0x478` when clear. Branch-sense was inverted in the first pass.

**Recurring false-positive class (SCC vs. video):** Many `call 0xb49` sites (`0xC3C`, `0xC47`, `0xC51`, `0xC6A`, `0xC9D`, `0xD5C`, `0xD9B`, `0xDE0`) were initially suspected as SCC register writes but are confirmed **dual-plane VRAM box/menu draws** (DX = packed coord/glyph, not a WR pair). Same disambiguation recurs in EMULATOR (`0xB50` etc.). This is the dominant systematic error the adversarial pass caught.

**Data-as-code misdecodes** (all resolved to data, not instructions):
- MFGTEST `0x14F1` — power-of-two bit-mask table after the ID string.
- EMULATOR `0x1FC` — CR/LF/`$` terminator of the "Terminating." string.
- DOWNLOAD `0x3C2`/`0x3C5` — small pointer table (note `4A 01` = buffer const `0x14A`).

---

## Where understanding is weak

- **Kernel INT 40h semantics are inferred, not specified.** AH function numbers (0/4/6/0x1E/0x20/0x26/0x2C/0x2E/0x30/0x34) are reconstructed from call-site context; there is no kernel disassembly. AH=0x1E/0x26 (MFGTEST version build) and AH=0x34's 3-way selector (EMULATOR `0x17C`–`0x18C`) are the least certain.
- **The exact host framing protocol** in DOWNLOAD is "XMODEM-style" by analogy only — the STX(0x2)/ETX(0x3)/0x0C/0x0F markers and the two-byte `[0x18]/[0x19]` trailer do not match standard XMODEM checksumming; the real block-validation arithmetic is not fully traced.
- **Error-mask bit assignments** in MFGTEST (`[0xa]/[0x2a]/[0x4a]/[0x6a]/[0xaa]` with shift amounts 1–10) are mapped per-test but the consuming/reporting side is only partially understood (the grid renderer paints them but the pass/fail reporting policy is unconfirmed).
- **Branch-polarity findings remain the highest-risk category** given two confirmed corrections (`0x371`, `0x46B`); other single-pass fail-flag annotations (e.g. MFGTEST `0x122`, `0x39D`) warrant the same scrutiny.
- **PCB port roles** like `0xFF08` (read-modify-write, bit2 clear at `0x592`) and `0xFF1C`/`0xFF0E` are identified positionally within the 80C186/188 PCB window but their precise terminal-board function (which chip-select/pin) is unverified.
