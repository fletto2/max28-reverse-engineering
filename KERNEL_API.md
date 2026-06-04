# LT300/UT200 kernel API — INT 40h function table

The resident kernel exposes its services via **`INT 40h`**, dispatched by `AH`:

```
INT 40h handler @ CS:0x11DC (file 0x71DC):
    sti ; push bx ; mov bx,0x3E ; and bl,ah ; jmp [cs:bx+0x119B]
```

- Jump table of 32 word-pointers at **CS:0x119B (file 0x719B)**, segment is the
  resident-kernel CS (=0xF600 at boot; file = CS*16 - 0xF0000 + offset).
- Index = **`AH & 0x3E`** → so the low bit of AH is ignored (AH=0 and 1 alias, etc.)
  and AH ≥ 0x40 wraps (bits 6–7 dropped, e.g. AH=0x40 → function 0).
- Every handler does `mov ds,0x40 ; mov bx,[0x914]` → DS = kernel data segment,
  `[0x914]` = pointer to the **current session/task control block (CB)**; many
  functions just get/set a field in that CB. This is a per-session terminal API.

| AH | handler (file) | function (from code + how modules call it) |
|------|----------|---------------------------------------------|
| 0x00 | 0x0A7CA | **yield / wait-for-event** — `pusha`+context save into scheduler; returns when input/event ready. EMULATOR & DOWNLOAD main loops poll this. (AH=0x40 aliases here.) |
| 0x02 | 0x0AC6E | timed wait / schedule (CX,DX) — kernel init calls AH=2,CX=0x3E8. |
| 0x04 | 0x0B37B | **get next queued record/message** — returns far ptr ES:BX (NULL if none); callers null-check ES\|BX. |
| 0x06 | 0x0A41E | process/dispatch a buffered item (builds stack frame; DS/SI/ES). |
| 0x08 | 0x09F4A | buffer/string operation (DS:SI). |
| 0x0A | 0x0AAF2 | invoke registered callback `call far [0x95B]`. |
| 0x0C | 0x0AB57 | invoke registered callback `call far [0x953]`. |
| 0x0E | 0x0AB8C | invoke registered callback `call far [0x957]`. |
| 0x10 | 0x0B3A6 | set current-CB field [+0xA0] = CX. |
| 0x12 | 0x07962 | validate far pointer ES:DI (NULL check). |
| 0x14 | 0x0736C | file/handle op via the alloc'd segment [0x7D5]. |
| 0x16 | 0x0748B | service taking AX,DX. |
| 0x18 | 0x07385 | context-save dispatch entry (variant of AH=0). |
| 0x1A | 0x0A86F | conditional service (tests DX). |
| 0x1C | 0x0A8B5 | set current-CB field [+0xA9] = DX. |
| 0x1E | 0x0B3C8 | get/set terminal config char (`cmp al,0x3C`); MFGTEST uses for version/ID. |
| 0x20 | 0x0798D | set current-CB field [+0x97] = AL (status byte); DOWNLOAD uses it. |
| 0x22 | 0x0BCD9 | clear current-CB flag bit ([+0xB7] &= 0xFE). |
| 0x24 | 0x0AC11 | **register callback vectors** (installs [0x953]/[0x957]/[0x95B] used by AH=0A/0C/0E). |
| 0x26 | 0x079A3 | get terminal mode/attribute state ([0x7F4], table [cs:0x1546]); MFGTEST. |
| 0x28 | 0x0B567 | peek queued record (variant of AH=04). |
| 0x2A | 0x0AC25 | state query (`cmp [0x7A8],2`). |
| 0x2C | 0x0AC3E | clear [0x7A8]; far call — DOWNLOAD. |
| 0x2E | 0x0A406 | **get system tick/time** → DX:AX = [0x89C]/[0x89E] (Timer-0 counter); DOWNLOAD. |
| 0x30 | 0x0AC52 | clear [0x7A8]; far call — DOWNLOAD. |
| 0x32 | 0x09BA3 | set byte [0x874] = AL. |
| 0x34 | 0x0B3EC | set current-CB mode (`cmp al,3`); EMULATOR. |
| 0x36 | 0x079B6 | set current-CB field [+0x96] = AL. |
| 0x38 | 0x0B42A | set current-CB field [+0x9A] = AL. |
| 0x3A | 0x0794D | service taking AX,CX. |
| 0x3C | 0x0B1FD | return pointer to kernel struct (BX=0x96D); `iret`. |
| 0x3E | 0x071E8 | **unimplemented** → falls to `INT 4Fh` (error). |

Confidence: AH 0x00/0x04/0x24/0x2E and the CB-field setters are well-grounded
(clear code + matching module usage); a few (0x06/0x08/0x16/0x1A/0x3A) are
characterized only by their prologue and remain approximate.

## Other interrupt-based APIs
- **INT 21h** (handler CS:0x0DF2, file 0x6DF2) — DOS-compatible layer: AH=09h
  print $-string, 02h char out, 3Dh/3Eh/3Fh/42h file open/close/read/lseek,
  48h/4Ah alloc/resize, 4Bh EXEC (load+run an embedded-FS module), 4Ch exit.
- **INT 4Fh** — NOT a multi-function API: it is the **internal-error / panic handler**,
  reached via the boot default IVT vector CS:0x0004 -> 0x000C (file 0x600C). It saves
  all registers, prints an "Internal Error" register + stack dump (GP regs, DS/ES, the
  faulting CS:IP:FLAGS) via INT 21h AH=9/AH=2 + the 0x139 hex helper, then `jmp $`
  HALTS. Triggered deliberately on fatal errors (INT 40h AH=0x3E unimplemented; boot
  EMULATOR-load failure @0x70D2) and as the catch-all for any uninstalled interrupt
  vector. (The MC structure map's "INT 4Fh dispatch table @0x6D2B / get-active-CB /
  time-of-day" labels were a mis-ID; those are ordinary call-reached kernel routines.)
- **INT 16h** (CS:0x1548, file 0x7548) keyboard; **INT 17h** (CS:0x3FA9, file 0x8FA9)
  printer; **INT 10h** video teletype — all installed by the boot IVT setup (0x7051).
