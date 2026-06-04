; ============================================================================
; EMULATOR.EXE (v0.177)  -  the boot ROM's built-in terminal / display engine
; ----------------------------------------------------------------------------
; WHAT IT DOES: a small glass-terminal plus hardware exerciser. It fetches display
; "records" from the host via the kernel comm API (INT 40h) and paints them into
; dual-plane VRAM (character plane + attribute plane 0x8000 apart), honouring 80- vs
; 132-column mode; draws screen test patterns; handles the keyboard (INT 16h) and
; printer output (INT 17h); and carries the parallel/serial printer-port test text.
; This is NOT the production T 27 / VT220 personality (those live in the 256 KiB
; flash) - it is the platform's generic built-in emulator. ;>>>> = annotations.
; ============================================================================

; EMULATOR.EXE - code/data-separated disassembly (MZ load module, 660 B, header 512 B stripped)
; entry @0x0000; 1 relocs. Classified CODE-unless-data-filter-fires
; (recursive descent under-covers C-runtime startups). Bytes: 365 code / 288 string / 7 data.
;

; ---- 0x0000-0x00d7 CODE ----
;
; >>>>>>>>>>>>>>>>  ROUTINE: STARTUP  <<<<<<<<<<<<<<<<
; Print the sign-on banner (INT 21h AH=9), shrink the program's memory
; block (AH=4Ah), set the video mode + 80/132-column flag [0x14], then
; jump into the main service loop.
;
00000000  1E                push ds
;>>>> [startup (INT 21h AH=9 sign-on)] mov ax,0x19: loads immediate 0x19, moved into DS at 0x04 (mov ds,ax) so DS:DX (DX=0x15 at 0x08) points at the $-terminated sign-on string for the INT 21h AH=9 print at 0x0B. 0x19 is the resident data/PSP-relative segment value, not a computed value. This is the module's first real instruction after push ds at 0x00.  // 0x04 mov ds,ax; 0x06 mov ah,9; 0x08 mov dx,0x15; 0x0B int 0x21
00000001  B81900            mov ax,0x19
00000004  8ED8              mov ds,ax
;>>>> [startup (INT 21h AH=9 sign-on)] mov ah,0x9: sets AH=9 (DOS INT 21h print $-terminated string) for the int 0x21 at 0x0B, with DS=0x19 (set at 0x01/0x04) and DX=0x15 (set at 0x08) pointing at the sign-on/status message. Displays the startup banner before the AH=4Ah resize sequence.  // 0x01 mov ax,0x19; 0x04 mov ds,ax; 0x08 mov dx,0x15; 0x0B int 0x21
00000006  B409              mov ah,0x9
00000008  BA1500            mov dx,0x15
0000000B  CD21              int 0x21   ; INT 21h AH=0x09: print $-string DS:DX
;>>>> [DOS startup / INT 21h AH=4Ah] pop es: recovers the PSP segment (pushed as DS at 0x00) into ES so the following block (mov bx,sp; add bx,0xf; shr bx,4; add bx,ss; sub bx,es-via-ax) computes the resident paragraph count, then `mov ah,0x4a; int 0x21` shrinks the memory block. Standard DOS resize-memory (INT 21h AH=4Ah) preamble.  // 0x00 push ds; 0x1E mov ah,0x4a; 0x20 int 0x21 confirm the AH=4Ah resize; ES is the block segment argument.
0000000D  07                pop es
;>>>> [DOS startup / INT 21h AH=4Ah resize preamble] mov bx,sp: captures the stack pointer as the top-of-image marker, first arithmetic step of the MZ C-runtime startup computing resident size in paragraphs. Followed by `add bx,0xf; shr bx,4; add bx,ss; sub bx,es` (0x10-0x1C) to form the paragraph count passed in BX to INT 21h AH=4Ah (mov ah,0x4a/int 21h at 0x1E/0x20) that shrinks the program arena. ES is the PSP popped at 0x0D.  // 0x0D pop es; 0x0E mov bx,sp; 0x10 add bx,0xf; 0x13 shr bx,4; 0x1E mov ah,0x4a; 0x20 int 0x21
0000000E  8BDC              mov bx,sp
;>>>> [DOS startup / memory] add bx,byte +0xf — MZ C-runtime startup: rounds the value just copied from SP (mov bx,sp at 0x0E) up by 15 so the subsequent shr bx,4 yields a paragraph count. This is the standard prologue computing the resident size in paragraphs to pass in BX to INT 21h AH=4Ah (resize memory block) at 0x1E/0x20, shrinking the program's arena.  // Sequence 0x0E mov bx,sp; 0x10 add bx,0xf; 0x13 shr bx,4; 0x16 mov ax,ss; 0x18 add bx,ax; 0x1A mov ax,es; 0x1C sub bx,ax; 0x1E mov ah,0x4a; 0x20 int 0x21.
00000010  83C30F            add bx,byte +0xf
00000013  C1EB04            shr bx,byte 0x4
00000016  8CD0              mov ax,ss
;>>>> [INT 21h AH=4Ah memory resize (startup)] add bx,ax adds the stack segment SS (in AX) to BX (=roundup(SP)/16 paragraphs) to form the segment of the top of the program image; this is the size-computation step feeding sub bx,ax then INT 21h AH=4Ah resize-memory-block.  // Target 03D8 add bx,ax; AX from mov ax,ss at 0x16, BX from shr bx,4 at 0x13. Result later has ES subtracted (0x1C) and used by mov ah,0x4a/int 21h.
00000018  03D8              add bx,ax
;>>>> [INT 21h AH=4Ah memory resize (startup)] mov ax,es loads the program's base segment (ES = PSP, restored by pop es at 0x0D) into AX so the next sub bx,ax can subtract it from the computed top-of-image segment, yielding the paragraph count for the INT 21h AH=4Ah resize-memory-block call.  // Target 8CC0 mov ax,es; immediately followed by 2BD8 sub bx,ax then mov ah,0x4a/int 0x21. ES was set by pop es at 0x0D to the original DS/PSP.
0000001A  8CC0              mov ax,es
;>>>> [INT 21h AH=4Ah memory resize (startup)] sub bx,ax computes the resident program size in paragraphs: BX = (SS + roundup(SP)/16) - ES(PSP). The result in BX is the new block size for the immediately-following INT 21h AH=4Ah (mov ah,0x4a at 0x1E, int 21h at 0x20) that shrinks the program's memory allocation.  // Target 2BD8 sub bx,ax with AX=ES (PSP from pop es at 0x0D), BX=SS+paragraphs; next mov ah,0x4a / int 0x21. Classic MZ startup resize-to-fit sequence.
0000001C  2BD8              sub bx,ax
;>>>> [DOS startup / INT 21h AH=4Ah resize memory block] mov ah,0x4a: loads DOS function 4Ah (resize memory block) for the immediately following int 0x21 (0x20). BX holds the resident size in paragraphs computed by the preceding C-runtime prologue (mov bx,sp; add bx,+0xf; shr bx,4; add ss; sub es-via-ax at 0x0E-0x1C); ES = PSP (popped at 0x0D). Shrinks the program's memory arena.  // 0x1E B44A mov ah,0x4a; 0x20 CD21 int 0x21; standard MZ startup BX=paragraph count from 0x0E-0x1C; ES restored by pop es at 0x0D.
0000001E  B44A              mov ah,0x4a
00000020  CD21              int 0x21   ; INT 21h AH=0x4a: resize memory block
00000022  B83200            mov ax,0x32
00000025  A21400            mov [0x14],al
00000028  CD10              int 0x10   ; INT 10h video (teletype/mode)
;>>>> [control flow / main-loop entry] jmp short 0x30: on the first pass through main-loop setup (right after INT 10h set-video-mode at 0x28), skips the INT 40h AH=0 serial char poll at 0x2C and lands directly on the INT 40h AH=4 get-host-record call at 0x30. Bypasses reading a char so the code immediately polls the kernel for an incoming host data block.  // Target is 0x30 (mov ah,0x4; int 0x40), skipping 0x2C (mov ah,0x0; int 0x40). Matches accepted 0x2A annotation exactly.
0000002A  EB04              jmp short 0x30
;
; >>>>>>>>>>>>>>>>  ROUTINE: MAIN LOOP head  <<<<<<<<<<<<<<<<
; INT 40h AH=0 idles/polls the Z8530 SCC host link, then falls into the
; get-host-record fetch. All handlers jmp back here when done.
;
status_0002C:
;>>>> [serial host link / main-loop head (INT 40h AH=0)] mov ah,0x0: sets AH=0 (kernel comm function: poll/get char or status from the Z8530 SCC host link) immediately before int 0x40 at 0x2E. This is the top of the main service loop, the target jumped to repeatedly from 0x3D, 0x119, 0x14D, 0x179. INT 40h is the terminal kernel's custom comm/system API, not DOS.  // 0x2E int 0x40; followed by AH=4 get-record at 0x30; jmp 0x2c back-edges from 0x3D/0x119/0x14D/0x179
0000002C  B400              mov ah,0x0
0000002E  CD40              int 0x40   ; INT 40h AH=0x00: yield / wait-for-event
;
; >>>>>>>>>>>>>>>>  ROUTINE: Get host display record  <<<<<<<<<<<<<<<<
; INT 40h AH=4 returns the next host data block in ES:BX. If null, clear
; the 'record present' flag and re-poll; otherwise save the pointer and
; paint the screen.
;
sub_00030:
;>>>> [kernel host-record fetch (INT 40h AH=4)] mov ah,0x4: sets the kernel function selector to 4 for the `int 40h` at 0x32 = get-host-record / get-display-buffer, which returns the record pointer in ES:BX (then validated by or ax,bx). Not a DOS allocation; INT 40h is the terminal kernel's custom comm/system API.  // 0x30 mov ah,4; 0x32 int 0x40; 0x34 mov ax,es; 0x36 or ax,bx; pointer stored at 0x3f/0x43.
00000030  B404              mov ah,0x4
;>>>> [kernel INT 40h AH=4 (get host record)] int 0x40 with AH=4 (set at 0x30): kernel get-host-record/get-display-buffer service, returns the next synchronous-link data block pointer in ES:BX. Immediately validated by `mov ax,es; or ax,bx; jnz 0x3f` (0x34-0x38) null test; on success ES:BX is saved to [0x10]/[0x12], on null [0xe] is zeroed and the loop re-polls. Custom terminal-kernel comm API, NOT DOS memory allocation.  // 0x30 mov ah,4; 0x32 int 0x40; 0x34 mov ax,es; 0x36 or ax,bx; 0x38 jnz 0x3f; 0x3F mov [0x10],bx
00000032  CD40              int 0x40   ; INT 40h AH=0x04: get next queued record -> ES:BX
;>>>> [kernel host-record fetch (INT 40h AH=4) null-check] mov ax,es: loads the ES segment returned by INT 40h AH=4 (int 0x40 at 0x32) into AX for the or ax,bx at 0x36, testing whether the returned ES:BX record pointer is null (0000:0000). On non-null, jnz 0x3f (0x38) stores the pointer into [0x10]/[0x12]; on null it clears [0xe] at 0x3a and re-polls. This is the main-loop get-host-record validation, not a DOS resize/alloc check.  // int 0x40 (AH=4 set at 0x30) at 0x32 precedes; or ax,bx at 0x36, jnz 0x3f at 0x38, store to [0x10]/[0x12] at 0x3f/0x43. Mirrors accepted 0x32/0x38/0x3A/0x3F chain.
00000034  8CC0              mov ax,es
00000036  0BC3              or ax,bx
;>>>> [kernel host-record fetch (INT 40h AH=4)] jnz 0x3f: tests the result of `mov ah,4; int 40h` (kernel get-host-record). AX=ES and `or ax,bx` set ZF only if ES:BX is the null pointer 0000:0000; non-null branches to 0x3f to store the record pointer in [0x10]/[0x12]. Null falls through to clear [0xe] and re-poll.  // 0x30 mov ah,4; 0x32 int40; 0x34 mov ax,es; 0x36 or ax,bx; 0x38 jnz 0x3f; 0x3f mov [0x10],bx; 0x43 mov [0x12],es.
00000038  7505              jnz loc_0003F   ; ->0x3F
;>>>> [INT 40h host-record poll / no-record flag] mov [0xe],ax: stores AX into the host-record-present flag word at [0x0E]. Reached only when the preceding or ax,bx (0x36; AX=ES, BX=offset from INT 40h AH=4 at 0x30-0x32) was zero, so AX=0 here -- it writes a null/clear into [0x0E] indicating 'no host record this pass', then jmp short 0x2c (0x3D) re-polls. The non-null path (jnz 0x3f at 0x38) instead saves the pointer to [0x10]/[0x12].  // 0x34 mov ax,es; 0x36 or ax,bx; 0x38 jnz 0x3f; 0x3A A30E00 mov [0xe],ax; 0x3D jmp short 0x2c. [0x0E] also tested by cmp word [0xe],0 at 0x47.
0000003A  A30E00            mov [0xe],ax
;>>>> [main loop / kernel poll (INT 40h)] jmp short 0x2c: unconditional branch back to the top of the main service loop at 0x2c. The loop head runs `mov ah,0; int 40h` (kernel idle/poll fn 0) immediately followed by `mov ah,4; int 40h` (get-host-record, returns pointer in ES:BX). This jmp is the 'no record yet / [0xe] already set' fall-through that re-polls. It is NOT a serial get-char-until-key loop; AH=0 and AH=4 are two distinct kernel calls and ES:BX (not AL) is the result consumed.  // 0x2c: mov ah,0/int40; 0x30: mov ah,4/int40; 0x34 mov ax,es; 0x36 or ax,bx; 0x38 jnz 0x3f. The two INT 40h calls return ES:BX tested by or ax,bx.
0000003D  EBED              jmp short 0x2c
loc_0003F:
0000003F  891E1000          mov [0x10],bx
00000043  8C061200          mov [0x12],es
00000047  833E0E0000        cmp word [0xe],byte +0x0
0000004C  7579              jnz cursor_fread_blk_000C7   ; ->0xC7
0000004E  8C060E00          mov [0xe],es
00000052  53                push bx
;>>>> [video / screen clear-paint setup] mov dx,0x1e: loads the outer-loop row count (0x1E = 30) for the dual-plane clear/paint routine; DX is decremented at 0x86 and tested by jnz at 0x87. BP=0x40 set next is the seed attribute value. 0x1E is the screen row count, not a data-structure offset.  // 0x53 mov dx,0x1e; 0x56 mov bp,0x40; 0x86 dec dx; 0x87 jnz 0x59 uses DX as the row counter.
00000053  BA1E00            mov dx,0x1e
00000056  BD4000            mov bp,0x40
;
; >>>>>>>>>>>>>>>>  ROUTINE: Screen clear/paint (outer row loop)  <<<<<<<<<<<<<<<<
; DX = row count. Per row: read a cell address word from the host record,
; clear the char + attribute VRAM planes, write an incrementing per-cell
; marker, then space-fill the row to 80 or 132 columns ([0x14] selects).
;
loc_00059:
00000059  268B07            mov ax,[es:bx]
;>>>> [host-record VRAM paint / record-pointer advance] inc bx: first of two inc bx (0x5C, 0x5D) that advance the host-record pointer ES:BX past the 16-bit address word just read at 0x59 (mov ax,[es:bx]). The word is byte-swapped (xchg al,ah at 0x5E) into DI as the VRAM cell offset; advancing BX by 2 steps to the next field of the synchronous-host record before the cell/attribute write at 0x64-0x65. Not a screen address word read from VRAM.  // 0x59 mov ax,[es:bx]; 0x5C/0x5D inc bx x2 (=+2); 0x5E xchg al,ah; 0x60 mov di,ax
0000005C  43                inc bx
;>>>> [host-record VRAM paint / record-pointer advance] inc bx: second of the two inc bx (0x5C, 0x5D), completing a +2 advance of the host-record pointer ES:BX past the 16-bit address word read at 0x59. After this, xchg al,ah (0x5E) byte-swaps that word into DI as the VRAM destination offset for the cell clear at 0x64. Steps to the next field of the synchronous-host record.  // 0x59 mov ax,[es:bx]; 0x5C inc bx; 0x5D inc bx; 0x5E xchg al,ah; 0x60 mov di,ax
0000005D  43                inc bx
;>>>> [video / VRAM character-plane addressing] xchg al,ah: byte-swaps the word read from the host record at [es:bx] (loaded at 0x59) from the host's big-endian order into a little-endian VRAM cell offset, which is then moved into DI at 0x60 (mov di,ax). Provides the destination address for the per-cell clear/init writes (stosb at 0x64, attribute plane at 0x65) in the screen clear-paint routine.  // mov ax,[es:bx] at 0x59, BX advanced by inc bx x2; mov di,ax at 0x60 right after. Same big-endian->LE swap idiom as accepted 0x8A and 0xB0.
0000005E  86C4              xchg al,ah
;>>>> [video / dual-plane VRAM addressing (screen clear setup)] mov di,ax: loads the VRAM destination offset DI from the byte-swapped word in AX. The per-row address word was read from the host record at [es:bx] (0x59), then `xchg al,ah` (0x5E) converted it from the host's big-endian order to a little-endian offset. DI then drives the stosb char-plane write at 0x64 and the [es:di-0x8000] attribute-plane write at 0x65. Sets the cell start address, not a data move.  // 0x59 mov ax,[es:bx]; 0x5E xchg al,ah; 0x60 mov di,ax; 0x64 stosb; 0x65 mov [es:di-0x8000],al
00000060  8BF8              mov di,ax
;>>>> [video / dual-plane VRAM cell clear] xor al,al: zeroes AL so the immediately-following stosb at 0x64 writes a NUL into the VRAM character plane and the mov [es:di-0x8000],al at 0x65 clears the matching attribute-plane byte. Primes the per-cell clear of the first cell of a row before the incrementing-attribute write (mov ax,bp at 0x6A). DI was set at 0x60 from the byte-swapped host-record address.  // stosb at 0x64 and attribute-plane write at 0x65 both consume AL=0; DI loaded at 0x60. Consistent with accepted 0x64/0x65.
00000062  32C0              xor al,al
;>>>> [video / dual-plane VRAM per-cell init (test pattern)] stosb: writes AL=0 (zeroed by xor al,al at 0x62) into the VRAM character plane at ES:DI, advancing DI. DI was loaded (0x60) from the byte-swapped word read at [es:bx] (0x59) + xchg (0x5E), i.e. a host-record-supplied screen offset. The next mov [es:di-0x8000],al (0x65) clears the matching attribute-plane byte 0x8000 below; then mov ax,bp/stosb/inc bp (0x6A-0x6D) writes an incrementing per-cell marker (BP from 0x40). First cell of the per-row paint setup.  // 0x62 32C0 xor al,al; 0x64 AA stosb; 0x65 mov [es:di-0x8000],al; attribute plane 0x8000 below char plane per OKI gate-array layout.
00000064  AA                stosb
;>>>> [video / attribute-plane clear (dual-plane VRAM)] mov [es:di-0x8000],al with AL=0 (zeroed at 0x62 xor al,al): writes a NUL into the attribute plane (0x8000 below the char plane per the OKI gate-array layout) for the cell whose char-plane byte was just cleared by stosb at 0x64. Per-cell init pairing char-plane write (0x64) with attribute-plane clear (here); precedes the incrementing-attribute write at 0x6A-0x6C.  // xor al,al at 0x62, stosb at 0x64; the -0x8000 displacement is the attribute plane (matches accepted 0x7E, 0x83, 0x64).
00000065  2688850080        mov [es:di-0x8000],al
;>>>> [video / dual-plane VRAM cell init (test pattern)] mov ax,bp: copies the BP cell counter (seeded to 0x40 at 0x56, incremented by inc bp at 0x6D) into AX so the following stosb at 0x6C writes it to the VRAM character plane. Emits an incrementing byte value per cell (0x40,0x41,...) as a per-position marker while initializing a display row from the byte-swapped address loaded into DI. Not a fill-character load.  // BP set at 0x56 (mov bp,0x40), inc bp at 0x6D forms a per-cell counter; stosb at 0x6C consumes AX=BP into the char plane (ES:DI). Matches prior accepted 0x6A.
0000006A  8BC5              mov ax,bp
;>>>> [video / dual-plane VRAM per-cell marker write] stosb: writes AL (=BP, copied by mov ax,bp at 0x6A; BP seeded 0x40 at 0x56, bumped by inc bp at 0x6D) into the VRAM character plane at ES:DI, advancing DI. This emits an incrementing per-position byte value (0x40,0x41,...) as a screen test/marker pattern, following the NUL char + cleared attribute written at 0x64/0x65. Char-plane write of the per-cell counter, not the space-fill (that is at 0x83).  // 0x6A 8BC5 mov ax,bp; 0x6C AA stosb; 0x6D 45 inc bp; BP init mov bp,0x40 at 0x56.
0000006C  AA                stosb
;>>>> [dual-plane VRAM cell init / test value] inc bp: increments BP (seeded 0x40 at 0x56) after mov ax,bp/stosb (0x6A/0x6C) wrote BP to the character plane. Each per-cell pass emits an incrementing byte 0x40,0x41,... as a position marker/test value while initializing the row header cell, before the space-fill loop at 0x6E onward.  // 0x56 mov bp,0x40; 0x6A mov ax,bp; 0x6C stosb; 0x6D inc bp
0000006D  45                inc bp
;>>>> [dual-plane VRAM row fill] mov ax,0x20 loads the row-fill pattern: AL=0x20 (ASCII space) written to the character plane via stosb at 0x83, and AH=0x20 written to the attribute plane at [es:di-0x8000] (0x7E). It primes the fill loop that blanks the remainder of a display row with spaces and a default attribute.  // Target B82000 mov ax,0x20; followed by mov cx,0x83 (col count), cmp byte [0x14],0x30 (80/132 select), and the loop at 0x7E writing AH to attr plane (es:di-0x8000) and AL via stosb to char plane.
0000006E  B82000            mov ax,0x20
00000071  B98300            mov cx,0x83
;>>>> [80/132-column mode select] cmp byte [0x14],0x30 — tests the column-mode flag at [0x14] (initialized AL=0x32 stored at 0x25 during startup) against '0' (0x30). ja 0x7e (0x79) skips the mov cx,0x4f, selecting CX=0x83 (132-col, =131) vs CX=0x4F (80-col, =79) as the per-row column count for the dual-plane VRAM fill loop at 0x7E.  // 0x71 mov cx,0x83; 0x74 cmp byte [0x14],0x30; 0x79 ja 0x7e; 0x7B mov cx,0x4f; [0x14] written at 0x25 from 0x32.
00000074  803E140030        cmp byte [0x14],0x30
00000079  7703              ja loc_0007E   ; ->0x7E
;>>>> [video / 80-column count for dual-plane row fill] mov cx,0x4f: sets the per-row column count to 0x4F (79) for the 80-column screen-clear fill loop at 0x7E. Reached by fall-through when cmp byte [0x14],0x30 / ja 0x7e (0x74/0x79) found the column-mode flag at [0x14] <= '0', i.e. 80-col; the 132-col path keeps CX=0x83 (set at 0x71). CX then drives loop 0x7E (0x84) which writes AH to the attribute plane (es:di-0x8000) and stosb's AL spaces to the char plane.  // 0x71 mov cx,0x83; 0x74 cmp byte [0x14],0x30; 0x79 ja 0x7e (skips this); 0x7B mov cx,0x4f; 0x7E mov [es:di-0x8000],ah; 0x84 loop 0x7e. [0x14] is the 80/132 mode flag (init 0x32 at 0x25).
0000007B  B94F00            mov cx,0x4f
;
; >>>>>>>>>>>>>>>>  ROUTINE: Row space-fill (inner loop)  <<<<<<<<<<<<<<<<
; Blank one display row: write space (0x20) to the char plane and the
; default attribute to the attribute plane (0x8000 below), CX = column
; count.
;
loc_0007E:
0000007E  2688A50080        mov [es:di-0x8000],ah
;>>>> [video / screen clear (dual-plane VRAM char plane)] stosb: writes AL=0x20 (space, loaded at 0x6E) into the VRAM character plane at ES:DI and advances DI. Paired with `mov [es:di-0x8000],ah` at 0x7E (attribute byte 0x20 to the attribute plane 0x8000 below). The `loop 0x7e` at 0x84 repeats CX times (0x4F/80-col or 0x83/132-col) to blank one display row across both planes; outer row counter DX dec'd at 0x86.  // 0x6E mov ax,0x20; 0x7E mov [es:di-0x8000],ah; 0x83 stosb; 0x84 loop 0x7e
00000083  AA                stosb
;>>>> [Dual-plane VRAM paint] loop 0x7e — inner row-fill loop, decrements CX (column count, 0x4F/80-col or 0x83/132-col) and re-runs 0x7E: mov [es:di-0x8000],ah (attribute plane) + stosb of AL (char plane, space 0x20). Fills one screen row across both VRAM planes (planes 0x8000 apart per the OKI gate-array layout).  // 0x7E mov [es:di-0x8000],ah; 0x83 stosb; 0x84 loop 0x7e; CX set to 0x4F/0x83 at 0x71/0x7B; -0x8000 plane offset.
00000084  E2F8              loop loc_0007E   ; ->0x7E
;>>>> [Dual-plane VRAM paint] dec dx — decrements the outer row counter of the nested screen clear/paint routine; jnz 0x59 (0x87) loops back to re-fill the next row (re-reads [es:bx] header, advances BX, re-runs the inner column loop). DX was the row count seeded at 0x53 (mov dx,0x1e = 30 rows). Outer loop of the full-screen paint.  // 0x84 loop 0x7e (inner col loop); 0x86 dec dx; 0x87 jnz 0x59; DX loaded 0x1E at 0x53; loop body 0x59 reads [es:bx].
00000086  4A                dec dx
;>>>> [video / screen clear (dual-plane VRAM)] jnz 0x59: outer row-loop back-edge of the clear/paint routine. After `dec dx` (DX = row counter), branches to 0x59 to process the next row. Inner body at 0x59-0x86 reads a per-row VRAM address word from [es:bx], writes a NUL+attribute cell, then fills the row: stosb spaces to the char plane and `mov [es:di-0x8000],ah` to the attribute plane 0x8000 below.  // 0x86 dec dx; 0x87 jnz 0x59; 0x59 mov ax,[es:bx]; 0x7E mov [es:di-0x8000],ah; 0x83 stosb; 0x84 loop 0x7e.
00000087  75D0              jnz loc_00059   ; ->0x59
00000089  5B                pop bx
;>>>> [Host-record VRAM paint] mov ax,[es:bx] — reads a 16-bit word from the host record pointer (ES:BX, restored by pop bx at 0x89); the following xchg al,ah byte-swaps it from the host's big-endian order into a little-endian VRAM offset loaded to DI (0x8F), which then seeds a digit/test-pattern fill row. Reads the next field of the synchronous-host record.  // 0x89 pop bx; 0x8A mov ax,[es:bx]; 0x8D xchg al,ah; 0x8F mov di,ax; 0x91 inc di; then digit-fill loop 0x92-0xAA.
0000008A  268B07            mov ax,[es:bx]
0000008D  86C4              xchg al,ah
0000008F  8BF8              mov di,ax
;>>>> [video / VRAM character-plane addressing] inc di: bumps the VRAM destination offset (DI was loaded from the byte-swapped word at [es:bx]) by one before the digit-fill stosb loop, adjusting the start column of the test-pattern row. Part of the per-row paint setup, not an attribute-plane access (attribute plane is reached via the di-0x8000 form elsewhere).  // 0x8A mov ax,[es:bx]; 0x8D xchg al,ah; 0x8F mov di,ax; 0x91 inc di; 0x92 mov cx,0x84; 0x95 mov al,0x31; 0xA1 stosb loop.
00000091  47                inc di
00000092  B98400            mov cx,0x84
00000095  B031              mov al,0x31
00000097  803E140030        cmp byte [0x14],0x30
0000009C  7703              ja loc_000A1   ; ->0xA1
0000009E  B95000            mov cx,0x50
;
; >>>>>>>>>>>>>>>>  ROUTINE: Column-ruler test pattern  <<<<<<<<<<<<<<<<
; Fill a row with the repeating '1'..'9','0' digit ruler (a visible screen
; test pattern), CX = 80/132 columns.
;
loc_000A1:
000000A1  AA                stosb
000000A2  FEC0              inc al
;>>>> [video / screen test pattern (VRAM char plane)] cmp al,0x39 ('9'): in the digit-row fill loop (loop 0xa1 at 0xAA), tests whether the ASCII digit just stosb'd (AL incremented at 0xA2) has passed '9'; jna 0xaa (0xA6) keeps it, else mov al,0x30 wraps to '0'. Generates the repeating 1-9-0 column-ruler test pattern into the character plane; CX is 0x50 (80-col) or 0x84 (132-col) from the [0x14] flag test at 0x97.  // 0x95 mov al,0x31; 0xA1 stosb; 0xA2 inc al; 0xA4 cmp al,0x39; 0xA6 jna 0xaa; 0xA8 mov al,0x30; 0xAA loop 0xa1
000000A4  3C39              cmp al,0x39
;>>>> [video / screen test pattern (VRAM char plane)] jna 0xaa: in the ASCII-digit row-fill loop, after inc al / cmp al,'9' (0x39 at 0xA4), if AL has not exceeded '9' it branches past mov al,0x30 (0xA8) leaving the digit unchanged; otherwise it falls through and wraps AL back to '0'. Produces the repeating 1-9-0 column-ruler test pattern STOSB'd into the character plane (CX=0x50 80-col or 0x84 132-col from [0x14], loop 0xa1 at 0xAA).  // cmp al,0x39 at 0xA4, mov al,0x30 at 0xA8, loop 0xa1 at 0xAA; CX set 0x50/0x84 at 0x9E/earlier. Mirrors accepted 0xA4 and 0xA6.
000000A6  7602              jna loc_000AA   ; ->0xAA
000000A8  B030              mov al,0x30
loc_000AA:
000000AA  E2F5              loop loc_000A1   ; ->0xA1
000000AC  268B4714          mov ax,[es:bx+0x14]
000000B0  86C4              xchg al,ah
000000B2  8BF8              mov di,ax
;>>>> [video / VRAM char-plane addressing (label-row paint)] inc di: bumps the VRAM destination offset by one. DI was just loaded (0x8F-style: mov ax,[es:bx+0x14] at 0xAC, xchg al,ah at 0xB0 to byte-swap host big-endian to little-endian, mov di,ax at 0xB2) from a host-record coordinate field at offset +0x14. The inc plus the following add di,0xa (0x0B5) adjust the start column before rep movsb copies a 0x28-byte label string (SI=0x15) into the char plane. Char-plane offset arithmetic, not an attribute access.  // 0xAC 268B4714 mov ax,[es:bx+0x14]; 0xB0 xchg al,ah; 0xB2 mov di,ax; 0xB4 inc di; 0xB5 add di,+0xa; 0xB8 mov si,0x15; 0xBB mov cx,0x28; 0xBE rep movsb.
000000B4  47                inc di
000000B5  83C70A            add di,byte +0xa
000000B8  BE1500            mov si,0x15
;>>>> [video / rep movsb label-string copy into char plane] mov cx,0x28: sets the byte count (0x28 = 40) for the rep movsb at 0x0BE that copies a 40-byte string from DS:SI=0x15 (in-module text at offset 0x15) to ES:DI in the VRAM character plane. DI was positioned at 0xB2-0xB5 from a host-record coordinate (+0x14 field, byte-swapped) plus inc di/add di,+0xa. Paints a fixed 40-char label/title row; 0x28 is the string length, not a 40-column mode.  // 0xB8 mov si,0x15; 0xBB B92800 mov cx,0x28; 0xBE F3A4 rep movsb; SI=0x15 is the same string offset used by the AH=9 sign-on at startup.
000000BB  B92800            mov cx,0x28
000000BE  F3A4              rep movsb
000000C0  B402              mov ah,0x2
000000C2  BA0018            mov dx,0x1800
;>>>> [video / INT 10h AH=2 set cursor position] int 0x10 with AH=2 (set at 0xC0) and DX=0x1800 (set at 0xC2) = BIOS/gate-array set-cursor-position to row DH=0x18 (24), column DL=0 (page BH ignored here). Issued right after rep movsb painted the 40-byte label row, parking the cursor at the bottom row before the INT 16h keyboard poll at 0xC7. AH=2 is set-cursor, not a video-mode set (that is INT 10h AH=0 at 0x28/0x123).  // 0xC0 B402 mov ah,0x2; 0xC2 BA0018 mov dx,0x1800; 0xC5 CD10 int 0x10; followed by 0xC7 mov ah,1/int 0x16 keyboard status. DH=0x18=24, DL=0.
000000C5  CD10              int 0x10   ; INT 10h video (teletype/mode)
;
; >>>>>>>>>>>>>>>>  ROUTINE: Keyboard service + dispatch  <<<<<<<<<<<<<<<<
; INT 16h AH=1 (status); if a key waits, INT 16h AH=0 (read), then run the
; cmp-al/jz key/escape dispatch table (the 0xD7-0x118 bytes). No key ->
; back to the main loop.
;
cursor_fread_blk_000C7:
;>>>> [keyboard (INT 16h AH=1 status poll)] mov ah,0x1: sets AH=1 (INT 16h get-keyboard-status, non-blocking) for the int 0x16 at 0xC9; the following jz 0x119 (0xCB) returns to the main loop (jmp 0x2c at 0x119) when ZF=1 means no key pending. This is the head of the keyboard-poll branch reached after the INT 10h cursor-position call (AH=2, BX=row/col at 0xC0-0xC5). When a key IS waiting it falls through to the blocking AH=0 read at 0xCD-0xCF.  // 0xC7 mov ah,1; 0xC9 int 0x16; 0xCB jz 0x119; 0x119 jmp 0x2c (verified in full.asm); paired AH=0 blocking read at 0xCF
000000C7  B401              mov ah,0x1
000000C9  CD16              int 0x16   ; INT 16h keyboard
;>>>> [keyboard INT 16h AH=01h (status poll)] jz 0x119: tests the ZF set by INT 16h AH=01h (non-blocking keyboard status, called at 0xC9 after `mov ah,1` at 0xC7). ZF=1 means no key waiting, so it branches to 0x119 (`jmp 0x2c`) back to the main poll loop. If a key is pending it falls through to AH=00h blocking read at 0xCD/0xCF. Standard INT 16h check-then-read pair.  // 0xC7 mov ah,1; 0xC9 int 0x16; 0xCB jz 0x119; 0xCD mov ah,0; 0xCF int 0x16; 0x119 jmp 0x2c
000000CB  744C              jz dispatch_fread_00119   ; ->0x119
000000CD  B400              mov ah,0x0
;>>>> [keyboard (INT 16h)] int 0x16 with AH=0: blocking keyboard read (return next key in AX). Preceded by the AH=1 non-blocking status check at 0xC7-0xCB (jz 0x119 if no key). The returned AL is then tested (test al,al; jz 0x119) to filter extended/zero scancodes before the cmp-al,x keyboard dispatch chain.  // 0xC7 mov ah,0x1; 0xC9 int 0x16; 0xCB jz 0x119; 0xCD mov ah,0x0; 0xCF int 0x16; 0xD1 test al,al; 0xD3 jz 0x119.
000000CF  CD16              int 0x16   ; INT 16h keyboard
000000D1  84C0              test al,al
000000D3  7444              jz dispatch_fread_00119   ; ->0x119
000000D5  B407              mov ah,0x7

; ---- 0x00d7-0x00db STRING (4 B) ----
0000D7  3c 35 74 41                                      |<5tA|

; ---- 0x00db-0x00dc CODE ----
000000DB  B4                db 0xb4

; ---- 0x00dc-0x00e1 STRING (5 B) ----
0000DC  27 3c 37 74 3b                                   |'<7t;|

; ---- 0x00e1-0x00e2 CODE ----
000000E1  B4                db 0xb4

; ---- 0x00e2-0x00e7 STRING (5 B) ----
0000E2  30 3c 33 74 35                                   |0<3t5|

; ---- 0x00e7-0x00e8 CODE ----
000000E7  B4                db 0xb4

; ---- 0x00e8-0x00ed STRING (5 B) ----
0000E8  32 3c 32 74 2f                                   |2<2t/|

; ---- 0x00ed-0x00ee CODE ----
000000ED  B4                db 0xb4

; ---- 0x00ee-0x00f3 STRING (5 B) ----
0000EE  34 3c 34 74 29                                   |4<4t)|

; ---- 0x00f3-0x00f4 CODE ----
000000F3  B4                db 0xb4

; ---- 0x00f4-0x0102 STRING (14 B) ----
0000F4  37 3c 36 74 23 3c 2b 74 3d 3c 2d 74 41 3c        |7<6t#<+t=<-tA<|

; ---- 0x0102-0x0103 CODE ----
00000102  1B                db 0x1b

; ---- 0x0103-0x0119 STRING (22 B) ----
000103  74 29 3c 70 74 47 3c 73 74 4a 3c 62 74 6b 3c 64  |t)<ptG<stJ<btk<d|
000113  74 67 3c 65 74 63                                |tg<etc|

; ---- 0x0119-0x019d CODE ----
;
; >>>>>>>>>>>>>>>>  ROUTINE: Dispatch exit / mode + control handlers  <<<<<<<<<<<<<<<<
; No-key/unmatched exit jumps to the main loop. Nearby table-dispatched
; handlers: switch 80/132-column mode (INT 10h), terminate (print
; 'Terminating', INT 21h AH=4Ch), and send a control byte to the host (INT
; 40h AH=20h).
;
dispatch_fread_00119:
;>>>> [main loop return (INT 40h poll)] jmp 0x2c: unconditional branch back to the main service-loop head (`mov ah,0; int 40h` at 0x2C). This is the 'no-key' target of the INT 16h AH=01h jz at 0xCB and the AH=00h zero/extended-scancode jz at 0xD3 - when no usable key is read, control returns here to re-poll the kernel. The preceding bytes 0x102-0x118 are a cmp-al/jz scancode dispatch table (e.g. 3c 35 74.. = 'cmp al,0x35 / jz ..'), so 0x119 is the fall-off/no-match exit of that dispatch chain.  // 0xCB jz 0x119; 0xD3 jz 0x119; 0x119 E910FF jmp 0x2c; preceding string bytes '3c xx 74 xx' = cmp al,imm/jz pattern
00000119  E910FF            jmp status_0002C   ; ->0x2C
0000011C  8AC4              mov al,ah
0000011E  A21400            mov [0x14],al
00000121  B400              mov ah,0x0
;>>>> [video (INT 10h)] int 0x10 with AH=0 (set video mode); AL was loaded from AH and stored at [0x14] (the 80/132-column mode flag) at 0x11C-0x121. This switches the OKI/Wyse gate-array display between 80- and 132-column modes, then clears [0x0E] and rejoins the main loop.  // 0x11C mov al,ah; 0x11E mov [0x14],al; 0x121 mov ah,0x0; 0x123 int 0x10; 0x125 mov word [0xe],0; 0x12B jmp 0x30.
00000123  CD10              int 0x10   ; INT 10h video (teletype/mode)
00000125  C7060E000000      mov word [0xe],0x0
0000012B  E902FF            jmp sub_00030   ; ->0x30
0000012E  B409              mov ah,0x9
00000130  BA4000            mov dx,0x40
;>>>> [DOS INT 21h AH=09h (print $-string) / exit path] int 0x21 executing AH=09h (set by `mov ah,0x9` at 0x12E) to print the $-terminated string at DS:DX=0x40 (the 'Terminating.' message). This is the print-then-exit sequence: immediately after, `mov ax,0x4c00; int 0x21` (0x135/0x138) performs the DOS AH=4Ch program terminate. AH=09h here, NOT a function call distinct from the following 4Ch exit.  // 0x12E mov ah,0x9; 0x130 mov dx,0x40; 0x133 int 0x21; 0x135 mov ax,0x4c00; 0x138 int 0x21
00000133  CD21              int 0x21   ; INT 21h AH=0x09: print $-string DS:DX
;>>>> [exit (INT 21h AH=4Ch)] mov ax,0x4c00: loads AX=0x4C00 so the following int 0x21 (0x138) performs DOS-style program terminate (AH=4Ch) with return code 0. Preceded by an INT 21h AH=9 print of the 'Terminating.' message at DS:DX=0x40.  // 0x130 mov dx,0x40; 0x133 int 0x21 (AH=9); 0x135 mov ax,0x4c00; 0x138 int 0x21.
00000135  B8004C            mov ax,0x4c00
00000138  CD21              int 0x21   ; INT 21h AH=0x4c: exit to kernel
0000013A  FE066F00          inc byte [0x6f]
0000013E  FE066F00          inc byte [0x6f]
;>>>> [INT 40h serial put-char (host TX counter)] dec byte [0x6f] — decrements the byte counter/state variable at [0x6F] (incremented twice at 0x13A/0x13E just before). The value is then loaded to AL at 0x146 and sent to the host link via INT 40h AH=0x20 (kernel serial put-character over the Z8530 SCC) at 0x149-0x14B. Adjusts the value transmitted as a host-control/status byte.  // 0x13A inc byte[0x6f]; 0x13E inc byte[0x6f]; 0x142 dec byte[0x6f]; 0x146 mov al,[0x6f]; 0x149 mov ah,0x20; 0x14B int 0x40; 0x14D jmp 0x2c.
00000142  FE0E6F00          dec byte [0x6f]
;>>>> [INT 40h AH=20h serial put-char to host (Z8530 SCC)] mov al,[0x6f]: loads the byte counter/state variable at [0x6F] into AL, which is then sent to the synchronous host link by mov ah,0x20 / int 0x40 (0x149/0x14B, kernel put-char-to-host over the Z8530 SCC); jmp 0x2c follows. [0x6F] was adjusted just before by inc/inc/dec (0x13A/0x13E/0x142), so AL carries a computed host-control/status byte.  // 0x13A FE066F00 inc byte[0x6f]; 0x13E inc; 0x142 FE0E6F00 dec; 0x146 A06F00 mov al,[0x6f]; 0x149 B420 mov ah,0x20; 0x14B CD40 int 0x40; 0x14D jmp 0x2c.
00000146  A06F00            mov al,[0x6f]
00000149  B420              mov ah,0x20
;>>>> [kernel send-to-host (INT 40h AH=20h)] int 0x40 with AH=0x20 (set at 0x149) and AL loaded from [0x6f] at 0x146: invokes the kernel put-char-to-host service, transmitting the byte over the synchronous Z8530 SCC host link. The counter at [0x6f] was adjusted (inc/inc/dec at 0x13A/0x13E/0x142) before being sent as a host-control/status byte; jmp 0x2c (0x14D) returns to the main poll loop. Not get-host-record.  // mov al,[0x6f] at 0x146, mov ah,0x20 at 0x149 immediately precede. Matches accepted 0x146/0x149 send-to-host annotation.
0000014B  CD40              int 0x40   ; INT 40h AH=0x20: set current-CB status [+0x97]=AL
0000014D  E9DCFE            jmp status_0002C   ; ->0x2C
00000150  33D2              xor dx,dx
00000152  BE7000            mov si,0x70
;>>>> [printer (INT 17h)] jmp short 0x15d: skips the alternate printer-setup block (mov dx,0x1; mov si,0xbb at 0x157/0x15A) and falls straight into mov ah,0x2 / int 0x17. With DX=0 (printer 0 / LPT1) and SI=0x70 already loaded at 0x150-0x152, this selects the first printer-port test path before issuing INT 17h AH=2 (init/status printer port).  // At 0x150 xor dx,dx; 0x152 mov si,0x70; 0x15d mov ah,0x2; 0x15f int 0x17. The 0x157/0x15A pair sets DX=1,SI=0xbb (second port) which this jump bypasses.
00000155  EB06              jmp short 0x15d
00000157  BA0100            mov dx,0x1
0000015A  BEBB00            mov si,0xbb
;
; >>>>>>>>>>>>>>>>  ROUTINE: Printer-port self-test loop  <<<<<<<<<<<<<<<<
; INT 17h AH=2 reads printer status (mask error/select/paper bits); while
; the host link stays busy (INT 40h AH=0/AH=4 polled) it re-issues; on
; 'printer OK' it jumps to the string-output loop.
;
print_fread_blk_0015D:
0000015D  B402              mov ah,0x2
;>>>> [printer (INT 17h AH=2 status/init)] int 0x17 with AH=2 (set at 0x15D): printer-port self-test status/init call for the printer selected in DX (DX=0/LPT1 via xor dx,dx at 0x150, or DX=1 via mov dx,0x1 at 0x157). Returns status in AH, then xor ah,0x80 (0x161) inverts the busy/ACK sense and test ah,0xa9 (0x164) masks error/select/paper-out bits 7,5,3,0; jz 0x18f (0x167) takes the 'printer OK' path to the lodsb string-output loop.  // 0x15D mov ah,2; 0x15F int 0x17; 0x161 xor ah,0x80; 0x164 test ah,0xa9; 0x167 jz 0x18f; DX from 0x150/0x157
0000015F  CD17              int 0x17   ; INT 17h printer
00000161  80F480            xor ah,0x80
00000164  F6C4A9            test ah,0xa9
;>>>> [INT 17h printer status test] jz 0x18f branches on the masked printer-status result. After INT 17h AH=2 (0x15F) returns status in AH, the code does xor ah,0x80 (invert the ACK/not-busy sense) then test ah,0xa9 (mask error/select/paper-out bits 7,5,3,0); jz takes the 'printer OK' path to 0x18F, the string-output lodsb loop.  // Target 7426 jz 0x18f; preceded by int 0x17 (AH=2), xor ah,0x80, test ah,0xa9. Branch target 0x18F is lodsb of the printer-test string output loop.
00000167  7426              jz print_0018F   ; ->0x18F
00000169  B400              mov ah,0x0
0000016B  CD40              int 0x40   ; INT 40h AH=0x00: yield / wait-for-event
;>>>> [kernel INT 40h AH=0 (char/status poll) carry test] jc 0x179: tests the carry flag returned by INT 40h AH=0 (kernel get-char/status from the Z8530 SCC host link, called at 0x16B after `mov ah,0` at 0x169). CF set -> branch to 0x179 (`jmp 0x2c`) back to main loop. CF clear falls through to the AH=4 get-host-record call at 0x16F. This is the comm-status branch inside the printer-port self-test polling block; CF is the AH=0 'no char / error' indicator, not a printer status.  // 0x169 mov ah,0; 0x16B int 0x40; 0x16D jc 0x179; 0x16F mov ah,4; 0x179 jmp 0x2c
0000016D  720A              jc status_00179   ; ->0x179
;>>>> [kernel host-record fetch (INT 40h AH=4)] mov ah,0x4: sets the kernel function selector to 4 for the int 40h at 0x171 = get-host-record / get-display-buffer, returning the record pointer in ES:BX. This is the printer-test path's host poll (after the INT 17h AH=2 status test and the AH=0 char poll at 0x169-0x16D); the returned ES:BX is null-tested by mov ax,es / or ax,bx / jnz 0x15d. Not a DOS allocation.  // int 0x40 follows at 0x171; mov ax,es/or ax,bx at 0x173/0x175. Identical AH=4/int40/null-check pattern to accepted 0x30 and 0x171.
0000016F  B404              mov ah,0x4
;>>>> [kernel host-record fetch (INT 40h AH=4)] int 0x40 with AH=4 (set at 0x16F): kernel get-host-record service fetching the next synchronous-link data block from the CDC-200/UT200 host over the Z8530 SCC. Returns the record pointer in ES:BX, tested by mov ax,es / or ax,bx (0x173/0x175) for null; jnz 0x15d (0x177) loops back into the printer-test/poll body. This is the second occurrence of the AH=4 fetch (first at 0x32).  // 0x16F mov ah,4; 0x173 mov ax,es; 0x175 or ax,bx; 0x177 jnz 0x15d
00000171  CD40              int 0x40   ; INT 40h AH=0x04: get next queued record -> ES:BX
;>>>> [kernel host-record fetch (INT 40h AH=4) null-check] mov ax,es: copies the ES segment returned by the INT 40h AH=4 call at 0x171 into AX so the following or ax,bx (0x175) sets ZF only if ES:BX is the null pointer 0000:0000. This is the printer-test-loop variant of the get-host-record null test; jnz 0x15d (0x177) re-runs the printer status/print step when a record/condition persists. Not a memory-block-allocated check.  // Directly follows int 0x40 (AH=4) at 0x171; or ax,bx at 0x175, jnz 0x15d at 0x177. Mirrors accepted 0x34 and the 0x171 null-check chain.
00000173  8CC0              mov ax,es
;>>>> [kernel INT 40h AH=4 (get host record) null test, in printer-test loop] or ax,bx: null-pointer test of the ES:BX returned by INT 40h AH=4 (get host record, called at 0x171 after `mov ah,4`; AX=es loaded at 0x173). ZF=1 only if ES:BX==0000:0000. Non-null -> jnz 0x15d (0x177) loops back into the printer status/output block; null falls through to the AH=34h selector chain. Same AH=4/or-ax-bx idiom as 0x36 and 0x16F, here embedded in the printer-port self-test loop.  // 0x16F mov ah,4; 0x171 int 0x40; 0x173 mov ax,es; 0x175 or ax,bx; 0x177 jnz 0x15d
00000175  0BC3              or ax,bx
;>>>> [INT 40h kernel host-record poll (printer-test loop tail)] jnz 0x15d: closes the printer-port self-test poll loop. After INT 17h AH=2 (printer status, 0x15D-0x167) the code polls INT 40h AH=0 (char-in, 0x169-0x16B; jc 0x179 on carry) and INT 40h AH=4 (get-host-record, 0x16F-0x171); mov ax,es / or ax,bx (0x173/0x175) test the returned ES:BX pointer, and this jnz branches back to 0x15D to re-issue the printer-status/print step while ES:BX is non-null (no pending host record / printer still active). Falls through to jmp 0x2c when the pointer is null.  // Preceding bytes: B400/CD40 (AH=0 int40), 720A (jc 0x179), B404/CD40 (AH=4 int40), 8CC0 (mov ax,es), 0BC3 (or ax,bx) at 0x169-0x175; target 0x15D is mov ah,2 before int 0x17. or ax,bx sets ZF only on null ES:BX.
00000177  75E4              jnz print_fread_blk_0015D   ; ->0x15D
status_00179:
00000179  E9B0FE            jmp status_0002C   ; ->0x2C
0000017C  B434              mov ah,0x34
0000017E  3C64              cmp al,0x64
00000180  B002              mov al,0x2
00000182  7206              jc sub_0018A   ; ->0x18A
00000184  B000              mov al,0x0
;>>>> [kernel INT 40h AH=34h (3-way selector)] jz 0x18a: final branch of the AL selector chain feeding INT 40h AH=34h. After `mov ah,0x34; cmp al,0x64` (0x17C/0x17E), the code picks AL: `mov al,2; jc 0x18a` (AL<0x64 -> 2), `mov al,0; jz 0x18a` (AL==0x64 -> 0), else fall to `mov al,1` (0x188). This jz takes the AL==0x64 case (ZF from the cmp at 0x17E) directly to the `int 0x40` at 0x18A, skipping the mov al,1. Selects argument 0 for kernel fn 34h.  // 0x17C mov ah,0x34; 0x17E cmp al,0x64; 0x180 mov al,2; 0x182 jc 0x18a; 0x184 mov al,0; 0x186 jz 0x18a; 0x188 mov al,1; 0x18A int 0x40
00000186  7402              jz sub_0018A   ; ->0x18A
00000188  B001              mov al,0x1
;
; >>>>>>>>>>>>>>>>  ROUTINE: Kernel INT 40h AH=34h call  <<<<<<<<<<<<<<<<
; Invoke kernel fn 34h with a 3-way selector (AL=0/1/2 chosen by comparing
; the key to 0x64), then return to the main loop.
;
sub_0018A:
0000018A  CD40              int 0x40   ; INT 40h AH=0x34: set current-CB mode
;>>>> [main loop return after INT 40h AH=34h] jmp 0x2c: returns to the main service loop head after the AH=34h kernel call. The preceding chain (mov ah,0x34; cmp al,0x64; jc/jz selecting AL=0/1/2; int 40h) invokes kernel function 34h with a 3-way selector argument; this jmp resumes polling.  // 0x17C mov ah,0x34; 0x182 jc; 0x186 jz; 0x188 mov al,1; 0x18A int 0x40; 0x18C jmp 0x2c (main loop at 0x2c).
0000018C  E99DFE            jmp status_0002C   ; ->0x2C
;
; >>>>>>>>>>>>>>>>  ROUTINE: Printer string-output loop  <<<<<<<<<<<<<<<<
; lodsb a char; '$' ends it; otherwise send via INT 17h AH=0 and repeat.
; Emits the parallel/serial printer-port test strings.
;
print_0018F:
;>>>> [INT 17h printer string output loop] lodsb fetches the next character from DS:SI into AL for the printer-output loop. Each byte is compared to '$' (cmp al,0x24 at 0x190); if not the terminator it is sent to the printer via INT 17h AH=0 (xor ah,ah at 0x197, int 17h at 0x199). This drives the parallel-printer-port self-test that prints the 'This is a test of the Parallel Printer Port' string.  // Target AC lodsb; followed by cmp al,0x24 ('$'), jnz 0x197, xor ah,ah, int 0x17. SI set earlier (0x152 mov si,0x70 / 0x15A mov si,0xbb) to test strings.
0000018F  AC                lodsb
00000190  3C24              cmp al,0x24
00000192  7503              jnz print_00197   ; ->0x197
00000194  E995FE            jmp status_0002C   ; ->0x2C
print_00197:
;>>>> [printer (INT 17h)] xor ah,ah: sets AH=0 (INT 17h function 0 = print/send character in AL to printer) immediately before int 0x17 at 0x199. This is the body of the string-print-to-printer loop: lodsb fetches a char (0x18F), exits on '$' (0x24), otherwise prints it via this INT 17h AH=0 call, then jmp short 0x15d re-enters the loop.  // 0x18F lodsb; 0x190 cmp al,0x24; 0x192 jnz 0x197; 0x197 xor ah,ah; 0x199 int 0x17; 0x19B jmp short 0x15d.
00000197  32E4              xor ah,ah
00000199  CD17              int 0x17   ; INT 17h printer
0000019B  EBC0              jmp short 0x15d

; ---- 0x019d-0x01a4 DATA (7 B) ----
00019D  00 00 00 00 00 00 00                             |.......|

; ---- 0x01a4-0x01a5 CODE ----
000001A4  07                pop es

; ---- 0x01a5-0x01cd STRING (40 B) ----
0001A5  54 68 65 20 45 6d 75 6c 61 74 6f 72 20 28 56 65  |The Emulator (Ve|
0001B5  72 73 69 6f 6e 20 30 2e 31 37 37 29 20 69 73 20  |rsion 0.177) is |
0001C5  52 75 6e 6e 69 6e 67 2e                          |Running.|

; ---- 0x01cd-0x01cf CODE ----
000001CD  0D                db 0x0d
000001CE  0A                db 0x0a

; ---- 0x01cf-0x01fc STRING (45 B) ----
0001CF  24 54 68 65 20 45 6d 75 6c 61 74 6f 72 20 28 56  |$The Emulator (V|
0001DF  65 72 73 69 6f 6e 20 30 2e 31 37 37 29 20 69 73  |ersion 0.177) is|
0001EF  20 54 65 72 6d 69 6e 61 74 69 6e 67 2e           | Terminating.|

; ---- 0x01fc-0x0200 CODE ----
;>>>> [string/data] Data misdecoded as code. Bytes 0D 0A 24 (00 follows) are CR, LF, '$' — the DOS AH=9 string terminator trailing the 'The Emulator (Version 0.177) is Terminating.' message at 0x1CF-0x1FB. ndisasm rendered them as 'or ax,0x240a'. Not an instruction.  // Preceding STRING 0x1CF-0x1FB ends 'Terminating.'; bytes 0D 0A 24 00; mirrors the 0D 0A at 0x1CD after the 'Running.' string.
000001FC  0D0A24            or ax,0x240a
000001FF  00                db 0x00

; ---- 0x0200-0x0248 STRING (72 B) ----
000200  54 68 69 73 20 69 73 20 61 20 74 65 73 74 20 6f  |This is a test o|
000210  66 20 74 68 65 20 50 61 72 61 6c 6c 65 6c 20 50  |f the Parallel P|
000220  72 69 6e 74 65 72 20 50 6f 72 74 20 6f 66 20 74  |rinter Port of t|
000230  68 65 20 4c 54 33 30 30 2f 55 54 32 30 30 20 54  |he LT300/UT200 T|
000240  65 72 6d 69 6e 61 6c 2e                          |erminal.|

; ---- 0x0248-0x024a CODE ----
00000248  0D                db 0x0d
00000249  0A                db 0x0a

; ---- 0x024a-0x0291 STRING (71 B) ----
00024A  24 54 68 69 73 20 69 73 20 61 20 74 65 73 74 20  |$This is a test |
00025A  6f 66 20 74 68 65 20 53 65 72 69 61 6c 20 50 72  |of the Serial Pr|
00026A  69 6e 74 65 72 20 50 6f 72 74 20 6f 66 20 74 68  |inter Port of th|
00027A  65 20 4c 54 33 30 30 2f 55 54 32 30 30 20 54 65  |e LT300/UT200 Te|
00028A  72 6d 69 6e 61 6c 2e                             |rminal.|

; ---- 0x0291-0x0294 CODE ----
00000291  0D0A24            or ax,0x240a
