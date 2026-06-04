# MAX28 reverse engineering

Reverse-engineering notes, disassemblies, and tools for the **Link Technologies
MAX28** serial video terminal (P/N 999-128-002, 1993) — a monochrome **Unisys
A-Series** terminal that speaks the Poll/Select protocol with **T 27** block-mode
emulation and a built-in **DEC VT220 / ANSI** emulator. (Link Technologies was
later absorbed by Wyse, which is why the video silicon is a Wyse part.)

The subject is the SBC's **64 KiB boot ROM**; this repo holds its disassembly and
analysis (the raw ROM image itself is not included). The terminal's main
application firmware lives in a separate, soldered **256 KiB Intel flash** (two
28F001 at CPU physical `0x80000-0xBFFFF`), which is also not included.

## Hardware (from the board + the ROM's chip-select programming)

| Part | Role |
|------|------|
| Intel **80C188EB** (13 MHz) | CPU — 16-bit core, 8-bit external bus, real mode |
| Zilog **Z8530 / Z85C30** SCC | dual serial controller @ I/O `0x300-0x303` (T27 host link + AUX async) |
| OKI **M76V020** (= Wyse `211019-02` gate array) | combined CRT/video + keyboard controller @ I/O `0x340-0x343` |
| 2× Intel **28F001** | 256 KiB main-program flash @ `0x80000-0xBFFFF` |
| 256 KiB DRAM | work RAM @ `0x00000-0x7FFFF` ; 24 KiB VRAM @ `0xC0000` |

Memory map, kernel API, and the video controller are documented in
`KERNEL_API.md` and `VIDEO_CONTROLLER.md`.

## What the boot ROM does

Power-on self-test of DRAM → relocate a small multitasking kernel into RAM →
install an `INT 21h` DOS-compatible layer + an `INT 40h` kernel/terminal API +
keyboard/printer/SCC/timer interrupt handlers → size/allocate memory → launch a
terminal-emulator module. The real T27/VT220 personalities are loaded from the
256 KiB flash. An embedded filesystem at offset `0xB4` holds three MS-DOS MZ
executables (`MFGTEST.EXE`, `EMULATOR.EXE`, `DOWNLOAD.EXE`) plus config blocks,
extracted under `extracted_fs/`.

## Operating note

The base emulator is **fixed to T 27** (the "Basic Emulator" line in setup is
display-only). To use the **VT220** emulator, press **`ALT`+`2` on the numeric
keypad** (`ALT`+`ESC` returns to T27). Setup screens: `ALT`+`1` (numpad). The VT
session communicates over the **AUX SERIAL** port (default 9600 8N1).

## Contents

- `M27C512_disasm.asm` — full disassembly of the boot ROM (code decoded, data as hex+ASCII).
- `M27C512_disasm.labeled.asm` / `.annotated.asm` — symbol-labeled / annotated variants.
- `KERNEL_API.md` — the `INT 40h` kernel API table + `INT 21h` / `INT 4Fh` notes.
- `VIDEO_CONTROLLER.md` — the OKI M76V020 / Wyse gate-array display controller.
- `CUSTOM_ROM_GUIDE.md` — how to build and run a custom boot ROM on this SBC.
- `flashdump.asm` / `flashdump.bin` — a custom boot ROM (source + assembled 64 KiB
  image) that dumps the 28F001 flash out AUX SERIAL as Motorola S-records (`nasm -f bin`).
- `rom_mc_summary.md` / `modules_mc_summary.md` — summaries of the boot ROM and the
  three embedded modules.
- `extracted_fs/` — the embedded filesystem members (`*.EXE`, `CONFIG.BLK`,
  `CONFIG.SYS`, `MANIFEST.json`) and their disassemblies (`.asm` / `.full.asm` /
  `.labeled.asm`).

## Legal

The disassemblies and the embedded modules here are derived from the
manufacturer's firmware, provided for interoperability and preservation research
only. All trademarks and firmware are the property of their respective owners.
