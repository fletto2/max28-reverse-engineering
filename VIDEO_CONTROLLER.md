# LT300/UT200 video controller — OKI M76V020 (Wyse 211019-02 gate array)

Reverse-engineered from the ROM (`M27C512@DIP28.BIN`) I/O access patterns. This
documents the terminal's CRT/video display controller: the chip, how the CPU
reaches it, its register interface as used by the firmware, and the driver
routines. Where a fact is inferred rather than proven, it is flagged.

## The chip
- **OKI M76V020** = **Wyse custom video gate array, part `211019-02`**, marked
  "© WYSE,1989" (QFP). It is a Wyse-proprietary display controller fabbed by OKI;
  there is **no standalone OKI datasheet**.
- Documented in MAME: `src/mame/wyse/wy30p.cpp:140` (Wyse WY-30+ terminal). One of
  a family of Wyse `211019-xx` video gate arrays (`-05` = WY-55/WY-185). MAME has
  **no register-level model** (the Wyse drivers using it are skeletons).
- Provenance note: Computer Logics built the LT300/UT200 display path on Wyse
  terminal video silicon. The WY-30+ pairs this gate array with an 8051; the LT300
  pairs the same gate-array family with an Intel **80C188EB**.
- A board "FONT SIZE" jumper (8K×8 / 2K×8) selects the external character-generator
  font memory the gate array scans — consistent with this ROM's large 8-px/row
  font table (see `codedata_map.txt`, the FONT regions).

## How the CPU reaches it (chip-select path)
- CPU `80C188EB` Chip-Select Unit programs a **GCS** line to decode I/O window
  `0x340–0x389`: boot init writes `FF90 = 0x340` (GCS start) and `FF92 = 0x389`
  (GCS stop). That GCS output drives the M76V020's chip-select pin.
- So: `CPU → GCS chip-select → M76V020 @ I/O 0x340–0x343`.

## Register interface (as used by firmware; offsets are I/O ports)

| Port   | Dir   | Role (reverse-engineered)                                            |
|--------|-------|----------------------------------------------------------------------|
| `0x340`| read  | **Status**. `in al; test al,0x3; jz ok` — bits 0–1 = error/not-ready; a set bit branches to an error string. Polled before access. |
| `0x341`| write | Control register B (secondary; written e.g. `0x9`).                  |
| `0x342`| write | Control/data — takes data bytes (`bh`/`bl`); row/col or attribute (inferred). |
| `0x343`| write | **Primary mode/control + character data.** Two uses: (1) character output — ASCII bytes incl. CR `0x0D`, LF `0x0A`, SUB `0x1A`, space `0x20`, and hex digits are written here; (2) write-only **control register**, updated read-modify-write through a **RAM shadow at `[0x7b9]`** under `cli`/`sti` (e.g. `mov al,0xFC; cli; and al,[0x7b9]; mov [0x7b9],al; out dx,al; sti`). |

Notes:
- `0x343` is write-only at the hardware; firmware keeps its last value in RAM
  `[0x7b9]` and does masked read-modify-write to change individual control bits
  without disturbing others (classic write-only-register idiom).
- This is **not** a stock Motorola 6845: 4-register interface, software-shadowed
  control, status/ready polling — a bespoke gate array.
- Frame/display memory is updated via a **4 KB-page-bounded block copy** loop
  adjacent to the control writes (the gate array maps screen RAM in the GCS
  *memory* windows, segments `0x8000–0xE000`; the I/O ports above are its control
  interface only).

## Driver routines (file offsets; see `M27C512_disasm.labeled.asm`)
- `~0x6819` — display-access routine: polls `0x340` status, runs the page-bounded
  block copy into display memory, then masks a control bit via `0x343`+`[0x7b9]`.
- `0x686E–0x687B` — the `cli` / `and al,[0x7b9]` / `out 0x343` / `sti` control
  read-modify-write.
- Many `out 0x343` sites across `0x6000–0x6B00` are character output (the
  hex/register-dump and string-print paths call into this).
- RAM shadow of the `0x343` control byte: `[0x7b9]`.

## Confidence
- **Solid**: chip identity & provenance (Wyse 211019-02 / OKI M76V020); chip-select
  path; that `0x340`=status, `0x343`=control+char-data with `[0x7b9]` shadow.
- **Inferred**: exact meaning of `0x341`/`0x342` and of individual `0x343` control
  bits; the internal register map of the gate array (no datasheet / no MAME model).
