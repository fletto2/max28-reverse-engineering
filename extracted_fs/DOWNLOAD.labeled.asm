; ============================================================================
; DOWNLOAD.EXE  -  serial file-download / firmware-load utility ("File Transfer v0.3")
; ----------------------------------------------------------------------------
; WHAT IT DOES: an XMODEM-style RECEIVER that runs on the terminal. It allocates a
; ~240 KiB RAM staging buffer (INT 21h AH=48h), then runs a block-protocol receive
; loop over the serial line via the kernel comm API (INT 40h) - pulling a file from a
; host PC running an XMODEM SEND - while painting a live "Blocks/Bytes Received"
; status screen to VRAM. It stages the received image in RAM; committing it (e.g. to
; the flash filesystem) is the kernel's job - this module issues no flash writes.
; The ;>>>> lines below are cross-verified per-instruction annotations.
; ============================================================================

; DOWNLOAD.EXE - code/data-separated disassembly (MZ load module, 1530 B, header 512 B stripped)
; entry @0x0000; 1 relocs. Classified CODE-unless-data-filter-fires
; (recursive descent under-covers C-runtime startups). Bytes: 985 code / 256 string / 289 data.
;

; ---- 0x0000-0x03bc CODE ----
;
; >>>>>>>>>>>>>>>>  ROUTINE: STARTUP  <<<<<<<<<<<<<<<<
; Print banner (INT 21h AH=9), shrink memory (AH=4Ah), set video mode 7
; (INT 10h), allocate two RAM staging buffers (AH=48h: 128 KiB + 112 KiB),
; register the receive buffer (INT 40h AH=2Eh), then loop: poll (0x60) ->
; send status (0x1FC) -> redraw status screen (0x219) -> INT 40h AH=0
; yield -> repeat.
;
00000000  1E                push ds
00000001  B83B00            mov ax,0x3b
00000004  8ED8              mov ds,ax
;>>>> [INT 21h AH=9 string output (startup banner)] `mov ah,0x9` selects DOS-style INT 21h print-$-terminated-string. Preceded by push ds / mov ax,0x3b / mov ds,ax (set DS=banner segment) and followed by mov dx,0xd5 / int 0x21 (0x0B), it prints the program startup banner at DS:DX=3B:00D5 via the resident kernel's INT 21h AH=9 service.  // 0x00 push ds; 0x01 mov ax,0x3b; 0x04 mov ds,ax; 0x06 mov ah,0x9; 0x08 mov dx,0xd5; 0x0B int 0x21.
00000006  B409              mov ah,0x9
00000008  BAD500            mov dx,0xd5
0000000B  CD21              int 0x21   ; INT 21h AH=0x09: print $-string DS:DX
0000000D  07                pop es
;>>>> [DOS/MZ startup memory sizing (INT 21h AH=4Ah)] `mov bx,sp` begins computing the resident program size in paragraphs: BX=SP, then add 0xf and shr 4 rounds the stack top up to a paragraph, add SS (0x16/0x18) forms the absolute top-of-image paragraph. `sub bx,ax` (with AX=ES=PSP, 0x1a/0x1c) yields the paragraph count passed to INT 21h AH=4Ah (0x1e/0x20) to shrink the block before the AH=48h download-buffer allocation. Standard MZ C-runtime startup.  // 0x0E mov bx,sp; 0x10 add bx,0xf; 0x13 shr bx,4; 0x16 mov ax,ss; 0x18 add bx,ax; 0x1A mov ax,es; 0x1C sub bx,ax; 0x1E mov ah,0x4a; 0x20 int 0x21.
0000000E  8BDC              mov bx,sp
00000010  83C30F            add bx,byte +0xf
00000013  C1EB04            shr bx,byte 0x4
00000016  8CD0              mov ax,ss
00000018  03D8              add bx,ax
;>>>> [DOS startup / memory management (INT 21h)] mov ax,es loads the program (PSP) segment to begin computing the resident size in paragraphs. BX was set to (SS + (SP+0xF)>>4); sub bx,ax then yields the paragraph count, and AH=0x4A / INT 21h resizes (shrinks) the program memory block. Standard MZ startup before allocating the download buffer with AH=0x48.  // 0x18 add bx,ax(=ss); 0x1A mov ax,es; 0x1C sub bx,ax; 0x1E mov ah,0x4a; 0x20 int 0x21
0000001A  8CC0              mov ax,es
;>>>> [DOS memory sizing (INT 21h AH=4Ah)] `sub bx,ax` computes resident program size in paragraphs: BX = (SS:SP top rounded up to paragraph) minus AX (=ES, the PSP segment loaded at 0x1A). The result is passed in BX to the immediately following INT 21h AH=4Ah (mov ah,0x4a at 0x1E; int 21h at 0x20) to shrink the program's memory block before allocating the download buffer with AH=48h.  // Preceded by mov ax,es (0x1A) and add bx,ax with ss/sp; followed by mov ah,0x4a / int 0x21. Classic MZ startup memory-resize idiom.
0000001C  2BD8              sub bx,ax
0000001E  B44A              mov ah,0x4a
;>>>> [DOS memory (INT 21h AH=4Ah)] int 0x21 with AH=0x4A (set at 0x1e) = DOS resize memory block. BX = paragraph count computed from SS:SP top-of-stack minus ES (program segment), shrinking the program's allocation to free RAM before the AH=48h buffer allocations.  // 0x16 mov ax,ss / 0x18 add bx,ax / 0x1a mov ax,es / 0x1c sub bx,ax / 0x1e mov ah,0x4a / 0x20 int 0x21
00000020  CD21              int 0x21   ; INT 21h AH=0x4a: resize memory block
;>>>> [video init (INT 10h)] mov ax,0x7 loads AH=0,AL=7 for the immediately following INT 10h (0x25): BIOS set-video-mode, mode 7 (80x25 monochrome text), initializing the display before the download status screen is drawn.  // 0x22 mov ax,0x7 / 0x25 int 0x10 (AH=0 set video mode, AL=7)
00000022  B80700            mov ax,0x7
00000025  CD10              int 0x10   ; INT 10h video (teletype/mode)
00000027  B448              mov ah,0x48
00000029  BB0020            mov bx,0x2000
0000002C  CD21              int 0x21   ; INT 21h AH=0x48: alloc memory
0000002E  7224              jc loc_00054   ; ->0x54
00000030  A31C00            mov [0x1c],ax
00000033  B448              mov ah,0x48
00000035  BB001C            mov bx,0x1c00
00000038  CD21              int 0x21   ; INT 21h AH=0x48: alloc memory
0000003A  7218              jc loc_00054   ; ->0x54
0000003C  8EC0              mov es,ax
;>>>> [download buffer init / INT 40h AH=0x2E host-link setup] mov cx,0x1c00 loads CX=0x1C00 (7168) as the size/length argument for the immediately following INT 40h AH=0x2E kernel call (0x41 mov ah,0x2e; 0x43 int 0x40). ES was just set (0x3C mov es,ax) to the segment returned by the second AH=0x48 allocation (0x1C00 paragraphs). This registers/initializes the allocated receive buffer with the kernel host-link service before entering the main poll loop at 0x45.  // 0x3C mov es,ax; 0x3E mov cx,0x1c00; 0x41 mov ah,0x2e; 0x43 int 0x40; 0x45 call 0x60
0000003E  B9001C            mov cx,0x1c00
00000041  B42E              mov ah,0x2e
00000043  CD40              int 0x40   ; INT 40h AH=0x2e: get system tick/time -> DX:AX
00000045  E81800            call sub_00060   ; ->0x60
00000048  E8B101            call clear_status_001FC   ; ->0x1FC
0000004B  E8CB01            call dispatch_blk_status_00219   ; ->0x219
0000004E  B400              mov ah,0x0
00000050  CD40              int 0x40   ; INT 40h AH=0x00: yield / wait-for-event
00000052  EBF1              jmp short 0x45
;
; >>>>>>>>>>>>>>>>  ROUTINE: Error exit  <<<<<<<<<<<<<<<<
; Print the 'Lack of Memory' message and terminate (INT 21h AH=4Ch, code
; 1). Reached when a buffer allocation failed.
;
loc_00054:
00000054  B409              mov ah,0x9
00000056  BAFC00            mov dx,0xfc
00000059  CD21              int 0x21   ; INT 21h AH=0x09: print $-string DS:DX
0000005B  B8014C            mov ax,0x4c01
;>>>> [INT 21h AH=4Ch program exit (error path)] `int 0x21` executes DOS-style terminate-with-exit-code: AX=0x4C01 (AH=0x4C exit, AL=01 error code) loaded at 0x5B. This is the error-exit path reached at 0x54 after an INT 21h AH=48h buffer allocation failed (jc 0x54 at 0x2E/0x3A); it first prints the error string at DS:DX=0xFC via INT 21h AH=9 (0x56/0x59), then this INT 21h returns control to the resident kernel with exit code 1.  // 0x54 mov ah,0x9; 0x56 mov dx,0xfc; 0x59 int 0x21; 0x5B mov ax,0x4c01; 0x5E int 0x21. Reached from jc 0x54 at 0x2E and 0x3A.
0000005E  CD21              int 0x21   ; INT 21h AH=0x4c: exit to kernel
;
; >>>>>>>>>>>>>>>>  ROUTINE: Poll-and-dispatch  <<<<<<<<<<<<<<<<
; INT 40h AH=2Ch gets a serial byte/status from the SCC. A status byte
; (AH!=0) branches to the ACK/NAK setter; otherwise bump the mod-4 tick
; counter and call the current receive-state handler via [0x12]. (The
; handlers at 0x7A/0x85/0x9A/0xB1/0xE6/0xF1/0xFE form the XMODEM-style
; block receive state machine.)
;
sub_00060:
00000060  B42C              mov ah,0x2c
00000062  CD40              int 0x40   ; INT 40h AH=0x2c: clear [0x7A8] + far call
00000064  7301              jnc loc_00067   ; ->0x67
00000066  C3                ret
loc_00067:
00000067  84E4              test ah,ah
;>>>> [serial comm (INT 40h kernel API)] jnz 0xd6: after 'test ah,ah' (0x67) on the AH value returned by INT 40h AH=0x2C (carry was set). Nonzero AH (a received-byte/status code present) branches to the byte-handling path at 0xd6; AH=0 falls through to the periodic-tick path (inc [0x137], call dispatch vector [0x12]).  // 0x62 int 0x40 / 0x64 jnc 0x67 / 0x67 test ah,ah / 0x69 jnz 0xd6 / 0x6b inc byte [0x137] / 0x6f and byte [0x137],0x3 / 0x74 call [0x12]
00000069  756B              jnz status_fhandle_000D6   ; ->0xD6
0000006B  FE063701          inc byte [0x137]
;>>>> [poll-loop modulo-4 counter (INT 40h AH=2Ch)] AND byte [0x137],0x3 masks the just-incremented counter [0x137] to modulo-4. This is the periodic polling/tick loop: after INT 40h AH=0x2C returns a received char with no error, [0x137] is bumped and wrapped mod 4, then the current state handler at [0x12] is called (CALL [0x12]) and the loop repeats (JMP 0x60). Used to index a 4-entry rotation (e.g. spinner / ACK cadence).  // 0060 mov ah,0x2c / int 0x40; 006B inc byte [0x137]; 006F 8026370103 and byte [0x137],0x3; 0074 call [0x12]; 0078 jmp 0x60
0000006F  8026370103        and byte [0x137],0x3
00000074  FF161200          call [0x12]
00000078  EBE6              jmp short 0x60
;>>>> [serial download / XMODEM-style framing] cmp al,0x2 tests the just-received byte (AL) against 0x02 (STX/block-start marker for this protocol's data block). If equal it falls through to set the next-state handler [0x12]=0x85 (block-header handler); if not (jnz 0x84) it just returns. This is the start-of-block detection in the receive state machine fed by the INT 40h comm poll.  // 0x7A cmp al,0x2; 0x7C jnz 0x84; 0x7E mov word [0x12],0x85; handler 0x85 stores header byte [0x13a] and advances state
0000007A  3C02              cmp al,0x2
0000007C  7506              jnz loc_00084   ; ->0x84
;>>>> [serial download / XMODEM-style framing (state-vector advance)] mov word [0x12],0x85 sets the next-state dispatch handler vector [0x12] to 0x85 (the block-header handler that stores the first block byte at [0x13a] and initializes the byte counter). Reached after start-of-block detection: cmp al,0x2 (0x7A) matched STX and jnz 0x84 (0x7C) was not taken. The dispatch loop later invokes this via call [0x12]; bytes arrive via INT 40h AH=0x2C polling.  // 0x7A cmp al,0x2; 0x7C jnz 0x84; 0x7E mov word [0x12],0x85; 0x85 mov [0x13a],al
0000007E  C70612008500      mov word [0x12],0x85
loc_00084:
00000084  C3                ret
00000085  A23A01            mov [0x13a],al
;>>>> [serial download / XMODEM-style receiver] xor ah,ah zero-extends the just-received byte (AL) to a 16-bit value so it can be added as a count. Here it is part of the block-header state handler: it then stores AX into the byte-count word [0x18] and sets buffer pointer [0x1a]=0x14a and next-state handler [0x12]=0x9a. Received bytes arrive via the INT 40h kernel comm service polled in the main loop.  // 0x88 xor ah,ah; 0x8A mov [0x18],ax; 0x8D mov word [0x1a],0x14a; 0x93 mov word [0x12],0x9a (handler dispatch via call [0x12] at 0x74)
00000088  32E4              xor ah,ah
0000008A  A31800            mov [0x18],ax
0000008D  C7061A004A01      mov word [0x1a],0x14a
00000093  C70612009A00      mov word [0x12],0x9a
00000099  C3                ret
0000009A  A23B01            mov [0x13b],al
0000009D  A23C01            mov [0x13c],al
000000A0  32E4              xor ah,ah
000000A2  01061800          add [0x18],ax
000000A6  84C0              test al,al
000000A8  741E              jz loc_000C8   ; ->0xC8
000000AA  C7061200B100      mov word [0x12],0xb1
000000B0  C3                ret
000000B1  8B3E1A00          mov di,[0x1a]
;>>>> [serial download / byte storage] mov [di],al stores the received serial byte (AL, fetched via INT 40h and routed through the state machine) into the receive buffer at DS:DI (pointer held in [0x1a]). It then inc di, writes pointer back to [0x1a], adds the byte to the 16-bit total at [0x18], and decrements the per-record remaining-byte counter [0x13c]. This is the core data-byte accumulation step.  // 0xB1 mov di,[0x1a]; 0xB5 mov [di],al; 0xB7 inc di; 0xB8 mov [0x1a],di; 0xBE add [0x18],ax; 0xC2 dec byte [0x13c]; 0xC6 jnz
000000B5  8805              mov [di],al
000000B7  47                inc di
000000B8  893E1A00          mov [0x1a],di
000000BC  32E4              xor ah,ah
000000BE  01061800          add [0x18],ax
;>>>> [XMODEM byte-store handler (per-record counter)] dec byte [0x13c] decrements the per-record remaining-byte counter in the data-store handler (entry 0xB1). After each received byte is written to [DI], the pointer [0x1a] advanced, and the byte added to the 16-bit total [0x18], this decrement tracks how many bytes remain in the current record; jnz 0x84 (0xC6) loops back for the next byte, and on reaching zero it sets next-state [0x12]=0xe6 and returns. Core loop-termination counter of the block payload receive.  // dec byte [0x13c] at 0xC2 follows mov [di],al / inc di / mov [0x1a],di / add [0x18],ax (0xB5-0xBE), then jnz 0x84 (0xC6); on fall-through [0x12]=0xe6 (0xC8). Matches prior accepted notes for 0xB5 and 0xCE.
000000C2  FE0E3C01          dec byte [0x13c]
;>>>> [serial download / XMODEM byte-accumulation loop] `jnz 0x84` is the loop test of the data-byte store handler (entry 0xB1): after storing the received byte to [DI], advancing the pointer [0x1a], adding it to the 16-bit total [0x18], and dec byte [0x13c] (per-record remaining-byte counter at 0xC2), JNZ branches back to 0x84 (a RET) to return for the next byte while bytes remain. When [0x13c] reaches zero it falls through to set the next-state vector [0x12]=0xe6 (0xC8) and ret (0xCE), advancing past the data phase.  // 0xB5 mov [di],al; 0xBE add [0x18],ax; 0xC2 dec byte [0x13c]; 0xC6 jnz 0x84; 0xC8 mov word [0x12],0xe6; 0xCE ret.
000000C6  75BC              jnz loc_00084   ; ->0x84
loc_000C8:
000000C8  C7061200E600      mov word [0x12],0xe6
;>>>> [XMODEM-style receive (data-byte store handler return)] `ret` ends the per-byte data-store handler (entry 0xb1) and returns to the dispatch caller `call [0x12]` in the poll loop. The handler stored the received byte to [DI], bumped pointer [0x1a], added it to the byte total [0x18], and decremented the per-record remaining-byte counter [0x13c] (dec at 0xc2). When the counter hit zero (jnz 0xc6 not taken) it set the next-state vector [0x12]=0xe6 (trailer/CRC handler) at 0xc8 before this return.  // 0xC2 dec byte [0x13c]; 0xC6 jnz 0x84; 0xC8 mov word [0x12],0xe6; 0xCE ret. Handler body at 0xB1-0xCE. Prior accepted note on 0xCE confirms entry 0xB1.
000000CE  C3                ret
blk_status_fhandle_000CF:
;>>>> [XMODEM receive state machine (ACK/status-byte set)] mov byte [0x138],0x60 sets the pending serial-transmit status/control byte to 0x60 on the EOT/end-of-block success path. [0x138] is the byte later loaded by the TX routine at 0x1FC, OR'd with the low nibble of [0x139] (block seq), and sent via INT 40h AH=0x30 to the Z8530 SCC. This is the success branch of the handler entered at 0xCF: it sets 0x60 then jmp short 0xdb skips the alternate =0x40 path, falling into INC [0x28] / set next-state vector [0x12]=0x7a. Selects the positive (ACK-class) response code.  // mov byte [0x138],0x60 at 0xCF; jmp short 0xdb at 0xD4 skips the [0x138]=0x40 path at 0xD6; tail at 0xDB inc [0x28], [0x12]=0x7a; [0x138] consumed by TX routine 0x1FC->INT 40h AH=0x30. Matches prior accepted notes for 0xD4 and 0x1FC.
000000CF  C606380160        mov byte [0x138],0x60
;>>>> [XMODEM receive state machine (status-byte branch)] JMP SHORT 0xdb skips the alternate branch at 0xD6 (which sets status byte [0x138]=0x40). This is the success branch of the receive-state-machine handler at 0xCF: it sets [0x138]=0x60 then jumps over the =0x40 path to the common tail at 0xDB (INC [0x28], set next-state vector [0x12]=0x7a). Selects the EOT/end-of-block status code path.  // 00CF C606380160 mov [0x138],0x60; 00D4 EB05 jmp 0xdb; 00D6 mov [0x138],0x40; 00DB inc [0x28]; 00DF mov [0x12],0x7a
000000D4  EB05              jmp short 0xdb
status_fhandle_000D6:
;>>>> [XMODEM receive state machine (alternate status-byte set)] mov byte [0x138],0x40 sets the pending serial-transmit status/control byte to 0x40 on the alternate (non-success) branch of the handler. This path is reached by jnz 0xd6 from test ah,ah at 0x67/0x69 (INT 40h AH=0x2C returned a nonzero AH, i.e. an error/status-present condition) rather than the 0xCF success path which sets 0x60. [0x138] is later sent to the Z8530 SCC via INT 40h AH=0x30; both branches join the common tail at 0xDB (inc [0x28], [0x12]=0x7a).  // mov byte [0x138],0x40 at 0xD6 is the jnz 0xd6 target from test ah,ah (0x67/0x69) and is jumped over by jmp short 0xdb (0xD4) on the [0x138]=0x60 success path; tail 0xDB inc [0x28]/[0x12]=0x7a. Matches prior accepted notes for 0xD4 and 0x69.
000000D6  C606380140        mov byte [0x138],0x40
000000DB  FF062800          inc word [0x28]
000000DF  C70612007A00      mov word [0x12],0x7a
000000E5  C3                ret
000000E6  3C03              cmp al,0x3
;>>>> [serial download / XMODEM-style receive state machine] jnz 0xcf branches when the just-received byte (AL) != 0x03 (cmp al,0x3 at 0xE6, an ETX/end-of-text trailer marker). On mismatch it goes to the status-byte handler at 0xCF (sets [0x138]=0x60); on match it falls through to set next-state vector [0x12]=0xf1 (the [0x18]-byte verify handler) and ret. Part of the trailer-byte validation chain in the receive dispatch driven by INT 40h AH=0x2C polling.  // 0xE6 cmp al,0x3; 0xE8 jnz 0xcf; 0xEA mov word [0x12],0xf1; 0xCF mov byte [0x138],0x60
000000E8  75E5              jnz blk_status_fhandle_000CF   ; ->0xCF
000000EA  C7061200F100      mov word [0x12],0xf1
000000F0  C3                ret
000000F1  3A061800          cmp al,[0x18]
;>>>> [XMODEM-style receive state machine (header field check)] `jnz 0xcf` branches to the error/NAK status path (0xcf sets status byte [0x138]=0x60) if the received byte AL does not equal the stored expected byte [0x18] (cmp al,[0x18] at 0xf1). On match it falls through to set the next-state vector [0x12]=0xfe (the handler that next checks al==[0x19]). This is the second comparison in the block-header verification chain fed by the INT 40h comm poll.  // 0xF1 cmp al,[0x18]; 0xF5 jnz 0xcf; 0xF7 mov word [0x12],0xfe; 0xFD ret. 0xFE cmp al,[0x19]. 0xCF mov byte [0x138],0x60.
000000F5  75D8              jnz blk_status_fhandle_000CF   ; ->0xCF
;>>>> [serial download / XMODEM receive state machine (vector advance)] mov word [0x12],0xfe sets the next-state dispatch vector [0x12] to 0xFE (the handler that does cmp al,[0x19], verifying the second header/checksum byte). Reached after the [0x18]-byte verification passed (cmp al,[0x18] / jnz 0xcf at 0xF1/0xF5 fell through). Then ret returns to the byte-dispatch loop which calls handlers via call [0x12]. Advances the protocol parser to the next expected byte.  // 0xF1 cmp al,[0x18]; 0xF5 jnz 0xcf; 0xF7 mov word [0x12],0xfe; 0xFE cmp al,[0x19]
000000F7  C7061200FE00      mov word [0x12],0xfe
000000FD  C3                ret
000000FE  3A061900          cmp al,[0x19]
;>>>> [XMODEM-style receive state machine (header field check)] `jnz 0xcf` branches to the NAK/error status path (0xcf sets status byte [0x138]=0x60) if the just-received byte AL does not equal the stored expected byte [0x19] (cmp at 0xfe). This is the third of a chain of header-field comparisons (al==0x3 at 0xe6, al==[0x18] at 0xf1, al==[0x19] here); on match it falls through to set next-state vector [0x12]=0x7a and `jmp [0x14]` into the block-completion path. Bytes arrive via the INT 40h kernel comm poll.  // 0xFE cmp al,[0x19]; 0x102 jnz 0xcf; 0x104 mov word [0x12],0x7a; 0x10A jmp [0x14]. 0xCF sets [0x138]=0x60. Parallel checks at 0xF5 jnz 0xcf, 0xE8 jnz 0xcf.
00000102  75CB              jnz blk_status_fhandle_000CF   ; ->0xCF
;>>>> [XMODEM receive state machine (next-state vector set)] mov word [0x12],0x7a sets the polled state-handler vector [0x12] to 0x7a after the trailer-byte check at 0xFE/0x102 (cmp al,[0x19] / jnz 0xcf) passed. [0x12] is the handler called via CALL [0x12] in the INT 40h AH=0x2C poll loop; 0x7a is the block-start detector (cmp al,0x2 at 0x7A). This resets the receiver to wait for the next block's STX after a frame's two-byte trailer verified, then jmp [0x14] dispatches the secondary vector.  // mov word [0x12],0x7a at 0x104, reached after cmp al,[0x19] (0xFE) / jnz 0xcf (0x102); followed by jmp [0x14] at 0x10A. Handler 0x7a is cmp al,0x2 block-start per prior accepted note (0x7A, 0x7E). [0x12] dispatched via CALL [0x12] at 0x74.
00000104  C70612007A00      mov word [0x12],0x7a
0000010A  FF261400          jmp [0x14]
;
; >>>>>>>>>>>>>>>>  ROUTINE: End-of-transfer handler  <<<<<<<<<<<<<<<<
; Verify the trailer bytes ([0x13b]==0x0C, [0x13a]==0x0F), copy the
; 12-byte completion record to the display area, and reset all block/byte
; counters for a new transfer.
;
dispatch_blk_status_0010E:
0000010E  A03B01            mov al,[0x13b]
00000111  3C0C              cmp al,0xc
00000113  7540              jnz blk_fhandle_00155   ; ->0x155
;>>>> [XMODEM end-of-transfer / completed-block handler] `mov si,0x14a` loads SI with the receive-data buffer pointer (0x14A, the in-RAM packet payload area) at the start of the end-of-block/final-block handler, reached after verifying the trailer byte [0x13b]==0x0C (cmp at 0x111) and about to verify the block-type byte [0x13a]==0x0F (loaded at 0x118). SI is the source for the subsequent 12-byte rep movsb that copies the completion record into the display buffer at 0x13D.  // Reached via jnz from cmp al,0xc at 0x111; followed by mov al,[0x13a]/cmp al,0xf and later mov di,0x13d / mov cx,0xc / rep movsb (0x121-0x127).
00000115  BE4A01            mov si,0x14a
00000118  A03A01            mov al,[0x13a]
0000011B  3C0F              cmp al,0xf
;>>>> [serial download / XMODEM end-of-transfer block-type validation] jnz 0x155 branches to the abort/short-handler at 0x155 if the block-type byte [0x13a] (loaded at 0x118) != 0x0F (cmp al,0xf at 0x11B). This is the second of two end-of-block trailer checks (the first verified [0x13b]==0x0C at 0x111). On a successful 0x0F match it falls through to push ds/pop es and rep movsb a 12-byte completion record from SI=0x14A to DI=0x13D, then resets the counters. Not a keyboard handler.  // 0x111 cmp al,0xc; 0x118 mov al,[0x13a]; 0x11B cmp al,0xf; 0x11D jnz 0x155; 0x121 mov di,0x13d; 0x124 mov cx,0xc; 0x127 rep movsb
0000011D  7536              jnz blk_fhandle_00155   ; ->0x155
0000011F  1E                push ds
00000120  07                pop es
00000121  BF3D01            mov di,0x13d
00000124  B90C00            mov cx,0xc
00000127  F3A4              rep movsb
;>>>> [XMODEM transfer-counter reset] XOR AX,AX zeroes AX to be stored into the block-state variables that immediately follow: [0x139] (expected block #), and word counters [0x26], [0x28], [0x1e], [0x20], [0x22]. This resets the block/byte counters when starting a new transfer (after the 0x0F/0x0C end-marker check passed).  // 0129 33C0 xor ax,ax; 012B mov [0x139],al; 012E mov [0x26],ax; 0131 mov [0x28],ax; 0134 mov [0x1e],ax; 0137 mov [0x20],ax
00000129  33C0              xor ax,ax
;>>>> [XMODEM receive state init] mov [0x139],al with AL=0 (from xor ax,ax at 0x129): zeros the expected block-sequence counter at [0x139]. Part of the new-transfer init block that also zeros [0x26],[0x28],[0x1e],[0x20],[0x22] (block count and 32-bit byte counters) and sets buffer pointer [0x24] from [0x1c].  // 0x129 xor ax,ax / 0x12b mov [0x139],al / 0x12e mov [0x26],ax / 0x131 mov [0x28],ax / 0x134 mov [0x1e],ax ...; [0x139] also masked &0x7 at 0x19d and inc'd at 0x199
0000012B  A23901            mov [0x139],al
;>>>> [XMODEM receive state reset (block/byte counters)] `mov [0x26],ax` with AX=0 (xor ax,ax at 0x129) zeros the received-block counter at [0x26]. Part of the post-successful-block reset block that also zeros [0x28], the 32-bit byte counter [0x1e]/[0x20], and the buffer write pointer [0x22]/[0x24], and sets status digit [0x138]='0', re-initializing the receiver state machine.  // AX zeroed at 0x129; followed by mov [0x28],ax, mov [0x1e],ax, mov [0x20],ax, mov [0x22],ax; [0x26] is later inc'd per block at 0x1A2.
0000012E  A32600            mov [0x26],ax
00000131  A32800            mov [0x28],ax
;>>>> [serial download / counter init] mov [0x1e],ax (AX=0 from xor ax,ax at 0x129) zeroes the low word of the 32-bit running byte-received counter. The next instruction zeroes [0x20] (high word). This is part of the post-header reset that also clears block counter [0x26] and field [0x28] before receiving the file body; the same 32-bit counter is later incremented by ADC at 0x17F/0x20.  // 0x129 xor ax,ax; 0x12E mov [0x26],ax; 0x131 mov [0x28],ax; 0x134 mov [0x1e],ax; 0x137 mov [0x20],ax; later 0x17B add [0x1e],cx / 0x17F adc word [0x20],0
00000134  A31E00            mov [0x1e],ax
00000137  A32000            mov [0x20],ax
0000013A  A32200            mov [0x22],ax
0000013D  A11C00            mov ax,[0x1c]
00000140  A32400            mov [0x24],ax
;>>>> [status screen state byte] mov byte [0x138],0x30 sets the spinner/state display byte to ASCII '0' (0x30). The same byte is set to 0x20 (' ') at 0x155 and 0x60 ('`') at 0xcf elsewhere, cycling a status/progress indicator character on the transfer screen.  // 0x143 mov byte [0x138],0x30; cf. 0x155 mov byte [0x138],0x20; 0x1a6 mov byte [0x138],0x30; 0xcf mov byte [0x138],0x60
00000143  C606380130        mov byte [0x138],0x30
00000148  C70616004200      mov word [0x16],0x42
0000014E  C70614005F01      mov word [0x14],0x15f
00000154  C3                ret
;
; >>>>>>>>>>>>>>>>  ROUTINE: Block-commit  <<<<<<<<<<<<<<<<
; Verify block type/sequence, copy the received CX bytes from the packet
; into the RAM staging buffer (les di,[0x22] / rep movsb), accumulate the
; 32-bit byte total [0x1e:0x20], renormalize the far write pointer
; [0x22:0x24], and increment the block counter [0x26].
;
blk_fhandle_00155:
00000155  C606380120        mov byte [0x138],0x20
0000015A  FF062800          inc word [0x28]
;>>>> [serial download / state machine] ret returns from the short helper at 0x155 (which set status byte [0x138]=0x20 ' ' and incremented counter [0x28]). It is the near-return ending that sub-handler, returning to the byte-dispatch loop that calls handlers via call [0x12].  // 0x155 mov byte [0x138],0x20; 0x15A inc word [0x28]; 0x15E ret; falls into separate routine at 0x15F
0000015E  C3                ret
0000015F  BE4A01            mov si,0x14a
00000162  A03A01            mov al,[0x13a]
00000165  3C0F              cmp al,0xf
00000167  74A5              jz dispatch_blk_status_0010E   ; ->0x10E
00000169  3A063901          cmp al,[0x139]
0000016D  7537              jnz status_001A6   ; ->0x1A6
0000016F  8A0E3B01          mov cl,[0x13b]
00000173  32ED              xor ch,ch
00000175  E335              jcxz dispatch_blk_status_001AC   ; ->0x1AC
00000177  C43E2200          les di,[0x22]
0000017B  010E1E00          add [0x1e],cx
0000017F  8316200000        adc word [0x20],byte +0x0
00000184  F3A4              rep movsb
00000186  8BC7              mov ax,di
;>>>> [serial download / buffer pointer normalization] and ax,0xf isolates the low 4 bits of the destination offset (DI was copied to AX) after a rep movsb block copy into the allocated receive buffer. Combined with shr di,4 and add bx(=es),di, it renormalizes the far buffer pointer to seg:off form, storing offset at [0x22] and segment at [0x24] so the next block continues contiguously without offset overflow.  // 0x184 rep movsb; 0x186 mov ax,di; 0x188 and ax,0xf; 0x18B shr di,4; 0x18E mov bx,es; 0x190 add bx,di; 0x192 mov [0x22],ax; 0x195 mov [0x24],bx
00000188  250F00            and ax,0xf
;>>>> [XMODEM buffer write-pointer normalization] `shr di,byte 0x4` converts the post-copy destination offset DI (after rep movsb at 0x184 wrote CX bytes into ES:DI) into a paragraph count, so it can be added to the segment ES (mov bx,es / add bx,di at 0x18E/0x190) to renormalize the far buffer pointer. The masked low nibble (and ax,0xf at 0x188) becomes the new offset stored to [0x22] and the new segment to [0x24], letting the next block write contiguously without offset overflow.  // 0x184 rep movsb; 0x186 mov ax,di; 0x188 and ax,0xf; 0x18B shr di,4; 0x18E mov bx,es; 0x190 add bx,di; 0x192 mov [0x22],ax; 0x195 mov [0x24],bx.
0000018B  C1EF04            shr di,byte 0x4
;>>>> [XMODEM buffer write-pointer normalization] `mov bx,es` copies the download-buffer segment into BX so it can be added to DI>>4 (add bx,di at 0x190) to form a normalized segment, while AX holds the offset masked to 0xF (and ax,0xf at 0x188). The new normalized far pointer is stored to [0x22] (offset) and [0x24] (segment), advancing the destination pointer after the rep movsb block copy so the next 0x80-byte XMODEM block writes contiguously into the allocated RAM buffer.  // Preceded by mov ax,di/and ax,0xf/shr di,4 (0x186-0x18B); followed by add bx,di, mov [0x22],ax, mov [0x24],bx; pointer reloaded via les di,[0x22] at 0x177.
0000018E  8CC3              mov bx,es
00000190  03DF              add bx,di
00000192  A32200            mov [0x22],ax
00000195  891E2400          mov [0x24],bx
00000199  FE063901          inc byte [0x139]
0000019D  8026390107        and byte [0x139],0x7
000001A2  FF062600          inc word [0x26]
status_001A6:
000001A6  C606380130        mov byte [0x138],0x30
000001AB  C3                ret
;
; >>>>>>>>>>>>>>>>  ROUTINE: Next-block setup  <<<<<<<<<<<<<<<<
; Reinitialize the receive state vectors ([0x12]/[0x14]/[0x16]), the
; status digit and sequence bytes and tick counter, then send the pending
; ACK (0x1FC) and redraw the status screen (0x219).
;
dispatch_blk_status_001AC:
000001AC  C60639010F        mov byte [0x139],0xf
000001B1  C606380130        mov byte [0x138],0x30
000001B6  C70616005A00      mov word [0x16],0x5a
;>>>> [serial download / XMODEM receive state init (handler-vector setup)] mov word [0x14],0x10e installs the secondary dispatch/continuation vector [0x14] = 0x10E (the trailer-check handler that loads [0x13b] and compares to 0x0C). This is part of the post-block-acquisition setup at 0x1AC-0x1C2 that also sets [0x16]=0x5A, status digit [0x138]='0', sequence byte [0x139]=0x0F, and tick counter [0x137]=4, then calls the serial-TX (0x1FC) and buffer-fetch (0x219) routines. [0x14] is later invoked via jmp [0x14] at 0x10A.  // 0x1B6 mov word [0x16],0x5a; 0x1BC mov word [0x14],0x10e; 0x1C2 mov byte [0x137],4; 0x10A jmp [0x14]; 0x10E mov al,[0x13b]
000001BC  C70614000E01      mov word [0x14],0x10e
000001C2  C606370104        mov byte [0x137],0x4
000001C7  E83200            call clear_status_001FC   ; ->0x1FC
000001CA  E84C00            call dispatch_blk_status_00219   ; ->0x219
000001CD  BE3D01            mov si,0x13d
000001D0  8E061C00          mov es,[0x1c]
000001D4  33DB              xor bx,bx
;>>>> [serial download / status display (32-bit byte-count snapshot)] mov cx,[0x20] loads the high word of the 32-bit byte-received counter ([0x1e] low / [0x20] high) into CX, paired with mov dx,[0x1e] at 0x1DA loading the low word into DX. These pass the running byte total as arguments before the INT 40h AH=0x6 serial-get call at 0x1DE (jc 0x1f0 on timeout). Captures the byte-count for the host-link request/status update.  // 0x1D6 mov cx,[0x20]; 0x1DA mov dx,[0x1e]; 0x1DE mov ah,0x6; 0x1E0 int 0x40; 0x1E2 jc 0x1f0
000001D6  8B0E2000          mov cx,[0x20]
;>>>> [serial comm / INT 40h AH=6 receive (32-bit counter args)] mov dx,[0x1e] loads the low word of the 32-bit bytes-received counter into DX as an argument before the INT 40h AH=6 serial-get-block call at 0x1DE. The preceding mov cx,[0x20] (high word) and this DX load pass the running byte total to the kernel comm service together with ES:BX (buffer seg from [0x1c], offset 0). After INT 40h AH=6 (CF set on timeout -> 0x1F0), the receiver continues. [0x1e]/[0x20] are the same 32-bit accumulator incremented by add/adc at 0x17B/0x17F.  // mov dx,[0x1e] at 0x1DA follows mov cx,[0x20] (0x1D6) and es=[0x1c]/xor bx,bx; then mov ah,6 / int 0x40 at 0x1DE/0x1E0, jc 0x1f0. [0x1e]/[0x20] are the 32-bit byte counter per prior accepted notes (0x134, 0x17F).
000001DA  8B161E00          mov dx,[0x1e]
000001DE  B406              mov ah,0x6
000001E0  CD40              int 0x40   ; INT 40h AH=0x06: process buffered item
000001E2  720C              jc dispatch_001F0   ; ->0x1F0
000001E4  C70616007200      mov word [0x16],0x72
;>>>> [serial comm / INT 40h AH=6 receive-success status] mov byte [0x138],0x50 sets the pending serial-transmit status/control byte to 0x50 on the INT 40h AH=6 receive-success path (fall-through after jc 0x1f0 was NOT taken, i.e. a byte/block was received). It pairs with [0x16]=0x72 set just before (0x1E4). [0x138] is the byte the TX routine at 0x1FC later sends to the Z8530 SCC via INT 40h AH=0x30. The timeout counterpart instead sets [0x138]=0x70 at 0x1F6.  // mov byte [0x138],0x50 at 0x1EA on the no-carry path of int 0x40 AH=6 (0x1E0/jc 0x1f0 at 0x1E2), preceded by mov word [0x16],0x72 at 0x1E4; error path sets [0x138]=0x70 at 0x1F6. [0x138] consumed by TX routine 0x1FC->INT 40h AH=0x30 per prior accepted notes.
000001EA  C606380150        mov byte [0x138],0x50
;>>>> [INT 40h AH=6 serial receive handler (success path return)] `ret` ends the receive-poll handler (entry near 0x1D0) on the success path: after int 0x40 AH=6 (kernel serial get-char from the Z8530 SCC) returned with CF=0 (jc 0x1f0 not taken), the code set the next-state vector [0x16]=0x72 and status byte [0x138]=0x50, then this RET returns to the dispatch loop. The CF=1 timeout path instead falls to 0x1F0 (sets [0x16]=0x8a, [0x138]=0x70) before its own ret at 0x1FB.  // 0x1DE mov ah,0x6; 0x1E0 int 0x40; 0x1E2 jc 0x1f0; 0x1E4 mov word [0x16],0x72; 0x1EA mov byte [0x138],0x50; 0x1EF ret.
000001EF  C3                ret
dispatch_001F0:
;>>>> [serial comm / INT 40h AH=6 timeout-error path] mov word [0x16],0x8a sets the secondary dispatch/state vector [0x16] to 0x8a on the INT 40h AH=6 timeout/error branch (reached via jc 0x1f0 at 0x1E2 when the serial get-char returned carry). The success path instead set [0x16]=0x72 and [0x138]=0x50 (0x1E4/0x1EA); this error path sets [0x16]=0x8a and then [0x138]=0x70 (0x1F6) marking the no-data/timeout state before returning to the poll loop.  // mov word [0x16],0x8a at 0x1F0 is the jc 0x1f0 target from int 0x40 AH=6 (0x1E0/0x1E2); paired with mov byte [0x138],0x70 at 0x1F6; success counterpart sets [0x16]=0x72/[0x138]=0x50 at 0x1E4/0x1EA.
000001F0  C70616008A00      mov word [0x16],0x8a
000001F6  C606380170        mov byte [0x138],0x70
;>>>> [INT 40h AH=6 serial receive handler (timeout path return)] `ret` ends the timeout/error branch of the INT 40h AH=6 serial-receive handler: reached via jc 0x1f0 when the kernel get-char returned CF=1 (no byte / timeout). That branch set next-state vector [0x16]=0x8a and status byte [0x138]=0x70 (error/timeout code), then this RET returns to the polling dispatch loop. It sits immediately before the ACK/NAK transmit routine at 0x1FC.  // 0x1E2 jc 0x1f0; 0x1F0 mov word [0x16],0x8a; 0x1F6 mov byte [0x138],0x70; 0x1FB ret; 0x1FC mov al,[0x138] (transmit routine).
000001FB  C3                ret
;
; >>>>>>>>>>>>>>>>  ROUTINE: Serial TX (ACK/NAK)  <<<<<<<<<<<<<<<<
; If a status byte is pending at [0x138], OR it with the low nibble of the
; block sequence [0x139] and send it to the SCC via INT 40h AH=30h; clear
; [0x138] on success.
;
clear_status_001FC:
;>>>> [INT 40h AH=0x30 serial TX (entry)] MOV AL,[0x138] loads the pending status/control byte at the top of the serial-transmit routine. It is tested (TEST AL,AL); if non-zero the value is ORed with the low nibble of [0x139] and sent via INT 40h AH=0x30 (kernel serial put-char to the Z8530 SCC), then [0x138] is cleared on success. Entry of the ACK/NAK transmit function.  // 01FC A03801 mov al,[0x138]; 01FF test al,al; 0201 jnz 0x204; 0204 mov ah,[0x139]; 020D mov ah,0x30; 020F int 0x40; 0213 mov byte [0x138],0
000001FC  A03801            mov al,[0x138]
000001FF  84C0              test al,al
;>>>> [INT 40h AH=0x30 serial TX (status guard)] JNZ 0x204 tests the pending-output status byte AL loaded from [0x138] (via the preceding TEST AL,AL). If zero, RET (nothing to send); if non-zero, fall through to build the control byte (OR with low nibble of [0x139]) and transmit it via INT 40h AH=0x30 (kernel serial put-char) to the Z8530 SCC. Guards the serial-transmit routine.  // 01FC mov al,[0x138]; 01FF test al,al; 0201 7501 jnz 0x204; 0203 ret; 0204 mov ah,[0x139]; 0208 and ah,0xf; 020D mov ah,0x30; 020F int 0x40
00000201  7501              jnz clear_status_00204   ; ->0x204
00000203  C3                ret
clear_status_00204:
00000204  8A263901          mov ah,[0x139]
00000208  80E40F            and ah,0xf
0000020B  0AC4              or al,ah
;>>>> [serial TX / INT 40h AH=0x30 (Z8530 SCC put-char)] mov ah,0x30 sets the INT 40h function selector to AH=0x30 (kernel serial put-char) immediately before int 0x40 at 0x20F. AL already holds the control byte built from [0x138] OR'd with the low nibble of [0x139] (and ah,0xf / or al,ah at 0x208/0x20B). This transmits the ACK/NAK/status byte to the Z8530 SCC host link; on success (no carry) [0x138] is cleared at 0x213, on error (jc 0x218) it returns leaving it pending.  // mov ah,0x30 at 0x20D directly precedes int 0x40 (0x20F); AL = [0x138] | ([0x139]&0xf) from 0x1FC/0x204/0x208/0x20B; jc 0x218 / mov byte [0x138],0 at 0x213. Matches prior accepted note for 0x1FC and 0x218.
0000020D  B430              mov ah,0x30
0000020F  CD40              int 0x40   ; INT 40h AH=0x30: clear [0x7A8] + far call
00000211  7205              jc clear_00218   ; ->0x218
00000213  C606380100        mov byte [0x138],0x0
clear_00218:
;>>>> [INT 40h AH=0x30 serial TX (return)] RET is the exit of the serial-transmit routine (taken via JC 0x218 on INT 40h AH=0x30 error, or after falling through clearing [0x138]). The bytes immediately after (0x219 MOV AH,4 / INT 40h) begin a separate routine that calls the kernel INT 40h AH=4 service to obtain/allocate the host-link buffer segment (returned in ES:BX).  // 0211 jc 0x218; 0213 mov byte [0x138],0; 0218 C3 ret; 0219 B404 mov ah,0x4; 021B CD40 int 0x40; 021D mov ax,es; 021F or ax,bx
00000218  C3                ret
;
; >>>>>>>>>>>>>>>>  ROUTINE: Get host buffer + frame  <<<<<<<<<<<<<<<<
; INT 40h AH=4 fetches the host-link/display buffer (ES:BX); on the first
; block, record the segment and draw the status-box frame (0x342); then
; fall into the field drawer.
;
dispatch_blk_status_00219:
00000219  B404              mov ah,0x4
0000021B  CD40              int 0x40   ; INT 40h AH=0x04: get next queued record -> ES:BX
0000021D  8CC0              mov ax,es
0000021F  0BC3              or ax,bx
00000221  7504              jnz loc_00227   ; ->0x227
00000223  A30C00            mov [0xc],ax
00000226  C3                ret
loc_00227:
00000227  891E0E00          mov [0xe],bx
0000022B  8C061000          mov [0x10],es
0000022F  833E0C0000        cmp word [0xc],byte +0x0
;>>>> [download-buffer init branch] JNZ 0x25f tests whether the saved buffer segment [0xc] is already set (CMP word [0xc],0 precedes it). On first block ([0xc]==0) it falls through to record ES into [0xc] and process the just-allocated host-link buffer (segment from INT 40h AH=4 at 0x219); on later blocks it branches to 0x25f to skip re-init.  // 0219 mov ah,0x4 / int 0x40; 0227 mov [0xe],bx; 022B mov [0x10],es; 022F cmp word [0xc],0; 0234 7529 jnz 0x25f; 0236 mov [0xc],es
00000234  7529              jnz fread_status_desc_0025F   ; ->0x25F
00000236  8C060C00          mov [0xc],es
0000023A  53                push bx
0000023B  BA1E00            mov dx,0x1e
loc_0023E:
0000023E  268B07            mov ax,[es:bx]
00000241  43                inc bx
00000242  43                inc bx
00000243  86C4              xchg al,ah
00000245  8BF8              mov di,ax
00000247  32C0              xor al,al
00000249  AA                stosb
0000024A  B82000            mov ax,0x20
0000024D  B98400            mov cx,0x84
loc_00250:
00000250  2688A50080        mov [es:di-0x8000],ah
00000255  AA                stosb
00000256  E2F8              loop loc_00250   ; ->0x250
00000258  4A                dec dx
00000259  75E3              jnz loc_0023E   ; ->0x23E
0000025B  5B                pop bx
0000025C  E8E300            call sub_00342   ; ->0x342
;
; >>>>>>>>>>>>>>>>  ROUTINE: Status-screen field drawer  <<<<<<<<<<<<<<<<
; Using a screen-layout descriptor (far ptr at [0xe]), draw the 'Blocks
; Received', 'Bytes Received', 'Errors' labels and a rotating activity
; indicator into dual-plane VRAM, and render the running counters as
; decimals (0x307).
;
fread_status_desc_0025F:
;>>>> [status-field parameter block (far pointer load)] `les bx,[0xe]` loads ES:BX from the far-pointer stored at offset 0x0E, giving a base for a parameter/coordinate structure. The code immediately reads word fields at [es:bx+0x8], +0xc, +0x10, +0x14, byte-swaps each (xchg al,ah) and uses them as screen offsets (DI) for drawing the status labels/fields. Functions as the screen-layout descriptor table for the download status display rather than a standard DOS environment pointer.  // Followed by mov ax,[es:bx+0x8]/xchg al,ah/mov di,ax/add di,0x1e/call 0x301 and repeated for +0xc,+0x10,+0x14 with different DI offsets.
0000025F  C41E0E00          les bx,[0xe]
00000263  268B4708          mov ax,[es:bx+0x8]
;>>>> [video screen layout (param block)] xchg al,ah byte-swaps the big-endian 16-bit value loaded from [es:bx+0x8], where ES:BX = far pointer fetched via 'les bx,[0xe]'. The swapped value becomes a video-RAM character offset placed in DI (0x269), then +0x1e (0x26b) to position the 'Blocks Received' count field on the status screen.  // 0x25f les bx,[0xe] / 0x263 mov ax,[es:bx+0x8] / 0x267 xchg al,ah / 0x269 mov di,ax / 0x26b add di,byte +0x1e / 0x272 call 0x301 (string draw)
00000267  86C4              xchg al,ah
;>>>> [video status-screen drawing (OKI/Wyse gate-array dual-plane VRAM)] `mov di,ax` loads the video-RAM character-plane write offset from AX, which holds the byte-swapped (xchg al,ah at 0x267) coordinate word read from the screen-layout descriptor at [es:bx+0x8] (ES:BX = far pointer via les bx,[0xe] at 0x25F). The following add di,byte +0x1e (0x26B) biases it to the 'Blocks Received' numeric field position, after which si=[0x16] and call 0x301 emit the label string and the count is drawn.  // 0x25F les bx,[0xe]; 0x263 mov ax,[es:bx+0x8]; 0x267 xchg al,ah; 0x269 mov di,ax; 0x26B add di,byte +0x1e; 0x272 call 0x301.
00000269  8BF8              mov di,ax
0000026B  83C71E            add di,byte +0x1e
0000026E  8B361600          mov si,[0x16]
00000272  E88C00            call fread_status_desc_00301   ; ->0x301
00000275  268B470C          mov ax,[es:bx+0xc]
00000279  86C4              xchg al,ah
0000027B  8BF8              mov di,ax
0000027D  83C726            add di,byte +0x26
00000280  53                push bx
00000281  BB3201            mov bx,0x132
00000284  A03701            mov al,[0x137]
00000287  D7                xlatb
;>>>> [video attribute-plane write (XLATB-translated status indicator)] `stosb` writes the XLATB-translated byte (AL = table[BX=0x132 + index [0x137]], computed by xlatb at 0x287) into video RAM at ES:DI. [0x137] is the modulo-4 spinner/activity counter, so this draws the rotating transfer-activity indicator character into the status screen via a lookup-table-driven attribute/char.  // Preceded by mov bx,0x132 / mov al,[0x137] / xlatb (0x281-0x287); [0x137] is the &0x3 counter incremented in the INT 40h AH=2Ch poll loop at 0x6B-0x6F.
00000288  AA                stosb
00000289  5B                pop bx
0000028A  268B4710          mov ax,[es:bx+0x10]
0000028E  86C4              xchg al,ah
00000290  8BF8              mov di,ax
00000292  83C71B            add di,byte +0x1b
00000295  BEA200            mov si,0xa2
;>>>> [video status screen (label string emit)] `call 0x301` invokes the ASCIIZ-to-VRAM emit loop (lodsb/test/stosb until NUL) to draw the label string at SI=0xa2 into the char plane at ES:DI. DI was positioned from the byte-swapped screen offset [es:bx+0x10] (+0x1b). It is immediately followed by another emit (SI=0x13d, call 0x301 at 0x29e), drawing the two adjacent status labels on the download screen.  // 0x289 pop bx; 0x28A mov ax,[es:bx+0x10]; 0x28E xchg al,ah; 0x290 mov di,ax; 0x292 add di,0x1b; 0x295 mov si,0xa2; 0x298 call 0x301; 0x29B mov si,0x13d; 0x29E call 0x301. Routine 0x301 = lodsb/test al,al/jnz 0x300/stosb.
00000298  E86600            call fread_status_desc_00301   ; ->0x301
0000029B  BE3D01            mov si,0x13d
0000029E  E86000            call fread_status_desc_00301   ; ->0x301
000002A1  268B4714          mov ax,[es:bx+0x14]
000002A5  86C4              xchg al,ah
000002A7  8BF8              mov di,ax
000002A9  83C71B            add di,byte +0x1b
000002AC  BEA900            mov si,0xa9
000002AF  E84F00            call fread_status_desc_00301   ; ->0x301
000002B2  A12600            mov ax,[0x26]
000002B5  33D2              xor dx,dx
000002B7  E84D00            call cursor_status_col_00307   ; ->0x307
000002BA  E83B00            call print_clear_fill_002F8   ; ->0x2F8
000002BD  268B4718          mov ax,[es:bx+0x18]
000002C1  86C4              xchg al,ah
;>>>> [video status screen formatting] `mov di,ax` sets the char-plane write cursor DI from the byte-swapped screen offset just produced (ax=[es:bx+0x18] then xchg al,ah at 0x2c1); `add di,0x1b` (0x2c5) then offsets it to the numeric-field column. This positions the 'Bytes Received' value field on the status screen before the label (si=0xbb) and the 32-bit decimal value from [0x1e]/[0x20] are drawn via call 0x301 and call 0x307.  // 0x2BD mov ax,[es:bx+0x18]; 0x2C1 xchg al,ah; 0x2C3 mov di,ax; 0x2C5 add di,0x1b; 0x2C8 mov si,0xbb; 0x2CB call 0x301; 0x2CE mov ax,[0x1e]; 0x2D1 mov dx,[0x20]; 0x2D5 call 0x307.
000002C3  8BF8              mov di,ax
000002C5  83C71B            add di,byte +0x1b
;>>>> [video status screen formatting] `mov si,0xbb` loads SI with the pointer to the ASCIIZ label string at offset 0xBB so the immediately following `call 0x301` (the ES:DI string-emit loop) copies it into the OKI gate-array char plane. This is in the 'Bytes Received' field-drawing path: after `les bx,[0xe]` gave the screen-layout descriptor, [es:bx+0x18] was byte-swapped into DI (+0x1b) to position the cursor, then this label is drawn before `call 0x307` renders the 32-bit byte count from [0x1e]/[0x20].  // At 0x2BD-0x2C5: mov ax,[es:bx+0x18]; xchg al,ah; mov di,ax; add di,0x1b. Then 0x2C8 mov si,0xbb / 0x2CB call 0x301 (string emit, prior 0x304). Followed by mov ax,[0x1e]; mov dx,[0x20]; call 0x307 (decimal printer).
000002C8  BEBB00            mov si,0xbb
000002CB  E83300            call fread_status_desc_00301   ; ->0x301
000002CE  A11E00            mov ax,[0x1e]
000002D1  8B162000          mov dx,[0x20]
000002D5  E82F00            call cursor_status_col_00307   ; ->0x307
;>>>> [video status-screen formatting (numeric field clear)] call 0x2f8 invokes the field-blank helper (writes space-words 0x2020 via repeated stosw to ES:DI) to pad/clear the remainder of the just-rendered numeric field. It follows call 0x307 (decimal printer) which formatted the 32-bit byte-count from [0x1e] (low) / [0x20] (high, loaded into DX at 0x2D1) into the 'Bytes Received' field on the status screen.  // 0x2CE mov ax,[0x1e]; 0x2D1 mov dx,[0x20]; 0x2D5 call 0x307; 0x2D8 call 0x2f8 (helper at 0x2f8 ends with ret at 0x2FF after stosw space-fill)
000002D8  E81D00            call print_clear_fill_002F8   ; ->0x2F8
000002DB  268B471C          mov ax,[es:bx+0x1c]
000002DF  86C4              xchg al,ah
000002E1  8BF8              mov di,ax
000002E3  83C71B            add di,byte +0x1b
000002E6  BECC00            mov si,0xcc
000002E9  E81500            call fread_status_desc_00301   ; ->0x301
000002EC  A12800            mov ax,[0x28]
000002EF  33D2              xor dx,dx
000002F1  E81300            call cursor_status_col_00307   ; ->0x307
000002F4  E80100            call print_clear_fill_002F8   ; ->0x2F8
000002F7  C3                ret
;
; >>>>>>>>>>>>>>>>  ROUTINE: Field-blank helper  <<<<<<<<<<<<<<<<
; Write four space-words (0x2020) to the char plane to clear a numeric
; field.
;
print_clear_fill_002F8:
000002F8  B82020            mov ax,0x2020
000002FB  AB                stosw
000002FC  AB                stosw
000002FD  AB                stosw
000002FE  AB                stosw
000002FF  C3                ret
status_vram_00300:
00000300  AA                stosb
;
; >>>>>>>>>>>>>>>>  ROUTINE: ASCIIZ -> VRAM  <<<<<<<<<<<<<<<<
; Copy a NUL-terminated string (DS:SI) into the char plane at ES:DI.
;
fread_status_desc_00301:
00000301  AC                lodsb
00000302  84C0              test al,al
;>>>> [video / string output] jnz 0x300 is the loop test of a zero-terminated string emit routine: lodsb fetches the next char from DS:SI, test al,al / jnz loops back to 0x300 which does stosb (write char to char plane at ES:DI) then lodsb again. It copies an ASCIIZ string to video RAM until the NUL terminator, then ret. Used to print field labels on the status screen.  // 0x300 stosb; 0x301 lodsb; 0x302 test al,al; 0x304 jnz 0x300; 0x306 ret
00000304  75FA              jnz status_vram_00300   ; ->0x300
00000306  C3                ret
;
; >>>>>>>>>>>>>>>>  ROUTINE: Unsigned decimal printer  <<<<<<<<<<<<<<<<
; Convert a 16/32-bit value to ASCII decimal with leading-zero suppression
; (divide by 10000/1000/100/10); used for the Blocks/Bytes counters.
;
cursor_status_col_00307:
00000307  33ED              xor bp,bp
00000309  B91027            mov cx,0x2710
0000030C  F7F1              div cx
;>>>> [binary-to-decimal conversion (status display)] `test ax,ax` checks the ten-thousands-digit quotient in the unsigned-decimal printer (routine at 0x307). At 0x309 CX=0x2710 (10000) and div cx (0x30C) puts the high digit in AX, remainder in DX. test ax,ax then jz 0x317 skips emitting the leading ten-thousands digit when it is zero (leading-zero suppression for the Blocks/Bytes-Received counters); if non-zero it pushes DX and calls 0x319 to emit that digit then continue with lower-order digits.  // 0x309 mov cx,0x2710; 0x30C div cx; 0x30E test ax,ax; 0x310 jz 0x317; 0x312 push dx; 0x313 call 0x319. Caller of 0x307 at 0x2D5 passes [0x1e]/[0x20] (byte count).
0000030E  85C0              test ax,ax
;>>>> [binary-to-decimal conversion (leading-zero / ten-thousands digit)] jz 0x317 in the unsigned-decimal printer at 0x307: after div cx (cx=0x2710=10000) and test ax,ax (0x30E), if the ten-thousands quotient is zero it skips emitting that digit (jumps to 0x317, mov ax,dx to process the remainder). If non-zero it falls through to push dx / call 0x319 to print the digit. This is the leading-zero suppression for the high digit of the Blocks/Bytes-Received counters drawn to video RAM.  // jz 0x317 at 0x310 follows div cx (cx=0x2710 at 0x309) and test ax,ax (0x30E); fall-through push dx/call 0x319, target 0x317 mov ax,dx. Matches prior accepted note for 0x313 (divide by 0x2710, ten-thousands digit).
00000310  7405              jz print_blk_00317   ; ->0x317
00000312  52                push dx
;>>>> [binary-to-decimal conversion (status display)] `call 0x319` is the dispatcher into the lower-order-digit chain of the unsigned-decimal printer (routine 0x307). It is taken only when the ten-thousands digit was non-zero (test ax,ax / jz 0x317 at 0x30E-0x310 not taken); DX (the div-by-10000 remainder) was pushed at 0x312 and is restored at 0x316. Routine 0x319 successively divides the remainder by 0x3E8/0x64/0xA (1000/100/10) calling the per-digit emitter at 0x32F, producing the ASCII Blocks/Bytes-Received digits in VRAM.  // 0x309 mov cx,0x2710; 0x30C div cx; 0x312 push dx; 0x313 call 0x319; 0x316 pop dx; 0x319 mov cx,0x3e8; 0x31C call 0x32f; 0x31F mov cx,0x64.
00000313  E80300            call print_blk_00319   ; ->0x319
00000316  5A                pop dx
print_blk_00317:
00000317  8BC2              mov ax,dx
print_blk_00319:
00000319  B9E803            mov cx,0x3e8
0000031C  E81000            call print_dispatch_blk_0032F   ; ->0x32F
0000031F  B96400            mov cx,0x64
00000322  E80A00            call print_dispatch_blk_0032F   ; ->0x32F
00000325  B90A00            mov cx,0xa
00000328  E80400            call print_dispatch_blk_0032F   ; ->0x32F
0000032B  B90100            mov cx,0x1
0000032E  45                inc bp
print_dispatch_blk_0032F:
0000032F  33D2              xor dx,dx
00000331  F7F1              div cx
;>>>> [binary-to-decimal conversion (leading-zero suppression)] `test bp,bp` tests the 'significant digit already emitted' flag BP inside the per-digit routine (0x32F), after xor dx,dx / div cx (0x331) produced the digit in AL and remainder in DX. If BP!=0 (jnz 0x33c) it jumps straight to emit the digit (add al,0x30 / stosb); if BP==0 it falls through to test ax,ax (0x337) to suppress leading zeros until the first non-zero digit, at which point inc bp (0x33B) sets the flag. Zero-blanking for the Blocks/Bytes counters drawn to VRAM.  // 0x331 div cx; 0x333 test bp,bp; 0x335 jnz 0x33c; 0x337 test ax,ax; 0x339 jz 0x33f; 0x33B inc bp; 0x33C add al,0x30; 0x33E stosb.
00000333  85ED              test bp,bp
;>>>> [binary-to-decimal conversion (leading-zero suppression)] `jnz 0x33c` branches in the per-digit routine (0x32F): after div cx gives the quotient digit in AL, BP is the 'significant digit seen' flag; if BP!=0 (test bp,bp at 0x333) it jumps directly to 0x33C (add al,0x30 / stosb) to emit the digit. If BP==0 it falls through to test ax,ax to suppress leading zeros (skip emitting until the first non-zero digit). Implements zero-blanking for the Blocks/Bytes counters.  // Preceded by div cx (0x331) and test bp,bp (0x333); fall-through path test ax,ax/jz 0x33f skips emit; emit path add al,0x30/stosb at 0x33C-0x33E.
00000335  7505              jnz fread_blk_vram_0033C   ; ->0x33C
;>>>> [decimal-to-ASCII conversion] test ax,ax in the per-digit conversion helper at 0x32f: after 'div cx' (0x331) AX=quotient. With BP still 0 (no significant digit emitted yet, checked at 0x333), this tests whether the quotient is zero; if zero (jz 0x33f) the leading zero is suppressed (not stored), otherwise inc bp and store the digit. Leading-zero suppression for block/byte counts on the status screen.  // 0x32f xor dx,dx / 0x331 div cx / 0x333 test bp,bp / 0x335 jnz 0x33c / 0x337 test ax,ax / 0x339 jz 0x33f / 0x33b inc bp / 0x33c add al,0x30 / 0x33e stosb
00000337  85C0              test ax,ax
00000339  7404              jz fread_blk_vram_0033F   ; ->0x33F
;>>>> [binary-to-decimal conversion (leading-zero suppression)] inc bp sets the 'significant digit seen' flag (BP) on the first non-zero quotient digit in the per-digit routine at 0x32F. Reached only when BP==0 (no prior digit, jnz 0x33c at 0x335 not taken) AND the quotient AX!=0 (jz 0x33f at 0x339 not taken). After inc bp it falls into add al,0x30 / stosb to emit the digit. Implements leading-zero blanking for the Blocks/Bytes-Received counters on the status screen.  // 0x333 test bp,bp; 0x335 jnz 0x33c; 0x337 test ax,ax; 0x339 jz 0x33f; 0x33B inc bp; 0x33C add al,0x30; 0x33E stosb
0000033B  45                inc bp
fread_blk_vram_0033C:
0000033C  0430              add al,0x30
0000033E  AA                stosb
fread_blk_vram_0033F:
0000033F  8BC2              mov ax,dx
;>>>> [decimal-to-ASCII conversion] ret terminates the single-digit conversion helper (0x32f). Before returning, AX is reloaded from DX (the remainder, 0x33f) so the next call divides the remainder; the emitted digit (al+0x30) was stored via stosb at 0x33e. Returns to the divide-by-powers-of-ten caller chain (0x319/0x32f).  // 0x32f xor dx,dx / div cx / ... / 0x33c add al,0x30 / 0x33e stosb / 0x33f mov ax,dx / 0x341 ret; callers at 0x31c,0x322,0x328 with cx=1000/100/10/1
00000341  C3                ret
;
; >>>>>>>>>>>>>>>>  ROUTINE: Status-box frame drawer  <<<<<<<<<<<<<<<<
; Write the 'I'..'M'-run..';' top border and the 'H'..'M'-run..'<' rows
; into dual-plane VRAM (char + attribute planes).
;
sub_00342:
00000342  53                push bx
00000343  83C304            add bx,byte +0x4
00000346  268B47FE          mov ax,[es:bx-0x2]
0000034A  86C4              xchg al,ah
0000034C  8BF8              mov di,ax
0000034E  83C715            add di,byte +0x15
00000351  B440              mov ah,0x40
00000353  B049              mov al,0x49
00000355  2688A50080        mov [es:di-0x8000],ah
0000035A  AA                stosb
0000035B  B04D              mov al,0x4d
0000035D  B92800            mov cx,0x28
status_attr_00360:
00000360  2688A50080        mov [es:di-0x8000],ah
;>>>> [video status-screen drawing (OKI/Wyse gate array dual-plane VRAM)] `stosb` writes the character 'M' (0x4d, loaded at 0x35b) into the char plane at ES:DI; the preceding `mov [es:di-0x8000],ah` (0x360) set the matching attribute (AH=0x40) in the attribute plane 0x8000 below. This is the body of the CX=0x28 (40) loop `loop 0x360` that draws a full-width run of 'M' separators on the status screen, between the leading 'I' (0x49) glyph and the trailing ';' (0x3b) glyph.  // 0x351 mov ah,0x40; 0x353 mov al,0x49 ('I'); 0x35b mov al,0x4d ('M'); 0x35d mov cx,0x28; 0x360 mov [es:di-0x8000],ah; 0x365 stosb; 0x366 loop 0x360; 0x368 mov al,0x3b (';').
00000365  AA                stosb
00000366  E2F8              loop status_attr_00360   ; ->0x360
00000368  B03B              mov al,0x3b
0000036A  2688A50080        mov [es:di-0x8000],ah
0000036F  AA                stosb
;>>>> [video / status display] mov cx,0xf sets loop count = 15 for the table-driven label-drawing loop at 0x373-0x391. The loop reads a 16-bit screen offset from a word table at [es:bx], byte-swaps it (xchg dl,dh), adds 0x15, then writes a colon char 0x3a to the OKI M76V020 char plane (stosb at ES:DI) with attribute via [es:di-0x8000] (attribute plane is 0x8000 below char plane). It draws 15 column separators/labels for the Blocks/Bytes status box.  // 0x373 mov dx,[es:bx]; 0x376 add bx,2; 0x379 xchg dl,dh; 0x37B mov di,dx; 0x37D add di,0x15; 0x380 mov al,0x3a; 0x382 mov [es:di-0x8000],ah; 0x387 stosb; 0x391 loop 0x373
00000370  B90F00            mov cx,0xf
fread_blk_status_00373:
00000373  268B17            mov dx,[es:bx]
00000376  83C302            add bx,byte +0x2
00000379  86D6              xchg dl,dh
0000037B  8BFA              mov di,dx
;>>>> [video status-screen drawing (OKI/Wyse gate array VRAM @ dual plane)] `add di,byte +0x15` adds 0x15 (21) to the screen offset in DI (just loaded from a byte-swapped coordinate word read from the ES:BX table at 0x373/0x37B) to position the write cursor for the next field column. The following code writes char 0x3A (':') to the char plane via stosb and attribute byte AH to the attribute plane at [es:di-0x8000], then advances DI by 0x28 (one 40-char row) inside the CX=0xF loop drawing a column of colon separators.  // Preceded by mov di,dx (byte-swapped coord) at 0x37B; followed by mov al,0x3a, mov [es:di-0x8000],ah, stosb, add di,0x28, loop 0x373.
0000037D  83C715            add di,byte +0x15
00000380  B03A              mov al,0x3a
00000382  2688A50080        mov [es:di-0x8000],ah
00000387  AA                stosb
00000388  83C728            add di,byte +0x28
0000038B  2688A50080        mov [es:di-0x8000],ah
00000390  AA                stosb
00000391  E2E0              loop fread_blk_status_00373   ; ->0x373
00000393  268B17            mov dx,[es:bx]
00000396  86D6              xchg dl,dh
00000398  8BFA              mov di,dx
0000039A  83C715            add di,byte +0x15
0000039D  B048              mov al,0x48
0000039F  2688A50080        mov [es:di-0x8000],ah
;>>>> [video / status display] stosb writes the character 'H' (0x48, loaded at 0x39D) into the OKI gate-array char plane at ES:DI; the immediately preceding mov [es:di-0x8000],ah set the matching attribute byte in the attribute plane (0x8000 below). This is one glyph of a fixed label drawn into the status screen (DI positioned from the byte-swapped table entry +0x15).  // 0x39D mov al,0x48; 0x39F mov [es:di-0x8000],ah; 0x3A4 stosb; followed by al=0x4d 'M' run via loop at 0x3aa
000003A4  AA                stosb
000003A5  B04D              mov al,0x4d
;>>>> [video status-screen drawing (OKI/Wyse gate array dual-plane VRAM)] mov cx,0x28 sets the repeat count = 40 for the following stosb loop at 0x3AA-0x3B0 that fills a 40-character horizontal run of 'M' (0x4D, loaded at 0x3A5) into the OKI M76V020 char plane (ES:DI) with attribute byte AH written to the attribute plane at [es:di-0x8000]. Bounded by an 'H' (0x48) at the left (0x39D/0x3A4) and '<' (0x3C) at the right (0x3B2/0x3B9), this draws one horizontal box-edge row of the download status screen.  // 0x3A5 mov al,0x4d; 0x3A7 mov cx,0x28; 0x3AA mov [es:di-0x8000],ah; 0x3AF stosb; 0x3B0 loop 0x3aa
000003A7  B92800            mov cx,0x28
fill_status_attr_003AA:
;>>>> [video status-screen drawing (OKI/Wyse dual-plane VRAM)] mov [es:di-0x8000],ah writes the attribute byte (AH) into the attribute plane (0x8000 below the char plane) for the character about to be stored by stosb at 0x3AF. This is the body of the CX=0x28 (40) loop at 0x3AA-0x3B0 that fills a 40-column run of 'M' (AL=0x4d) into the OKI M76V020 char plane at ES:DI with the matching attribute, drawing a horizontal status-box bar. DI was positioned from a byte-swapped table coordinate +0x15.  // mov [es:di-0x8000],ah at 0x3AA, AL=0x4d set at 0x3A5, cx=0x28 at 0x3A7, stosb at 0x3AF, loop 0x3aa at 0x3B0. Dual-plane attribute write at -0x8000 matches prior accepted notes for 0x3A4 and 0x37D.
000003AA  2688A50080        mov [es:di-0x8000],ah
000003AF  AA                stosb
;>>>> [video status-screen drawing (OKI/Wyse gate array dual-plane VRAM)] `loop 0x3aa` is the CX=0x28 (40-iteration) body that draws a horizontal run of 'M' (0x4d) characters across the status box. Each iteration writes the attribute byte AH into the attribute plane via `mov [es:di-0x8000],ah` (0x3aa) then the char 'M' via `stosb` (0x3af), advancing DI. After the loop it writes the closing '<' (0x3c) glyph. This renders one full-width separator/border row of the download status screen.  // 0x3A5 mov al,0x4d; 0x3A7 mov cx,0x28; 0x3AA mov [es:di-0x8000],ah; 0x3AF stosb; 0x3B0 loop 0x3aa; then 0x3B2 mov al,0x3c (closing char).
000003B0  E2F8              loop fill_status_attr_003AA   ; ->0x3AA
000003B2  B03C              mov al,0x3c
;>>>> [video status-screen drawing (OKI/Wyse gate array dual-plane VRAM)] `mov [es:di-0x8000],ah` writes the attribute byte (AH) for the closing '<' glyph (AL=0x3c, loaded at 0x3b2) into the attribute plane, which sits 0x8000 below the char plane in the dual-plane VRAM. The following `stosb` (0x3b9) then writes the '<' character into the char plane at ES:DI. This terminates the 'M'-run separator row drawn by the loop at 0x3aa, capping the status box with a '<' marker.  // 0x3B2 mov al,0x3c ('<'); 0x3B4 mov [es:di-0x8000],ah; 0x3B9 stosb; 0x3BA pop bx; 0x3BB ret. Same attr-then-char idiom as 0x39f/0x3a4 and 0x3aa/0x3af.
000003B4  2688A50080        mov [es:di-0x8000],ah
000003B9  AA                stosb
000003BA  5B                pop bx
000003BB  C3                ret

; ---- 0x03bc-0x03c2 DATA (6 B) ----
0003BC  00 00 00 00 00 00                                |......|

; ---- 0x03c2-0x03cc CODE ----
;>>>> [string/data] UNKNOWN as code. This sits immediately after the real subroutine RET at 0x3BB and a 6-byte zero DATA gap (0x3BC-0x3C2). The bytes 7A 00 0E 01 2A 00 00 00 00 4A 01 are misdecoded data (note 4A 01 = constant 0x14A, the buffer-pointer value used elsewhere) - a small pointer/data table, not executable code. The 'jpe 0x3c4' decode is spurious.  // 03BB C3 ret; 03BC-03C2 zero DATA; 03C2 7A00 jpe; 03C5 012A add[bp+si],bp (nonsensical); 4A01 = 0x14A buffer const; adjacent STRING 'Transfer INACTIVE' at 0x3DA
000003C2  7A00              jpe data_003C4   ; ->0x3C4
data_003C4:
000003C4  0E                push cs
;>>>> [string/data] Not code: this is a small pointer/coordinate data table that the recursive-descent disassembler misdecoded as `add [bp+si],bp`. The raw bytes 01 2A 00 00 00 00 4A 01 sit between a DATA gap (0x3BC-0x3C2, all-zero) and the ASCII string "Transfer INACTIVE      " at 0x3DA, and the 4A 01 word = 0x014A is the receive-buffer pointer used elsewhere. UNKNOWN exact field semantics, but it is data, not an instruction.  // Surrounded by `; ---- DATA ----` regions and the "Transfer INACTIVE" string in the same sample; bytes form 0x014A (=buffer ptr 0x14A seen at 0x115/0x15F).
000003C5  012A              add [bp+si],bp
000003C7  0000              add [bx+si],al
000003C9  004A01            add [bp+si+0x1],cl

; ---- 0x03cc-0x03da DATA (14 B) ----
0003CC  00 00 00 00 00 00 00 00 00 00 00 00 00 00        |..............|

; ---- 0x03da-0x03f1 STRING (23 B) ----
0003DA  54 72 61 6e 73 66 65 72 20 49 4e 41 43 54 49 56  |Transfer INACTIV|
0003EA  45 20 20 20 20 20 20                             |E      |

; ---- 0x03f1-0x03f2 CODE ----
000003F1  00                db 0x00

; ---- 0x03f2-0x0409 STRING (23 B) ----
0003F2  46 69 6c 65 20 54 72 61 6e 73 66 65 72 20 41 43  |File Transfer AC|
000402  54 49 56 45 20 20 20                             |TIVE   |

; ---- 0x0409-0x040a CODE ----
00000409  00                db 0x00

; ---- 0x040a-0x0421 STRING (23 B) ----
00040A  46 69 6c 65 20 42 65 69 6e 67 20 57 52 49 54 54  |File Being WRITT|
00041A  45 4e 20 20 20 20 20                             |EN     |

; ---- 0x0421-0x0422 CODE ----
00000421  00                db 0x00

; ---- 0x0422-0x0439 STRING (23 B) ----
000422  46 69 6c 65 20 54 72 61 6e 73 66 65 72 20 43 4f  |File Transfer CO|
000432  4d 50 4c 45 54 45 20                             |MPLETE |

; ---- 0x0439-0x043a CODE ----
00000439  00                db 0x00

; ---- 0x043a-0x0451 STRING (23 B) ----
00043A  46 69 6c 65 20 54 72 61 6e 73 66 65 72 20 46 41  |File Transfer FA|
00044A  49 4c 45 44 21 21 21                             |ILED!!!|

; ---- 0x0451-0x0452 CODE ----
00000451  00                db 0x00

; ---- 0x0452-0x0458 STRING (6 B) ----
000452  46 69 6c 65 3a 20                                |File: |

; ---- 0x0458-0x0459 CODE ----
00000458  00                db 0x00

; ---- 0x0459-0x046a STRING (17 B) ----
000459  42 6c 6f 63 6b 73 20 52 65 63 65 69 76 65 64 3a  |Blocks Received:|
000469  20                                               | |

; ---- 0x046a-0x046b CODE ----
0000046A  00                db 0x00

; ---- 0x046b-0x047b STRING (16 B) ----
00046B  42 79 74 65 73 20 52 65 63 65 69 76 65 64 3a 20  |Bytes Received: |

; ---- 0x047b-0x047c CODE ----
0000047B  00                db 0x00

; ---- 0x047c-0x0484 STRING (8 B) ----
00047C  45 72 72 6f 72 73 3a 20                          |Errors: |

; ---- 0x0484-0x0485 CODE ----
00000484  00                db 0x00

; ---- 0x0485-0x04a9 STRING (36 B) ----
000485  46 69 6c 65 20 54 72 61 6e 73 66 65 72 20 56 65  |File Transfer Ve|
000495  72 73 69 6f 6e 20 30 2e 33 20 69 73 20 41 63 74  |rsion 0.3 is Act|
0004A5  69 76 65 2e                                      |ive.|

; ---- 0x04a9-0x04ab CODE ----
000004A9  0D                db 0x0d
000004AA  0A                db 0x0a

; ---- 0x04ab-0x04df STRING (52 B) ----
0004AB  24 46 69 6c 65 20 54 72 61 6e 73 66 65 72 20 69  |$File Transfer i|
0004BB  73 20 54 65 72 6d 69 6e 61 74 69 6e 67 20 64 75  |s Terminating du|
0004CB  65 20 74 6f 20 4c 61 63 6b 20 6f 66 20 4d 65 6d  |e to Lack of Mem|
0004DB  6f 72 79 2e                                      |ory.|

; ---- 0x04df-0x04e1 CODE ----
000004DF  0D                db 0x0d
000004E0  0A                db 0x0a

; ---- 0x04e1-0x04e7 STRING (6 B) ----
0004E1  24 2f 2d 5c 7c 20                                |$/-\| |

; ---- 0x04e7-0x04ed CODE ----
000004E7  0400              add al,0x0
000004E9  0F0000            sldt [bx+si]
000004EC  00                db 0x00

; ---- 0x04ed-0x05fa DATA (269 B) ----
0004ED  20 20 20 20 20 20 20 20 20 20 20 20 00 00 00 00  |            ....|
0004FD  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
00050D  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
00051D  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
00052D  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
00053D  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
00054D  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
00055D  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
00056D  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
00057D  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
00058D  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
00059D  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0005AD  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0005BD  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0005CD  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0005DD  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0005ED  00 00 00 00 00 00 00 00 00 00 00 00 00           |.............|
