The task is to write a technical summary based on the already-confirmed annotations and structure regions provided. I have all the data I need in the context. Let me synthesize it directly.

# LT300/UT200 Boot ROM (M27C512, 64 KB @ 0xF0000) — Firmware Analysis Summary

## 1. Boot sequence (in execution order)

### 1.1 Reset vector — file `0xFFF0`
Power-on lands at the x86 reset address `0xFFFF0`. The vector is `JMP FAR FFE0:0000`, redirecting to the init stream at file `0xFE00`.

### 1.2 Chip-select / PCB init — file `0xFE00`
Unrolled `MOV DX,port / MOV AX,val / OUT DX,AL` stream programs the 80C188EB Peripheral Control Block: PACS `0xFFA4`, MMCS `0xFFA6`, UMCS `0xFFA0` (this ROM), LMCS `0xFFA2` (DRAM), then timers (`0xFF50–0xFF6A`) and the Interrupt Control Unit (`0xFF30–0xFF3E`). On completion it transfers to `JMP 0xF600:0` = file `0x6000`.

### 1.3 Resident kernel entry — file `0x6000`
"Operating Kernel Version 1.035" (banner string at `0x74F6`: *"Operating Kernel Copyright (c) 1993 Computer Logics Limited"* + *"Version 1.035"* at `0x7536`). Entry is `JMP 0x6F12` (`0x6000`) into the power-on RAM/flash sizing path.

### 1.4 Power-on memory sizing self-test — `0x6F11–0x700D`
Blanks video (`OUT 0x343,0x44`), then from segment 0 does a write-pattern / `repe scasb` presence scan walking `0x1000`-paragraph segments (`0x6F7B`). On failure it programs ICU/timer ports `0xFF32/0xFF34/0xFF36` to beep and halts at `0x7008` (`jmp $`).

### 1.5 Kernel relocation + IVT install — `0x700E–0x70A2`
Computes the data segment from CS (`add ax,0xFE8E / sub 0xF600`), `rep movsb` relocates kernel data to `0..0x9CA`, zero-fills BSS to `0x304C`, sets `SS:SP`, then an unrolled `MOV DI / MOV AX / STOSW` series pre-loads IVT offset halves: INT 2Fh (DI=`0xBC`, off `0x11DB`, `0x7071`), plus slots `0x170/0xA8/0x100/0x84/0x68/0x5C/0x58`.

### 1.6 Subsystem bring-up — `0x70A3–0x70EE`
Unrolled calls: `0xB28A` (timer/ICU vector seg fill), `0xA6B0` (IVT + first control block), `0xA074` (flash bank probe), `0xAEFC` (ICU/timer program), `0x75B0/0x75B7` (emulator table load), `0x9FA2` (printer init), then `STI`. Computes heap base/size (`0x70B9`) into `0x9E0F`, loads the EMULATOR module (`0x71EA`), applies its config (`0x7399`), polls host (`0x69A5`), and starts video/timer services.

## 2. Drivers and services

### 2.1 INT 40h — custom comm/system kernel API
Central dispatch surface. Notable: serial get-status/get-char from the ring buffer in control block `[0x914]` (head `[bx+0x90]` vs tail `[bx+0x8E]`, `0x7549–0x75AF`, `0x756E`); page/context-switch handler (`0xA82A`) saving/restoring per-page cursor and attribute state; control-block lookup walking the `0xB8`-byte stride table `0x18DE–0x245E` keyed on `[bx+4]` (`0x6E83`). Far-callable handlers return status in carry via `retf 2` (`0x9B1D`, `0x9C92`).

### 2.2 Z8530 SCC serial driver — I/O `0x300–0x303`, `0xA9ED–0xAC11`
Tx/Rx ISR reading baud/timer regs (`0xFF66/0xFF68`), EOI via `0xFF02=0x8000`, dual ring buffers (`[0x946]/[0x948]` word, `[0x94A]/[0x94C]` byte) wrapping in the `0x255E–0x285E` region. Host-link command issued via INT 40h AH=10h to `DX=0x302` (channel-B control). Far-vector get/put/status entries self-installed at `0x953/0x957/0x95B` (`0xAC11`).

### 2.3 M76V020 video gate array — I/O `0x340–0x343`, dual-plane VRAM @ `0xD000`/`0xC000`
Mode/control written through RAM shadow `[0x7B9]` to port `0x343`. Character-write routine (`0xBACF`, `0xBAD5`) dispatches BS/CR/BEL/LF vs printable into the char plane and attribute plane (`0x8000` apart). CRTC timing programmed for 80 vs 132 columns by testing `[0x989]==0x50` (`0xB714`). Scroll/fill engine (`0xB8E2`) and deferred-refresh state machine via INT 0Eh (`0xBD1F`, vector installed `0xBD06`, unmask via ICU `0xFF1C`). Cursor-blink driven from the timer ISR.

### 2.4 Timer-0 periodic tick ISR — `0xAFB6–0xB212`
Increments 32-bit tick `[0x968]/[0x96A]`, EOIs `0xFF02`, decrements countdown `[0x96D]`, services cursor-blink threshold (`[0x970]/[0x971]` seeded at `0xAF4F` from `5 * [0x7B7]`), chains `INT 8`/`INT 1Ch`. Baud-rate ladder maps an index to a divisor (`0xAF8F`).

### 2.5 Keyboard — INT 16h path, `0x79C7–0x7A11`
Char-available query returns AL=`0xFF` when a char is pending, AL=`0x00` when empty (the polarity was corrected during review — see contradictions). Scancode→ASCII via `CS:XLATB` over the QWERTY table at `0x7A12+` (`0xB145` bit-scan compare, `0xB1AB` POPA/enqueue).

### 2.6 INT 21h — DOS-style services
Char I/O (AH=1/2/6/9), file open/seek/read/close (AH=3D/42/3F/3E), memory alloc/resize (AH=48/4A). Includes an MZ/.EXE loader (`0x98A2`: `cmp ax,0x5A4D`, relocations, builds a PSP at seg 0, `jmp 0xFFFD:0`) and a 'CL'-magic heap arena manager (`0x9BAF`: allocate/coalesce/split/resize 0xC-byte descriptors).

### 2.7 INT 4Fh — escape/control-code dispatch
Master dispatcher (`0x6DF4`) does `jmp [cs:bx+0x6D2C]` indexing the table at `0x6D2C` (default-handler word `0x0E07` fill). EMULATOR escape-sequence matcher is a recursive table walk (`0x760D`, `0x763E`) over the state-machine tables loaded into RAM at `0xA4A–0x144A`.

### 2.8 INT 17h printer — `0x9FA9–0xA073`
AH=0 print (poll busy bit7 at `0x340`, write `0x342`, strobe via `0x341` shadow `[0x89A]`), AH=1 init, AH=2 status. Also drives MFGTEST's parallel-port string output (`0x64D5`).

## 3. Self-test (MFGTEST) and flash programming
- **Driver** `0x70F9`: INT 40h sys call, banner, four M76V020 video-register test patterns (`0x240/0x880/0x2020/0x8008`) via `0x714E`, error accumulators `[0x7F1]/[0x7F2]`, pass→`0xBC12`, fail→`0x62A7`.
- **Peripheral register dumps** `0x66B3`: SCC `0x300–0x30F` and the 16-reg device at `0x350–0x35F`.
- **Flash probe/erase/program** `0xA074`/`0x67C8`/`0xA581`: 28F001 Read-ID (`0x90`, IDs `0x9589`/`0x9489`), erase (`0x50/0x20/0xD0`), byte-program (`0x40`, status poll bit7/bit0x10 at `0xA564`); builds 8-entry descriptor table at `[0x8B1]`; copies image in `0x8000`-byte windows.
- **Download trigger** `0x69A5`/`0x7358`: SCC status poll + match host magic strings, jumping into the firmware-program path (writes the separate 256 KB flash).
- **Reports**: checksums of segments `0xE000`/`0xF000` (`0x620C`), per-control-block memory report (`0x6443`), descriptor/region report (`0x6718`).

## 4. Most confident findings
- **CPU/boot chain is fully pinned**: reset `0xFFF0` → init `0xFE00` (PCB chip-selects/timers/ICU) → kernel `0x6000` (`JMP FFE0` / `JMP F600`). Confirmed by register-for-register PCB programming.
- **Kernel identity**: "Operating Kernel Version 1.035", Computer Logics Limited, 1993 (`0x74F6/0x7536`).
- **Memory model**: control blocks on `0xB8` stride `0x18DE–0x245E`; kernel data segment `0x40` (physical `0x400`); active-page pointer `[0x914]/[0x978]`; VRAM `0xD000` (char) + `+0x8000` (attr).
- **Peripheral map**: Z8530 SCC `0x300`, M76V020 `0x340–0x343`, second gate array `0x350`, PCB `0xFF00+`.
- **Embedded module directory** (`0xEA16` / file `0xB4`): MFGTEST/CONFIG.SYS/EMULATOR/DOWNLOAD.

## 5. Contradictions surfaced by the review cycles
- **`0x79CD` keyboard char-available polarity** (corrected): original claim had AL=`0xFF`/`0x00` meanings reversed; AL=`0x00` is empty, AL=`0xFF` is char-available.
- **`0x9BA7` segment/flag target** (corrected): DS=`0x40` so `mov [0x874],al` stores to physical `0xCB4`; the flag is read at `0x63A7`, **not** `0x638B` as first claimed.
- **`0xACBD` "timer count" misattribution** (corrected): the `0xFF30/FF32/FF34/FF36` OUTs reprogram the **ICU** (FF36=mask), not timer-count registers. A recurring theme: ICU and timer PCB blocks were initially conflated.
- **Code-vs-data misdecodes** (repeatedly corrected): many `0xFA`/`0x0E07`/`0x4Bxx` bytes ndisasm rendered as `cli`/`push cs;pop es`/`fisttp` are jump/offset table data (e.g. `0x617E`, `0x6D2C` INT 4Fh table, `0xABF9`), not instructions.

## 6. Where understanding is weak
- **Second gate-array device at `0x350–0x35F`** (16 regs): only exercised by the MFGTEST register dump (`0x66CF`); its function (LAN/PCMCIA controller? the strings mention "LAN ROM"/"LAN Regs Page 0/1" and "PCMCIA") is **not** decoded.
- **EMULATOR escape-sequence semantics**: the recursive matcher (`0x760D`) and its large offset/parameter tables (`0xDE14–0xE8C6`) are identified as data but the actual CDC-200/UT200 escape-code → action mapping is not enumerated.
- **INT 40h sub-function numbering**: many sub-handlers are mapped to addresses, but a complete AH-value → service table is incomplete (e.g. AH=2 with DX=`0x7D`, CX=`0x3E8` timeout at `0x7857`/`0x791C` is an unidentified comm/system call).
- **Font/glyph region `0x823A–0xD7E1`**: confirmed as character-generator bitmap + offset tables, but glyph-to-codepoint mapping and the FONTFILE record at `0xF29E` are not parsed.
- **Handler vectors `0x953/0x957/0x95B` and far entry `0xF600:4B49/4BFC`**: referenced as serial/device-status calls but their full behavior lives partly in the *separate 256 KB flash* (not in this dump), limiting closure.
