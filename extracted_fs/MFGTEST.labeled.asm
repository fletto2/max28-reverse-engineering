; MFGTEST.EXE - code/data-separated disassembly (MZ load module, 5578 B, header 512 B stripped)
; entry @0x0000; 5 relocs. Classified CODE-unless-data-filter-fires
; (recursive descent under-covers C-runtime startups). Bytes: 5019 code / 382 string / 177 data.
;

; ---- 0x0000-0x1342 CODE ----
00000000  1E                push ds
00000001  B83401            mov ax,0x134
00000004  8ED8              mov ds,ax
00000006  07                pop es
00000007  8BDC              mov bx,sp
00000009  83C30F            add bx,byte +0xf
0000000C  C1EB04            shr bx,byte 0x4
0000000F  8CD0              mov ax,ss
00000011  03D8              add bx,ax
00000013  8CC0              mov ax,es
00000015  2BD8              sub bx,ax
00000017  B44A              mov ah,0x4a
00000019  CD21              int 0x21
;>>>> [kernel-API/INT40h] mov al,[0x13f] loads the stored configuration/version byte and feeds it as the AL parameter to the immediately following INT 40h AH=0x1E then INT 40h AH=0x26 (kernel custom comm/system API calls). This runs right after the MZ startup INT 21h AH=4Ah memory-resize (at 0x19). The returned DL is masked (and dl,0xf) and ORed 0x30 to form an ASCII hex/decimal digit stored at [0x19d]; DH is then divided by 10 (idiv dh) to render further decimal digits. Builds the version/ID string for the diagnostic display.  // >>>>0x1B mov al,[0x13f]; 0x1E mov ah,0x1e; 0x20 int 0x40; 0x22 mov ah,0x26; 0x24 int 0x40; 0x26 and dl,0xf; 0x29 or dl,0x30; 0x2C mov [0x19d],dl; matches prior accepted 0x1B annotation
0000001B  A03F01            mov al,[0x13f]
0000001E  B41E              mov ah,0x1e
00000020  CD40              int 0x40
00000022  B426              mov ah,0x26
00000024  CD40              int 0x40
00000026  80E20F            and dl,0xf
00000029  80CA30            or dl,0x30
0000002C  88169D01          mov [0x19d],dl
00000030  8AC6              mov al,dh
00000032  B60A              mov dh,0xa
00000034  32E4              xor ah,ah
00000036  F6FE              idiv dh
00000038  80CC30            or ah,0x30
0000003B  8826A101          mov [0x1a1],ah
0000003F  32E4              xor ah,ah
;>>>> [string/data (binary->decimal ASCII)] idiv dh (DH=10, set at 0x32 mov dh,0xa) is the 2nd of three successive unsigned... (signed idiv) divide-by-10 steps converting the byte in AL (a value returned by the earlier INT 40h AH=0x26 call) into decimal ASCII digits. Each step: xor ah,ah / idiv dh leaves remainder in AH; or ah,0x30 makes it ASCII and stores it (0x1a1, then 0x1a0, then 0x19f), producing a 3-digit decimal string in [0x19f..0x1a1] for the diagnostic/version display.  // 0x32 mov dh,0xa; 0x3F xor ah,ah; 0x41 idiv dh; 0x43 or ah,0x30; 0x46 mov [0x1a0],ah; repeated at 0x4C idiv dh -> [0x19f]. Source AL=dh from INT 40h result at 0x30 mov al,dh.
00000041  F6FE              idiv dh
00000043  80CC30            or ah,0x30
00000046  8826A001          mov [0x1a0],ah
0000004A  32E4              xor ah,ah
0000004C  F6FE              idiv dh
0000004E  80CC30            or ah,0x30
00000051  88269F01          mov [0x19f],ah
00000055  1E                push ds
00000056  33C0              xor ax,ax
00000058  BB00E0            mov bx,0xe000
0000005B  33D2              xor dx,dx
0000005D  8EDB              mov ds,bx
0000005F  33F6              xor si,si
loc_00061:
00000061  AC                lodsb
00000062  03D0              add dx,ax
00000064  0BF6              or si,si
00000066  75F9              jnz loc_00061   ; ->0x61
00000068  81FB00E0          cmp bx,0xe000
0000006C  7508              jnz loc_00076   ; ->0x76
0000006E  8BCA              mov cx,dx
00000070  81C30010          add bx,0x1000
00000074  EBE5              jmp short 0x5b
loc_00076:
00000076  58                pop ax
;>>>> [ROM checksum / self-test] mov ds,ax (followed by mov es,ax) sets DS=ES to the segment whose 16-bit additive checksum was just computed (loop at 0x5B-0x74 sums bytes via LODSB over 0x1000-byte banks until BX reaches 0xE000). It then points DI at a hex-output buffer [0x1AB] to render the computed sum as ASCII hex (via the nibble table at [0x185]) for the diagnostic display - this is the ROM/memory-bank checksum self-test.  // Lines 56-80: xor si,si; lodsb; add dx,ax loop; cmp bx,0xe000; add bx,0x1000; then mov ds/es,ax; lea di,[0x1ab]; cmp cx,dx; rol dx,4; and ax,0xf; mov al,[si+0x185]; stosb (nibble-to-hex).
00000077  8ED8              mov ds,ax
00000079  8EC0              mov es,ax
0000007B  8D3EAB01          lea di,[0x1ab]
;>>>> [checksum/diagnostic] cmp cx,dx: compares the expected stored checksum (CX, loaded from end of each 0x1000-byte ROM bank in the preceding loop) against the running 8/16-bit sum DX. If unequal (not jz 0x85) it does add dx,cx to fold the difference in, then the code (cx=4 / rol dx,4 / hex-digit lookup at [si+0x185]) converts DX to 4 ASCII hex digits for the displayed ROM checksum result.  // 0x5b-0x76 loop: lodsb/add dx,ax over banks, cmp bx,0xe000, add bx,0x1000, mov cx,dx. Then 0x7f cmp cx,dx; 0x88 mov cx,4; rol dx,4; nibble->[si+0x185] hex table; stosb.
0000007F  3BCA              cmp cx,dx
00000081  7402              jz loc_00085   ; ->0x85
00000083  03D1              add dx,cx
loc_00085:
00000085  B90400            mov cx,0x4
loc_00088:
00000088  B80F00            mov ax,0xf
0000008B  C1C204            rol dx,byte 0x4
0000008E  23C2              and ax,dx
;>>>> [system] mov si,ax takes the masked low nibble (ax = 0xF AND DX, computed at 0x88-0x8E after rol dx,4) and uses it as an index into the hex-digit ASCII lookup table at [si+0x185]; the next instr mov al,[si+0x185] / stosb writes one hex character to the display buffer (di from lea di,[0x1ab]). This is the inner step of a 4-iteration (cx=4) binary-to-4-hex-ASCII conversion used to display the ROM checksum/diagnostic value.  // 0x88 mov ax,0xf; 0x8B rol dx,4; 0x8E and ax,dx (isolate top nibble of DX); 0x90 mov si,ax; 0x92 mov al,[si+0x185]; 0x96 stosb; 0x97 loop 0x88 (cx=4). Table at 0x185 is the '0'-'F' hex digit string. di set at 0x7B lea di,[0x1ab].
00000090  8BF0              mov si,ax
00000092  8A848501          mov al,[si+0x185]
00000096  AA                stosb
00000097  E2EF              loop loc_00088   ; ->0x88
;>>>> [system] call 0x10e0 is the first of a chain of subsystem init/self-test routines invoked after the ROM-checksum-to-hex-ASCII display loop (0x88-0x97 converts DX to 4 hex digits via table [si+0x185] and stosb). The chain (0x10e0,0x10f0,0x10fb,0x1224,0x12a2,0x1166,0xff3,0x10f0) sequentially initializes/tests the terminal subsystems (timers/PCB ports, SCC, video). 0x10f0 is called twice and 0xff3 is the common short delay/poll helper used across the self-test.  // Preceding 0x88-0x97 nibble loop (mov ax,0xf; rol dx,4; and ax,dx; mov si,ax; mov al,[si+0x185]; stosb; loop) is hex display. 0x99-0xAE is a flat sequence of call instructions, the top-level self-test dispatcher. 0xff3 appears repeatedly elsewhere as a poll/delay helper.
00000099  E84410            call hexprint_cksum_dispatch_010E0   ; ->0x10E0
0000009C  E85110            call hexprint_cksum_dispatch_010F0   ; ->0x10F0
0000009F  E85910            call hexprint_cksum_dispatch_010FB   ; ->0x10FB
000000A2  E87F11            call hexprint_cksum_dispatch_01224   ; ->0x1224
000000A5  E8FA11            call hexprint_cksum_dispatch_012A2   ; ->0x12A2
000000A8  E8BB10            call hexprint_cksum_dispatch_01166   ; ->0x1166
loc_000AB:
000000AB  E8450F            call hexprint_cksum_dispatch_00FF3   ; ->0xFF3
000000AE  E83F10            call hexprint_cksum_dispatch_010F0   ; ->0x10F0
000000B1  32DB              xor bl,bl
000000B3  881E5902          mov [0x259],bl
000000B7  BA08FF            mov dx,0xff08
000000BA  ED                in ax,dx
000000BB  25BFFF            and ax,0xffbf
000000BE  EF                out dx,ax
000000BF  B80200            mov ax,0x2
000000C2  E8670F            call 0x102c
loc_000C5:
000000C5  0A1E5902          or bl,[0x259]
000000C9  751F              jnz loc_000EA   ; ->0xEA
000000CB  E8250F            call hexprint_cksum_dispatch_00FF3   ; ->0xFF3
000000CE  E8770F            call fread_status_01048   ; ->0x1048
000000D1  75F2              jnz loc_000C5   ; ->0xC5
000000D3  0A1E5902          or bl,[0x259]
000000D7  7511              jnz loc_000EA   ; ->0xEA
000000D9  750F              jnz loc_000EA   ; ->0xEA
000000DB  B80100            mov ax,0x1
000000DE  A32A01            mov [0x12a],ax
000000E1  D1E0              shl ax,1
000000E3  09060A01          or [0x10a],ax
000000E7  EB01              jmp short 0xea
000000E9  90                nop
loc_000EA:
000000EA  E8060F            call hexprint_cksum_dispatch_00FF3   ; ->0xFF3
000000ED  BB0000            mov bx,0x0
000000F0  E8B00D            call fread_status_00EA3   ; ->0xEA3
000000F3  740C              jz fread_fill_vram_00101   ; ->0x101
000000F5  B80100            mov ax,0x1
000000F8  A32A01            mov [0x12a],ax
000000FB  D1E0              shl ax,1
000000FD  09060A00          or [0xa],ax
fread_fill_vram_00101:
00000101  BA0EFF            mov dx,0xff0e
00000104  ED                in ax,dx
00000105  A98000            test ax,0x80
00000108  750D              jnz loc_00117   ; ->0x117
0000010A  B80100            mov ax,0x1
0000010D  A32A01            mov [0x12a],ax
00000110  C1E007            shl ax,byte 0x7
00000113  09060A00          or [0xa],ax
loc_00117:
00000117  BB5740            mov bx,0x4057
0000011A  E8860D            call fread_status_00EA3   ; ->0xEA3
0000011D  740D              jz fread_status_0012C   ; ->0x12C
0000011F  B80100            mov ax,0x1
;>>>> [80C188EB PCB / self-test fail-flag] mov [0x12a],ax stores the fail-flag (AX=1, set at 0x11F) into the shared result temp [0x12a]. This is the failure path of a hardware-status test: after call 0xea3 at 0x11A with BX=0x4057, jz 0x12c was NOT taken (test failed), so the flag is stored then shl ax,2 / or [0xa],ax records the bit in the [0xa] error mask. (The neighboring test at 0x12C reads PCB port 0xFF0E, test bit7.) Standard fail-flag store; bit-slot 2 in mask [0xa].  // 0x11A call 0xea3 (BX=0x4057); 0x11D jz 0x12c; 0x11F mov ax,1; 0x122 mov [0x12a],ax; 0x125 shl ax,2; 0x128 or [0xa],ax. Next test: 0x12C dx=0xff0e,in ax,dx,test ax,0x80.
00000122  A32A01            mov [0x12a],ax
00000125  C1E002            shl ax,byte 0x2
00000128  09060A00          or [0xa],ax
fread_status_0012C:
0000012C  BA0EFF            mov dx,0xff0e
0000012F  ED                in ax,dx
00000130  A98000            test ax,0x80
00000133  740D              jz loc_00142   ; ->0x142
00000135  B80100            mov ax,0x1
00000138  A32A01            mov [0x12a],ax
0000013B  C1E006            shl ax,byte 0x6
0000013E  09060A00          or [0xa],ax
loc_00142:
00000142  BB5D80            mov bx,0x805d
00000145  E85B0D            call fread_status_00EA3   ; ->0xEA3
00000148  740D              jz loc_00157   ; ->0x157
0000014A  B80100            mov ax,0x1
0000014D  A32A01            mov [0x12a],ax
00000150  C1E003            shl ax,byte 0x3
00000153  09060A00          or [0xa],ax
loc_00157:
00000157  BB7520            mov bx,0x2075
0000015A  E8460D            call fread_status_00EA3   ; ->0xEA3
0000015D  740D              jz loc_0016C   ; ->0x16C
0000015F  B80100            mov ax,0x1
00000162  A32A01            mov [0x12a],ax
00000165  C1E004            shl ax,byte 0x4
00000168  09060A00          or [0xa],ax
loc_0016C:
0000016C  BBD508            mov bx,0x8d5
0000016F  E8310D            call fread_status_00EA3   ; ->0xEA3
00000172  740D              jz loc_00181   ; ->0x181
00000174  B80100            mov ax,0x1
00000177  A32A01            mov [0x12a],ax
0000017A  C1E005            shl ax,byte 0x5
0000017D  09060A00          or [0xa],ax
loc_00181:
00000181  E86F0E            call hexprint_cksum_dispatch_00FF3   ; ->0xFF3
00000184  BA0103            mov dx,0x301
00000187  B809C0            mov ax,0xc009
0000018A  E8280D            call init_00EB5   ; ->0xEB5
0000018D  B80400            mov ax,0x4
00000190  E8220D            call init_00EB5   ; ->0xEB5
00000193  B803C2            mov ax,0xc203
00000196  E81C0D            call init_00EB5   ; ->0xEB5
00000199  B80560            mov ax,0x6005
0000019C  E8160D            call init_00EB5   ; ->0xEB5
0000019F  B80616            mov ax,0x1606
000001A2  E8100D            call init_00EB5   ; ->0xEB5
000001A5  B80716            mov ax,0x1607
000001A8  E80A0D            call init_00EB5   ; ->0xEB5
000001AB  B80B00            mov ax,0xb
000001AE  E8040D            call init_00EB5   ; ->0xEB5
000001B1  B80E10            mov ax,0x100e
000001B4  E8FE0C            call init_00EB5   ; ->0xEB5
;>>>> [serial/SCC] mov ax,0xf (then call 0xeb5 at 0x1BA) writes WR0=0x0F to the Z8530 SCC. 0xeb5 is the SCC write-register helper (OUT DX,AL select-reg=AL=0x0F as a register-pointer/command, XCHG AL,AH, OUT DX,AL data=AH=0x00) at the SCC control port. This is one step in the long WR0..WR15 init burst (preceding writes: 0x6005,0x1606,0x1607,0x000B,0x100E, then this 0x000F) that programs the SCC for synchronous host-link operation. The 0x0F low byte = WR0 with a reset/EOI-class command.  // >>>>0x1B7 mov ax,0xf; 0x1BA call 0xeb5; preceding 0x1B1 mov ax,0x100e/call; 0x1AB mov ax,0xb/call; helper 0xeb5 = out dx,al;xchg al,ah;out dx,al per priors
000001B7  B80F00            mov ax,0xf
000001BA  E8F80C            call init_00EB5   ; ->0xEB5
000001BD  B70C              mov bh,0xc
000001BF  32DB              xor bl,bl
000001C1  8AC7              mov al,bh
000001C3  EE                out dx,al
000001C4  EE                out dx,al
000001C5  EE                out dx,al
000001C6  EC                in al,dx
000001C7  02D8              add bl,al
000001C9  8AC7              mov al,bh
000001CB  EE                out dx,al
000001CC  EE                out dx,al
;>>>> [hardware test] out dx,al is the 3rd of three back-to-back writes (0xCB,0xCC,0xCD) of BH to the same I/O port in DX, immediately followed by in al,dx and add bl,al. This is a data-bus / register read-back integrity test: it writes a fixed pattern (BH) several times to settle the bus, reads one byte back, and accumulates it in BL. The accumulated BL is later compared (cmp bl,0x78 at 0x211) to verify the device echoes the expected value. The triple-OUT pattern is the SCC/peripheral write-recovery wait sequence on the slow external bus.  // 0x1C1 mov al,bh; 0x1C3-0x1C5 three out dx,al; 0x1C6 in al,dx; 0x1C7 add bl,al — repeating block. Downstream 0x211 cmp bl,0x78 / jz validates the running sum. xor bl,bl at 0x1BF initializes the checksum accumulator.
000001CD  EE                out dx,al
000001CE  EC                in al,dx
000001CF  02D8              add bl,al
000001D1  8AC7              mov al,bh
000001D3  EE                out dx,al
000001D4  EE                out dx,al
000001D5  EE                out dx,al
000001D6  EC                in al,dx
000001D7  02D8              add bl,al
000001D9  8AC7              mov al,bh
000001DB  EE                out dx,al
000001DC  EE                out dx,al
000001DD  EE                out dx,al
;>>>> [hardware test] in al,dx reads one byte back from the peripheral port in DX after the preceding triple out dx,al (0x1DB-0x1DD) wrote BH; the following add bl,al (0x1DF) accumulates it into the BL checksum. This is one iteration of the write-pattern/read-back data-bus integrity loop whose running sum is later compared to 0x78 (cmp bl,0x78 at 0x211) to verify the external peripheral (SCC/gate-array) echoes correctly.  // 0x1DB-0x1DD three out dx,al (BH pattern + bus write-recovery waits); 0x1DE in al,dx; 0x1DF add bl,al — identical repeating block as 0x1C6/0x1EE/0x1FE/0x206. Terminal check 0x211 cmp bl,0x78 / jz validates accumulated readback.
000001DE  EC                in al,dx
000001DF  02D8              add bl,al
000001E1  8AC7              mov al,bh
000001E3  EE                out dx,al
000001E4  EE                out dx,al
000001E5  EE                out dx,al
000001E6  EC                in al,dx
000001E7  02D8              add bl,al
000001E9  8AC7              mov al,bh
000001EB  EE                out dx,al
000001EC  EE                out dx,al
000001ED  EE                out dx,al
000001EE  EC                in al,dx
000001EF  02D8              add bl,al
000001F1  8AC7              mov al,bh
000001F3  EE                out dx,al
000001F4  EE                out dx,al
000001F5  EE                out dx,al
;>>>> [SCC (Z8530) read-back test] IN AL,DX reads back the Z8530 SCC control port 0x301 (DX=0x301 set at 0x184). This is one iteration of the SCC register write/read integrity loop: write BH three times (OUT DX,AL x3) then IN, and add to BL. The triple-OUT/single-IN cadence repeatedly drives the SCC's reg-pointer/data sequence and the accumulated BL is later compared to 0x78 (at 0x211) to validate the SCC data bus.  // Lines 254-259: out dx,al x3; in al,dx; add bl,al pattern; mov dx,0x301 at 0x184; cmp bl,0x78 at 0x211. Same loop body as sample 2/0x020F.
000001F6  EC                in al,dx
000001F7  02D8              add bl,al
000001F9  8AC7              mov al,bh
000001FB  EE                out dx,al
000001FC  EE                out dx,al
000001FD  EE                out dx,al
000001FE  EC                in al,dx
000001FF  02D8              add bl,al
00000201  8AC7              mov al,bh
;>>>> [SCC (Z8530 serial)] out dx,al is the 1st of the triple back-to-back OUT DX,AL writes (0x203,0x204,0x205) of BH to the same SCC port (DX=0x300/0x301), followed by IN AL,DX (0x206) and add bl,al (0x207). This is one iteration of the SCC register write/read-back integrity loop: BH is written three times as a write-recovery/settle sequence on the slow external bus, one byte is read back, and accumulated into BL. The running BL sum is later compared to 0x78 (cmp bl,0x78 at 0x211) to verify the Z8530 echoes the expected pattern. Identical cadence to the accepted 0x1CD/0x1DE/0x1F6 annotations.  // 0x203-0x205 out dx,al x3; 0x206 in al,dx; 0x207 add bl,al; later cmp bl,0x78 at 0x211
00000203  EE                out dx,al
00000204  EE                out dx,al
00000205  EE                out dx,al
00000206  EC                in al,dx
00000207  02D8              add bl,al
00000209  8AC7              mov al,bh
0000020B  EE                out dx,al
0000020C  EE                out dx,al
0000020D  EE                out dx,al
0000020E  EC                in al,dx
;>>>> [SCC (Z8530 serial)] add bl,al accumulates a byte just read (IN AL,DX) from the Z8530 SCC control port 0x301 into checksum BL. This is inside the SCC register read-back integrity test: DX=0x301 (set at 0x184), it writes BH=0x0C three times then reads (the SCC's auto-incrementing/RR readback), summing. The next instruction cmp bl,0x78 / jz checks the expected accumulated value; on mismatch it sets failure flag [0x12a]=1 and ORs a shifted bit into the channel-A SCC error mask at [0x4a].  // mov dx,0x301 at 000001A5/0x184; mov bh,0xc at 0x1BD; cmp bl,0x78 at 0x211 (line 259); on fail or [0x4a],ax at 0x21E. 0xEBA helper (line 1572) selects SCC reg 0 and reads.
0000020F  02D8              add bl,al
00000211  80FB78            cmp bl,0x78
00000214  740C              jz loc_00222   ; ->0x222
00000216  B80100            mov ax,0x1
00000219  A32A01            mov [0x12a],ax
0000021C  D1E0              shl ax,1
0000021E  09064A00          or [0x4a],ax
loc_00222:
00000222  B80016            mov ax,0x1600
00000225  CD40              int 0x40
00000227  BA56FF            mov dx,0xff56
0000022A  ED                in ax,dx
0000022B  8BC8              mov cx,ax
0000022D  0C40              or al,0x40
0000022F  EE                out dx,al
00000230  E8660C            call fread_00E99   ; ->0xE99
00000233  BA0103            mov dx,0x301
00000236  B000              mov al,0x0
00000238  E87F0C            call cksum_fread_00EBA   ; ->0xEBA
0000023B  A820              test al,0x20
0000023D  740C              jz loc_0024B   ; ->0x24B
0000023F  B80100            mov ax,0x1
00000242  A32A01            mov [0x12a],ax
00000245  D1E0              shl ax,1
00000247  09066A00          or [0x6a],ax
loc_0024B:
0000024B  BA5AFF            mov dx,0xff5a
0000024E  ED                in ax,dx
0000024F  A804              test al,0x4
00000251  750D              jnz loc_00260   ; ->0x260
00000253  B80100            mov ax,0x1
00000256  A32A01            mov [0x12a],ax
00000259  C1E002            shl ax,byte 0x2
0000025C  09066A00          or [0x6a],ax
loc_00260:
00000260  BA56FF            mov dx,0xff56
00000263  8BC1              mov ax,cx
00000265  24BF              and al,0xbf
00000267  EE                out dx,al
00000268  E82E0C            call fread_00E99   ; ->0xE99
0000026B  BA5AFF            mov dx,0xff5a
0000026E  ED                in ax,dx
0000026F  A804              test al,0x4
00000271  740D              jz blk_00280   ; ->0x280
00000273  B80100            mov ax,0x1
00000276  A32A01            mov [0x12a],ax
00000279  C1E003            shl ax,byte 0x3
0000027C  09066A00          or [0x6a],ax
blk_00280:
00000280  BA0103            mov dx,0x301
00000283  B000              mov al,0x0
00000285  E8320C            call cksum_fread_00EBA   ; ->0xEBA
00000288  A820              test al,0x20
0000028A  750D              jnz loc_00299   ; ->0x299
0000028C  B80100            mov ax,0x1
0000028F  A32A01            mov [0x12a],ax
00000292  C1E004            shl ax,byte 0x4
00000295  09066A00          or [0x6a],ax
loc_00299:
00000299  B80116            mov ax,0x1601
0000029C  CD40              int 0x40
0000029E  E8F80B            call fread_00E99   ; ->0xE99
;>>>> [SCC (Z8530) status test] mov al,0 sets the SCC register pointer to 0 (RR0) for the helper 0xeba, which does OUT DX,AL (select reg) then IN AL,DX (read) on port 0x301. The returned RR0 is then tested for bit5 (test al,0x20, the CTS/sync-status class bit); on the set/clear branch it stores fail-flag [0x12a]=1, shifts left 5 and ORs into SCC mask [0x6a]. One of a series of per-bit SCC RR0 status verifications.  // Lines 203-210: mov al,0x0; call 0xeba; test al,0x20; jz; mov [0x12a]; shl ax,5; or [0x6a],ax. 0xeba routine confirmed (line 1572-1575) writes 0 then reads DX (DX=0x301 in this region).
000002A1  B000              mov al,0x0
000002A3  E8140C            call cksum_fread_00EBA   ; ->0xEBA
000002A6  A820              test al,0x20
000002A8  740D              jz loc_002B7   ; ->0x2B7
000002AA  B80100            mov ax,0x1
000002AD  A32A01            mov [0x12a],ax
000002B0  C1E005            shl ax,byte 0x5
000002B3  09066A00          or [0x6a],ax
loc_002B7:
000002B7  B80562            mov ax,0x6205
000002BA  E8F80B            call init_00EB5   ; ->0xEB5
000002BD  E8D90B            call fread_00E99   ; ->0xE99
000002C0  B000              mov al,0x0
000002C2  E8F50B            call cksum_fread_00EBA   ; ->0xEBA
000002C5  A820              test al,0x20
000002C7  750D              jnz loc_002D6   ; ->0x2D6
000002C9  B80100            mov ax,0x1
000002CC  A32A01            mov [0x12a],ax
000002CF  C1E006            shl ax,byte 0x6
000002D2  09066A00          or [0x6a],ax
loc_002D6:
000002D6  B8056A            mov ax,0x6a05
000002D9  E8D90B            call init_00EB5   ; ->0xEB5
000002DC  B90500            mov cx,0x5
fread_status_002DF:
000002DF  BA0303            mov dx,0x303
000002E2  B0AA              mov al,0xaa
000002E4  EE                out dx,al
000002E5  BA0103            mov dx,0x301
;>>>> [SCC (Z8530) Tx-ready poll] mov al,0x0 sets the SCC register pointer to 0 (select RR0) for the read helper 0xeba (which does OUT DX,AL to select then IN AL,DX on port 0x301). The returned RR0 is tested with test al,0x40 (bit6 = Tx Buffer Empty) inside a loope 0x2df poll loop (CX=5 retries, preceded by writing 0xAA to port 0x303). On timeout/failure (jnz not taken) it sets fail-flag [0x12a]=1, shifts left 7 and ORs into the channel-A SCC status mask [0x4a]. This is the SCC transmitter-ready (Tx buffer empty) verification.  // >>>>0x2E8 mov al,0; 0x2EA call 0xeba; 0x2ED test al,0x40; 0x2EF loope 0x2df; 0x2F1 jnz 0x300; 0x2F3 mov [0x12a]=1; 0x2F9 shl ax,7; 0x2FC or [0x4a],ax
000002E8  B000              mov al,0x0
000002EA  E8CD0B            call cksum_fread_00EBA   ; ->0xEBA
000002ED  A840              test al,0x40
000002EF  E1EE              loope fread_status_002DF   ; ->0x2DF
000002F1  750D              jnz fread_00300   ; ->0x300
000002F3  B80100            mov ax,0x1
000002F6  A32A01            mov [0x12a],ax
;>>>> [SCC (Z8530) Tx-status test / fail-flag] shl ax,0x7 (AX was just set to 1 and stored to [0x12a] at 0x2F6) then or [0x4a],ax records an SCC channel-A failure by setting bit7 in the error mask [0x4a]. It is reached when the preceding Tx-buffer-empty poll failed: the loop wrote 0xAA to port 0x303 and polled RR0 via 0xeba at 0x301 testing bit6 (test al,0x40), and loope/jnz fell through indicating the SCC never reported Tx ready. Fail-flag store for the Z8530 transmit-readiness check.  // 0x2E2 mov al,0xAA/out (0x303); 0x2E8 mov al,0/call 0xeba (read RR0 at 0x301); 0x2ED test al,0x40; 0x2EF loope; 0x2F1 jnz; 0x2F3 ax=1/0x2F6 [0x12a]=1; 0x2F9 shl ax,7; 0x2FC or [0x4a],ax.
000002F9  C1E007            shl ax,byte 0x7
000002FC  09064A00          or [0x4a],ax
fread_00300:
00000300  B91400            mov cx,0x14
fread_status_00303:
00000303  B80568            mov ax,0x6805
;>>>> [SCC (Z8530) WR5 register exercise] call 0xeb5 with AX=0x6805 (set at 0x303) writes WR5=0x68 to the Z8530 via the helper 0xeb5 (out reg-select AL, xchg, out data AH; channel control 0x301). It is inside a cx=0x14 loop that alternately writes WR5=0x68 (0x6805) and WR5=0x6a (0x6a05, call at 0x30C) — toggling the WR5 RTS/DTR/Tx-enable bit repeatedly to exercise the SCC modem-control output line. After the loop it re-reads RR0 (0xeba, test al,0x40) and records failure in mask [0x6a] bit8.  // 0x300 mov cx,0x14; 0x303 mov ax,0x6805/0x306 call 0xeb5; 0x309 mov ax,0x6a05/0x30C call 0xeb5; 0x30F loop 0x303; 0x311 mov al,0/call 0xeba/test al,0x40; 0x320 shl ax,8/or [0x6a]. 0xeb5 = SCC WR helper (out AL reg, out AH data).
00000306  E8AC0B            call init_00EB5   ; ->0xEB5
00000309  B8056A            mov ax,0x6a05
0000030C  E8A60B            call init_00EB5   ; ->0xEB5
0000030F  E2F2              loop fread_status_00303   ; ->0x303
00000311  B000              mov al,0x0
00000313  E8A40B            call cksum_fread_00EBA   ; ->0xEBA
00000316  A840              test al,0x40
00000318  750D              jnz loc_00327   ; ->0x327
0000031A  B80100            mov ax,0x1
0000031D  A32A01            mov [0x12a],ax
00000320  C1E008            shl ax,byte 0x8
00000323  09066A00          or [0x6a],ax
loc_00327:
00000327  BA0103            mov dx,0x301
0000032A  B80B28            mov ax,0x280b
0000032D  E8850B            call init_00EB5   ; ->0xEB5
00000330  B90500            mov cx,0x5
fread_clear_status_00333:
00000333  BA0303            mov dx,0x303
00000336  B0AA              mov al,0xaa
00000338  EE                out dx,al
00000339  BA0103            mov dx,0x301
0000033C  B000              mov al,0x0
0000033E  E8790B            call cksum_fread_00EBA   ; ->0xEBA
00000341  A840              test al,0x40
00000343  E1EE              loope fread_clear_status_00333   ; ->0x333
00000345  750D              jnz loc_00354   ; ->0x354
00000347  B80100            mov ax,0x1
0000034A  A32A01            mov [0x12a],ax
;>>>> [SCC (Z8530)] shl ax,0x9 shifts the fail-flag (AX=1, set at 0x347) left by 9, then or [0x4a],ax records the failure bit in the channel-A SCC status/error mask at [0x4a]. This branch is reached when the preceding loop (write 0xAA to port 0x303 at 0x336-0x338, read RR0 via call 0xeba at port 0x301, test al,0x40, loope 0x333) failed to see SCC status bit6 clear within the count - i.e. an SCC RR0 status-bit poll timed out. The shift amount (9) selects this test's dedicated bit slot in the mask.  // 0x347 mov ax,1; 0x34A mov [0x12a],ax; 0x34D shl ax,0x9; 0x350 or [0x4a],ax. Preceding poll: 0x336 al=0xaa,out 0x303; 0x33C al=0,call 0xeba(port 0x301); 0x341 test al,0x40; 0x343 loope.
0000034D  C1E009            shl ax,byte 0x9
00000350  09064A00          or [0x4a],ax
loc_00354:
00000354  BA56FF            mov dx,0xff56
00000357  ED                in ax,dx
00000358  8BD8              mov bx,ax
0000035A  B91400            mov cx,0x14
loc_0035D:
0000035D  8BC3              mov ax,bx
0000035F  0C40              or al,0x40
00000361  EE                out dx,al
00000362  24BF              and al,0xbf
00000364  EE                out dx,al
00000365  E2F6              loop loc_0035D   ; ->0x35D
00000367  BA0103            mov dx,0x301
0000036A  B000              mov al,0x0
0000036C  E84B0B            call cksum_fread_00EBA   ; ->0xEBA
0000036F  A840              test al,0x40
;>>>> [SCC (Z8530) Tx-status test] jnz 0x380 is the branch after testing RR0 bit 6 (0x40 = Tx Underrun/EOM, not Tx Buffer Empty) read from SCC port 0x301 via 0xeba. The immediately preceding cx=0x14 toggle loop (or al,0x40 / and al,0xbf out/out) targets 80C186 PCB timer register 0xFF56, not the SCC port. The failure path (shl ax,0xa into error mask [0x6a]) is as described.  // 0x367 mov dx,0x301; 0x36A mov al,0/call 0xeba; 0x36F test al,0x40; 0x371 jnz 0x380; 0x373 ax=1/[0x12a]; 0x379 shl ax,0xa; 0x37C or [0x6a],ax.
00000371  750D              jnz fread_00380   ; ->0x380
00000373  B80100            mov ax,0x1
00000376  A32A01            mov [0x12a],ax
;>>>> [SCC (Z8530)] shl ax,0xa shifts the fail-flag (AX=1, set at 0x373/stored 0x376) left by 10, then or [0x6a],ax records the failure bit (slot 10) in the SCC error/status mask at [0x6a]. This is the failure path of an SCC Tx-status check: the preceding code reads SCC RR0 via call 0xeba (al=0, port 0x301 set at 0x367) and test al,0x40 (RR0 bit6, Tx-buffer-empty/under-run class); jnz 0x380 skips the fail path when the bit is set, so this branch records that the Tx-empty status was not seen. After it, code resumes a PCB timer test at port 0xFF5E.  // 0x367 dx=0x301; 0x36A al=0,call 0xeba; 0x36F test al,0x40; 0x371 jnz 0x380; 0x373 mov ax,1; 0x376 mov [0x12a],ax; 0x379 shl ax,0xa; 0x37C or [0x6a],ax; 0x380 dx=0xff5e (timer).
00000379  C1E00A            shl ax,byte 0xa
0000037C  09066A00          or [0x6a],ax
fread_00380:
00000380  BA5EFF            mov dx,0xff5e
00000383  ED                in ax,dx
00000384  250FFF            and ax,0xff0f
00000387  8BD8              mov bx,ax
00000389  EE                out dx,al
0000038A  E80C0B            call fread_00E99   ; ->0xE99
0000038D  BA5AFF            mov dx,0xff5a
00000390  ED                in ax,dx
00000391  24F0              and al,0xf0
00000393  740C              jz fread_003A1   ; ->0x3A1
00000395  B80100            mov ax,0x1
00000398  A32A01            mov [0x12a],ax
0000039B  D1E0              shl ax,1
;>>>> [80C188EB PCB timer-1 test] or [0x2a],ax merges the shifted fail bit (ax=1<<1, from mov ax,1 at 0x395 / shl ax,1 at 0x39B) into the timer error bitmask [0x2a]. This fail path is taken when the timer-1 count register read at I/O 0xFF5A (in ax,dx at 0x390; and al,0xf0) was non-zero (jz 0x3a1 NOT taken). It is the error-flag store for one phase of the timer-1 count verification; the next phase reprograms 0xFF5E (or al,0x80) and re-reads 0xFF5A expecting 0x90.  // >>>>0x39D or [0x2a],ax; 0x395 mov ax,1; 0x398 mov [0x12a],ax; 0x39B shl ax,1; 0x390 in ax,dx(0xff5a); 0x391 and al,0xf0; 0x393 jz 0x3a1; matches prior 0x3D8 timer-1 annotation
0000039D  09062A00          or [0x2a],ax
fread_003A1:
000003A1  BA5EFF            mov dx,0xff5e
000003A4  8BC3              mov ax,bx
000003A6  0C80              or al,0x80
000003A8  EE                out dx,al
000003A9  E8ED0A            call fread_00E99   ; ->0xE99
000003AC  BA5AFF            mov dx,0xff5a
000003AF  ED                in ax,dx
000003B0  24F0              and al,0xf0
000003B2  3C90              cmp al,0x90
000003B4  740D              jz fread_003C3   ; ->0x3C3
000003B6  B80100            mov ax,0x1
000003B9  A32A01            mov [0x12a],ax
000003BC  C1E002            shl ax,byte 0x2
000003BF  09062A00          or [0x2a],ax
fread_003C3:
000003C3  BA5EFF            mov dx,0xff5e
000003C6  8BC3              mov ax,bx
000003C8  0C40              or al,0x40
000003CA  EE                out dx,al
000003CB  E8CB0A            call fread_00E99   ; ->0xE99
000003CE  BA5AFF            mov dx,0xff5a
000003D1  ED                in ax,dx
000003D2  25F000            and ax,0xf0
000003D5  3D6000            cmp ax,0x60
;>>>> [timer/PCB] jz 0x3e7: branch in a timer-1 verification test. Preceding code sets a timer mode bit (mov dx,0xff5e / or al,0x40 / out), delays (call 0xe99), reads timer-1 count register at I/O 0xff5a, masks upper nibble (and ax,0xf0) and compares to 0x60. If it matches (jz) it skips the error path; otherwise sets [0x12a]=1 and ORs (1<<3) into timer error mask [0x2a].  // 0x3c3-0x3d8: mov dx,0xff5e; or al,0x40; out dx,al; call 0xe99; mov dx,0xff5a; in ax,dx; and ax,0xf0; cmp ax,0x60; jz 0x3e7. 0x3da-0x3e3 sets flag/shl 3/or [0x2a].
000003D8  740D              jz fread_003E7   ; ->0x3E7
000003DA  B80100            mov ax,0x1
000003DD  A32A01            mov [0x12a],ax
000003E0  C1E003            shl ax,byte 0x3
000003E3  09062A00          or [0x2a],ax
fread_003E7:
000003E7  E8090C            call hexprint_cksum_dispatch_00FF3   ; ->0xFF3
000003EA  BA0103            mov dx,0x301
000003ED  B809C0            mov ax,0xc009
000003F0  E8C20A            call init_00EB5   ; ->0xEB5
000003F3  B80405            mov ax,0x504
000003F6  E8BC0A            call init_00EB5   ; ->0xEB5
000003F9  B80104            mov ax,0x401
000003FC  E8B60A            call init_00EB5   ; ->0xEB5
000003FF  B80200            mov ax,0x2
00000402  E8B00A            call init_00EB5   ; ->0xEB5
00000405  B803C0            mov ax,0xc003
00000408  E8AA0A            call init_00EB5   ; ->0xEB5
0000040B  B80560            mov ax,0x6005
0000040E  E8A40A            call init_00EB5   ; ->0xEB5
00000411  B80901            mov ax,0x109
00000414  E89E0A            call init_00EB5   ; ->0xEB5
00000417  B80B50            mov ax,0x500b
0000041A  E8980A            call init_00EB5   ; ->0xEB5
0000041D  B80C7E            mov ax,0x7e0c
00000420  E8920A            call init_00EB5   ; ->0xEB5
00000423  B80D00            mov ax,0xd
00000426  E88C0A            call init_00EB5   ; ->0xEB5
00000429  B80E02            mov ax,0x20e
0000042C  E8860A            call init_00EB5   ; ->0xEB5
0000042F  B80E03            mov ax,0x30e
00000432  E8800A            call init_00EB5   ; ->0xEB5
00000435  B803C1            mov ax,0xc103
00000438  E87A0A            call init_00EB5   ; ->0xEB5
0000043B  B80568            mov ax,0x6805
0000043E  E8740A            call init_00EB5   ; ->0xEB5
00000441  B80F00            mov ax,0xf
00000444  E86E0A            call init_00EB5   ; ->0xEB5
00000447  B80010            mov ax,0x1000
0000044A  E8680A            call init_00EB5   ; ->0xEB5
0000044D  B80010            mov ax,0x1000
;>>>> [serial/SCC] call 0xeb5 to program a Z8530 SCC write-register pair. 0xeb5 is `out dx,al; xchg al,ah; out dx,al; ret` (DX=SCC control port 0x300): it writes AH=register-select then AL=data. Here AX=0x1000 writes WR0=0x10 (Reset Tx CRC / command). Part of the full WR0..WR15 init burst (0x30E,0xC103,0x6805,0x0F,0x1000,0x1000,0x3000,0x1401) configuring the synchronous host link.  // 0xeb5 body verified in MFGTEST.full.asm L1568-1571: out dx,al / xchg al,ah / out dx,al / ret. Preceding mov ax,0x1000 at 0x44D.
00000450  E8620A            call init_00EB5   ; ->0xEB5
00000453  B80030            mov ax,0x3000
00000456  E85C0A            call init_00EB5   ; ->0xEB5
00000459  B80114            mov ax,0x1401
;>>>> [serial/SCC] call 0xEB5 with AX=0x1401 (set at 0x459). 0xEB5 is the Z8530 SCC write-register helper: it does OUT DX,AL (register pointer = AL=0x01) then XCHG AL,AH; OUT DX,AL (data = AH=0x14) to the SCC control port (DX=0x301, channel control). This writes WR1=0x14 as one step in the WR0..WR15 init burst (0x30E,0xC103,0x6805,0x0F,0x1000,0x1000,0x3000,0x1401) configuring the SCC for synchronous host-link operation.  // 0xEB5 body: out dx,al / xchg al,ah / out dx,al / ret; AX=0x1401 loaded at 0x459; surrounding mov ax,0x3000/0x1000 SCC values
0000045C  E8560A            call init_00EB5   ; ->0xEB5
0000045F  BA0EFF            mov dx,0xff0e
00000462  ED                in ax,dx
00000463  A91000            test ax,0x10
00000466  7410              jz clear_00478   ; ->0x478
00000468  B80100            mov ax,0x1
;>>>> [80C188EB PCB status / fail-flag] The fail-flag branch at 0x468-0x471 (mov [0x12a]=1, shl ax,2, or [0x4a],ax) is taken when 0xFF0E bit4 is SET (test nonzero, no jump). It is skipped (jz 0x478) when bit4 is clear.  // Lines 170-178: mov dx,0xff0e; in ax,dx; test ax,0x10; jz 0x478; mov ax,1; mov [0x12a],ax; shl ax,2; or [0x4a],ax. Preceding calls 0xeb5 write SCC WR regs (0x1401 etc).
0000046B  A32A01            mov [0x12a],ax
0000046E  C1E002            shl ax,byte 0x2
00000471  09064A00          or [0x4a],ax
00000475  EB12              jmp short 0x489
00000477  90                nop
clear_00478:
00000478  BA0103            mov dx,0x301
0000047B  B80909            mov ax,0x909
0000047E  E8340A            call init_00EB5   ; ->0xEB5
00000481  BA08FF            mov dx,0xff08
00000484  ED                in ax,dx
00000485  25EFFF            and ax,0xffef
00000488  EF                out dx,ax
00000489  BA56FF            mov dx,0xff56
0000048C  ED                in ax,dx
0000048D  24BF              and al,0xbf
0000048F  EE                out dx,al
00000490  B80016            mov ax,0x1600
00000493  CD40              int 0x40
00000495  B80200            mov ax,0x2
;>>>> [serial/SCC] call 0x102c (Z8530 channel/test setup with AX=2) then a poll loop: call 0xff3 (delay), call 0x1048 (status read), jnz loops back. After the loop it reads SCC RR0 via 0xeba at DX=0x301 (mov al,0; out; in al,dx) and tests bit7 (0x80) to check a receive/sync status; failure sets flag [0x12a]=1 and ORs shifted bit into error mask [0xaa].  // Context shows int 0x40 AX=0x1600 at 0x490, then call 0x102c; loop 0x49b->0x4a1; mov dx,0x301 / call 0xeba / test ax,0x80 at 0x4a3-0x4ab. 0xeba verified L1572-1575.
00000498  E8910B            call 0x102c
fread_status_0049B:
0000049B  E8550B            call hexprint_cksum_dispatch_00FF3   ; ->0xFF3
0000049E  E8A70B            call fread_status_01048   ; ->0x1048
000004A1  75F8              jnz fread_status_0049B   ; ->0x49B
000004A3  BA0103            mov dx,0x301
000004A6  B000              mov al,0x0
000004A8  E80F0A            call cksum_fread_00EBA   ; ->0xEBA
000004AB  A98000            test ax,0x80
000004AE  750D              jnz loc_004BD   ; ->0x4BD
000004B0  B80100            mov ax,0x1
000004B3  A32A01            mov [0x12a],ax
000004B6  C1E002            shl ax,byte 0x2
000004B9  0906AA00          or [0xaa],ax
loc_004BD:
000004BD  B80116            mov ax,0x1601
000004C0  CD40              int 0x40
000004C2  B80200            mov ax,0x2
000004C5  E8640B            call 0x102c
loc_004C8:
000004C8  E8280B            call hexprint_cksum_dispatch_00FF3   ; ->0xFF3
000004CB  E87A0B            call fread_status_01048   ; ->0x1048
000004CE  75F8              jnz loc_004C8   ; ->0x4C8
000004D0  BA0103            mov dx,0x301
000004D3  B000              mov al,0x0
000004D5  E8E209            call cksum_fread_00EBA   ; ->0xEBA
000004D8  A98000            test ax,0x80
000004DB  740C              jz fread_clear_status_004E9   ; ->0x4E9
;>>>> [SCC (Z8530) / modem-status test] mov ax,1 begins recording an SCC test failure: it stores 1 to the shared result temp [0x12a], shifts left by 1, and ORs into the channel-A SCC status mask at [0xaa]. It is reached when the preceding test of the SCC RR0 status (read via call 0xeba with DX=0x301) found bit7 (0x80, Break/Abort or DCD-class status bit) set/clear unexpectedly. So this is the fail-flag store for a Z8530 channel status check at port 0x301.  // Lines 143-152: mov dx,0x301; call 0xeba (reads SCC RR0); test ax,0x80; jz 0x4e9; mov ax,0x1; mov [0x12a],ax; shl ax,1; or [0xaa],ax. 0xeba (line1572) = select reg0/read at DX.
000004DD  B80100            mov ax,0x1
000004E0  A32A01            mov [0x12a],ax
000004E3  D1E0              shl ax,1
000004E5  0906AA00          or [0xaa],ax
fread_clear_status_004E9:
000004E9  C606570200        mov byte [0x257],0x0
000004EE  C70655020000      mov word [0x255],0x0
000004F4  B83600            mov ax,0x36
000004F7  E8320B            call 0x102c
000004FA  C706E5010000      mov word [0x1e5],0x0
loc_00500:
00000500  E8F40D            call sub_012F7   ; ->0x12F7
00000503  A15502            mov ax,[0x255]
00000506  3D3600            cmp ax,0x36
00000509  7349              jnc loc_00554   ; ->0x554
0000050B  E8E50A            call hexprint_cksum_dispatch_00FF3   ; ->0xFF3
0000050E  E8370B            call fread_status_01048   ; ->0x1048
00000511  75ED              jnz loc_00500   ; ->0x500
00000513  A05702            mov al,[0x257]
00000516  3C01              cmp al,0x1
00000518  7410              jz loc_0052A   ; ->0x52A
0000051A  B80100            mov ax,0x1
0000051D  A32A01            mov [0x12a],ax
00000520  C1E003            shl ax,byte 0x3
00000523  09064A00          or [0x4a],ax
00000527  EB47              jmp short 0x570
00000529  90                nop
loc_0052A:
0000052A  A1E501            mov ax,[0x1e5]
0000052D  3D3600            cmp ax,0x36
00000530  7310              jnc loc_00542   ; ->0x542
00000532  B80100            mov ax,0x1
00000535  A32A01            mov [0x12a],ax
00000538  C1E004            shl ax,byte 0x4
0000053B  09064A00          or [0x4a],ax
0000053F  EB2F              jmp short 0x570
00000541  90                nop
loc_00542:
00000542  7210              jc loc_00554   ; ->0x554
00000544  B80100            mov ax,0x1
00000547  A32A01            mov [0x12a],ax
0000054A  C1E005            shl ax,byte 0x5
0000054D  09064A00          or [0x4a],ax
00000551  EB1D              jmp short 0x570
00000553  90                nop
loc_00554:
00000554  1E                push ds
00000555  07                pop es
00000556  BF1F02            mov di,0x21f
00000559  BEAF01            mov si,0x1af
0000055C  B93600            mov cx,0x36
0000055F  F3A6              repe cmpsb
00000561  740D              jz loc_00570   ; ->0x570
00000563  B80100            mov ax,0x1
00000566  A32A01            mov [0x12a],ax
00000569  C1E006            shl ax,byte 0x6
0000056C  09064A00          or [0x4a],ax
loc_00570:
00000570  BA60FF            mov dx,0xff60
00000573  B81F80            mov ax,0x801f
00000576  EF                out dx,ax
00000577  BA64FF            mov dx,0xff64
0000057A  B82B00            mov ax,0x2b
0000057D  EF                out dx,ax
0000057E  BA66FF            mov dx,0xff66
00000581  ED                in ax,dx
00000582  BA68FF            mov dx,0xff68
00000585  ED                in ax,dx
;>>>> [80C188EB PCB timer test] mov dx,0xff66 then IN AX,DX reads a 80C186/188 PCB timer register (timer-2 block in the 0xFF50-0xFF6A timer window per the PCB map). This is part of a timer/counter readback exercise: the code first programmed timer registers 0xFF60 (=0x801F) and 0xFF64 (=0x002B) via OUT, then reads back 0xFF66 and 0xFF68 to verify the timer hardware. Immediately after it reads chip-select reg 0xFF08, clears bit2 (and ax,0xfffb) and writes it back.  // Lines 110-131: mov dx,0xff60/out, mov dx,0xff64/out, in from 0xff66/0xff68, then mov dx,0xff08; in; and ax,0xfffb; out. PCB map in CLAUDE.md: 0xFF50-0xFF6A = Timer 0/1/2.
00000586  BA66FF            mov dx,0xff66
00000589  ED                in ax,dx
;>>>> [80C188EB PCB timer test] mov dx,0xff68 then in ax,dx (0x58D) reads the 80C186/188 PCB timer register at 0xFF68 (timer-2 block in the 0xFF50-0xFF6A timer window). This is the second of a paired timer readback: the code first programmed 0xFF60 and 0xFF64 (=0x2B) via OUT, then reads back 0xFF66 (at 0x586/0x589) and 0xFF68 here to verify the timer hardware. Immediately after it reads chip-select port 0xFF08, clears bit2 (and ax,0xfffb) and writes it back. Timer/counter readback exercise, not serial.  // >>>>0x58A mov dx,0xff68; 0x58D in ax,dx; 0x577 mov dx,0xff64/out; 0x57E mov dx,0xff66/in; 0x58E mov dx,0xff08/in; 0x592 and ax,0xfffb; matches prior 0x586 annotation
0000058A  BA68FF            mov dx,0xff68
0000058D  ED                in ax,dx
0000058E  BA08FF            mov dx,0xff08
00000591  ED                in ax,dx
;>>>> [timer/PCB-port] and ax,0xFFFB clears bit 2 of the word just read from 80C188EB PCB port 0xFF08 (peripheral/port-1 control or pin-mux register); the following out dx,ax writes it back. Read-modify-write that disables one peripheral/chip-select pin during the timer/port exercise sequence (which read timers at 0xFF66/0xFF68 just before).  // prior mov dx,0xff08 / in ax,dx; this and ax,0xfffb; next out dx,ax
00000592  25FBFF            and ax,0xfffb
00000595  EF                out dx,ax
00000596  E85A0A            call hexprint_cksum_dispatch_00FF3   ; ->0xFF3
00000599  C606580200        mov byte [0x258],0x0
0000059E  C7061D020000      mov word [0x21d],0x0
000005A4  B83600            mov ax,0x36
000005A7  E8820A            call 0x102c
000005AA  C706E5010100      mov word [0x1e5],0x1
000005B0  BA6AFF            mov dx,0xff6a
000005B3  A0AF01            mov al,[0x1af]
000005B6  EE                out dx,al
loc_005B7:
000005B7  A11D02            mov ax,[0x21d]
000005BA  3D3600            cmp ax,0x36
000005BD  7349              jnc loc_00608   ; ->0x608
000005BF  E8310A            call hexprint_cksum_dispatch_00FF3   ; ->0xFF3
000005C2  E8830A            call fread_status_01048   ; ->0x1048
000005C5  75F0              jnz loc_005B7   ; ->0x5B7
000005C7  A05802            mov al,[0x258]
000005CA  3C01              cmp al,0x1
000005CC  7410              jz loc_005DE   ; ->0x5DE
000005CE  B80100            mov ax,0x1
000005D1  A32A01            mov [0x12a],ax
000005D4  C1E004            shl ax,byte 0x4
000005D7  09062A00          or [0x2a],ax
000005DB  EB47              jmp short 0x624
000005DD  90                nop
loc_005DE:
000005DE  A1E501            mov ax,[0x1e5]
000005E1  3D3600            cmp ax,0x36
000005E4  7310              jnc loc_005F6   ; ->0x5F6
000005E6  B80100            mov ax,0x1
000005E9  A32A01            mov [0x12a],ax
000005EC  C1E005            shl ax,byte 0x5
000005EF  09062A00          or [0x2a],ax
000005F3  EB2F              jmp short 0x624
000005F5  90                nop
loc_005F6:
000005F6  7210              jc loc_00608   ; ->0x608
000005F8  B80100            mov ax,0x1
000005FB  A32A01            mov [0x12a],ax
000005FE  C1E006            shl ax,byte 0x6
00000601  09062A00          or [0x2a],ax
00000605  EB1D              jmp short 0x624
00000607  90                nop
loc_00608:
00000608  1E                push ds
00000609  07                pop es
0000060A  BFE701            mov di,0x1e7
0000060D  BEAF01            mov si,0x1af
00000610  B93600            mov cx,0x36
00000613  F3A6              repe cmpsb
00000615  740D              jz kbd_00624   ; ->0x624
;>>>> [keyboard] mov ax,0x1 loads the fail-flag value (stored to [0x12a] at 0x61A) for a keyboard-identification/table comparison failure. It is reached only when the preceding repe cmpsb (0x613) of a 0x36-byte (54) region [di=0x1e7] vs the reference table at [si=0x1af] did NOT fully match (the jz 0x624 at 0x615 was not taken). The flag is then shl ax,7 / or [0x2a],ax recording the mismatch bit in the [0x2a] error mask. This validates the captured keyboard scancode buffer against the expected 54-byte table.  // 0x60A mov di,0x1e7; 0x60D mov si,0x1af; 0x610 mov cx,0x36; 0x613 repe cmpsb; 0x615 jz 0x624; 0x617 mov ax,1; 0x61A mov [0x12a],ax; 0x61D shl ax,7; 0x620 or [0x2a],ax. 0x36=54 byte table at 0x1af.
00000617  B80100            mov ax,0x1
0000061A  A32A01            mov [0x12a],ax
0000061D  C1E007            shl ax,byte 0x7
00000620  09062A00          or [0x2a],ax
kbd_00624:
00000624  E984FA            jmp loc_000AB   ; ->0xAB
kbd_cursor_fread_00627:
00000627  E8C60A            call hexprint_cksum_dispatch_010F0   ; ->0x10F0
0000062A  E8960B            call sub_011C3   ; ->0x11C3
0000062D  E8A10C            call sub_012D1   ; ->0x12D1
00000630  E8270C            call sub_0125A   ; ->0x125A
00000633  E8D40A            call sub_0110A   ; ->0x110A
00000636  E8AF0A            call fread_010E8   ; ->0x10E8
00000639  B000              mov al,0x0
0000063B  B41E              mov ah,0x1e
0000063D  CD40              int 0x40
0000063F  B8004C            mov ax,0x4c00
00000642  CD21              int 0x21
cursor_00644:
00000644  06                push es
00000645  53                push bx
00000646  B83000            mov ax,0x30
00000649  CD10              int 0x10
0000064B  B80006            mov ax,0x600
0000064E  B90000            mov cx,0x0
00000651  BA4F1D            mov dx,0x1d4f
00000654  B702              mov bh,0x2
00000656  CD10              int 0x10
00000658  B80002            mov ax,0x200
;>>>> [video/display] mov bh,al loads the BIOS video page number (BH) from AL ahead of the INT 10h AH=02h set-cursor-position call at 0x660. AX=0x0200 was just set at 0x658; DX=0x2000 (row 0x20=32, col 0x00) is the target cursor position. This follows the INT 10h AH=06h scroll/clear of the 80x30 screen (0x656) and precedes a loop (cx=0x1e=30 rows) that walks the keyboard scancode table (es lodsw, byte-swap to DI at 0x66F) to paint the self-test display. Standard INT 10h cursor setup, not SCC.  // 0x658 mov ax,0x200; 0x65B mov bh,al; 0x65D mov dx,0x2000; 0x660 int 0x10; prior 0x64B-0x656 is INT 10h AH=06h scroll
0000065B  8AF8              mov bh,al
0000065D  BA0020            mov dx,0x2000
00000660  CD10              int 0x10
00000662  5B                pop bx
00000663  07                pop es
00000664  8BF3              mov si,bx
00000666  33D2              xor dx,dx
;>>>> [video (dual-plane VRAM attribute clear)] mov cx,0x1e (30) sets the iteration count for a row-clearing loop over the 30-row screen. The loop (0x66B-0x674): es lodsw reads a big-endian screen-offset word from the row-coordinate table (ES:SI, SI=BX restored at 0x664), xchg al,ah byte-swaps it to DI, then mov [es:di],dl writes DL (=0, from xor dx,dx at 0x666) into the VRAM attribute/char plane, clearing each row anchor. Runs right after INT 10h AH=06h scroll-clear (0x656) and AH=02h cursor-set (0x660). DX cleared, so it zeroes 30 cells.  // 0x666 xor dx,dx; 0x668 mov cx,0x1e; 0x66B es lodsw; 0x66D xchg al,ah; 0x66F mov di,ax; 0x671 mov [es:di],dl; 0x674 loop 0x66b. Preceded by int 10h at 0x656/0x660.
00000668  B91E00            mov cx,0x1e
cursor_fread_clear_0066B:
0000066B  26AD              es lodsw
0000066D  86C4              xchg al,ah
0000066F  8BF8              mov di,ax
00000671  268815            mov [es:di],dl
00000674  E2F5              loop cursor_fread_clear_0066B   ; ->0x66B
00000676  BF0100            mov di,0x1
00000679  033E2E01          add di,[0x12e]
0000067D  53                push bx
0000067E  8BC3              mov ax,bx
00000680  03062C01          add ax,[0x12c]
00000684  03062C01          add ax,[0x12c]
00000688  8B160A00          mov dx,[0xa]
0000068C  33F6              xor si,si
vram_attr_col_0068E:
0000068E  83C602            add si,byte +0x2
00000691  83FE20            cmp si,byte +0x20
00000694  7424              jz loc_006BA   ; ->0x6BA
00000696  D1EA              shr dx,1
00000698  F7C20100          test dx,0x1
0000069C  74F0              jz vram_attr_col_0068E   ; ->0x68E
0000069E  8BD8              mov bx,ax
000006A0  268B1F            mov bx,[es:bx]
;>>>> [video/display (self-test indicator grid)] xchg bh,bl byte-swaps the screen-offset word just loaded into BX from the table (mov bx,[es:bx] at 0x6A0), converting the big-endian stored offset to a linear VRAM offset. The next instructions write literal 0x50 to the char plane at [es:bx+di] (0x6A5) and a character/attribute word from [si+0xa] into [es:bx+di+1]/[es:bx+di+2] (0x6A9-0x6B1). This is inside the loop (0x68E-0x6B8) that walks a 0x20-bit (32-column) mask in DX (from [0xa], the channel-A error bitmask) by shr/test, painting one highlighted cell per set bit. Self-test result indicator grid, identical pattern to accepted 0x8B1. Not SCC.  // 0x6A0 mov bx,[es:bx]; 0x6A3 xchg bh,bl; 0x6A5 mov byte [es:bx+di],0x50; 0x6A9 mov cx,[si+0xa]; 0x6AD mov [es:bx+di+1],cl; 0x688 mov dx,[0xa]
000006A3  86FB              xchg bh,bl
000006A5  26C60150          mov byte [es:bx+di],0x50
000006A9  8B8C0A00          mov cx,[si+0xa]
000006AD  26884901          mov [es:bx+di+0x1],cl
000006B1  26886902          mov [es:bx+di+0x2],ch
000006B5  050400            add ax,0x4
000006B8  EBD4              jmp short 0x68e
loc_006BA:
000006BA  5B                pop bx
000006BB  83C706            add di,byte +0x6
000006BE  53                push bx
000006BF  8BC3              mov ax,bx
000006C1  03062C01          add ax,[0x12c]
;>>>> [video/self-test result display] add ax,[0x12c] is the SECOND of two adds of [0x12c] to AX (AX=BX at 0x6BF, +[0x12c] at 0x6C1, +[0x12c] here), building a VRAM cell-table base address (BX + 2*[0x12c], where [0x12c] is the blink/display-state counter). It then loads DX=[0x2a] (a per-test error bitmask), zeroes SI and walks a 0x20-bit (32-position) loop: add si,2 / cmp si,0x20 / shr dx,1 / test dx,1, and for each set bit reads a screen-offset word via [es:bx], byte-swaps it (xchg bh,bl at 0x6A3) and paints a character (0x50) + attribute pair into the dual-plane VRAM. This is the loop that renders the 32-bit self-test result/indicator grid for the timer-error mask [0x2a].  // 0x6BF mov ax,bx; 0x6C1 add ax,[0x12c]; >>>>0x6C5 add ax,[0x12c]; 0x6C9 mov dx,[0x2a]; 0x6CD xor si,si; 0x6CF add si,2; 0x6D2 cmp si,0x20; 0x6D7 shr dx,1; 0x6D9 test dx,1; mirrors the [0xa]-mask loop at 0x684-0x6B8
000006C5  03062C01          add ax,[0x12c]
000006C9  8B162A00          mov dx,[0x2a]
000006CD  33F6              xor si,si
fread_vram_attr_006CF:
000006CF  83C602            add si,byte +0x2
000006D2  83FE20            cmp si,byte +0x20
000006D5  7424              jz loc_006FB   ; ->0x6FB
000006D7  D1EA              shr dx,1
000006D9  F7C20100          test dx,0x1
000006DD  74F0              jz fread_vram_attr_006CF   ; ->0x6CF
000006DF  8BD8              mov bx,ax
000006E1  268B1F            mov bx,[es:bx]
000006E4  86FB              xchg bh,bl
000006E6  26C60141          mov byte [es:bx+di],0x41
000006EA  8B8C2A00          mov cx,[si+0x2a]
000006EE  26884901          mov [es:bx+di+0x1],cl
000006F2  26886902          mov [es:bx+di+0x2],ch
000006F6  050400            add ax,0x4
000006F9  EBD4              jmp short 0x6cf
loc_006FB:
000006FB  5B                pop bx
000006FC  83C706            add di,byte +0x6
000006FF  53                push bx
00000700  8BC3              mov ax,bx
00000702  03062C01          add ax,[0x12c]
00000706  03062C01          add ax,[0x12c]
0000070A  8B164A00          mov dx,[0x4a]
0000070E  33F6              xor si,si
loc_00710:
00000710  83C602            add si,byte +0x2
00000713  83FE20            cmp si,byte +0x20
00000716  7424              jz loc_0073C   ; ->0x73C
00000718  D1EA              shr dx,1
0000071A  F7C20100          test dx,0x1
0000071E  74F0              jz loc_00710   ; ->0x710
00000720  8BD8              mov bx,ax
00000722  268B1F            mov bx,[es:bx]
00000725  86FB              xchg bh,bl
00000727  26C60153          mov byte [es:bx+di],0x53
0000072B  8B8C4A00          mov cx,[si+0x4a]
0000072F  26884901          mov [es:bx+di+0x1],cl
00000733  26886902          mov [es:bx+di+0x2],ch
00000737  050400            add ax,0x4
0000073A  EBD4              jmp short 0x710
loc_0073C:
0000073C  5B                pop bx
0000073D  83C706            add di,byte +0x6
00000740  53                push bx
00000741  8BC3              mov ax,bx
00000743  03062C01          add ax,[0x12c]
00000747  03062C01          add ax,[0x12c]
0000074B  8B166A00          mov dx,[0x6a]
0000074F  33F6              xor si,si
loc_00751:
00000751  83C602            add si,byte +0x2
00000754  83FE20            cmp si,byte +0x20
00000757  7424              jz loc_0077D   ; ->0x77D
00000759  D1EA              shr dx,1
0000075B  F7C20100          test dx,0x1
0000075F  74F0              jz loc_00751   ; ->0x751
00000761  8BD8              mov bx,ax
00000763  268B1F            mov bx,[es:bx]
00000766  86FB              xchg bh,bl
00000768  26C60143          mov byte [es:bx+di],0x43
0000076C  8B8C6A00          mov cx,[si+0x6a]
00000770  26884901          mov [es:bx+di+0x1],cl
00000774  26886902          mov [es:bx+di+0x2],ch
00000778  050400            add ax,0x4
0000077B  EBD4              jmp short 0x751
loc_0077D:
0000077D  5B                pop bx
0000077E  83C706            add di,byte +0x6
00000781  53                push bx
00000782  8BC3              mov ax,bx
00000784  03062C01          add ax,[0x12c]
00000788  03062C01          add ax,[0x12c]
0000078C  8B168A00          mov dx,[0x8a]
00000790  33F6              xor si,si
loc_00792:
00000792  83C602            add si,byte +0x2
00000795  83FE20            cmp si,byte +0x20
00000798  7424              jz loc_007BE   ; ->0x7BE
0000079A  D1EA              shr dx,1
0000079C  F7C20100          test dx,0x1
000007A0  74F0              jz loc_00792   ; ->0x792
000007A2  8BD8              mov bx,ax
000007A4  268B1F            mov bx,[es:bx]
000007A7  86FB              xchg bh,bl
000007A9  26C60155          mov byte [es:bx+di],0x55
000007AD  8B8C8A00          mov cx,[si+0x8a]
000007B1  26884901          mov [es:bx+di+0x1],cl
000007B5  26886902          mov [es:bx+di+0x2],ch
000007B9  050400            add ax,0x4
000007BC  EBD4              jmp short 0x792
loc_007BE:
000007BE  5B                pop bx
000007BF  83C706            add di,byte +0x6
000007C2  53                push bx
000007C3  8BC3              mov ax,bx
000007C5  03062C01          add ax,[0x12c]
000007C9  03062C01          add ax,[0x12c]
000007CD  8B16AA00          mov dx,[0xaa]
000007D1  33F6              xor si,si
loc_007D3:
000007D3  83C602            add si,byte +0x2
000007D6  83FE20            cmp si,byte +0x20
000007D9  7424              jz loc_007FF   ; ->0x7FF
000007DB  D1EA              shr dx,1
000007DD  F7C20100          test dx,0x1
000007E1  74F0              jz loc_007D3   ; ->0x7D3
000007E3  8BD8              mov bx,ax
000007E5  268B1F            mov bx,[es:bx]
000007E8  86FB              xchg bh,bl
000007EA  26C60154          mov byte [es:bx+di],0x54
000007EE  8B8CAA00          mov cx,[si+0xaa]
000007F2  26884901          mov [es:bx+di+0x1],cl
000007F6  26886902          mov [es:bx+di+0x2],ch
000007FA  050400            add ax,0x4
000007FD  EBD4              jmp short 0x7d3
loc_007FF:
000007FF  5B                pop bx
00000800  83C706            add di,byte +0x6
00000803  53                push bx
00000804  8BC3              mov ax,bx
00000806  03062C01          add ax,[0x12c]
0000080A  03062C01          add ax,[0x12c]
0000080E  8B16CA00          mov dx,[0xca]
00000812  33F6              xor si,si
loc_00814:
00000814  83C602            add si,byte +0x2
00000817  83FE20            cmp si,byte +0x20
0000081A  7424              jz loc_00840   ; ->0x840
0000081C  D1EA              shr dx,1
0000081E  F7C20100          test dx,0x1
00000822  74F0              jz loc_00814   ; ->0x814
00000824  8BD8              mov bx,ax
00000826  268B1F            mov bx,[es:bx]
00000829  86FB              xchg bh,bl
0000082B  26C60158          mov byte [es:bx+di],0x58
0000082F  8B8CCA00          mov cx,[si+0xca]
00000833  26884901          mov [es:bx+di+0x1],cl
00000837  26886902          mov [es:bx+di+0x2],ch
0000083B  050400            add ax,0x4
0000083E  EBD4              jmp short 0x814
loc_00840:
00000840  5B                pop bx
00000841  83C706            add di,byte +0x6
00000844  53                push bx
00000845  8BC3              mov ax,bx
00000847  03062C01          add ax,[0x12c]
0000084B  03062C01          add ax,[0x12c]
0000084F  8B16EA00          mov dx,[0xea]
00000853  33F6              xor si,si
loc_00855:
00000855  83C602            add si,byte +0x2
00000858  83FE20            cmp si,byte +0x20
0000085B  7424              jz loc_00881   ; ->0x881
0000085D  D1EA              shr dx,1
0000085F  F7C20100          test dx,0x1
00000863  74F0              jz loc_00855   ; ->0x855
00000865  8BD8              mov bx,ax
00000867  268B1F            mov bx,[es:bx]
0000086A  86FB              xchg bh,bl
0000086C  26C6014E          mov byte [es:bx+di],0x4e
00000870  8B8CEA00          mov cx,[si+0xea]
00000874  26884901          mov [es:bx+di+0x1],cl
00000878  26886902          mov [es:bx+di+0x2],ch
0000087C  050400            add ax,0x4
0000087F  EBD4              jmp short 0x855
loc_00881:
00000881  5B                pop bx
00000882  83C706            add di,byte +0x6
00000885  53                push bx
00000886  8BC3              mov ax,bx
00000888  03062C01          add ax,[0x12c]
0000088C  03062C01          add ax,[0x12c]
00000890  8B160A01          mov dx,[0x10a]
00000894  33F6              xor si,si
vram_attr_00896:
00000896  83C602            add si,byte +0x2
00000899  83FE20            cmp si,byte +0x20
0000089C  7424              jz kbd_fread_vram_008C2   ; ->0x8C2
0000089E  D1EA              shr dx,1
000008A0  F7C20100          test dx,0x1
000008A4  74F0              jz vram_attr_00896   ; ->0x896
000008A6  8BD8              mov bx,ax
000008A8  268B1F            mov bx,[es:bx]
000008AB  86FB              xchg bh,bl
000008AD  26C60147          mov byte [es:bx+di],0x47
;>>>> [video/display] Loads the 2-byte display-cell pair from the on-ROM glyph/attribute table at offset 0x10A (indexed by SI) into CX; the very next instructions store CL to [es:bx+di+1] and CH to [es:bx+di+2], writing a character + attribute pair into the dual-plane VRAM. Part of the loop (0x896-0x8C0) that walks a 0x20-entry bitfield in DX, byte-swaps a screen offset from [es:bx], and paints highlighted cells (literal 0x47 stored at base) for the self-test indicator grid.  // mov cx,[si+0x10a]; mov [es:bx+di+0x1],cl; mov [es:bx+di+0x2],ch; preceding xchg bh,bl byte-swap of screen offset and mov byte [es:bx+di],0x47
000008B1  8B8C0A01          mov cx,[si+0x10a]
000008B5  26884901          mov [es:bx+di+0x1],cl
000008B9  26886902          mov [es:bx+di+0x2],ch
000008BD  050400            add ax,0x4
000008C0  EBD4              jmp short 0x896
kbd_fread_vram_008C2:
;>>>> [keyboard] pop bx restores BX (saved at routine entry/0x8C2 region) at the end of the scancode-table display loop (the loop at 0x896-0x8C0 writes 0x47 markers and width words from [si+0x10a] into VRAM). It then loads ax=0x24 (0x8C3) and calls 0x107c (0x8C6), which is a BIOS-timer-tick delay routine (INT 1Ah AH=0 read tick, add AX ticks, used as a ~36-tick pause), then ret. So this finalizes the keyboard-scancode display and pauses before returning.  // Loop 0x896 add si,2 / cmp si,0x20 / processes table; exit jz 0x8c2; 0x8C3 mov ax,0x24; 0x8C6 call 0x107c. 0x107c (disasm): pusha; mov bx,ax; int 1Ah; mov [0x264],dx; add [0x268],bx — a tick-count delay using ax as tick count.
000008C2  5B                pop bx
000008C3  B82400            mov ax,0x24
000008C6  E8B307            call kbd_fread_vram_0107C   ; ->0x107C
000008C9  C3                ret
cursor_008CA:
000008CA  F7062C010100      test word [0x12c],0x1
000008D0  751B              jnz cursor_008ED   ; ->0x8ED
000008D2  83062E0101        add word [0x12e],byte +0x1
;>>>> [video/display (blink animation)] cmp word [0x12e],byte +0x6 tests the blink/animation counter [0x12e] against 6. This is the rising edge of a bounce/blink state machine: when flag bit [0x12c]&1==0 it increments [0x12e] (0x8D2) and, on reaching 6, sets direction flag [0x12c]=1 and reloads [0x12e]=5 (0x8DE-0x8E4); the descending branch (0x8ED) decrements and on underflow resets both to 0. After updating it calls 0x644 (the screen-paint/self-test display routine, also reached via 0x900). Controls the cursor/indicator blink phase on the self-test screen, not serial.  // 0x8CA test word [0x12c],0x1; 0x8D2 add word [0x12e],1; 0x8D7 cmp word [0x12e],6; 0x8DE mov [0x12c],1; 0x8E4 mov [0x12e],5; 0x900 call 0x644
000008D7  833E2E0106        cmp word [0x12e],byte +0x6
000008DC  7522              jnz cursor_00900   ; ->0x900
000008DE  C7062C010100      mov word [0x12c],0x1
000008E4  C7062E010500      mov word [0x12e],0x5
000008EA  EB14              jmp short 0x900
000008EC  90                nop
cursor_008ED:
000008ED  832E2E0101        sub word [0x12e],byte +0x1
000008F2  730C              jnc cursor_00900   ; ->0x900
000008F4  C7062C010000      mov word [0x12c],0x0
000008FA  C7062E010000      mov word [0x12e],0x0
cursor_00900:
00000900  E841FD            call cursor_00644   ; ->0x644
00000903  C3                ret
dispatch_fhandle_00904:
00000904  06                push es
00000905  53                push bx
00000906  B83000            mov ax,0x30
00000909  CD10              int 0x10
0000090B  B80002            mov ax,0x200
0000090E  8AF8              mov bh,al
00000910  BA0020            mov dx,0x2000
00000913  CD10              int 0x10
00000915  5B                pop bx
00000916  07                pop es
00000917  8BF3              mov si,bx
00000919  BA1E00            mov dx,0x1e
loc_0091C:
0000091C  26AD              es lodsw
0000091E  86C4              xchg al,ah
00000920  8BF8              mov di,ax
00000922  33C0              xor ax,ax
00000924  AA                stosb
00000925  A03D01            mov al,[0x13d]
00000928  2AC2              sub al,dl
0000092A  B402              mov ah,0x2
0000092C  B95000            mov cx,0x50
loc_0092F:
0000092F  2688A50080        mov [es:di-0x8000],ah
00000934  AA                stosb
00000935  FEC0              inc al
00000937  E2F6              loop loc_0092F   ; ->0x92F
00000939  4A                dec dx
0000093A  75E0              jnz loc_0091C   ; ->0x91C
0000093C  B80600            mov ax,0x6
0000093F  E83A07            call kbd_fread_vram_0107C   ; ->0x107C
00000942  C3                ret
dispatch_fhandle_00943:
00000943  06                push es
00000944  53                push bx
00000945  B80106            mov ax,0x601
00000948  B90000            mov cx,0x0
0000094B  BA4F1D            mov dx,0x1d4f
0000094E  B702              mov bh,0x2
;>>>> [video/display] INT 10h video BIOS, AH=06h (scroll window up) with AL=01 (1 line), CX=0x0000 (top-left row0,col0), DX=0x1D4F (bottom-right row 0x1D=29, col 0x4F=79), BH=0x02 (blank-line attribute = green on black). Clears/scrolls the 80x30 text screen. Immediately followed by INT 10h AH=02h (set cursor) at 0x95A.  // mov ax,0x601; mov cx,0; mov dx,0x1d4f; mov bh,0x2; int 0x10; then mov ax,0x200/int 0x10 set-cursor
00000950  CD10              int 0x10
00000952  B80002            mov ax,0x200
00000955  8AF8              mov bh,al
00000957  BA0020            mov dx,0x2000
0000095A  CD10              int 0x10
0000095C  5B                pop bx
0000095D  07                pop es
0000095E  268B473A          mov ax,[es:bx+0x3a]
00000962  86C4              xchg al,ah
00000964  8BF8              mov di,ax
00000966  33C0              xor ax,ax
00000968  AA                stosb
00000969  A03D01            mov al,[0x13d]
0000096C  B402              mov ah,0x2
0000096E  B95000            mov cx,0x50
loc_00971:
00000971  2688A50080        mov [es:di-0x8000],ah
00000976  AA                stosb
00000977  FEC0              inc al
00000979  E2F6              loop loc_00971   ; ->0x971
0000097B  FE063D01          inc byte [0x13d]
0000097F  B80600            mov ax,0x6
00000982  E8F706            call kbd_fread_vram_0107C   ; ->0x107C
00000985  C3                ret
cursor_00986:
00000986  06                push es
00000987  53                push bx
00000988  B83700            mov ax,0x37
0000098B  CD10              int 0x10
;>>>> [video (INT 10h)] mov ax,0x200 loads AH=02h (INT 10h set-cursor-position) ahead of the INT 10h at 0x995. The following mov bh,al sets page BH=0 (AL=0) and mov dx,0x2000 sets DH=row 0x20, DL=col 0. This positions the cursor at the start of the keyboard/scancode test display, immediately after the mode-set INT 10h AX=0x37 at 0x98B. Part of the 0x986 setup-screen entry routine.  // 0x988 mov ax,0x37/0x98B int 0x10 (mode set); 0x98D mov ax,0x200; 0x990 mov bh,al; 0x992 mov dx,0x2000; 0x995 int 0x10. Identical cursor-set pattern at 0x658/0x9FE.
0000098D  B80002            mov ax,0x200
00000990  8AF8              mov bh,al
00000992  BA0020            mov dx,0x2000
00000995  CD10              int 0x10
00000997  5B                pop bx
00000998  07                pop es
00000999  8BF3              mov si,bx
0000099B  BA1E00            mov dx,0x1e
loc_0099E:
0000099E  26AD              es lodsw
000009A0  86C4              xchg al,ah
000009A2  8BF8              mov di,ax
000009A4  33C0              xor ax,ax
000009A6  AA                stosb
000009A7  B06D              mov al,0x6d
000009A9  B402              mov ah,0x2
000009AB  B98400            mov cx,0x84
loc_009AE:
000009AE  2688A50080        mov [es:di-0x8000],ah
000009B3  AA                stosb
000009B4  E2F8              loop loc_009AE   ; ->0x9AE
000009B6  4A                dec dx
000009B7  75E5              jnz loc_0099E   ; ->0x99E
000009B9  8BF3              mov si,bx
000009BB  83C614            add si,byte +0x14
000009BE  BA0A00            mov dx,0xa
loc_009C1:
000009C1  26AD              es lodsw
000009C3  86C4              xchg al,ah
000009C5  8BF8              mov di,ax
000009C7  83C715            add di,byte +0x15
000009CA  B020              mov al,0x20
000009CC  B421              mov ah,0x21
000009CE  B91F00            mov cx,0x1f
loc_009D1:
000009D1  2688A50080        mov [es:di-0x8000],ah
000009D6  AA                stosb
000009D7  E2F8              loop loc_009D1   ; ->0x9D1
000009D9  B422              mov ah,0x22
000009DB  B91F00            mov cx,0x1f
loc_009DE:
000009DE  2688A50080        mov [es:di-0x8000],ah
000009E3  AA                stosb
000009E4  E2F8              loop loc_009DE   ; ->0x9DE
000009E6  B420              mov ah,0x20
000009E8  B91F00            mov cx,0x1f
loc_009EB:
000009EB  2688A50080        mov [es:di-0x8000],ah
000009F0  AA                stosb
000009F1  E2F8              loop loc_009EB   ; ->0x9EB
000009F3  4A                dec dx
000009F4  75CB              jnz loc_009C1   ; ->0x9C1
000009F6  C3                ret
dispatch_fhandle_009F7:
000009F7  06                push es
000009F8  53                push bx
000009F9  B83000            mov ax,0x30
000009FC  CD10              int 0x10
000009FE  B80002            mov ax,0x200
00000A01  8AF8              mov bh,al
00000A03  BA0020            mov dx,0x2000
00000A06  CD10              int 0x10
00000A08  5B                pop bx
00000A09  07                pop es
00000A0A  8BF3              mov si,bx
00000A0C  BA1E00            mov dx,0x1e
clear_fill_vram_00A0F:
00000A0F  26AD              es lodsw
;>>>> [video (dual-plane VRAM screen clear)] xchg al,ah byte-swaps the word just loaded by es lodsw (0xA0F) from a big-endian screen-offset table (ES:SI, the row-coordinate table walked by the dx=0x1e=30-row loop), producing a linear VRAM offset placed into DI (next instr mov di,ax). The routine then zero-stores one char cell (xor ax,ax/stosb) and fills cx=0x50 (80) cells writing attribute 0x20 to the attribute plane (es:di-0x8000) and space 0x20 to the char plane (stosb). Big-endian->little-endian offset conversion for the per-row screen-clear primitive, NOT SCC.  // 0xA0F es lodsw; 0xA11 xchg al,ah; 0xA13 mov di,ax; 0xA1C mov cx,0x50; 0xA1F mov [es:di-0x8000],ah/stosb/loop. Driven by dx=0x1e row count at 0xA0C.
00000A11  86C4              xchg al,ah
00000A13  8BF8              mov di,ax
00000A15  33C0              xor ax,ax
00000A17  AA                stosb
00000A18  B420              mov ah,0x20
00000A1A  B020              mov al,0x20
00000A1C  B95000            mov cx,0x50
clear_fill_attr_00A1F:
;>>>> [video/display] mov [es:di-0x8000],ah writes attribute byte AH=0x20 into the attribute plane (ES:DI-0x8000) inside a CX=0x50 (80-column) fill loop (followed by stosb of AL=0x20 space into the char plane, loop 0xa1f). This clears/draws one full 80-column screen row. The row offset DI was computed by es lodsw + xchg al,ah (byte-swap of a screen-position word from the table at ES:BX) at 0xA0F-0xA13. After filling, it pokes box-corner glyphs (0x22/0x21) at fixed -0x50-relative positions and decrements DX (row counter, dec dx / jnz 0xa0f) to draw the next row. Setup/test screen frame draw.  // >>>>0xA1F mov [es:di-0x8000],ah; 0xA1C mov cx,0x50; 0xA24 stosb; 0xA25 loop 0xa1f; 0xA18 mov ah,0x20; 0xA0F es lodsw; 0xA4E dec dx; 0xA4F jnz 0xa0f
00000A1F  2688A50080        mov [es:di-0x8000],ah
00000A24  AA                stosb
00000A25  E2F8              loop clear_fill_attr_00A1F   ; ->0xA1F
00000A27  83EF50            sub di,byte +0x50
00000A2A  26C685098022      mov byte [es:di-0x7ff7],0x22
00000A30  26C685468022      mov byte [es:di-0x7fba],0x22
00000A36  26C6851D8021      mov byte [es:di-0x7fe3],0x21
00000A3C  26C685328021      mov byte [es:di-0x7fce],0x21
00000A42  26C685268000      mov byte [es:di-0x7fda],0x0
00000A48  26C685298000      mov byte [es:di-0x7fd7],0x0
00000A4E  4A                dec dx
00000A4F  75BE              jnz clear_fill_vram_00A0F   ; ->0xA0F
00000A51  268B4704          mov ax,[es:bx+0x4]
00000A55  86C4              xchg al,ah
00000A57  8BF8              mov di,ax
00000A59  83C702            add di,byte +0x2
00000A5C  33C0              xor ax,ax
00000A5E  A03F01            mov al,[0x13f]
00000A61  2D3C00            sub ax,0x3c
;>>>> [keyboard] cmp ax,0xc bounds-checks a scancode-table index before a table copy. AX was formed at 0xA5C-0xA61 by zero-extending config byte [0x13f] and subtracting 0x3c (base scancode), giving a 0..N entry index. If AX>0xc (ja 0xA74) the copy is skipped; otherwise lea si,[0x140]/add si,ax/cx=7/rep movsb copies a 7-byte scancode-name string from the table at 0x140 into VRAM. Guards the key-label lookup in the keyboard scancode display.  // 0xA5C xor ax,ax; 0xA5E mov al,[0x13f]; 0xA61 sub ax,0x3c; 0xA64 cmp ax,0xc; 0xA67 ja 0xa74; 0xA69 lea si,[0x140]; 0xA6D add si,ax; 0xA6F mov cx,0x7; 0xA72 rep movsb.
00000A64  3D0C00            cmp ax,0xc
00000A67  770B              ja kbd_copy_vram_00A74   ; ->0xA74
;>>>> [video/keyboard-display] lea si,[0x140] then add si,ax / mov cx,7 / rep movsb: copies a 7-byte keyboard scancode-name string from table at offset 0x140, indexed by (byte[0x13f]-0x3c) which was just bounds-checked <=0xC (0x64 cmp ax,0xc / ja). Writes the key label into the video buffer for the setup/key-test display.  // 0xA5C-0xA67: xor ax,ax; mov al,[0x13f]; sub ax,0x3c; cmp ax,0xc; ja 0xa74. Then lea si,[0x140]; add si,ax; mov cx,0x7; rep movsb.
00000A69  8D364001          lea si,[0x140]
00000A6D  03F0              add si,ax
00000A6F  B90700            mov cx,0x7
00000A72  F3A4              rep movsb
kbd_copy_vram_00A74:
00000A74  268B470E          mov ax,[es:bx+0xe]
00000A78  86C4              xchg al,ah
00000A7A  8BF8              mov di,ax
00000A7C  47                inc di
00000A7D  57                push di
00000A7E  83C70A            add di,byte +0xa
00000A81  B82000            mov ax,0x20
00000A84  2688A50080        mov [es:di-0x8000],ah
00000A89  AA                stosb
00000A8A  B030              mov al,0x30
00000A8C  B404              mov ah,0x4
00000A8E  B91100            mov cx,0x11
loc_00A91:
00000A91  2688A50080        mov [es:di-0x8000],ah
00000A96  AA                stosb
00000A97  E2F8              loop loc_00A91   ; ->0xA91
00000A99  B82000            mov ax,0x20
00000A9C  2688A50080        mov [es:di-0x8000],ah
00000AA1  AA                stosb
00000AA2  5F                pop di
00000AA3  26C685278000      mov byte [es:di-0x7fd9],0x0
00000AA9  26C685288000      mov byte [es:di-0x7fd8],0x0
00000AAF  268B472C          mov ax,[es:bx+0x2c]
00000AB3  86C4              xchg al,ah
00000AB5  8BF8              mov di,ax
00000AB7  47                inc di
00000AB8  57                push di
00000AB9  83C733            add di,byte +0x33
00000ABC  B82000            mov ax,0x20
00000ABF  2688A50080        mov [es:di-0x8000],ah
00000AC4  AA                stosb
00000AC5  B030              mov al,0x30
00000AC7  B404              mov ah,0x4
00000AC9  B91100            mov cx,0x11
loc_00ACC:
00000ACC  2688A50080        mov [es:di-0x8000],ah
00000AD1  AA                stosb
00000AD2  E2F8              loop loc_00ACC   ; ->0xACC
00000AD4  B82000            mov ax,0x20
00000AD7  2688A50080        mov [es:di-0x8000],ah
00000ADC  AA                stosb
00000ADD  5F                pop di
00000ADE  26C685278000      mov byte [es:di-0x7fd9],0x0
00000AE4  26C685288000      mov byte [es:di-0x7fd8],0x0
00000AEA  268B471C          mov ax,[es:bx+0x1c]
00000AEE  86C4              xchg al,ah
00000AF0  8BF8              mov di,ax
00000AF2  47                inc di
00000AF3  B0C4              mov al,0xc4
00000AF5  B440              mov ah,0x40
00000AF7  B95000            mov cx,0x50
loc_00AFA:
00000AFA  2608A50080        or [es:di-0x8000],ah
00000AFF  AA                stosb
00000B00  E2F8              loop loc_00AFA   ; ->0xAFA
00000B02  83EF50            sub di,byte +0x50
00000B05  26C64513C2        mov byte [es:di+0x13],0xc2
00000B0A  26C64516C2        mov byte [es:di+0x16],0xc2
00000B0F  26C6453BC2        mov byte [es:di+0x3b],0xc2
00000B14  26C6453EC2        mov byte [es:di+0x3e],0xc2
00000B19  268B471E          mov ax,[es:bx+0x1e]
00000B1D  86C4              xchg al,ah
00000B1F  8BF8              mov di,ax
00000B21  47                inc di
00000B22  B0C4              mov al,0xc4
00000B24  B440              mov ah,0x40
00000B26  B95000            mov cx,0x50
loc_00B29:
00000B29  2608A50080        or [es:di-0x8000],ah
00000B2E  AA                stosb
00000B2F  E2F8              loop loc_00B29   ; ->0xB29
00000B31  83EF50            sub di,byte +0x50
00000B34  26C64513C1        mov byte [es:di+0x13],0xc1
00000B39  26C64516C1        mov byte [es:di+0x16],0xc1
00000B3E  26C6453BC1        mov byte [es:di+0x3b],0xc1
00000B43  26C6453EC1        mov byte [es:di+0x3e],0xc1
00000B48  C3                ret
video_fill_vram_00B49:
00000B49  53                push bx
00000B4A  50                push ax
00000B4B  56                push si
00000B4C  03D8              add bx,ax
00000B4E  03D8              add bx,ax
;>>>> [video] mov ax,[es:bx] inside the screen-draw subroutine 0xb49: BX (caller index, doubled at 0xB4C/0xB4E) indexes a screen-coordinate table in VRAM/ROM; the loaded word is byte-swapped (xchg al,ah at 0xB53) from big-endian to a linear screen offset, moved to DI (0xB55) and added to SI. The routine then fills cx=[0x132] cells: writes DH (attribute) to ES:DI-0x8000 (attribute plane) and 0x20 space to ES:DI (char plane) via stosb. This is the core setup-menu box/line-draw primitive, NOT an SCC write.  // 0xB49 push bx/ax/si; 0xB4C add bx,ax (twice => index*2 word table); 0xB50 mov ax,[es:bx]; 0xB53 xchg al,ah (endian swap of screen offset); 0xB57 add di,si; 0xB59 mov al,0x20; 0xB5B mov cx,[0x132]; 0xB5F mov [es:di-0x8000],dh (attr plane 0x8000 below char plane); 0xB64 stosb; loop. Matches dual-plane VRAM (char/attr 0x8000 apart).
00000B50  268B07            mov ax,[es:bx]
00000B53  86C4              xchg al,ah
00000B55  8BF8              mov di,ax
00000B57  03FE              add di,si
00000B59  B020              mov al,0x20
00000B5B  8B0E3201          mov cx,[0x132]
video_fill_vram_00B5F:
00000B5F  2688B50080        mov [es:di-0x8000],dh
00000B64  AA                stosb
00000B65  E2F8              loop video_fill_vram_00B5F   ; ->0xB5F
00000B67  83C304            add bx,byte +0x4
00000B6A  268B07            mov ax,[es:bx]
00000B6D  86C4              xchg al,ah
00000B6F  8BF8              mov di,ax
00000B71  03FE              add di,si
00000B73  B020              mov al,0x20
00000B75  8B0E3201          mov cx,[0x132]
loc_00B79:
00000B79  2688B50080        mov [es:di-0x8000],dh
00000B7E  AA                stosb
00000B7F  E2F8              loop loc_00B79   ; ->0xB79
00000B81  83EB02            sub bx,byte +0x2
;>>>> [video] mov ax,[es:bx] inside the screen-draw primitive 0xb49 reads a screen-position word from the coordinate table in VRAM/ROM at ES:BX; it is byte-swapped (xchg al,ah at 0xB87) into DI (0xB89), then SI added (0xB8B) to form the linear VRAM offset. The routine then fills cx=[0x138] cells writing attribute DH to the attribute plane (ES:DI-0x8000) and space 0x20 to the char plane via stosb (0xB8D-0xB99). This is the second fill segment of the box/line draw helper (the first used cx=[0x132] at 0xB75), drawing the setup-menu frame. Not SCC.  // 0xB84 mov ax,[es:bx]; 0xB87 xchg al,ah; 0xB89 mov di,ax; 0xB8B add di,si; 0xB8F mov cx,[0x138]; 0xB93 mov [es:di-0x8000],dh; 0xB98 stosb
00000B84  268B07            mov ax,[es:bx]
00000B87  86C4              xchg al,ah
00000B89  8BF8              mov di,ax
00000B8B  03FE              add di,si
00000B8D  B020              mov al,0x20
00000B8F  8B0E3801          mov cx,[0x138]
video_fread_fill_00B93:
00000B93  2688B50080        mov [es:di-0x8000],dh
00000B98  AA                stosb
00000B99  E2F8              loop video_fread_fill_00B93   ; ->0xB93
00000B9B  8D365D01          lea si,[0x15d]
00000B9F  8B0E3601          mov cx,[0x136]
fill_attr_00BA3:
00000BA3  2688950080        mov [es:di-0x8000],dl
00000BA8  A4                movsb
;>>>> [video/setup-menu] loop 0xba3: inner loop of the menu-row draw routine. It writes attribute byte DL into the attribute plane (ES:DI-0x8000) and copies a label string from [0x15d] into the char plane via movsb, repeated CX=[0x136] times. Surrounded by space-fill loops (DH attribute, AL=0x20) sized by [0x138] — drawing one bordered text line of the setup menu.  // 0xb9b lea si,[0x15d]; mov cx,[0x136]; mov [es:di-0x8000],dl; movsb; loop 0xba3. Adjacent space-fill loops use mov cx,[0x138]; mov al,0x20; mov [es:di-0x8000],dh; stosb; loop.
00000BA9  E2F8              loop fill_attr_00BA3   ; ->0xBA3
;>>>> [video/setup-menu] mov al,0x20 (space) loads the char-plane fill byte for the following stosb loop: mov cx,[0x138] / mov [es:di-0x8000],dh (write attribute DH to the attribute plane) / stosb (write space 0x20 to char plane) / loop 0xbb1. This is the trailing space-fill (right margin) of a setup-menu text row in the menu-row draw routine 0xbbd; [0x138] is the column-width count. After the loop it pops si/ax/bx and RETs. Dual-plane VRAM row draw, not serial.  // >>>>0xBAB mov al,0x20; 0xBAD mov cx,[0x138]; 0xBB1 mov [es:di-0x8000],dh; 0xBB6 stosb; 0xBB7 loop 0xbb1; mirrors leading fill at 0xB8D-0xB99
00000BAB  B020              mov al,0x20
00000BAD  8B0E3801          mov cx,[0x138]
fill_vram_attr_00BB1:
00000BB1  2688B50080        mov [es:di-0x8000],dh
00000BB6  AA                stosb
00000BB7  E2F8              loop fill_vram_attr_00BB1   ; ->0xBB1
00000BB9  5E                pop si
00000BBA  58                pop ax
00000BBB  5B                pop bx
00000BBC  C3                ret
fill_vram_attr_00BBD:
00000BBD  06                push es
00000BBE  53                push bx
00000BBF  A13001            mov ax,[0x130]
00000BC2  CD10              int 0x10
00000BC4  B80006            mov ax,0x600
00000BC7  33DB              xor bx,bx
00000BC9  33C9              xor cx,cx
00000BCB  8B163A01          mov dx,[0x13a]
00000BCF  CD10              int 0x10
00000BD1  B80002            mov ax,0x200
00000BD4  8AF8              mov bh,al
00000BD6  BA0020            mov dx,0x2000
00000BD9  CD10              int 0x10
00000BDB  5B                pop bx
00000BDC  07                pop es
00000BDD  B80200            mov ax,0x2
00000BE0  BE0100            mov si,0x1
00000BE3  BA0202            mov dx,0x202
00000BE6  E860FF            call video_fill_vram_00B49   ; ->0xB49
00000BE9  03363201          add si,[0x132]
00000BED  BA2222            mov dx,0x2222
00000BF0  E856FF            call video_fill_vram_00B49   ; ->0xB49
00000BF3  03363201          add si,[0x132]
00000BF7  BA0A0A            mov dx,0xa0a
00000BFA  E84CFF            call video_fill_vram_00B49   ; ->0xB49
00000BFD  03363201          add si,[0x132]
00000C01  03363401          add si,[0x134]
00000C05  BA1202            mov dx,0x212
00000C08  E83EFF            call video_fill_vram_00B49   ; ->0xB49
00000C0B  03363201          add si,[0x132]
00000C0F  BA3222            mov dx,0x2232
00000C12  E834FF            call video_fill_vram_00B49   ; ->0xB49
00000C15  03363201          add si,[0x132]
00000C19  BA1A0A            mov dx,0xa1a
00000C1C  E82AFF            call video_fill_vram_00B49   ; ->0xB49
00000C1F  050300            add ax,0x3
00000C22  BE0100            mov si,0x1
00000C25  BA0000            mov dx,0x0
00000C28  E81EFF            call video_fill_vram_00B49   ; ->0xB49
00000C2B  03363201          add si,[0x132]
00000C2F  BA2020            mov dx,0x2020
00000C32  E814FF            call video_fill_vram_00B49   ; ->0xB49
00000C35  03363201          add si,[0x132]
00000C39  BA0808            mov dx,0x808
;>>>> [video/setup-menu] call 0xb49 with DX=0x0808 (set at 0x39) draws one setup-menu box/glyph cell. 0xb49 reads a screen-offset word from the table at ES:BX, byte-swaps it to DI, adds SI, and fills the dual-plane VRAM (attribute DH at ES:DI-0x8000, spaces in char plane). SI is advanced by [0x132] (column count 80/132) between calls (0xC3F, 0xC4D) and by [0x134] (0xC43) to step the cursor down/over. DX=0x0808 selects the table entry/glyph pair. One of the run of menu-frame draw calls (0xC25 DX=0, 0xC32 DX=0x2020, 0xC4A DX=0x10, 0xC54 DX=0x2030). Not SCC.  // 0xC39 mov dx,0x808; 0xC3C call 0xb49; 0xC3F add si,[0x132]; 0xC43 add si,[0x134]; matches accepted 0xC47/0xC51/0xC9D 0xb49 draw annotations
00000C3C  E80AFF            call video_fill_vram_00B49   ; ->0xB49
00000C3F  03363201          add si,[0x132]
00000C43  03363401          add si,[0x134]
;>>>> [video/display] mov dx,0x10 as the argument to the call 0xB49 display routine that follows. 0xB49 reads a screen offset from a table via [es:bx], byte-swaps it, and writes a character/attribute cell to the dual-plane VRAM (char plane at ES:DI, attribute plane at ES:DI-0x8000). DX=0x0010 supplies the char/attribute code (here a box/line glyph). SI advanced by [0x132] (column count 80/132) between calls to step down the screen. Part of drawing the self-test/setup-menu frame.  // mov dx,0x10; call 0xb49; repeated add si,[0x132] / mov dx,<code> / call 0xb49 pattern; 0xB49 uses mov ax,[es:bx]/xchg al,ah/mov di,ax to compute VRAM address
00000C47  BA1000            mov dx,0x10
00000C4A  E8FCFE            call video_fill_vram_00B49   ; ->0xB49
00000C4D  03363201          add si,[0x132]
;>>>> [video] mov dx,0x2030 loads a 2-element field-descriptor/coordinate parameter passed in DX to the screen-draw subroutine 0xb49 (called at 0xC54). DX (high byte 0x20, low byte 0x30) selects which menu field/segment to render; 0xb49 uses BX/SI (advanced by add si,[0x132] column-width steps) to compute the VRAM offset and fills the row with attribute DH and spaces. These are setup-menu/test-screen layout draws, NOT SCC register writes.  // 0xC54 call 0xb49 which is the video box-draw routine (see 0xB50 analysis: writes attr plane DH and char-plane 0x20). Surrounding calls use add si,[0x132] (the 80/132 column width) between draws to step across the screen — consistent with screen layout, not serial I/O.
00000C51  BA3020            mov dx,0x2030
00000C54  E8F2FE            call video_fill_vram_00B49   ; ->0xB49
00000C57  03363201          add si,[0x132]
00000C5B  BA1808            mov dx,0x818
00000C5E  E8E8FE            call video_fill_vram_00B49   ; ->0xB49
00000C61  050300            add ax,0x3
00000C64  BE0100            mov si,0x1
00000C67  BA0101            mov dx,0x101
;>>>> [video/setup-menu] call 0xb49 with DX=0x101 (set at 0xC67) is a setup-menu box/glyph DRAW call, NOT an SCC register write. 0xb49 reads a screen-offset word from the VRAM/ROM coordinate table at ES:BX, byte-swaps it to DI, adds SI, and fills [0x132] cells writing attribute DH to the attribute plane (ES:DI-0x8000) and spaces/glyphs to the char plane. SI is advanced by [0x132] (column-width) between successive calls (0xC6D add si,[0x132]). DX=0x101 selects the table entry/glyph pair. Part of the run of layout draws (DX=0x2030,0x818,0x101,0x2121,0x909,...).  // 0xC67 mov dx,0x101; 0xC6A call 0xb49; 0xC6D add si,[0x132]; surrounding calls 0xC54/0xC5E/0xC74/0xC7E all call 0xb49 with add si,[0x132] between. 0xb49 verified as dual-plane VRAM fill (prior 0xB49/0xB50 notes).
00000C6A  E8DCFE            call video_fill_vram_00B49   ; ->0xB49
00000C6D  03363201          add si,[0x132]
00000C71  BA2121            mov dx,0x2121
00000C74  E8D2FE            call video_fill_vram_00B49   ; ->0xB49
00000C77  03363201          add si,[0x132]
00000C7B  BA0909            mov dx,0x909
00000C7E  E8C8FE            call video_fill_vram_00B49   ; ->0xB49
00000C81  03363201          add si,[0x132]
00000C85  03363401          add si,[0x134]
00000C89  BA1101            mov dx,0x111
00000C8C  E8BAFE            call video_fill_vram_00B49   ; ->0xB49
00000C8F  03363201          add si,[0x132]
00000C93  BA3121            mov dx,0x2131
00000C96  E8B0FE            call video_fill_vram_00B49   ; ->0xB49
00000C99  03363201          add si,[0x132]
;>>>> [video/setup-menu] mov dx,0x919 then call 0xb49: a box/menu drawing call. 0xb49 reads a screen-position word from a table (ES:BX, byte-swapped to DI), adds SI (column offset from [0x132]/[0x134]), and fills the dual-plane VRAM (attribute byte DH at ES:DI-0x8000, spaces in char plane). DX=0x919 selects the table entry / glyph pair to draw. This is setup-menu UI rendering, NOT SCC programming.  // 0xb49 body verified L1216-1246: push bx/ax/si; add bx,ax x2; mov ax,[es:bx]; xchg al,ah; mov di,ax; add di,si; mov al,0x20; mov cx,[0x132]; mov [es:di-0x8000],dh; stosb; loop.
00000C9D  BA1909            mov dx,0x919
00000CA0  E8A6FE            call video_fill_vram_00B49   ; ->0xB49
00000CA3  050300            add ax,0x3
00000CA6  BE0100            mov si,0x1
00000CA9  BA0303            mov dx,0x303
00000CAC  E89AFE            call video_fill_vram_00B49   ; ->0xB49
00000CAF  03363201          add si,[0x132]
00000CB3  BA2323            mov dx,0x2323
00000CB6  E890FE            call video_fill_vram_00B49   ; ->0xB49
00000CB9  03363201          add si,[0x132]
00000CBD  BA0B0B            mov dx,0xb0b
00000CC0  E886FE            call video_fill_vram_00B49   ; ->0xB49
00000CC3  03363201          add si,[0x132]
00000CC7  03363401          add si,[0x134]
00000CCB  BA1303            mov dx,0x313
00000CCE  E878FE            call video_fill_vram_00B49   ; ->0xB49
00000CD1  03363201          add si,[0x132]
00000CD5  BA3323            mov dx,0x2333
00000CD8  E86EFE            call video_fill_vram_00B49   ; ->0xB49
00000CDB  03363201          add si,[0x132]
00000CDF  BA1B0B            mov dx,0xb1b
00000CE2  E864FE            call video_fill_vram_00B49   ; ->0xB49
00000CE5  050300            add ax,0x3
00000CE8  BE0100            mov si,0x1
00000CEB  BA0602            mov dx,0x206
00000CEE  E858FE            call video_fill_vram_00B49   ; ->0xB49
00000CF1  03363201          add si,[0x132]
00000CF5  BA2622            mov dx,0x2226
00000CF8  E84EFE            call video_fill_vram_00B49   ; ->0xB49
00000CFB  03363201          add si,[0x132]
00000CFF  BA0E0A            mov dx,0xa0e
00000D02  E844FE            call video_fill_vram_00B49   ; ->0xB49
00000D05  03363201          add si,[0x132]
00000D09  03363401          add si,[0x134]
00000D0D  BA1602            mov dx,0x216
00000D10  E836FE            call video_fill_vram_00B49   ; ->0xB49
00000D13  03363201          add si,[0x132]
00000D17  BA3622            mov dx,0x2236
00000D1A  E82CFE            call video_fill_vram_00B49   ; ->0xB49
00000D1D  03363201          add si,[0x132]
00000D21  BA1E0A            mov dx,0xa1e
00000D24  E822FE            call video_fill_vram_00B49   ; ->0xB49
00000D27  050300            add ax,0x3
00000D2A  BE0100            mov si,0x1
00000D2D  BA0400            mov dx,0x4
00000D30  E816FE            call video_fill_vram_00B49   ; ->0xB49
00000D33  03363201          add si,[0x132]
00000D37  BA2420            mov dx,0x2024
00000D3A  E80CFE            call video_fill_vram_00B49   ; ->0xB49
00000D3D  03363201          add si,[0x132]
00000D41  BA0C08            mov dx,0x80c
00000D44  E802FE            call video_fill_vram_00B49   ; ->0xB49
00000D47  03363201          add si,[0x132]
00000D4B  03363401          add si,[0x134]
00000D4F  BA1400            mov dx,0x14
00000D52  E8F4FD            call video_fill_vram_00B49   ; ->0xB49
00000D55  03363201          add si,[0x132]
00000D59  BA3420            mov dx,0x2034
;>>>> [video/setup-menu] call 0xb49 with DX=0x2034 (loaded at 0xD59) is one box/row-draw call in a sequence rendering a setup-menu screen element. 0xb49 reads a screen-offset word from the table at ES:BX, byte-swaps it into DI, adds SI, and fills cx=[0x132] cells writing attribute DH to the attribute plane (ES:DI-0x8000) and space 0x20 to the char plane. DX=0x2034 (hi 0x20 attribute/segment, lo 0x34 field/glyph selector) picks the table entry. SI is advanced by add si,[0x132] (column width) between calls to step down the screen. Setup-menu frame draw, NOT SCC programming.  // >>>>0xD5C call 0xb49; 0xD59 mov dx,0x2034; surrounding calls 0xD3A/0xD44/0xD52/0xD66 each with add si,[0x132]; matches prior 0xb49 draw-primitive annotations
00000D5C  E8EAFD            call video_fill_vram_00B49   ; ->0xB49
00000D5F  03363201          add si,[0x132]
00000D63  BA1C08            mov dx,0x81c
00000D66  E8E0FD            call video_fill_vram_00B49   ; ->0xB49
00000D69  050300            add ax,0x3
00000D6C  BE0100            mov si,0x1
00000D6F  BA0501            mov dx,0x105
00000D72  E8D4FD            call video_fill_vram_00B49   ; ->0xB49
00000D75  03363201          add si,[0x132]
00000D79  BA2521            mov dx,0x2125
00000D7C  E8CAFD            call video_fill_vram_00B49   ; ->0xB49
00000D7F  03363201          add si,[0x132]
00000D83  BA0D09            mov dx,0x90d
00000D86  E8C0FD            call video_fill_vram_00B49   ; ->0xB49
00000D89  03363201          add si,[0x132]
00000D8D  03363401          add si,[0x134]
00000D91  BA1501            mov dx,0x115
00000D94  E8B2FD            call video_fill_vram_00B49   ; ->0xB49
00000D97  03363201          add si,[0x132]
;>>>> [video / setup-menu UI] mov dx,0x2135 loads a packed drawing parameter (row/col + line-style code) passed to the box/row-drawing helper at 0xB49 (NOT a print or SCC call). 0xB49 (verified at file 0xB49) reads a screen-offset word from a table at ES:BX, byte-swaps it into DI, adds SI, and fills CX=[0x132] (column count, 80/132) cells writing attribute byte DH to the attribute plane at [ES:DI-0x8000] and space 0x20 to the char plane via STOSB. This is one of many such calls drawing the manufacturing/setup-menu screen frame.  // Disasm of 0xB49 routine (lines 1216-1245): mov ax,[es:bx]; xchg al,ah; mov di,ax; add di,si; mov al,0x20; mov cx,[0x132]; mov [es:di-0x8000],dh; stosb; loop. Surrounding code repeatedly does 'add si,[0x132]' then 'mov dx,imm; call 0xb49' - screen positioning, not I/O.
00000D9B  BA3521            mov dx,0x2135
00000D9E  E8A8FD            call video_fill_vram_00B49   ; ->0xB49
00000DA1  03363201          add si,[0x132]
00000DA5  BA1D09            mov dx,0x91d
00000DA8  E89EFD            call video_fill_vram_00B49   ; ->0xB49
00000DAB  050300            add ax,0x3
00000DAE  BE0100            mov si,0x1
00000DB1  BA0703            mov dx,0x307
00000DB4  E892FD            call video_fill_vram_00B49   ; ->0xB49
00000DB7  03363201          add si,[0x132]
00000DBB  BA2723            mov dx,0x2327
00000DBE  E888FD            call video_fill_vram_00B49   ; ->0xB49
00000DC1  03363201          add si,[0x132]
00000DC5  BA0F0B            mov dx,0xb0f
00000DC8  E87EFD            call video_fill_vram_00B49   ; ->0xB49
00000DCB  03363201          add si,[0x132]
00000DCF  03363401          add si,[0x134]
00000DD3  BA1703            mov dx,0x317
00000DD6  E870FD            call video_fill_vram_00B49   ; ->0xB49
00000DD9  03363201          add si,[0x132]
00000DDD  BA3723            mov dx,0x2337
;>>>> [video/setup-menu] call 0xb49 (DX=0x2337 set at 0x2DD): another setup-menu box/glyph draw call. SI is advanced by column-width [0x132]/[0x134] between calls to step the screen cursor; DX selects the table entry/character pair drawn into the dual-plane VRAM. The following code (mov dx,[0x13a]; +3; -0x14; shr; centering math) computes a centered horizontal screen position, confirming this is screen-layout/UI, not serial.  // 0xddd mov dx,0x2337; 0xde0 call 0xb49; 0xdee mov dx,[0x13a] (screen width var); add 3; sub 0x14; xor dh,dh; shr dx,1; or dx,1 — horizontal centering for an 0x14-wide field.
00000DE0  E866FD            call video_fill_vram_00B49   ; ->0xB49
00000DE3  03363201          add si,[0x132]
00000DE7  BA1F0B            mov dx,0xb1f
00000DEA  E85CFD            call video_fill_vram_00B49   ; ->0xB49
00000DED  53                push bx
00000DEE  8B163A01          mov dx,[0x13a]
00000DF2  83C203            add dx,byte +0x3
00000DF5  83EA14            sub dx,byte +0x14
00000DF8  32F6              xor dh,dh
00000DFA  D1EA              shr dx,1
00000DFC  83CA01            or dx,byte +0x1
00000DFF  B1D0              mov cl,0xd0
00000E01  268B07            mov ax,[es:bx]
00000E04  86C4              xchg al,ah
00000E06  8BF8              mov di,ax
00000E08  26880D            mov [es:di],cl
00000E0B  03FA              add di,dx
00000E0D  8D365301          lea si,[0x153]
00000E11  B90A00            mov cx,0xa
loc_00E14:
00000E14  AC                lodsb
00000E15  AA                stosb
00000E16  AA                stosb
00000E17  E2FB              loop loc_00E14   ; ->0xE14
00000E19  8BCB              mov cx,bx
00000E1B  5B                pop bx
00000E1C  3BCB              cmp cx,bx
00000E1E  7508              jnz loc_00E28   ; ->0xE28
00000E20  53                push bx
00000E21  83C302            add bx,byte +0x2
00000E24  B1C0              mov cl,0xc0
00000E26  EBD9              jmp short 0xe01
loc_00E28:
00000E28  83C336            add bx,byte +0x36
00000E2B  268B07            mov ax,[es:bx]
00000E2E  86C4              xchg al,ah
00000E30  8BF8              mov di,ax
00000E32  26C60580          mov byte [es:di],0x80
00000E36  8B163A01          mov dx,[0x13a]
00000E3A  83C203            add dx,byte +0x3
00000E3D  83EA1C            sub dx,byte +0x1c
00000E40  32F6              xor dh,dh
00000E42  D1EA              shr dx,1
00000E44  83CA01            or dx,byte +0x1
00000E47  03FA              add di,dx
00000E49  8D366B01          lea si,[0x16b]
00000E4D  B90E00            mov cx,0xe
loc_00E50:
00000E50  AC                lodsb
00000E51  AA                stosb
00000E52  AA                stosb
00000E53  E2FB              loop loc_00E50   ; ->0xE50
00000E55  83C302            add bx,byte +0x2
00000E58  53                push bx
00000E59  B150              mov cl,0x50
00000E5B  268B07            mov ax,[es:bx]
00000E5E  86C4              xchg al,ah
00000E60  8BF8              mov di,ax
;>>>> [video] mov [es:di],cl writes CL=0x50 (decimal 80) into the char plane at ES:DI as part of a setup-menu box/field draw routine. Here CL is NOT ASCII 'P' but the column count/field-width literal loaded at 0xE59 (mov cl,0x50); the routine then advances DI and does rep movsb of a 13-byte label (lea si,[0x195]; cx=0xd) into the dual-plane VRAM char plane (ES:DI), positioning via [0x13a] screen width. Part of the setup-menu UI text/field rendering.  // Preceding 0xE59 mov cl,0x50; 0xE5B mov ax,[es:bx]/xchg/mov di,ax computes screen offset; following 0xE6D mov cx,0xd; 0xE70 rep movsb copies a fixed-length label; 0xE74 mov dx,[0x13a] (column width 80/132) used to right-position. VRAM char plane is ES:DI, attribute plane ES:DI-0x8000 per the 0xb49 routine.
00000E62  26880D            mov [es:di],cl
00000E65  83C701            add di,byte +0x1
00000E68  57                push di
00000E69  8D369501          lea si,[0x195]
00000E6D  B90D00            mov cx,0xd
00000E70  F3A4              rep movsb
00000E72  5F                pop di
;>>>> [video/setup-menu] push di saves the current char-plane VRAM write offset before the routine computes a RIGHT-justified position for a second 13-byte label copy. The next instrs load dx=[0x13a] (screen width/column-count), sub dx,0xd (width minus 13-char field), xor dh,dh (keep low byte), add di,dx (advance DI to right edge), then lea si,[0x1a2]/cx=0xd/rep movsb copies the 13-byte string into the char plane. The saved DI is popped at 0xE88. This is setup-menu field/label rendering, paired with the left-justified copy from [0x195] just above.  // 0xE73 push di; 0xE74 mov dx,[0x13a]; 0xE78 sub dx,0xd; 0xE7B xor dh,dh; 0xE7D add di,dx; 0xE7F lea si,[0x1a2]; 0xE83 mov cx,0xd; 0xE86 rep movsb; 0xE88 pop di. [0x13a] is the column-width var used by draw routine.
00000E73  57                push di
00000E74  8B163A01          mov dx,[0x13a]
00000E78  83EA0D            sub dx,byte +0xd
00000E7B  32F6              xor dh,dh
00000E7D  03FA              add di,dx
00000E7F  8D36A201          lea si,[0x1a2]
00000E83  B90D00            mov cx,0xd
00000E86  F3A4              rep movsb
00000E88  5F                pop di
00000E89  8BCB              mov cx,bx
00000E8B  5B                pop bx
00000E8C  3BCB              cmp cx,bx
00000E8E  7508              jnz cursor_fill_vram_00E98   ; ->0xE98
;>>>> [video/setup-menu] push bx saves the current column/index BX at the top of the menu-label rendering loop body; the next instructions add bx,2 (advance to next table entry, 2-byte stride), mov cl,0x40 (reload CL=0x40 fill/marker byte) and jmp short 0xe5b back to the loop head. This branch is reached when the position check (cmp cx,bx at 0xE8C; jnz 0xe98) finds the cursor column NOT yet at the target, so it iterates drawing the next 13-byte menu label (rep movsb of strings at [0x195]/[0x1a2] into VRAM, positioned via width [0x13a]). Setup-menu UI text loop, not serial.  // >>>>0xE90 push bx; 0xE91 add bx,2; 0xE94 mov cl,0x40; 0xE96 jmp 0xe5b; 0xE8C cmp cx,bx; 0xE8E jnz 0xe98; 0xE98 ret; labels copied at 0xE6D/0xE83 cx=0xd
00000E90  53                push bx
00000E91  83C302            add bx,byte +0x2
00000E94  B140              mov cl,0x40
00000E96  EBC3              jmp short 0xe5b
cursor_fill_vram_00E98:
00000E98  C3                ret
fread_00E99:
00000E99  8BC1              mov ax,cx
00000E9B  B91400            mov cx,0x14
sub_00E9E:
;>>>> [timing / busy-wait delay] loop 0xe9e is a degenerate self-looping busy-wait that burns CX iterations doing nothing. It is the body of the short delay helper at 0xE99: mov ax,cx (save caller CX) / mov cx,0x14 / loop 0xe9e (spin 0x14 times) / mov cx,ax (restore) / ret. This is the calibrated software delay called between SCC/gate-array OUT and IN (e.g. used by the 0xEA3 video-register write/verify and SCC register sequences) to satisfy peripheral write-recovery/settle time on the slow external bus.  // 0xE99 mov ax,cx; 0xE9B mov cx,0x14; 0xE9E loop 0xe9e; 0xEA0 mov cx,ax; 0xEA2 ret. Called at 0xEA9 (call 0xe99) between out dx,al (0x342) and in al,dx (0x340).
00000E9E  E2FE              loop sub_00E9E   ; ->0xE9E
00000EA0  8BC8              mov cx,ax
00000EA2  C3                ret
fread_status_00EA3:
00000EA3  BA4203            mov dx,0x342
00000EA6  8AC3              mov al,bl
00000EA8  EE                out dx,al
00000EA9  E8EDFF            call fread_00E99   ; ->0xE99
00000EAC  BA4003            mov dx,0x340
00000EAF  EC                in al,dx
00000EB0  24E8              and al,0xe8
00000EB2  3AC7              cmp al,bh
00000EB4  C3                ret
init_00EB5:
00000EB5  EE                out dx,al
00000EB6  86C4              xchg al,ah
00000EB8  EE                out dx,al
00000EB9  C3                ret
cksum_fread_00EBA:
00000EBA  B000              mov al,0x0
00000EBC  EE                out dx,al
00000EBD  EC                in al,dx
00000EBE  C3                ret
kbd_cursor_fread_00EBF:
00000EBF  BA0100            mov dx,0x1
00000EC2  B400              mov ah,0x0
00000EC4  CD16              int 0x16
00000EC6  3C1B              cmp al,0x1b
;>>>> [keyboard] jz 0xed4: handles the result of the INT 16h AH=0 keystroke read at 0xec4. cmp al,0x1b tested for ESC; this jz takes ESC to 0xed4 which `jmp 0x627` to abort/exit the test menu. The fall-through then tests mode byte [0x13e] and checks for Space (0x20), and arrow/cursor keys (0x12,0x13) to navigate the setup menu.  // 0xebf-0xec8: mov dx,1; mov ah,0; int 0x16; cmp al,0x1b; jz 0xed4. 0xed4 jmp 0x627. 0xed7 cmp al,0x20; 0xee3 cmp al,0x12; 0xee7 cmp al,0x13.
00000EC8  740A              jz kbd_cursor_fread_00ED4   ; ->0xED4
00000ECA  F6063E010F        test byte [0x13e],0xf
00000ECF  7406              jz kbd_cursor_fread_00ED7   ; ->0xED7
00000ED1  EB69              jmp short 0xf3c
00000ED3  90                nop
kbd_cursor_fread_00ED4:
00000ED4  E950F7            jmp kbd_cursor_fread_00627   ; ->0x627
kbd_cursor_fread_00ED7:
00000ED7  3C20              cmp al,0x20
00000ED9  7413              jz loc_00EEE   ; ->0xEEE
00000EDB  F7062A010100      test word [0x12a],0x1
00000EE1  7408              jz loc_00EEB   ; ->0xEEB
00000EE3  3C12              cmp al,0x12
00000EE5  7414              jz data_clear_init_00EFB   ; ->0xEFB
00000EE7  3C13              cmp al,0x13
00000EE9  7439              jz loc_00F24   ; ->0xF24
loc_00EEB:
00000EEB  33D2              xor dx,dx
00000EED  C3                ret
loc_00EEE:
00000EEE  C6063E0101        mov byte [0x13e],0x1
00000EF3  33C0              xor ax,ax
00000EF5  E88401            call kbd_fread_vram_0107C   ; ->0x107C
00000EF8  0BD2              or dx,dx
00000EFA  C3                ret
data_clear_init_00EFB:
00000EFB  33C0              xor ax,ax
00000EFD  A32A01            mov [0x12a],ax
00000F00  A30A00            mov [0xa],ax
00000F03  A32A00            mov [0x2a],ax
00000F06  A34A00            mov [0x4a],ax
00000F09  A36A00            mov [0x6a],ax
00000F0C  A38A00            mov [0x8a],ax
00000F0F  A3AA00            mov [0xaa],ax
00000F12  A3CA00            mov [0xca],ax
;>>>> [string/data] mov [0xea],ax (AX=0): part of an init routine zeroing a strided table of word error-flag/mask variables at offsets 0x0a,0x2a,0x4a,0x6a,0x8a,0xaa,0xca,0xea,0x10a (the per-test result bitmasks set elsewhere via or [0xXX],ax). Clears all subsystem self-test result accumulators before a test pass; then mov ax,6 / call 0x107c.  // 0xefb-0xf18: xor ax,ax; mov [0x12a],ax; mov [0xa]..[0xca],ax in 0x20 strides; mov [0xea],ax; mov [0x10a],ax; mov ax,0x6; call 0x107c. Matches or [0x4a]/[0x6a]/[0xaa]/[0x2a] error masks in other samples.
00000F15  A3EA00            mov [0xea],ax
00000F18  A30A01            mov [0x10a],ax
00000F1B  B80600            mov ax,0x6
00000F1E  E85B01            call kbd_fread_vram_0107C   ; ->0x107C
00000F21  0BD2              or dx,dx
00000F23  C3                ret
loc_00F24:
00000F24  80363C0101        xor byte [0x13c],0x1
00000F29  7408              jz loc_00F33   ; ->0xF33
00000F2B  33C0              xor ax,ax
00000F2D  E84C01            call kbd_fread_vram_0107C   ; ->0x107C
00000F30  33D2              xor dx,dx
00000F32  C3                ret
loc_00F33:
00000F33  B82400            mov ax,0x24
00000F36  E84301            call kbd_fread_vram_0107C   ; ->0x107C
00000F39  33D2              xor dx,dx
00000F3B  C3                ret
00000F3C  3C0D              cmp al,0xd
00000F3E  740B              jz loc_00F4B   ; ->0xF4B
00000F40  3C01              cmp al,0x1
00000F42  7415              jz loc_00F59   ; ->0xF59
00000F44  3C13              cmp al,0x13
00000F46  7424              jz loc_00F6C   ; ->0xF6C
loc_00F48:
00000F48  33D2              xor dx,dx
00000F4A  C3                ret
loc_00F4B:
00000F4B  C6063E0100        mov byte [0x13e],0x0
00000F50  B80600            mov ax,0x6
00000F53  E82601            call kbd_fread_vram_0107C   ; ->0x107C
00000F56  0BD2              or dx,dx
00000F58  C3                ret
loc_00F59:
00000F59  FE063E01          inc byte [0x13e]
00000F5D  803E3E0103        cmp byte [0x13e],0x3
00000F62  7605              jna loc_00F69   ; ->0xF69
00000F64  C6063E0101        mov byte [0x13e],0x1
loc_00F69:
00000F69  0BD2              or dx,dx
00000F6B  C3                ret
loc_00F6C:
00000F6C  803E3E0102        cmp byte [0x13e],0x2
00000F71  750F              jnz blk_fill_col_00F82   ; ->0xF82
00000F73  A03F01            mov al,[0x13f]
00000F76  3474              xor al,0x74
00000F78  A23F01            mov [0x13f],al
00000F7B  B41E              mov ah,0x1e
00000F7D  CD40              int 0x40
;>>>> [setup-menu / config state] or dx,dx (flag-set) immediately before RET, returning status from the [0x13e]==2 branch of the setup-menu handler. That branch read config byte [0x13f], XORed it with 0x74 (toggling a setup field), wrote it back, then issued INT 40h with AH=0x1E (kernel custom system service) before reaching this return. The or dx,dx is the routine's exit-status convention, not a data computation.  // Lines 222-231: mov al,[0x13f]; xor al,0x74; mov [0x13f],al; mov ah,0x1e; int 0x40; or dx,dx; ret. INT 40h is the kernel custom API per hardware notes.
00000F7F  0BD2              or dx,dx
00000F81  C3                ret
blk_fill_col_00F82:
00000F82  803E3E0103        cmp byte [0x13e],0x3
00000F87  75BF              jnz loc_00F48   ; ->0xF48
00000F89  8336300107        xor word [0x130],byte +0x7
00000F8E  8336320118        xor word [0x132],byte +0x18
00000F93  8336340104        xor word [0x134],byte +0x4
00000F98  8336360106        xor word [0x136],byte +0x6
;>>>> [setup-menu] xor word [0x138],0x01 toggles one of a block of setup-config word variables. This is in the branch taken when mode byte [0x13e]==3 (cmp at 0xF82): it XOR-flips [0x130]+=7, [0x132]+=0x18, [0x134]+=4, [0x136]+=6, [0x138]+=1, [0x13a]^=0xCC. [0x132]/[0x138] are the screen column-width values consumed by the video draw loop (mov cx,[0x132]/[0x138]); this toggles between 80/132-column (and related layout) parameters for the setup-menu UI mode.  // Branch entry 0xF82 cmp byte [0x13e],0x3 / jnz; the XOR-toggle block 0xF89-0xFA2; [0x132] and [0x138] are loaded as loop counters in the screen-fill routines (0xB5B mov cx,[0x132]; 0xB8F/0xBAD mov cx,[0x138]); 0x13a is the line-width referenced at 0xE74/0xDEE.
00000F9D  8336380101        xor word [0x138],byte +0x1
00000FA2  81363A01CC00      xor word [0x13a],0xcc
;>>>> [setup-menu / config state] or dx,dx sets the flags (and is immediately followed by RET) to return DX status to the caller of this setup-menu key/mode handler. This is the tail of the branch taken when config-mode byte [0x13e]==3, which XORs (toggles) the menu/attribute state words [0x130],[0x132],[0x134],[0x136],[0x138],[0x13a] - the column-width/attribute variables used by the drawing routine. Not a numeric value move; it is a flag-set-then-return convention.  // Lines 84-96: cmp byte [0x13e],0x3; jnz; xor word [0x130]..[0x13a]; or dx,dx; ret. [0x132] is the same column-count used in 0xB49.
00000FA8  0BD2              or dx,dx
00000FAA  C3                ret
dispatch_fhandle_00FAB:
00000FAB  803E3E0101        cmp byte [0x13e],0x1
00000FB0  741A              jz dispatch_fhandle_00FCC   ; ->0xFCC
00000FB2  803E3E0102        cmp byte [0x13e],0x2
00000FB7  7417              jz dispatch_fhandle_00FD0   ; ->0xFD0
00000FB9  803E3E0103        cmp byte [0x13e],0x3
00000FBE  7414              jz dispatch_fhandle_00FD4   ; ->0xFD4
00000FC0  F7062A010100      test word [0x12a],0x1
00000FC6  7510              jnz dispatch_fhandle_00FD8   ; ->0xFD8
00000FC8  E839F9            call dispatch_fhandle_00904   ; ->0x904
00000FCB  C3                ret
dispatch_fhandle_00FCC:
;>>>> [setup-menu / mode dispatch] call 0x986 is the dispatch target taken when setup-menu mode byte [0x13e]==1 (cmp byte [0x13e],0x1 / jz 0xfcc at 0xFAB-0xFB0). 0x986 is one of the per-mode screen handlers (push es prologue, like its siblings 0x9f7 for [0x13e]==2, 0xbbd for [0x13e]==3, and 0x904/0x644 for the default/test path at 0xFC8/0xFD8). It renders/refreshes the screen for menu mode 1. The following RET (0xFCF) returns to the menu loop. This is UI mode-selection dispatch, not an SCC/serial routine.  // 0xFAB cmp byte [0x13e],0x1; 0xFB0 jz 0xfcc; 0xFCC call 0x986; 0xFD0 call 0x9f7 (mode 2); 0xFD4 call 0xbbd (mode 3); 0x986 at line 1034 begins push es
00000FCC  E8B7F9            call cursor_00986   ; ->0x986
00000FCF  C3                ret
dispatch_fhandle_00FD0:
00000FD0  E824FA            call dispatch_fhandle_009F7   ; ->0x9F7
00000FD3  C3                ret
dispatch_fhandle_00FD4:
00000FD4  E8E6FB            call fill_vram_attr_00BBD   ; ->0xBBD
00000FD7  C3                ret
dispatch_fhandle_00FD8:
00000FD8  E869F6            call cursor_00644   ; ->0x644
00000FDB  C3                ret
dispatch_fhandle_00FDC:
00000FDC  803E3E0100        cmp byte [0x13e],0x0
00000FE1  750F              jnz dispatch_fhandle_00FF2   ; ->0xFF2
00000FE3  F7062A010100      test word [0x12a],0x1
00000FE9  7504              jnz dispatch_fhandle_00FEF   ; ->0xFEF
00000FEB  E855F9            call dispatch_fhandle_00943   ; ->0x943
00000FEE  C3                ret
dispatch_fhandle_00FEF:
;>>>> [setup-menu / self-test dispatch] call 0x8ca is the branch taken when config-mode byte [0x13e]==0 AND the cumulative SCC/test error flag word [0x12a] has bit0 set (test word [0x12a],0x1 / jnz 0xfef). 0x8ca is the error/animation display path (it tests [0x12c]/[0x12e] blink counters and calls 0x644), so on a failed self-test in normal mode this shows the failure indicator screen; the alternate (no error) path calls 0x943. This is the result-dispatch tail of the menu handler.  // 0xFDC cmp byte [0x13e],0; 0xFE1 jnz 0xff2; 0xFE3 test word [0x12a],0x1; 0xFE9 jnz 0xfef; 0xFEB call 0x943 (no-error path); 0xFEF call 0x8ca. 0x8ca body (sample 14) handles [0x12c]/[0x12e] blink and calls 0x644.
00000FEF  E8D8F8            call cursor_008CA   ; ->0x8CA
dispatch_fhandle_00FF2:
00000FF2  C3                ret
hexprint_cksum_dispatch_00FF3:
00000FF3  B400              mov ah,0x0
00000FF5  CD40              int 0x40
00000FF7  9C                pushf
00000FF8  B401              mov ah,0x1
00000FFA  CD16              int 0x16
00000FFC  7409              jz dispatch_status_01007   ; ->0x1007
00000FFE  E8BEFE            call kbd_cursor_fread_00EBF   ; ->0xEBF
00001001  7404              jz dispatch_status_01007   ; ->0x1007
;>>>> [kernel-API/INT40h] popf restores the flags that were saved (pushf at 0xFF7) immediately after INT 40h AH=0 (kernel get-char/status). The routine then checks the keyboard via INT 16h AH=01h (peek), and depending on the restored carry from the INT 40h call dispatches: jnc 0x1018 or INT 40h AH=04h. So this popf re-establishes the INT 40h serial-receive status flag for the subsequent JNC branch.  // 0xFF5 int 0x40 (ah=0); pushf; int 0x16 (ah=1); ... popf at 0x1003/0x1007; jnc 0x1018; mov ah,0x4/int 0x40
00001003  9D                popf
00001004  EB04              jmp short 0x100a
00001006  90                nop
dispatch_status_01007:
00001007  9D                popf
00001008  730E              jnc dispatch_status_01018   ; ->0x1018
0000100A  B404              mov ah,0x4
0000100C  CD40              int 0x40
0000100E  8CC0              mov ax,es
00001010  0BC3              or ax,bx
00001012  74DF              jz hexprint_cksum_dispatch_00FF3   ; ->0xFF3
00001014  E894FF            call dispatch_fhandle_00FAB   ; ->0xFAB
00001017  C3                ret
dispatch_status_01018:
00001018  E88900            call sub_010A4   ; ->0x10A4
0000101B  750D              jnz loc_0102A   ; ->0x102A
0000101D  B404              mov ah,0x4
0000101F  CD40              int 0x40
00001021  8CC0              mov ax,es
00001023  0BC3              or ax,bx
00001025  74CC              jz hexprint_cksum_dispatch_00FF3   ; ->0xFF3
00001027  E8B2FF            call dispatch_fhandle_00FDC   ; ->0xFDC
loc_0102A:
0000102A  C3                ret
0000102B  00608B            add [bx+si-0x75],ah
0000102E  D833              fdiv dword [bp+di]
00001030  C0CD1A            ror ch,byte 0x1a
00001033  89165A02          mov [0x25a],dx
00001037  89165E02          mov [0x25e],dx
0000103B  A36002            mov [0x260],ax
0000103E  011E5E02          add [0x25e],bx
00001042  11066002          adc [0x260],ax
00001046  61                popa
00001047  C3                ret
fread_status_01048:
00001048  60                pusha
00001049  32E4              xor ah,ah
0000104B  CD1A              int 0x1a
0000104D  BE0100            mov si,0x1
00001050  F70660020100      test word [0x260],0x1
00001056  7512              jnz loc_0106A   ; ->0x106A
00001058  A15E02            mov ax,[0x25e]
0000105B  2BC2              sub ax,dx
0000105D  7619              jna loc_01078   ; ->0x1078
0000105F  A15A02            mov ax,[0x25a]
00001062  2BC2              sub ax,dx
00001064  7712              ja loc_01078   ; ->0x1078
loc_01066:
00001066  0BF6              or si,si
00001068  61                popa
00001069  C3                ret
loc_0106A:
0000106A  A15E02            mov ax,[0x25e]
0000106D  2BC2              sub ax,dx
0000106F  77F5              ja loc_01066   ; ->0x1066
00001071  A15A02            mov ax,[0x25a]
00001074  2BC2              sub ax,dx
00001076  76EE              jna loc_01066   ; ->0x1066
loc_01078:
00001078  33F6              xor si,si
0000107A  61                popa
0000107B  C3                ret
kbd_fread_vram_0107C:
0000107C  60                pusha
0000107D  8BD8              mov bx,ax
0000107F  0BDB              or bx,bx
00001081  7419              jz loc_0109C   ; ->0x109C
00001083  33C0              xor ax,ax
00001085  CD1A              int 0x1a
00001087  89166402          mov [0x264],dx
0000108B  89166802          mov [0x268],dx
0000108F  A36A02            mov [0x26a],ax
00001092  011E6802          add [0x268],bx
00001096  11066A02          adc [0x26a],ax
0000109A  61                popa
0000109B  C3                ret
loc_0109C:
0000109C  C7066A020200      mov word [0x26a],0x2
000010A2  61                popa
000010A3  C3                ret
sub_010A4:
000010A4  60                pusha
000010A5  BE0100            mov si,0x1
000010A8  F7066A020200      test word [0x26a],0x2
000010AE  751A              jnz loc_010CA   ; ->0x10CA
000010B0  32E4              xor ah,ah
000010B2  CD1A              int 0x1a
000010B4  F7066A020100      test word [0x26a],0x1
000010BA  7512              jnz loc_010CE   ; ->0x10CE
000010BC  A16802            mov ax,[0x268]
000010BF  2BC2              sub ax,dx
000010C1  7619              jna loc_010DC   ; ->0x10DC
000010C3  A16402            mov ax,[0x264]
000010C6  2BC2              sub ax,dx
000010C8  7712              ja loc_010DC   ; ->0x10DC
loc_010CA:
000010CA  0BF6              or si,si
000010CC  61                popa
000010CD  C3                ret
loc_010CE:
000010CE  A16802            mov ax,[0x268]
000010D1  2BC2              sub ax,dx
000010D3  77F5              ja loc_010CA   ; ->0x10CA
000010D5  A16402            mov ax,[0x264]
000010D8  2BC2              sub ax,dx
000010DA  76EE              jna loc_010CA   ; ->0x10CA
loc_010DC:
000010DC  33F6              xor si,si
000010DE  61                popa
;>>>> [timer/PCB-port] ret terminating a polling/timeout wait subroutine. The body (0x10C8-0x10DE) repeatedly subtracts DX from the timer-snapshot values [0x264] and [0x268] and loops (popa/ret on match), implementing a busy-wait until an elapsed-timer threshold is reached; this ret is the timeout/exit after popa restores all registers.  // mov ax,[0x268]/sub ax,dx/ja; mov ax,[0x264]/sub ax,dx/jna; xor si,si; popa; ret at 0x10DF
000010DF  C3                ret
hexprint_cksum_dispatch_010E0:
000010E0  BA08FF            mov dx,0xff08
000010E3  ED                in ax,dx
000010E4  A38202            mov [0x282],ax
000010E7  C3                ret
fread_010E8:
000010E8  BA08FF            mov dx,0xff08
000010EB  A18202            mov ax,[0x282]
;>>>> [timer/PCB-port] out dx,ax writes the saved value [0x282] back to 80C188EB PCB port 0xFF08. This is the restore half of a save/restore pair: 0x10E0 reads 0xFF08 into [0x282], and this routine (0x10E8) writes it back unchanged, restoring the port state after a test.  // 0x10E8: mov dx,0xff08 / mov ax,[0x282] / out dx,ax / ret; companion 0x10E0 reads and stores [0x282]
000010EE  EF                out dx,ax
000010EF  C3                ret
hexprint_cksum_dispatch_010F0:
000010F0  BA08FF            mov dx,0xff08
000010F3  A18202            mov ax,[0x282]
000010F6  0DD400            or ax,0xd4
000010F9  EF                out dx,ax
000010FA  C3                ret
hexprint_cksum_dispatch_010FB:
000010FB  BA1EFF            mov dx,0xff1e
000010FE  ED                in ax,dx
000010FF  A38802            mov [0x288],ax
00001102  BA1EFF            mov dx,0xff1e
00001105  B81800            mov ax,0x18
00001108  EF                out dx,ax
00001109  C3                ret
sub_0110A:
0000110A  BA1EFF            mov dx,0xff1e
0000110D  A18802            mov ax,[0x288]
00001110  EF                out dx,ax
00001111  C3                ret
00001112  60                pusha
00001113  1E                push ds
00001114  B83401            mov ax,0x134
00001117  8ED8              mov ds,ax
00001119  C606580201        mov byte [0x258],0x1
0000111E  BA68FF            mov dx,0xff68
00001121  ED                in ax,dx
00001122  8B1E1D02          mov bx,[0x21d]
00001126  81FB3600          cmp bx,0x36
0000112A  7305              jnc loc_01131   ; ->0x1131
0000112C  8887E701          mov [bx+0x1e7],al
00001130  43                inc bx
loc_01131:
00001131  891E1D02          mov [0x21d],bx
00001135  BA02FF            mov dx,0xff02
00001138  B80080            mov ax,0x8000
0000113B  EF                out dx,ax
0000113C  1F                pop ds
0000113D  61                popa
0000113E  CF                iret
0000113F  60                pusha
00001140  1E                push ds
00001141  B83401            mov ax,0x134
00001144  8ED8              mov ds,ax
00001146  8B1EE501          mov bx,[0x1e5]
0000114A  81FB3600          cmp bx,0x36
0000114E  730C              jnc loc_0115C   ; ->0x115C
00001150  BA6AFF            mov dx,0xff6a
00001153  8A87AF01          mov al,[bx+0x1af]
00001157  EE                out dx,al
00001158  FF06E501          inc word [0x1e5]
loc_0115C:
0000115C  BA02FF            mov dx,0xff02
0000115F  B80080            mov ax,0x8000
00001162  EF                out dx,ax
00001163  1F                pop ds
00001164  61                popa
00001165  CF                iret
hexprint_cksum_dispatch_01166:
00001166  06                push es
00001167  50                push ax
00001168  53                push bx
00001169  33C0              xor ax,ax
0000116B  8EC0              mov es,ax
0000116D  BB1400            mov bx,0x14
00001170  D1E3              shl bx,1
00001172  D1E3              shl bx,1
00001174  268B07            mov ax,[es:bx]
00001177  A37202            mov [0x272],ax
0000117A  268B4702          mov ax,[es:bx+0x2]
0000117E  A37402            mov [0x274],ax
00001181  26C7071211        mov word [es:bx],0x1112
00001186  268C4F02          mov [es:bx+0x2],cs
0000118A  5B                pop bx
0000118B  58                pop ax
0000118C  07                pop es
;>>>> [interrupt setup / kernel-API] push es begins the INT 15h vector-hook block. The routine immediately does xor ax,ax / mov es,ax (ES=IVT seg 0), bx=0x15, shl bx,1 twice (bx=0x54 = 0x15*4), reads the existing far vector at [es:0x54]/[es:0x56] saving offset->[0x276] and segment->[0x278], then installs its own handler (offset 0x113F, CS) into the IVT. This is one of a series of identical hook blocks (INT 0Ch->0x1280 at 0x12A2, INT 0Eh->[0x27a] at 0x125D, INT 14h->0x1112 just above at 0x118A) that install the MFGTEST resident handlers. push es/push ax/push bx are the caller-save prologue of this block.  // 0x118D push es; 0x1190 xor ax,ax/mov es,ax; 0x1194 mov bx,0x15; 0x1197 shl bx,1 x2 -> 0x54; 0x119B read [es:bx]->[0x276], [es:bx+2]->[0x278]; later writes new offset 0x113F. Preceding block at 0x1181 wrote 0x1112/CS for INT 14h.
0000118D  06                push es
0000118E  50                push ax
0000118F  53                push bx
00001190  33C0              xor ax,ax
00001192  8EC0              mov es,ax
00001194  BB1500            mov bx,0x15
00001197  D1E3              shl bx,1
00001199  D1E3              shl bx,1
0000119B  268B07            mov ax,[es:bx]
0000119E  A37602            mov [0x276],ax
000011A1  268B4702          mov ax,[es:bx+0x2]
000011A5  A37802            mov [0x278],ax
000011A8  26C7073F11        mov word [es:bx],0x113f
000011AD  268C4F02          mov [es:bx+0x2],cs
000011B1  5B                pop bx
000011B2  58                pop ax
000011B3  07                pop es
000011B4  BA60FF            mov dx,0xff60
000011B7  ED                in ax,dx
000011B8  A37E02            mov [0x27e],ax
000011BB  BA64FF            mov dx,0xff64
000011BE  ED                in ax,dx
000011BF  A38002            mov [0x280],ax
000011C2  C3                ret
sub_011C3:
000011C3  06                push es
000011C4  50                push ax
000011C5  53                push bx
000011C6  33C0              xor ax,ax
000011C8  8EC0              mov es,ax
000011CA  BB1400            mov bx,0x14
000011CD  D1E3              shl bx,1
000011CF  D1E3              shl bx,1
000011D1  A17202            mov ax,[0x272]
000011D4  268907            mov [es:bx],ax
000011D7  A17402            mov ax,[0x274]
000011DA  26894702          mov [es:bx+0x2],ax
000011DE  5B                pop bx
000011DF  58                pop ax
000011E0  07                pop es
000011E1  06                push es
000011E2  50                push ax
000011E3  53                push bx
000011E4  33C0              xor ax,ax
000011E6  8EC0              mov es,ax
000011E8  BB1500            mov bx,0x15
000011EB  D1E3              shl bx,1
000011ED  D1E3              shl bx,1
000011EF  A17602            mov ax,[0x276]
000011F2  268907            mov [es:bx],ax
000011F5  A17802            mov ax,[0x278]
000011F8  26894702          mov [es:bx+0x2],ax
000011FC  5B                pop bx
;>>>> [timer/PCB-port] pop ax restoring a caller-saved register at the end of an IVT-install block: the preceding code zeroed ES, set BX=0x15<<2=0x54 (INT 15h vector) and stored [0x276]/[0x278] there. After the pop ax/pop es, the routine programs 80C188EB timer registers 0xFF60 (timer1 count from [0x27E]) and 0xFF64 (timer2 from [0x280]). So this line is register cleanup between hooking INT 15h and programming the timers.  // bx=0x15 shl 1 shl 1; mov [es:bx],ax / [es:bx+2]; pop bx / pop ax / pop es; then mov dx,0xff60 ... mov dx,0xff64 OUTs
000011FD  58                pop ax
000011FE  07                pop es
000011FF  BA60FF            mov dx,0xff60
00001202  A17E02            mov ax,[0x27e]
00001205  EF                out dx,ax
00001206  BA64FF            mov dx,0xff64
00001209  A18002            mov ax,[0x280]
0000120C  EF                out dx,ax
0000120D  C3                ret
0000120E  60                pusha
0000120F  1E                push ds
00001210  B83401            mov ax,0x134
00001213  8ED8              mov ds,ax
00001215  C606590201        mov byte [0x259],0x1
0000121A  BA02FF            mov dx,0xff02
0000121D  B80080            mov ax,0x8000
00001220  EF                out dx,ax
00001221  1F                pop ds
00001222  61                popa
00001223  CF                iret
hexprint_cksum_dispatch_01224:
00001224  06                push es
00001225  50                push ax
00001226  53                push bx
00001227  33C0              xor ax,ax
00001229  8EC0              mov es,ax
0000122B  BB0E00            mov bx,0xe
0000122E  D1E3              shl bx,1
00001230  D1E3              shl bx,1
00001232  268B07            mov ax,[es:bx]
00001235  A37A02            mov [0x27a],ax
00001238  268B4702          mov ax,[es:bx+0x2]
0000123C  A37C02            mov [0x27c],ax
0000123F  26C7070E12        mov word [es:bx],0x120e
00001244  268C4F02          mov [es:bx+0x2],cs
00001248  5B                pop bx
00001249  58                pop ax
0000124A  07                pop es
0000124B  BA1CFF            mov dx,0xff1c
0000124E  ED                in ax,dx
0000124F  A38602            mov [0x286],ax
00001252  BA1CFF            mov dx,0xff1c
00001255  B80700            mov ax,0x7
00001258  EF                out dx,ax
00001259  C3                ret
sub_0125A:
0000125A  06                push es
0000125B  50                push ax
0000125C  53                push bx
;>>>> [interrupt setup] xor ax,ax then mov es,ax sets ES=0 to address the real-mode IVT, preparing to install the INT 0Eh vector. Following code loads bx=0x0E, shifts left twice (bx=0x38 = 0x0E*4), and stores the far pointer from [0x27a]/[0x27c] into [es:0x38]/[es:0x3a]. INT 0Eh on the 80C188EB is typically a timer/INT-controller hardware vector; this hooks the handler whose far address was captured in the [0x27a] data table.  // 0x125F mov es,ax; 0x1261 mov bx,0xe; 0x1264/0x1266 shl bx,1 (twice => *4 = 0x38); 0x1268 mov ax,[0x27a] / 0x126B mov [es:bx],ax; 0x126E mov ax,[0x27c] / 0x1271 mov [es:bx+0x2],ax. Classic real-mode IVT vector install at physical 0:0x38.
0000125D  33C0              xor ax,ax
0000125F  8EC0              mov es,ax
00001261  BB0E00            mov bx,0xe
00001264  D1E3              shl bx,1
00001266  D1E3              shl bx,1
00001268  A17A02            mov ax,[0x27a]
0000126B  268907            mov [es:bx],ax
0000126E  A17C02            mov ax,[0x27c]
00001271  26894702          mov [es:bx+0x2],ax
;>>>> [interrupt setup] pop bx restores BX at the end of the INT 0Eh IVT-install block (matching the push bx that preceded the ES=0 / BX=0x0E<<2=0x38 setup at 0x125D-0x1266). The block stored the far handler pointer from [0x27a]/[0x27c] into [es:0x38]/[es:0x3a] (0x1268-0x1271). After pop bx/pop ax/pop es (0x1275-0x1277) the routine writes [0x286] out to PCB port 0xFF1C (0x1278) and returns. INT 0Eh on the 80C188EB is a timer/INT-controller hardware vector; this is the register cleanup after hooking it. Matches accepted 0x125D annotation.  // 0x1261 mov bx,0xe; shl bx,1 x2; 0x1268 mov ax,[0x27a]; 0x126B mov [es:bx],ax; 0x1275 pop bx; 0x1276 pop ax; 0x1277 pop es
00001275  5B                pop bx
00001276  58                pop ax
00001277  07                pop es
;>>>> [timer/PCB-port] mov dx,0xff1c sets DX to 80C188EB PCB I/O port 0xFF1C, then [0x286] is loaded into AX (0x127B) and written out (OUT DX,AX at 0x127E) before RET. 0xFF1C lies in the 80C186/188 PCB register window; this restores/programs a PCB control register (chip-select/refresh-class) with the saved value from data table [0x286]. It is the tail of the INT 0Eh hook routine (after the IVT writes at 0x1268-0x1271 and the pop sequence at 0x1275-0x1277).  // 0x1278 mov dx,0xff1c; 0x127B mov ax,[0x286]; 0x127E out dx,ax; 0x127F ret
00001278  BA1CFF            mov dx,0xff1c
0000127B  A18602            mov ax,[0x286]
0000127E  EF                out dx,ax
0000127F  C3                ret
00001280  60                pusha
00001281  1E                push ds
00001282  B83401            mov ax,0x134
00001285  8ED8              mov ds,ax
00001287  C606570201        mov byte [0x257],0x1
0000128C  E88D00            call sub_0131C   ; ->0x131C
0000128F  BA02FF            mov dx,0xff02
00001292  B80080            mov ax,0x8000
00001295  EF                out dx,ax
00001296  BA0103            mov dx,0x301
00001299  B80038            mov ax,0x3800
0000129C  E816FC            call init_00EB5   ; ->0xEB5
0000129F  1F                pop ds
000012A0  61                popa
000012A1  CF                iret
hexprint_cksum_dispatch_012A2:
000012A2  06                push es
000012A3  50                push ax
;>>>> [interrupt setup] push bx saves BX at entry of the IVT-install block that hooks INT 0Ch. The following code zeroes ES (0x12A5 xor ax,ax / mov es,ax) to address the real-mode IVT, sets BX=0x0C then shl bx,1 twice (=0x30 = 0x0C*4), saves the existing vector words to [0x26e]/[0x270] (0x12B0-0x12BA), and installs the new handler offset 0x1280 with CS as segment (0x12BD-0x12C2). INT 0Ch on the 80C188EB is a hardware interrupt vector; this captures the old vector and installs the MFGTEST handler at 0x1280.  // 0x12A4 push bx; 0x12A9 mov bx,0xc; 0x12AC/0x12AE shl bx,1; 0x12B0 mov ax,[es:bx]; 0x12B3 mov [0x26e],ax; 0x12BD mov word [es:bx],0x1280
000012A4  53                push bx
000012A5  33C0              xor ax,ax
000012A7  8EC0              mov es,ax
000012A9  BB0C00            mov bx,0xc
000012AC  D1E3              shl bx,1
000012AE  D1E3              shl bx,1
000012B0  268B07            mov ax,[es:bx]
000012B3  A36E02            mov [0x26e],ax
000012B6  268B4702          mov ax,[es:bx+0x2]
000012BA  A37002            mov [0x270],ax
000012BD  26C7078012        mov word [es:bx],0x1280
000012C2  268C4F02          mov [es:bx+0x2],cs
000012C6  5B                pop bx
000012C7  58                pop ax
000012C8  07                pop es
000012C9  BA18FF            mov dx,0xff18
000012CC  ED                in ax,dx
000012CD  A38402            mov [0x284],ax
000012D0  C3                ret
sub_012D1:
000012D1  06                push es
000012D2  50                push ax
000012D3  53                push bx
000012D4  33C0              xor ax,ax
000012D6  8EC0              mov es,ax
000012D8  BB0C00            mov bx,0xc
000012DB  D1E3              shl bx,1
000012DD  D1E3              shl bx,1
000012DF  A16E02            mov ax,[0x26e]
000012E2  268907            mov [es:bx],ax
000012E5  A17002            mov ax,[0x270]
000012E8  26894702          mov [es:bx+0x2],ax
000012EC  5B                pop bx
000012ED  58                pop ax
000012EE  07                pop es
000012EF  BA18FF            mov dx,0xff18
000012F2  A18402            mov ax,[0x284]
000012F5  EF                out dx,ax
000012F6  C3                ret
sub_012F7:
000012F7  BA0103            mov dx,0x301
000012FA  B000              mov al,0x0
000012FC  E8BBFB            call cksum_fread_00EBA   ; ->0xEBA
000012FF  A804              test al,0x4
00001301  7418              jz loc_0131B   ; ->0x131B
00001303  8B1EE501          mov bx,[0x1e5]
00001307  81FB3600          cmp bx,0x36
0000130B  730E              jnc loc_0131B   ; ->0x131B
0000130D  8A87AF01          mov al,[bx+0x1af]
00001311  BA0303            mov dx,0x303
00001314  EE                out dx,al
00001315  FF06E501          inc word [0x1e5]
00001319  EBDC              jmp short 0x12f7
loc_0131B:
0000131B  C3                ret
sub_0131C:
0000131C  BA0103            mov dx,0x301
0000131F  B000              mov al,0x0
00001321  E896FB            call cksum_fread_00EBA   ; ->0xEBA
00001324  A801              test al,0x1
00001326  7419              jz loc_01341   ; ->0x1341
00001328  BA0303            mov dx,0x303
0000132B  EC                in al,dx
0000132C  8B1E5502          mov bx,[0x255]
00001330  81FB3600          cmp bx,0x36
00001334  7305              jnc loc_0133B   ; ->0x133B
00001336  88871F02          mov [bx+0x21f],al
0000133A  43                inc bx
loc_0133B:
0000133B  891E5502          mov [0x255],bx
0000133F  EBDB              jmp short 0x131c
loc_01341:
00001341  C3                ret

; ---- 0x1342-0x134c DATA (10 B) ----
001342  00 00 00 00 00 00 00 00 00 00                    |..........|

; ---- 0x134c-0x136a STRING (30 B) ----
00134C  30 31 30 32 30 33 30 34 30 35 34 30 34 31 20 20  |01020304054041  |
00135C  20 20 20 20 20 20 20 20 20 20 20 20 20 20        |              |

; ---- 0x136a-0x136c CODE ----
0000136A  0000              add [bx+si],al

; ---- 0x136c-0x138a STRING (30 B) ----
00136C  32 36 32 37 32 38 34 32 34 33 34 34 34 35 20 20  |26272842434445  |
00137C  20 20 20 20 20 20 20 20 20 20 20 20 20 20        |              |

; ---- 0x138a-0x138c CODE ----
0000138A  0000              add [bx+si],al

; ---- 0x138c-0x13aa STRING (30 B) ----
00138C  34 36 34 37 34 38 34 39 35 30 35 31 20 20 20 20  |464748495051    |
00139C  20 20 20 20 20 20 20 20 20 20 20 20 20 20        |              |

; ---- 0x13aa-0x13ac CODE ----
000013AA  0000              add [bx+si],al

; ---- 0x13ac-0x13ca STRING (30 B) ----
0013AC  31 30 30 39 30 38 30 37 35 39 30 36 31 31 31 32  |1009080759061112|
0013BC  31 33 31 34 20 20 20 20 20 20 20 20 20 20        |1314          |

; ---- 0x13ca-0x13cc CODE ----
000013CA  0000              add [bx+si],al

; ---- 0x13cc-0x13ea STRING (30 B) ----
0013CC  31 35 31 36 31 37 31 38 31 39 32 30 32 31 32 32  |1516171819202122|
0013DC  32 33 32 34 32 35 20 20 20 20 20 20 20 20        |232425        |

; ---- 0x13ea-0x13ec CODE ----
000013EA  0000              add [bx+si],al

; ---- 0x13ec-0x140a STRING (30 B) ----
0013EC  32 39 33 30 20 20 20 20 20 20 20 20 20 20 20 20  |2930            |
0013FC  20 20 20 20 20 20 20 20 20 20 20 20 20 20        |              |

; ---- 0x140a-0x140c CODE ----
0000140A  0000              add [bx+si],al

; ---- 0x140c-0x142a STRING (30 B) ----
00140C  33 31 33 32 33 33 33 34 33 35 33 36 33 37 33 38  |3132333435363738|
00141C  33 39 20 20 20 20 20 20 20 20 20 20 20 20        |39            |

; ---- 0x142a-0x142c CODE ----
0000142A  0000              add [bx+si],al

; ---- 0x142c-0x144a STRING (30 B) ----
00142C  35 32 35 33 35 34 35 35 35 36 35 37 35 38 20 20  |52535455565758  |
00143C  20 20 20 20 20 20 20 20 20 20 20 20 20 20        |              |

; ---- 0x144a-0x144c CODE ----
0000144A  0000              add [bx+si],al

; ---- 0x144c-0x146a STRING (30 B) ----
00144C  36 30 20 20 20 20 20 20 20 20 20 20 20 20 20 20  |60              |
00145C  20 20 20 20 20 20 20 20 20 20 20 20 20 20        |              |

; ---- 0x146a-0x1470 DATA (6 B) ----
00146A  00 00 00 00 00 00                                |......|

; ---- 0x1470-0x147f CODE ----
00001470  3000              xor [bx+si],al
00001472  0C00              or al,0x0
00001474  0800              or [bx+si],al
00001476  0800              or [bx+si],al
00001478  0200              add al,[bx+si]
0000147A  4F                dec di
0000147B  1D004E            sbb ax,0x4e00
0000147E  00                db 0x00

; ---- 0x147f-0x14ef STRING (112 B) ----
00147F  3c 20 36 30 20 48 7a 20 20 20 20 20 20 20 37 32  |< 60 Hz       72|
00148F  20 48 7a 20 41 54 54 52 49 42 55 54 45 53 64 62  | Hz ATTRIBUTESdb|
00149F  20 71 70 20 64 62 20 71 70 20 64 62 49 44 45 4e  | qp db qp dbIDEN|
0014AF  54 49 46 49 43 41 54 49 4f 4e 4c 41 4e 20 41 64  |TIFICATIONLAN Ad|
0014BF  64 72 65 73 73 3a 30 31 32 33 34 35 36 37 38 39  |dress:0123456789|
0014CF  41 42 43 44 45 46 55 54 32 30 30 2d 32 20 30 2e  |ABCDEFUT200-2 0.|
0014DF  30 30 30 30 38 2f 33 31 2f 39 33 20 58 58 58 58  |00008/31/93 XXXX|

; ---- 0x14ef-0x1527 CODE ----
000014EF  00FF              add bh,bh
;>>>> [string/data] NOT code - data misdecoded by the disassembler. This region immediately follows the string block ending at 0x14EF (the 'UT200-2 0.0000 08/31/93 XXXX' identification string). The bytes 00 FF 01 02 04 08 10 20 40 80 ... form a power-of-two / bit-mask lookup table (single-set-bit values 0x01,0x02,...,0x80 with 0xFF/0x00 framing), of the kind used to build/index the per-test result bitmasks. 'add [bp+si],ax' / 'add al,0x8' are spurious decodings of these data bytes.  // 0x147f-0x14ef is an ASCII string block ('< 60 Hz ... XXXX'); at 0x14EF bytes are 00 FF 01 02 04 08 10 20 40 80 - a 1<<n bit table, repeating (00FF 0102 0408 ... visible again at 0x1501). Decodes as nonsensical add ops.
000014F1  0102              add [bp+si],ax
000014F3  0408              add al,0x8
000014F5  1020              adc [bx+si],ah
000014F7  40                inc ax
000014F8  80030C            add byte [bp+di],0xc
000014FB  30C0              xor al,al
000014FD  55                push bp
000014FE  AA                stosb
000014FF  55                push bp
00001500  AA                stosb
00001501  00FF              add bh,bh
00001503  0102              add [bp+si],ax
00001505  0408              add al,0x8
00001507  1020              adc [bx+si],ah
00001509  40                inc ax
0000150A  80030C            add byte [bp+di],0xc
0000150D  30C0              xor al,al
0000150F  55                push bp
00001510  AA                stosb
00001511  55                push bp
00001512  AA                stosb
00001513  00FF              add bh,bh
00001515  0102              add [bp+si],ax
00001517  0408              add al,0x8
00001519  1020              adc [bx+si],ah
0000151B  40                inc ax
0000151C  80030C            add byte [bp+di],0xc
0000151F  30C0              xor al,al
00001521  55                push bp
00001522  AA                stosb
00001523  55                push bp
00001524  AA                stosb
00001525  0000              add [bx+si],al

; ---- 0x1527-0x155d DATA (54 B) ----
001527  ee ee ee ee ee ee ee ee ee ee ee ee ee ee ee ee  |................|
001537  ee ee ee ee ee ee ee ee ee ee ee ee ee ee ee ee  |................|
001547  ee ee ee ee ee ee ee ee ee ee ee ee ee ee ee ee  |................|
001557  ee ee ee ee ee ee                                |......|

; ---- 0x155d-0x155f CODE ----
0000155D  0000              add [bx+si],al

; ---- 0x155f-0x15ca DATA (107 B) ----
00155F  ee ee ee ee ee ee ee ee ee ee ee ee ee ee ee ee  |................|
00156F  ee ee ee ee ee ee ee ee ee ee ee ee ee ee ee ee  |................|
00157F  ee ee ee ee ee ee ee ee ee ee ee ee ee ee ee ee  |................|
00158F  ee ee ee ee ee ee 00 00 00 00 00 00 00 00 00 00  |................|
00159F  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0015AF  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0015BF  00 00 00 00 00 00 00 00 00 00 00                 |...........|
