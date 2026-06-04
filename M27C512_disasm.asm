; LT300/UT200 terminal ROM - complete disassembly
; Decoder: ndisasm -b16 (16-bit real mode). Addresses = file offsets.
; Code/data separated by heuristic engine (see codedata_map.txt).
; CODE blocks disassembled inline; DATA blocks shown as hex+ASCII.
; FS = embedded-filesystem member, extracted to extracted_fs/ (disassemble
;      those .EXE images separately; shown here as payload preview).


; ---- 0x00000-0x000b4  erased (0xFF fill)  [H21] ----
00000000  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
00000010  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
00000020  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
00000030  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
00000040  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
00000050  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
00000060  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
00000070  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
00000080  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
00000090  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
000000A0  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
000000B0  ff ff ff ff                                      |....|

; ---- 0x000b4-0x000c6  module directory  [known] ----
000000B4  4d 46 47 54 45 53 54 2e 45 58 45 20 ca 17 00 00  |MFGTEST.EXE ....|
000000C4  00 03                                            |..|

; ---- 0x000c6-0x000d8  erased (0xFF fill)  [H21] ----
000000C6  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
000000D6  ff ff                                            |..|

; ---- 0x000d8-0x0011a  module directory  [known] ----
000000D8  43 4f 4e 46 49 47 2e 53 59 53 20 20 01 00 00 00  |CONFIG.SYS  ....|
000000E8  00 02 43 4f 4e 46 49 47 2e 42 4c 4b 20 20 58 03  |..CONFIG.BLK  X.|
000000F8  00 00 80 01 45 4d 55 4c 41 54 4f 52 2e 45 58 45  |....EMULATOR.EXE|
00000108  94 04 00 00 00 01 44 4f 57 4e 4c 4f 41 44 2e 45  |......DOWNLOAD.E|
00000118  58 45                                            |XE|

; ==== 0x0011a-0x00120  CODE (linear/orphan, conf 80) ====
0000011A  FA                cli
0000011B  07                pop es
0000011C  0000              add [bx+si],al
0000011E  80                db 0x80
0000011F  00                db 0x00

; ---- 0x00120-0x00800  erased (0xFF fill)  [H21] ----
00000120  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
00000130  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
00000140  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
00000150  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
00000160  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
00000170  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
00000180  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
00000190  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
000001A0  ... (1632 more bytes)

; ==== 0x00800-0x00ffa  FS member DOWNLOAD.EXE (2042 B) -> extracted_fs/DOWNLOAD.EXE ====
00000800  4d 5a fa 01 04 00 01 00 20 00 41 00 ff ff 60 00  |MZ...... .A...`.|
00000810  00 04 03 eb 00 00 00 00 1e 00 00 00 01 00 02 00  |................|
00000820  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
00000830  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
00000840  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
00000850  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
00000860  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
00000870  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
00000880  ... (1914 more bytes)

; ---- 0x00ffa-0x01000  erased (0xFF fill)  [H21] ----
00000FFA  ff ff ff ff ff ff                                |......|

; ==== 0x01000-0x01494  FS member EMULATOR.EXE (1172 B) -> extracted_fs/EMULATOR.EXE ====
00001000  4d 5a 94 00 03 00 01 00 20 00 41 00 ff ff 2a 00  |MZ...... .A...*.|
00001010  00 04 2f e3 00 00 00 00 1e 00 00 00 01 00 02 00  |../.............|
00001020  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
00001030  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
00001040  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
00001050  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
00001060  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
00001070  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
00001080  ... (1044 more bytes)

; ---- 0x01494-0x01800  erased (0xFF fill)  [H21] ----
00001494  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
000014A4  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
000014B4  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
000014C4  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
000014D4  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
000014E4  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
000014F4  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
00001504  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
00001514  ... (748 more bytes)

; ==== 0x01800-0x01b58  FS member CONFIG.BLK (856 B) -> extracted_fs/CONFIG.BLK ====
00001800  20 00 43 00 00 00 51 00 91 00 00 00 00 00 00 00  | .C...Q.........|
00001810  19 01 26 01 33 01 40 01 00 00 4d 01 9e 01 57 03  |..&.3.@...M...W.|
00001820  31 0d 05 01 00 0f 06 00 00 03 08 02 01 03 01 11  |1...............|
00001830  13 00 00 02 01 01 00 00 00 00 3a 17 58 03 10 00  |..........:.X...|
00001840  00 00 00 00 00 00 00 00 00 00 00 00 21 00 00 00  |............!...|
00001850  00 00 00 01 00 01 00 80 80 80 80 80 80 80 80 80  |................|
00001860  80 80 80 80 80 80 80 80 88 78 40 00 20 20 20 20  |.........x@.    |
00001870  20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20  |                |
00001880  ... (728 more bytes)

; ---- 0x01b58-0x02000  erased (0xFF fill)  [H21] ----
00001B58  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
00001B68  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
00001B78  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
00001B88  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
00001B98  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
00001BA8  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
00001BB8  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
00001BC8  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
00001BD8  ... (1064 more bytes)

; ==== 0x02000-0x02001  FS member CONFIG.SYS (1 B) -> extracted_fs/CONFIG.SYS ====
00002000  1a                                               |.|

; ---- 0x02001-0x03000  erased (0xFF fill)  [H21] ----
00002001  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
00002011  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
00002021  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
00002031  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
00002041  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
00002051  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
00002061  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
00002071  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
00002081  ... (3967 more bytes)

; ==== 0x03000-0x047ca  FS member MFGTEST.EXE (6090 B) -> extracted_fs/MFGTEST.EXE ====
00003000  4d 5a ca 01 0c 00 05 00 20 00 41 00 ff ff 5d 01  |MZ...... .A...].|
00003010  00 04 b2 be 00 00 00 00 1e 00 00 00 01 00 02 00  |................|
00003020  00 00 15 11 00 00 42 11 00 00 11 12 00 00 83 12  |......B.........|
00003030  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
00003040  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
00003050  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
00003060  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
00003070  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
00003080  ... (5962 more bytes)

; ---- 0x047ca-0x06000  erased (0xFF fill)  [H21] ----
000047CA  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
000047DA  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
000047EA  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
000047FA  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
0000480A  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
0000481A  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
0000482A  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
0000483A  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
0000484A  ... (6070 more bytes)

; ==== 0x06000-0x074d6  CODE (CF-reached, conf 99) ====
00006000  E90F0F            jmp 0x6f12
00006003  00EB              add bl,ch
00006005  06                push es
00006006  55                push bp
00006007  55                push bp
00006008  E45D              in al,0x5d
0000600A  00F6              add dh,dh
0000600C  C8000000          enter 0x0,0x0
00006010  60                pusha
00006011  1E                push ds
00006012  06                push es
00006013  B84000            mov ax,0x40
00006016  8ED8              mov ds,ax
00006018  A0B907            mov al,[0x7b9]
0000601B  BA4303            mov dx,0x343
0000601E  24BF              and al,0xbf
00006020  EE                out dx,al
00006021  A1BA07            mov ax,[0x7ba]
00006024  A37809            mov [0x978],ax
00006027  BA9400            mov dx,0x94
0000602A  B409              mov ah,0x9
0000602C  CD21              int 0x21
0000602E  8B4604            mov ax,[bp+0x4]
00006031  E80501            call 0x6139
00006034  B402              mov ah,0x2
00006036  B23A              mov dl,0x3a
00006038  CD21              int 0x21
0000603A  8B4602            mov ax,[bp+0x2]
0000603D  E8F900            call 0x6139
00006040  BAB300            mov dx,0xb3
00006043  B409              mov ah,0x9
00006045  CD21              int 0x21
00006047  BEAB00            mov si,0xab
0000604A  03361409          add si,[0x914]
0000604E  B90C00            mov cx,0xc
00006051  AC                lodsb
00006052  84C0              test al,al
00006054  7408              jz 0x605e
00006056  8AD0              mov dl,al
00006058  B402              mov ah,0x2
0000605A  CD21              int 0x21
0000605C  E2F3              loop 0x6051
0000605E  BAC300            mov dx,0xc3
00006061  B409              mov ah,0x9
00006063  CD21              int 0x21
00006065  8B46FE            mov ax,[bp-0x2]
00006068  E8CE00            call 0x6139
0000606B  BAD300            mov dx,0xd3
0000606E  B409              mov ah,0x9
00006070  CD21              int 0x21
00006072  8B46F8            mov ax,[bp-0x8]
00006075  E8C100            call 0x6139
00006078  BADB00            mov dx,0xdb
0000607B  B409              mov ah,0x9
0000607D  CD21              int 0x21
0000607F  8B46FC            mov ax,[bp-0x4]
00006082  E8B400            call 0x6139
00006085  BAE300            mov dx,0xe3
00006088  B409              mov ah,0x9
0000608A  CD21              int 0x21
0000608C  8B46FA            mov ax,[bp-0x6]
0000608F  E8A700            call 0x6139
00006092  BAEB00            mov dx,0xeb
00006095  B409              mov ah,0x9
00006097  CD21              int 0x21
00006099  8B46F2            mov ax,[bp-0xe]
0000609C  E89A00            call 0x6139
0000609F  BAF200            mov dx,0xf2
000060A2  B409              mov ah,0x9
000060A4  CD21              int 0x21
000060A6  8B46F0            mov ax,[bp-0x10]
000060A9  E88D00            call 0x6139
000060AC  BAFA00            mov dx,0xfa
000060AF  B409              mov ah,0x9
000060B1  CD21              int 0x21
000060B3  8BC5              mov ax,bp
000060B5  050800            add ax,0x8
000060B8  8BF0              mov si,ax
000060BA  E87C00            call 0x6139
000060BD  BA0201            mov dx,0x102
000060C0  B409              mov ah,0x9
000060C2  CD21              int 0x21
000060C4  8B4600            mov ax,[bp+0x0]
000060C7  E86F00            call 0x6139
000060CA  BA0A01            mov dx,0x10a
000060CD  B409              mov ah,0x9
000060CF  CD21              int 0x21
000060D1  8B46EE            mov ax,[bp-0x12]
000060D4  E86200            call 0x6139
000060D7  BA1101            mov dx,0x111
000060DA  B409              mov ah,0x9
000060DC  CD21              int 0x21
000060DE  8B46EC            mov ax,[bp-0x14]
000060E1  E85500            call 0x6139
000060E4  BA1901            mov dx,0x119
000060E7  B409              mov ah,0x9
000060E9  CD21              int 0x21
000060EB  8CD0              mov ax,ss
000060ED  E84900            call 0x6139
000060F0  BA2101            mov dx,0x121
000060F3  B409              mov ah,0x9
000060F5  CD21              int 0x21
000060F7  8B4606            mov ax,[bp+0x6]
000060FA  E83C00            call 0x6139
000060FD  BA2C01            mov dx,0x12c
00006100  B409              mov ah,0x9
00006102  CD21              int 0x21
00006104  BF0800            mov di,0x8
00006107  8CD0              mov ax,ss
00006109  E82D00            call 0x6139
0000610C  B402              mov ah,0x2
0000610E  B23A              mov dl,0x3a
00006110  CD21              int 0x21
00006112  8BC6              mov ax,si
00006114  E82200            call 0x6139
00006117  B402              mov ah,0x2
00006119  B220              mov dl,0x20
0000611B  CD21              int 0x21
0000611D  B90800            mov cx,0x8
00006120  B402              mov ah,0x2
00006122  B220              mov dl,0x20
00006124  CD21              int 0x21
00006126  36AD              ss lodsw
00006128  E80E00            call 0x6139
0000612B  E2F3              loop 0x6120
0000612D  BA2D01            mov dx,0x12d
00006130  B409              mov ah,0x9
00006132  CD21              int 0x21
00006134  4F                dec di
00006135  75D0              jnz 0x6107
00006137  EBFE              jmp short 0x6137
00006139  51                push cx
0000613A  52                push dx
0000613B  57                push di
0000613C  B90400            mov cx,0x4
0000613F  BB8400            mov bx,0x84
00006142  C1C004            rol ax,byte 0x4
00006145  50                push ax
00006146  240F              and al,0xf
00006148  D7                xlatb
00006149  8AD0              mov dl,al
0000614B  B402              mov ah,0x2
0000614D  CD21              int 0x21
0000614F  58                pop ax
00006150  E2F0              loop 0x6142
00006152  5F                pop di
00006153  5A                pop dx
00006154  59                pop cx
00006155  C3                ret
00006156  8706F904          xchg ax,[0x4f9]
0000615A  2F                das
0000615B  05E502            add ax,0x2e5
0000615E  1807              sbb [bx],al
00006160  96                xchg ax,si
00006161  0219              add bl,[bx+di]
00006163  080C              or [si],cl
00006165  024C06            add cl,[si+0x6]
00006168  1B05              sbb ax,[di]
0000616A  E101              loope 0x616d
0000616C  CB                retf
0000616D  01AC02EC          add [si-0x13fe],bp
00006171  02B306E7          add dh,[bp+di-0x18fa]
00006175  039602D5          add dx,[bp-0x2afe]
00006179  0496              add al,0x96
0000617B  0217              add dl,[bx]
0000617D  06                push es
0000617E  FA                cli
0000617F  03E4              add sp,sp
00006181  05FA04            add ax,0x4fa
00006184  B105              mov cl,0x5
00006186  B102              mov cl,0x2
00006188  830CC8            or word [si],byte -0x38
0000618B  07                pop es
0000618C  CB                retf
0000618D  01CB              add bx,cx
0000618F  01CB              add bx,cx
00006191  01CB              add bx,cx
00006193  01CB              add bx,cx
00006195  013C              add [si],di
00006197  0D7413            or ax,0x1374
0000619A  3C08              cmp al,0x8
0000619C  740F              jz 0x61ad
0000619E  3C07              cmp al,0x7
000061A0  740B              jz 0x61ad
000061A2  3C00              cmp al,0x0
000061A4  7407              jz 0x61ad
000061A6  833E300103        cmp word [0x130],byte +0x3
000061AB  750E              jnz 0x61bb
000061AD  8AD8              mov bl,al
000061AF  32FF              xor bh,bh
000061B1  03DB              add bx,bx
000061B3  2EFFA75601        jmp [cs:bx+0x156]
000061B8  0A17              or dl,[bx]
000061BA  0CBB              or al,0xbb
000061BC  B80103            mov ax,0x301
000061BF  1E                push ds
000061C0  3001              xor [bx+di],al
000061C2  2E3A07            cmp al,[cs:bx]
000061C5  7512              jnz 0x61d9
000061C7  FF063001          inc word [0x130]
000061CB  50                push ax
000061CC  B85E0E            mov ax,0xe5e
000061CF  CD10              int 0x10
000061D1  58                pop ax
000061D2  0440              add al,0x40
000061D4  B40E              mov ah,0xe
000061D6  CD10              int 0x10
000061D8  C3                ret
000061D9  C70630010000      mov word [0x130],0x0
000061DF  EBEA              jmp short 0x61cb
000061E1  C70630010100      mov word [0x130],0x1
000061E7  EBE2              jmp short 0x61cb
000061E9  8B3ECE01          mov di,[0x1ce]
000061ED  81FF7301          cmp di,0x173
000061F1  7307              jnc 0x61fa
000061F3  8805              mov [di],al
000061F5  47                inc di
000061F6  893ECE01          mov [0x1ce],di
000061FA  BF00C0            mov di,0xc000
000061FD  8EC7              mov es,di
000061FF  8B3ED001          mov di,[0x1d0]
00006203  AA                stosb
00006204  83E70F            and di,byte +0xf
00006207  893ED001          mov [0x1d0],di
0000620B  C3                ret
0000620C  1E                push ds
0000620D  0E                push cs
0000620E  1F                pop ds
0000620F  BAF814            mov dx,0x14f8
00006212  B409              mov ah,0x9
00006214  CD21              int 0x21
00006216  1F                pop ds
00006217  BA4207            mov dx,0x742
0000621A  B409              mov ah,0x9
0000621C  CD21              int 0x21
0000621E  33D2              xor dx,dx
00006220  B426              mov ah,0x26
00006222  CD40              int 0x40
00006224  80C230            add dl,0x30
00006227  B402              mov ah,0x2
00006229  CD21              int 0x21
0000622B  B22E              mov dl,0x2e
0000622D  B402              mov ah,0x2
0000622F  CD21              int 0x21
00006231  8AC6              mov al,dh
00006233  32E4              xor ah,ah
00006235  B664              mov dh,0x64
00006237  F6F6              div dh
00006239  0430              add al,0x30
0000623B  8AD0              mov dl,al
0000623D  50                push ax
0000623E  B402              mov ah,0x2
00006240  CD21              int 0x21
00006242  58                pop ax
00006243  8AC4              mov al,ah
00006245  32E4              xor ah,ah
00006247  B60A              mov dh,0xa
00006249  F6F6              div dh
0000624B  0430              add al,0x30
0000624D  8AD0              mov dl,al
0000624F  50                push ax
00006250  B402              mov ah,0x2
00006252  CD21              int 0x21
00006254  58                pop ax
00006255  8AD4              mov dl,ah
00006257  80C230            add dl,0x30
0000625A  B402              mov ah,0x2
0000625C  CD21              int 0x21
0000625E  BA4F07            mov dx,0x74f
00006261  B409              mov ah,0x9
00006263  CD21              int 0x21
00006265  B800E0            mov ax,0xe000
00006268  E81B00            call 0x6286
0000626B  8BEA              mov bp,dx
0000626D  B800F0            mov ax,0xf000
00006270  E81300            call 0x6286
00006273  3BEA              cmp bp,dx
00006275  7402              jz 0x6279
00006277  03D5              add dx,bp
00006279  8BC2              mov ax,dx
0000627B  E89009            call 0x6c0e
0000627E  BA5E07            mov dx,0x75e
00006281  B409              mov ah,0x9
00006283  CD21              int 0x21
00006285  C3                ret
00006286  1E                push ds
00006287  8ED8              mov ds,ax
00006289  33C9              xor cx,cx
0000628B  8BD1              mov dx,cx
0000628D  8BC1              mov ax,cx
0000628F  AC                lodsb
00006290  03D0              add dx,ax
00006292  E2FB              loop 0x628f
00006294  1F                pop ds
00006295  C3                ret
00006296  A2D201            mov [0x1d2],al
00006299  B86701            mov ax,0x167
0000629C  A3CE01            mov [0x1ce],ax
0000629F  BAD301            mov dx,0x1d3
000062A2  B409              mov ah,0x9
000062A4  CD21              int 0x21
000062A6  C3                ret
000062A7  BA3601            mov dx,0x136
000062AA  EB08              jmp short 0x62b4
000062AC  BA5A01            mov dx,0x15a
000062AF  EB03              jmp short 0x62b4
000062B1  BA4D01            mov dx,0x14d
000062B4  C606730801        mov byte [0x873],0x1
000062B9  E8F811            call 0x74b4
000062BC  1E                push ds
000062BD  07                pop es
000062BE  BBC001            mov bx,0x1c0
000062C1  B8004B            mov ax,0x4b00
000062C4  CD21              int 0x21
000062C6  730C              jnc 0x62d4
000062C8  50                push ax
000062C9  BACF02            mov dx,0x2cf
000062CC  B409              mov ah,0x9
000062CE  CD21              int 0x21
000062D0  58                pop ax
000062D1  E83A09            call 0x6c0e
000062D4  BAE602            mov dx,0x2e6
000062D7  B409              mov ah,0x9
000062D9  CD21              int 0x21
000062DB  C606730800        mov byte [0x873],0x0
000062E0  C3                ret
000062E1  E8F23B            call 0x9ed6
000062E4  C3                ret
000062E5  C606D20100        mov byte [0x1d2],0x0
000062EA  B00D              mov al,0xd
000062EC  833E300103        cmp word [0x130],byte +0x3
000062F1  750F              jnz 0x6302
000062F3  80FC32            cmp ah,0x32
000062F6  74E9              jz 0x62e1
000062F8  80FCAD            cmp ah,0xad
000062FB  74E4              jz 0x62e1
000062FD  80FCBB            cmp ah,0xbb
00006300  74DF              jz 0x62e1
00006302  B40E              mov ah,0xe
00006304  CD10              int 0x10
00006306  B00A              mov al,0xa
00006308  B40E              mov ah,0xe
0000630A  CD10              int 0x10
0000630C  32C0              xor al,al
0000630E  3806D201          cmp [0x1d2],al
00006312  74D0              jz 0x62e4
00006314  8B3ECE01          mov di,[0x1ce]
00006318  8805              mov [di],al
0000631A  BA6701            mov dx,0x167
0000631D  8606D201          xchg al,[0x1d2]
00006321  3C05              cmp al,0x5
00006323  748F              jz 0x62b4
00006325  3C08              cmp al,0x8
00006327  7490              jz 0x62b9
00006329  3C10              cmp al,0x10
0000632B  758F              jnz 0x62bc
0000632D  B8003D            mov ax,0x3d00
00006330  CD21              int 0x21
00006332  7308              jnc 0x633c
00006334  BA9902            mov dx,0x299
00006337  B409              mov ah,0x9
00006339  CD21              int 0x21
0000633B  C3                ret
0000633C  A33201            mov [0x132],ax
0000633F  BE4A0A            mov si,0xa4a
00006342  E87000            call 0x63b5
00006345  3C05              cmp al,0x5
00006347  7411              jz 0x635a
00006349  3C08              cmp al,0x8
0000634B  740D              jz 0x635a
0000634D  3C12              cmp al,0x12
0000634F  7409              jz 0x635a
00006351  3C1A              cmp al,0x1a
00006353  7444              jz 0x6399
00006355  BAB702            mov dx,0x2b7
00006358  EBDD              jmp short 0x6337
0000635A  A2D201            mov [0x1d2],al
0000635D  BAD301            mov dx,0x1d3
00006360  B409              mov ah,0x9
00006362  CD21              int 0x21
00006364  1E                push ds
00006365  07                pop es
00006366  BF6701            mov di,0x167
00006369  E84900            call 0x63b5
0000636C  3C20              cmp al,0x20
0000636E  720D              jc 0x637d
00006370  81FF7301          cmp di,0x173
00006374  73F3              jnc 0x6369
00006376  AA                stosb
00006377  B40E              mov ah,0xe
00006379  CD10              int 0x10
0000637B  EBEC              jmp short 0x6369
0000637D  893ECE01          mov [0x1ce],di
00006381  56                push si
00006382  B80D00            mov ax,0xd
00006385  E864FF            call 0x62ec
00006388  E81C00            call 0x63a7
0000638B  5E                pop si
0000638C  E82600            call 0x63b5
0000638F  3C0A              cmp al,0xa
00006391  74F9              jz 0x638c
00006393  3C0D              cmp al,0xd
00006395  74F5              jz 0x638c
00006397  EBAC              jmp short 0x6345
00006399  8B1E3201          mov bx,[0x132]
0000639D  B8003E            mov ax,0x3e00
000063A0  CD21              int 0x21
000063A2  C3                ret
000063A3  B400              mov ah,0x0
000063A5  CD40              int 0x40
000063A7  803E740800        cmp byte [0x874],0x0
000063AC  75F5              jnz 0x63a3
000063AE  C3                ret
000063AF  BA4201            mov dx,0x142
000063B2  E978FF            jmp 0x632d
000063B5  81FE4A0A          cmp si,0xa4a
000063B9  7302              jnc 0x63bd
000063BB  AC                lodsb
000063BC  C3                ret
000063BD  BECA09            mov si,0x9ca
000063C0  8BD6              mov dx,si
000063C2  B98000            mov cx,0x80
000063C5  8B1E3201          mov bx,[0x132]
000063C9  B8003F            mov ax,0x3f00
000063CC  CD21              int 0x21
000063CE  7302              jnc 0x63d2
000063D0  33C0              xor ax,ax
000063D2  57                push di
000063D3  8BFE              mov di,si
000063D5  03F8              add di,ax
000063D7  B98000            mov cx,0x80
000063DA  2BC8              sub cx,ax
000063DC  7406              jz 0x63e4
000063DE  1E                push ds
000063DF  07                pop es
000063E0  B01A              mov al,0x1a
000063E2  F3AA              rep stosb
000063E4  5F                pop di
000063E5  EBCE              jmp short 0x63b5
000063E7  33C0              xor ax,ax
000063E9  BBDE18            mov bx,0x18de
000063EC  894708            mov [bx+0x8],ax
000063EF  81C3B800          add bx,0xb8
000063F3  81FB5E24          cmp bx,0x245e
000063F7  72F3              jc 0x63ec
000063F9  C3                ret
000063FA  BBDE18            mov bx,0x18de
000063FD  33C0              xor ax,ax
000063FF  8BD0              mov dx,ax
00006401  034708            add ax,[bx+0x8]
00006404  83D200            adc dx,byte +0x0
00006407  81C3B800          add bx,0xb8
0000640B  81FB5E24          cmp bx,0x245e
0000640F  72F0              jc 0x6401
00006411  C1E806            shr ax,byte 0x6
00006414  C1CA06            ror dx,byte 0x6
00006417  0BC2              or ax,dx
00006419  7503              jnz 0x641e
0000641B  B80100            mov ax,0x1
0000641E  A33401            mov [0x134],ax
00006421  BBDE18            mov bx,0x18de
00006424  BA2031            mov dx,0x3120
00006427  80BFA70000        cmp byte [bx+0xa7],0x0
0000642C  7515              jnz 0x6443
0000642E  81C3B800          add bx,0xb8
00006432  FEC6              inc dh
00006434  80FE39            cmp dh,0x39
00006437  7603              jna 0x643c
00006439  BA3130            mov dx,0x3031
0000643C  81FB5E24          cmp bx,0x245e
00006440  72E5              jc 0x6427
00006442  C3                ret
00006443  52                push dx
00006444  B402              mov ah,0x2
00006446  CD21              int 0x21
00006448  86D6              xchg dl,dh
0000644A  B402              mov ah,0x2
0000644C  CD21              int 0x21
0000644E  B23A              mov dl,0x3a
00006450  B402              mov ah,0x2
00006452  CD21              int 0x21
00006454  B220              mov dl,0x20
00006456  B402              mov ah,0x2
00006458  CD21              int 0x21
0000645A  8B4704            mov ax,[bx+0x4]
0000645D  E8AE07            call 0x6c0e
00006460  B220              mov dl,0x20
00006462  B402              mov ah,0x2
00006464  CD21              int 0x21
00006466  8DB7AB00          lea si,[bx+0xab]
0000646A  B90C00            mov cx,0xc
0000646D  AC                lodsb
0000646E  84C0              test al,al
00006470  7503              jnz 0x6475
00006472  B020              mov al,0x20
00006474  4E                dec si
00006475  8AD0              mov dl,al
00006477  B402              mov ah,0x2
00006479  CD21              int 0x21
0000647B  E2F0              loop 0x646d
0000647D  8A87A700          mov al,[bx+0xa7]
00006481  BA2902            mov dx,0x229
00006484  84C0              test al,al
00006486  780A              js 0x6492
00006488  BA3702            mov dx,0x237
0000648B  3C02              cmp al,0x2
0000648D  7403              jz 0x6492
0000648F  BA1B02            mov dx,0x21b
00006492  B409              mov ah,0x9
00006494  CD21              int 0x21
00006496  E8153A            call 0x9eae
00006499  C1C004            rol ax,byte 0x4
0000649C  BA0F00            mov dx,0xf
0000649F  23D0              and dx,ax
000064A1  25F0FF            and ax,0xfff0
000064A4  E88407            call 0x6c2b
000064A7  BA4502            mov dx,0x245
000064AA  B409              mov ah,0x9
000064AC  CD21              int 0x21
000064AE  8B4708            mov ax,[bx+0x8]
000064B1  33D2              xor dx,dx
000064B3  F7363401          div word [0x134]
000064B7  3D2000            cmp ax,0x20
000064BA  7203              jc 0x64bf
000064BC  B82000            mov ax,0x20
000064BF  8BC8              mov cx,ax
000064C1  E307              jcxz 0x64ca
000064C3  B82A0E            mov ax,0xe2a
000064C6  CD10              int 0x10
000064C8  E2F9              loop 0x64c3
000064CA  BAF801            mov dx,0x1f8
000064CD  B409              mov ah,0x9
000064CF  CD21              int 0x21
000064D1  5A                pop dx
000064D2  E959FF            jmp 0x642e
000064D5  BE3C05            mov si,0x53c
000064D8  B402              mov ah,0x2
000064DA  33D2              xor dx,dx
000064DC  CD17              int 0x17
000064DE  50                push ax
000064DF  E83207            call 0x6c14
000064E2  58                pop ax
000064E3  80F480            xor ah,0x80
000064E6  F6C4A9            test ah,0xa9
000064E9  75ED              jnz 0x64d8
000064EB  AC                lodsb
000064EC  3C24              cmp al,0x24
000064EE  7408              jz 0x64f8
000064F0  32E4              xor ah,ah
000064F2  33D2              xor dx,dx
000064F4  CD17              int 0x17
000064F6  EBE0              jmp short 0x64d8
000064F8  C3                ret
000064F9  C3                ret
000064FA  8036AF0701        xor byte [0x7af],0x1
000064FF  BAFB06            mov dx,0x6fb
00006502  803EAF0700        cmp byte [0x7af],0x0
00006507  7503              jnz 0x650c
00006509  BAE106            mov dx,0x6e1
0000650C  B409              mov ah,0x9
0000650E  CD21              int 0x21
00006510  B80700            mov ax,0x7
00006513  CD10              int 0x10
00006515  C606850901        mov byte [0x985],0x1
0000651A  C3                ret
0000651B  8036870902        xor byte [0x987],0x2
00006520  803E870902        cmp byte [0x987],0x2
00006525  BA1507            mov dx,0x715
00006528  75E2              jnz 0x650c
0000652A  BA2C07            mov dx,0x72c
0000652D  EBDD              jmp short 0x650c
0000652F  BA8102            mov dx,0x281
00006532  B409              mov ah,0x9
00006534  CD21              int 0x21
00006536  A0AA07            mov al,[0x7aa]
00006539  FEC0              inc al
0000653B  3C0A              cmp al,0xa
0000653D  7202              jc 0x6541
0000653F  32C0              xor al,al
00006541  A2AA07            mov [0x7aa],al
00006544  50                push ax
00006545  E86444            call 0xa9ac
00006548  58                pop ax
00006549  1E                push ds
0000654A  0E                push cs
0000654B  1F                pop ds
0000654C  BBA705            mov bx,0x5a7
0000654F  D7                xlatb
00006550  32E4              xor ah,ah
00006552  BA5D05            mov dx,0x55d
00006555  03D0              add dx,ax
00006557  B409              mov ah,0x9
00006559  CD21              int 0x21
0000655B  1F                pop ds
0000655C  C3                ret
0000655D  3330              xor si,[bx+si]
0000655F  300D              xor [di],cl
00006561  0A24              or ah,[si]
00006563  3132              xor [bp+si],si
00006565  3030              xor [bx+si],dh
00006567  0D0A24            or ax,0x240a
0000656A  3234              xor dh,[si]
0000656C  3030              xor [bx+si],dh
0000656E  0D0A24            or ax,0x240a
00006571  3438              xor al,0x38
00006573  3030              xor [bx+si],dh
00006575  0D0A24            or ax,0x240a
00006578  39363030          cmp [0x3030],si
0000657C  0D0A24            or ax,0x240a
0000657F  3134              xor [si],si
00006581  3430              xor al,0x30
00006583  300D              xor [di],cl
00006585  0A24              or ah,[si]
00006587  3139              xor [bx+di],di
00006589  3230              xor dh,[bx+si]
0000658B  300D              xor [di],cl
0000658D  0A24              or ah,[si]
0000658F  3238              xor bh,[bx+si]
00006591  3830              cmp [bx+si],dh
00006593  300D              xor [di],cl
00006595  0A24              or ah,[si]
00006597  3338              xor di,[bx+si]
00006599  3430              xor al,0x30
0000659B  300D              xor [di],cl
0000659D  0A24              or ah,[si]
0000659F  353630            xor ax,0x3036
000065A2  3030              xor [bx+si],dh
000065A4  0D0A24            or ax,0x240a
000065A7  00060D14          add [0x140d],al
000065AB  1B22              sbb sp,[bp+si]
000065AD  2A32              sub dh,[bp+si]
000065AF  3A42FE            cmp al,[bp+si-0x2]
000065B2  06                push es
000065B3  250580            and ax,0x8005
000065B6  3E25050A          ds and ax,0xa05
000065BA  7205              jc 0x65c1
000065BC  C606250500        mov byte [0x525],0x0
000065C1  BA8CFF            mov dx,0xff8c
000065C4  B800D0            mov ax,0xd000
000065C7  02062505          add al,[0x525]
000065CB  EE                out dx,al
000065CC  BA1105            mov dx,0x511
000065CF  B409              mov ah,0x9
000065D1  CD21              int 0x21
000065D3  B8300E            mov ax,0xe30
000065D6  02062505          add al,[0x525]
000065DA  CD10              int 0x10
000065DC  BAF801            mov dx,0x1f8
000065DF  B409              mov ah,0x9
000065E1  CD21              int 0x21
000065E3  C3                ret
000065E4  FE063B05          inc byte [0x53b]
000065E8  803E3B050A        cmp byte [0x53b],0xa
000065ED  7205              jc 0x65f4
000065EF  C6063B0500        mov byte [0x53b],0x0
000065F4  BA88FF            mov dx,0xff88
000065F7  B800C0            mov ax,0xc000
000065FA  02063B05          add al,[0x53b]
000065FE  EE                out dx,al
000065FF  BA2605            mov dx,0x526
00006602  B409              mov ah,0x9
00006604  CD21              int 0x21
00006606  B8300E            mov ax,0xe30
00006609  02063B05          add al,[0x53b]
0000660D  CD10              int 0x10
0000660F  BAF801            mov dx,0x1f8
00006612  B409              mov ah,0x9
00006614  CD21              int 0x21
00006616  C3                ret
00006617  BA4303            mov dx,0x343
0000661A  FA                cli
0000661B  A0B907            mov al,[0x7b9]
0000661E  8AE0              mov ah,al
00006620  FEC0              inc al
00006622  2507F8            and ax,0xf807
00006625  0AC4              or al,ah
00006627  A2B907            mov [0x7b9],al
0000662A  EE                out dx,al
0000662B  FB                sti
0000662C  50                push ax
0000662D  BA9505            mov dx,0x595
00006630  A804              test al,0x4
00006632  7403              jz 0x6637
00006634  BAB905            mov dx,0x5b9
00006637  B409              mov ah,0x9
00006639  CD21              int 0x21
0000663B  58                pop ax
0000663C  2403              and al,0x3
0000663E  0430              add al,0x30
00006640  B40E              mov ah,0xe
00006642  CD10              int 0x10
00006644  BAF801            mov dx,0x1f8
00006647  B409              mov ah,0x9
00006649  CD21              int 0x21
0000664B  C3                ret
0000664C  833E300103        cmp word [0x130],byte +0x3
00006651  7505              jnz 0x6658
00006653  80FC23            cmp ah,0x23
00006656  742C              jz 0x6684
00006658  B40E              mov ah,0xe
0000665A  CD10              int 0x10
0000665C  B020              mov al,0x20
0000665E  B40E              mov ah,0xe
00006660  CD10              int 0x10
00006662  B008              mov al,0x8
00006664  B40E              mov ah,0xe
00006666  CD10              int 0x10
00006668  8B1ECE01          mov bx,[0x1ce]
0000666C  81FB6701          cmp bx,0x167
00006670  7605              jna 0x6677
00006672  4B                dec bx
00006673  891ECE01          mov [0x1ce],bx
00006677  8B3ED001          mov di,[0x1d0]
0000667B  4F                dec di
0000667C  83E70F            and di,byte +0xf
0000667F  893ED001          mov [0x1d0],di
00006683  C3                ret
00006684  E90FFC            jmp 0x6296
00006687  50                push ax
00006688  BA1702            mov dx,0x217
0000668B  B409              mov ah,0x9
0000668D  CD21              int 0x21
0000668F  58                pop ax
00006690  C1C004            rol ax,byte 0x4
00006693  E80C00            call 0x66a2
00006696  C1C004            rol ax,byte 0x4
00006699  E80600            call 0x66a2
0000669C  B8200E            mov ax,0xe20
0000669F  CD10              int 0x10
000066A1  C3                ret
000066A2  50                push ax
000066A3  240F              and al,0xf
000066A5  3C0A              cmp al,0xa
000066A7  7202              jc 0x66ab
000066A9  0407              add al,0x7
000066AB  0430              add al,0x30
000066AD  B40E              mov ah,0xe
000066AF  CD10              int 0x10
000066B1  58                pop ax
000066B2  C3                ret
000066B3  1E                push ds
000066B4  07                pop es
000066B5  BF3003            mov di,0x330
000066B8  BA0003            mov dx,0x300
000066BB  B91000            mov cx,0x10
000066BE  EC                in al,dx
000066BF  42                inc dx
000066C0  8AE0              mov ah,al
000066C2  E8AA05            call 0x6c6f
000066C5  47                inc di
000066C6  E2F6              loop 0x66be
000066C8  BA2703            mov dx,0x327
000066CB  B409              mov ah,0x9
000066CD  CD21              int 0x21
000066CF  BF7503            mov di,0x375
000066D2  BA5003            mov dx,0x350
000066D5  EC                in al,dx
000066D6  E80BFC            call 0x62e4
000066D9  243F              and al,0x3f
000066DB  EE                out dx,al
000066DC  E805FC            call 0x62e4
000066DF  B91000            mov cx,0x10
000066E2  EC                in al,dx
000066E3  42                inc dx
000066E4  8AE0              mov ah,al
000066E6  E88605            call 0x6c6f
000066E9  47                inc di
000066EA  E2F6              loop 0x66e2
000066EC  BA6303            mov dx,0x363
000066EF  B409              mov ah,0x9
000066F1  CD21              int 0x21
000066F3  BFBA03            mov di,0x3ba
000066F6  BA5003            mov dx,0x350
000066F9  EC                in al,dx
000066FA  E8E7FB            call 0x62e4
000066FD  0C40              or al,0x40
000066FF  EE                out dx,al
00006700  E8E1FB            call 0x62e4
00006703  B91000            mov cx,0x10
00006706  EC                in al,dx
00006707  42                inc dx
00006708  8AE0              mov ah,al
0000670A  E86205            call 0x6c6f
0000670D  47                inc di
0000670E  E2F6              loop 0x6706
00006710  BAA803            mov dx,0x3a8
00006713  B409              mov ah,0x9
00006715  CD21              int 0x21
00006717  C3                ret
00006718  BAE901            mov dx,0x1e9
0000671B  BEB108            mov si,0x8b1
0000671E  56                push si
0000671F  8B04              mov ax,[si]
00006721  E85C00            call 0x6780
00006724  5E                pop si
00006725  83C608            add si,byte +0x8
00006728  81FEF108          cmp si,0x8f1
0000672C  72F0              jc 0x671e
0000672E  BAEF01            mov dx,0x1ef
00006731  B800E0            mov ax,0xe000
00006734  E84900            call 0x6780
00006737  BAFB01            mov dx,0x1fb
0000673A  B409              mov ah,0x9
0000673C  CD21              int 0x21
0000673E  BEB108            mov si,0x8b1
00006741  B90800            mov cx,0x8
00006744  B8200E            mov ax,0xe20
00006747  CD10              int 0x10
00006749  B83900            mov ax,0x39
0000674C  2BC1              sub ax,cx
0000674E  B40E              mov ah,0xe
00006750  CD10              int 0x10
00006752  BA1502            mov dx,0x215
00006755  B409              mov ah,0x9
00006757  CD21              int 0x21
00006759  51                push cx
0000675A  8B4406            mov ax,[si+0x6]
0000675D  33D2              xor dx,dx
0000675F  03C0              add ax,ax
00006761  13D2              adc dx,dx
00006763  03C0              add ax,ax
00006765  13D2              adc dx,dx
00006767  03C0              add ax,ax
00006769  13D2              adc dx,dx
0000676B  03C0              add ax,ax
0000676D  13D2              adc dx,dx
0000676F  E8B904            call 0x6c2b
00006772  59                pop cx
00006773  83C608            add si,byte +0x8
00006776  E2CC              loop 0x6744
00006778  BAF801            mov dx,0x1f8
0000677B  B409              mov ah,0x9
0000677D  CD21              int 0x21
0000677F  C3                ret
00006780  8EC0              mov es,ax
00006782  33FF              xor di,di
00006784  268A05            mov al,[es:di]
00006787  84C0              test al,al
00006789  7433              jz 0x67be
0000678B  FEC0              inc al
0000678D  742F              jz 0x67be
0000678F  52                push dx
00006790  B409              mov ah,0x9
00006792  CD21              int 0x21
00006794  8BF7              mov si,di
00006796  B90C00            mov cx,0xc
00006799  1E                push ds
0000679A  06                push es
0000679B  1F                pop ds
0000679C  AC                lodsb
0000679D  B40E              mov ah,0xe
0000679F  CD10              int 0x10
000067A1  E2F9              loop 0x679c
000067A3  1F                pop ds
000067A4  BAF501            mov dx,0x1f5
000067A7  B409              mov ah,0x9
000067A9  CD21              int 0x21
000067AB  268B450C          mov ax,[es:di+0xc]
000067AF  268B550E          mov dx,[es:di+0xe]
000067B3  E87504            call 0x6c2b
000067B6  BAF801            mov dx,0x1f8
000067B9  B409              mov ah,0x9
000067BB  CD21              int 0x21
000067BD  5A                pop dx
000067BE  83C712            add di,byte +0x12
000067C1  81FF2001          cmp di,0x120
000067C5  72BD              jc 0x6784
000067C7  C3                ret
000067C8  BAED03            mov dx,0x3ed
000067CB  B409              mov ah,0x9
000067CD  CD21              int 0x21
000067CF  BA0504            mov dx,0x405
000067D2  BBB108            mov bx,0x8b1
000067D5  8B07              mov ax,[bx]
000067D7  8EC0              mov es,ax
000067D9  33FF              xor di,di
000067DB  B050              mov al,0x50
000067DD  268805            mov [es:di],al
000067E0  B020              mov al,0x20
000067E2  268805            mov [es:di],al
000067E5  B0D0              mov al,0xd0
000067E7  268805            mov [es:di],al
000067EA  268A05            mov al,[es:di]
000067ED  A880              test al,0x80
000067EF  74F9              jz 0x67ea
000067F1  A820              test al,0x20
000067F3  7408              jz 0x67fd
000067F5  C606E00601        mov byte [0x6e0],0x1
000067FA  BA0D04            mov dx,0x40d
000067FD  B050              mov al,0x50
000067FF  268805            mov [es:di],al
00006802  B0FF              mov al,0xff
00006804  268805            mov [es:di],al
00006807  83C308            add bx,byte +0x8
0000680A  81FBF108          cmp bx,0x8f1
0000680E  72C5              jc 0x67d5
00006810  B409              mov ah,0x9
00006812  CD21              int 0x21
00006814  E85D38            call 0xa074
00006817  C3                ret
00006818  C3                ret
00006819  BA4003            mov dx,0x340
0000681C  EC                in al,dx
0000681D  A803              test al,0x3
0000681F  7406              jz 0x6827
00006821  BADA05            mov dx,0x5da
00006824  E91D01            jmp 0x6944
00006827  C606E00600        mov byte [0x6e0],0x0
0000682C  C7066F070000      mov word [0x76f],0x0
00006832  BA6A05            mov dx,0x56a
00006835  B409              mov ah,0x9
00006837  CD21              int 0x21
00006839  BBB108            mov bx,0x8b1
0000683C  33D2              xor dx,dx
0000683E  8B07              mov ax,[bx]
00006840  8B4F02            mov cx,[bx+0x2]
00006843  BEFF0F            mov si,0xfff
00006846  23F2              and si,dx
00006848  BF0010            mov di,0x1000
0000684B  2BFE              sub di,si
0000684D  3BCF              cmp cx,di
0000684F  7611              jna 0x6862
00006851  50                push ax
00006852  51                push cx
00006853  57                push di
00006854  8BCF              mov cx,di
00006856  E8F000            call 0x6949
00006859  5F                pop di
0000685A  59                pop cx
0000685B  58                pop ax
0000685C  03C7              add ax,di
0000685E  2BCF              sub cx,di
00006860  EBE1              jmp short 0x6843
00006862  E8E400            call 0x6949
00006865  83C308            add bx,byte +0x8
00006868  81FBF108          cmp bx,0x8f1
0000686C  72D0              jc 0x683e
0000686E  BA4303            mov dx,0x343
00006871  B0FC              mov al,0xfc
00006873  FA                cli
00006874  2206B907          and al,[0x7b9]
00006878  A2B907            mov [0x7b9],al
0000687B  EE                out dx,al
0000687C  FB                sti
0000687D  BA3806            mov dx,0x638
00006880  803EE00600        cmp byte [0x6e0],0x0
00006885  759D              jnz 0x6824
00006887  1E                push ds
00006888  07                pop es
00006889  BF7307            mov di,0x773
0000688C  BA7B06            mov dx,0x67b
0000688F  B409              mov ah,0x9
00006891  CD21              int 0x21
00006893  B401              mov ah,0x1
00006895  CD16              int 0x16
00006897  74FA              jz 0x6893
00006899  B400              mov ah,0x0
0000689B  CD16              int 0x16
0000689D  B40E              mov ah,0xe
0000689F  CD10              int 0x10
000068A1  3C08              cmp al,0x8
000068A3  740B              jz 0x68b0
000068A5  3C0D              cmp al,0xd
000068A7  7410              jz 0x68b9
000068A9  AA                stosb
000068AA  81FF8207          cmp di,0x782
000068AE  72E3              jc 0x6893
000068B0  81FF7307          cmp di,0x773
000068B4  76DD              jna 0x6893
000068B6  4F                dec di
000068B7  EBDA              jmp short 0x6893
000068B9  32C0              xor al,al
000068BB  AA                stosb
000068BC  81FF8307          cmp di,0x783
000068C0  72F9              jc 0x68bb
000068C2  BF00C0            mov di,0xc000
000068C5  8EC7              mov es,di
000068C7  8B3E6F07          mov di,[0x76f]
000068CB  1E                push ds
000068CC  33F6              xor si,si
000068CE  8E1EB108          mov ds,[0x8b1]
000068D2  B91200            mov cx,0x12
000068D5  AD                lodsw
000068D6  2BF8              sub di,ax
000068D8  E2FB              loop 0x68d5
000068DA  1F                pop ds
000068DB  893E6F07          mov [0x76f],di
000068DF  BAA606            mov dx,0x6a6
000068E2  B409              mov ah,0x9
000068E4  CD21              int 0x21
000068E6  B401              mov ah,0x1
000068E8  CD16              int 0x16
000068EA  74FA              jz 0x68e6
000068EC  B400              mov ah,0x0
000068EE  CD16              int 0x16
000068F0  BAC104            mov dx,0x4c1
000068F3  C6066E0700        mov byte [0x76e],0x0
000068F8  3C79              cmp al,0x79
000068FA  7404              jz 0x6900
000068FC  3C59              cmp al,0x59
000068FE  7506              jnz 0x6906
00006900  BAC604            mov dx,0x4c6
00006903  A26E07            mov [0x76e],al
00006906  B409              mov ah,0x9
00006908  CD21              int 0x21
0000690A  33FF              xor di,di
0000690C  BE6307            mov si,0x763
0000690F  B90E00            mov cx,0xe
00006912  F3A4              rep movsb
00006914  BF1200            mov di,0x12
00006917  BE7107            mov si,0x771
0000691A  B91200            mov cx,0x12
0000691D  F3A4              rep movsb
0000691F  BAF705            mov dx,0x5f7
00006922  B409              mov ah,0x9
00006924  CD21              int 0x21
00006926  33D2              xor dx,dx
00006928  B004              mov al,0x4
0000692A  E84502            call 0x6b72
0000692D  B005              mov al,0x5
0000692F  E84002            call 0x6b72
00006932  B006              mov al,0x6
00006934  E83B02            call 0x6b72
00006937  B007              mov al,0x7
00006939  E83602            call 0x6b72
0000693C  8BC2              mov ax,dx
0000693E  E8CD02            call 0x6c0e
00006941  BAE602            mov dx,0x2e6
00006944  B409              mov ah,0x9
00006946  CD21              int 0x21
00006948  C3                ret
00006949  53                push bx
0000694A  8B1E6F07          mov bx,[0x76f]
0000694E  1E                push ds
0000694F  50                push ax
00006950  52                push dx
00006951  B004              mov al,0x4
00006953  F7C20010          test dx,0x1000
00006957  7402              jz 0x695b
00006959  0C01              or al,0x1
0000695B  F7C20020          test dx,0x2000
0000695F  7402              jz 0x6963
00006961  0C02              or al,0x2
00006963  81E2FF0F          and dx,0xfff
00006967  81C200C0          add dx,0xc000
0000696B  8EC2              mov es,dx
0000696D  BA4303            mov dx,0x343
00006970  B4FC              mov ah,0xfc
00006972  FA                cli
00006973  2226B907          and ah,[0x7b9]
00006977  0AC4              or al,ah
00006979  A2B907            mov [0x7b9],al
0000697C  EE                out dx,al
0000697D  FB                sti
0000697E  5A                pop dx
0000697F  03D1              add dx,cx
00006981  1F                pop ds
00006982  C1E103            shl cx,byte 0x3
00006985  51                push cx
00006986  33F6              xor si,si
00006988  33FF              xor di,di
0000698A  AD                lodsw
0000698B  AB                stosw
0000698C  03D8              add bx,ax
0000698E  E2FA              loop 0x698a
00006990  59                pop cx
00006991  33F6              xor si,si
00006993  33FF              xor di,di
00006995  F3A7              repe cmpsw
00006997  1F                pop ds
00006998  7405              jz 0x699f
0000699A  C606E00601        mov byte [0x6e0],0x1
0000699F  891E6F07          mov [0x76f],bx
000069A3  5B                pop bx
000069A4  C3                ret
000069A5  BA4003            mov dx,0x340
000069A8  EC                in al,dx
000069A9  A803              test al,0x3
000069AB  752E              jnz 0x69db
000069AD  BA4303            mov dx,0x343
000069B0  B0FC              mov al,0xfc
000069B2  FA                cli
000069B3  2206B907          and al,[0x7b9]
000069B7  0C04              or al,0x4
000069B9  A2B907            mov [0x7b9],al
000069BC  EE                out dx,al
000069BD  FB                sti
000069BE  B800C0            mov ax,0xc000
000069C1  8EC0              mov es,ax
000069C3  33FF              xor di,di
000069C5  BE6307            mov si,0x763
000069C8  B90B00            mov cx,0xb
000069CB  F3A6              repe cmpsb
000069CD  7410              jz 0x69df
000069CF  33FF              xor di,di
000069D1  BE8307            mov si,0x783
000069D4  B91000            mov cx,0x10
000069D7  F3A6              repe cmpsb
000069D9  7401              jz 0x69dc
000069DB  C3                ret
000069DC  E97909            jmp 0x7358
000069DF  1E                push ds
000069E0  1E                push ds
000069E1  06                push es
000069E2  1F                pop ds
000069E3  07                pop es
000069E4  8BF7              mov si,di
000069E6  AC                lodsb
000069E7  26A26E07          mov [es:0x76e],al
000069EB  AD                lodsw
000069EC  26A36F07          mov [es:0x76f],ax
000069F0  8BD8              mov bx,ax
000069F2  BE1400            mov si,0x14
000069F5  BF7307            mov di,0x773
000069F8  B90800            mov cx,0x8
000069FB  F3A5              rep movsw
000069FD  1F                pop ds
000069FE  BA4303            mov dx,0x343
00006A01  B404              mov ah,0x4
00006A03  BE1200            mov si,0x12
00006A06  50                push ax
00006A07  B0FC              mov al,0xfc
00006A09  FA                cli
00006A0A  2206B907          and al,[0x7b9]
00006A0E  0AC4              or al,ah
00006A10  A2B907            mov [0x7b9],al
00006A13  EE                out dx,al
00006A14  FB                sti
00006A15  B90080            mov cx,0x8000
00006A18  2BCE              sub cx,si
00006A1A  03F6              add si,si
00006A1C  1E                push ds
00006A1D  B800C0            mov ax,0xc000
00006A20  8ED8              mov ds,ax
00006A22  AD                lodsw
00006A23  2BD8              sub bx,ax
00006A25  E2FB              loop 0x6a22
00006A27  1F                pop ds
00006A28  58                pop ax
00006A29  33F6              xor si,si
00006A2B  80F401            xor ah,0x1
00006A2E  F6C401            test ah,0x1
00006A31  75D3              jnz 0x6a06
00006A33  80F402            xor ah,0x2
00006A36  F6C402            test ah,0x2
00006A39  75CB              jnz 0x6a06
00006A3B  BAED04            mov dx,0x4ed
00006A3E  85DB              test bx,bx
00006A40  753B              jnz 0x6a7d
00006A42  E8D2F7            call 0x6217
00006A45  BE7307            mov si,0x773
00006A48  AC                lodsb
00006A49  84C0              test al,al
00006A4B  7406              jz 0x6a53
00006A4D  B40E              mov ah,0xe
00006A4F  CD10              int 0x10
00006A51  EBF5              jmp short 0x6a48
00006A53  BAE602            mov dx,0x2e6
00006A56  B409              mov ah,0x9
00006A58  CD21              int 0x21
00006A5A  803E6E0700        cmp byte [0x76e],0x0
00006A5F  7528              jnz 0x6a89
00006A61  BA1904            mov dx,0x419
00006A64  B409              mov ah,0x9
00006A66  CD21              int 0x21
00006A68  B401              mov ah,0x1
00006A6A  CD16              int 0x16
00006A6C  74FA              jz 0x6a68
00006A6E  B400              mov ah,0x0
00006A70  CD16              int 0x16
00006A72  3C79              cmp al,0x79
00006A74  740C              jz 0x6a82
00006A76  3C59              cmp al,0x59
00006A78  7408              jz 0x6a82
00006A7A  BAC104            mov dx,0x4c1
00006A7D  B409              mov ah,0x9
00006A7F  CD21              int 0x21
00006A81  C3                ret
00006A82  BAC604            mov dx,0x4c6
00006A85  B409              mov ah,0x9
00006A87  CD21              int 0x21
00006A89  C606E00600        mov byte [0x6e0],0x0
00006A8E  E80701            call 0x6b98
00006A91  E834FD            call 0x67c8
00006A94  803EE00600        cmp byte [0x6e0],0x0
00006A99  75FE              jnz 0x6a99
00006A9B  BA5104            mov dx,0x451
00006A9E  B409              mov ah,0x9
00006AA0  CD21              int 0x21
00006AA2  BBB108            mov bx,0x8b1
00006AA5  33D2              xor dx,dx
00006AA7  8B07              mov ax,[bx]
00006AA9  8B4F02            mov cx,[bx+0x2]
00006AAC  BEFF0F            mov si,0xfff
00006AAF  23F2              and si,dx
00006AB1  BF0010            mov di,0x1000
00006AB4  2BFE              sub di,si
00006AB6  3BCF              cmp cx,di
00006AB8  7611              jna 0x6acb
00006ABA  50                push ax
00006ABB  51                push cx
00006ABC  57                push di
00006ABD  8BCF              mov cx,di
00006ABF  E86800            call 0x6b2a
00006AC2  5F                pop di
00006AC3  59                pop cx
00006AC4  58                pop ax
00006AC5  03C7              add ax,di
00006AC7  2BCF              sub cx,di
00006AC9  EBE1              jmp short 0x6aac
00006ACB  E85C00            call 0x6b2a
00006ACE  83C308            add bx,byte +0x8
00006AD1  81FBF108          cmp bx,0x8f1
00006AD5  72D0              jc 0x6aa7
00006AD7  803EE00600        cmp byte [0x6e0],0x0
00006ADC  7543              jnz 0x6b21
00006ADE  1E                push ds
00006ADF  33D2              xor dx,dx
00006AE1  BB0080            mov bx,0x8000
00006AE4  E8A100            call 0x6b88
00006AE7  BB0090            mov bx,0x9000
00006AEA  E89B00            call 0x6b88
00006AED  BB00A0            mov bx,0xa000
00006AF0  E89500            call 0x6b88
00006AF3  BB00B0            mov bx,0xb000
00006AF6  E88F00            call 0x6b88
00006AF9  1F                pop ds
00006AFA  89166107          mov [0x761],dx
00006AFE  E87335            call 0xa074
00006B01  E84C07            call 0x7250
00006B04  721B              jc 0x6b21
00006B06  E8EC00            call 0x6bf5
00006B09  7216              jc 0x6b21
00006B0B  BA6B04            mov dx,0x46b
00006B0E  B409              mov ah,0x9
00006B10  CD21              int 0x21
00006B12  A16107            mov ax,[0x761]
00006B15  E8F600            call 0x6c0e
00006B18  BACC04            mov dx,0x4cc
00006B1B  B409              mov ah,0x9
00006B1D  CD21              int 0x21
00006B1F  EBFE              jmp short 0x6b1f
00006B21  BAA204            mov dx,0x4a2
00006B24  B409              mov ah,0x9
00006B26  CD21              int 0x21
00006B28  EBFE              jmp short 0x6b28
00006B2A  1E                push ds
00006B2B  52                push dx
00006B2C  8EC0              mov es,ax
00006B2E  B004              mov al,0x4
00006B30  F7C20010          test dx,0x1000
00006B34  7402              jz 0x6b38
00006B36  0C01              or al,0x1
00006B38  F7C20020          test dx,0x2000
00006B3C  7402              jz 0x6b40
00006B3E  0C02              or al,0x2
00006B40  BA4303            mov dx,0x343
00006B43  B4FC              mov ah,0xfc
00006B45  FA                cli
00006B46  2226B907          and ah,[0x7b9]
00006B4A  0AC4              or al,ah
00006B4C  A2B907            mov [0x7b9],al
00006B4F  EE                out dx,al
00006B50  FB                sti
00006B51  5A                pop dx
00006B52  8BC2              mov ax,dx
00006B54  03D1              add dx,cx
00006B56  25FF0F            and ax,0xfff
00006B59  0500C0            add ax,0xc000
00006B5C  8ED8              mov ds,ax
00006B5E  C1E104            shl cx,byte 0x4
00006B61  33F6              xor si,si
00006B63  33FF              xor di,di
00006B65  E8FC39            call 0xa564
00006B68  1F                pop ds
00006B69  7405              jz 0x6b70
00006B6B  C606E00601        mov byte [0x6e0],0x1
00006B70  C3                ret
00006B71  C3                ret
00006B72  52                push dx
00006B73  BA4303            mov dx,0x343
00006B76  B4FC              mov ah,0xfc
00006B78  FA                cli
00006B79  2226B907          and ah,[0x7b9]
00006B7D  0AC4              or al,ah
00006B7F  A2B907            mov [0x7b9],al
00006B82  EE                out dx,al
00006B83  FB                sti
00006B84  5A                pop dx
00006B85  BB00C0            mov bx,0xc000
00006B88  1E                push ds
00006B89  8EDB              mov ds,bx
00006B8B  33C9              xor cx,cx
00006B8D  8BC1              mov ax,cx
00006B8F  8BF1              mov si,cx
00006B91  AC                lodsb
00006B92  03D0              add dx,ax
00006B94  E2FB              loop 0x6b91
00006B96  1F                pop ds
00006B97  C3                ret
00006B98  33C0              xor ax,ax
00006B9A  A3A307            mov [0x7a3],ax
00006B9D  BA9307            mov dx,0x793
00006BA0  B8003D            mov ax,0x3d00
00006BA3  CD21              int 0x21
00006BA5  7301              jnc 0x6ba8
00006BA7  C3                ret
00006BA8  A39F07            mov [0x79f],ax
00006BAB  33D2              xor dx,dx
00006BAD  8BCA              mov cx,dx
00006BAF  8BD8              mov bx,ax
00006BB1  B80242            mov ax,0x4202
00006BB4  CD21              int 0x21
00006BB6  7234              jc 0x6bec
00006BB8  50                push ax
00006BB9  33D2              xor dx,dx
00006BBB  8BCA              mov cx,dx
00006BBD  8B1E9F07          mov bx,[0x79f]
00006BC1  B80042            mov ax,0x4200
00006BC4  CD21              int 0x21
00006BC6  5B                pop bx
00006BC7  7223              jc 0x6bec
00006BC9  53                push bx
00006BCA  891EA107          mov [0x7a1],bx
00006BCE  83C30F            add bx,byte +0xf
00006BD1  C1EB04            shr bx,byte 0x4
00006BD4  B448              mov ah,0x48
00006BD6  CD21              int 0x21
00006BD8  7212              jc 0x6bec
00006BDA  A3A307            mov [0x7a3],ax
00006BDD  8B1E9F07          mov bx,[0x79f]
00006BE1  59                pop cx
00006BE2  1E                push ds
00006BE3  8ED8              mov ds,ax
00006BE5  33D2              xor dx,dx
00006BE7  B43F              mov ah,0x3f
00006BE9  CD21              int 0x21
00006BEB  1F                pop ds
00006BEC  8B1E9F07          mov bx,[0x79f]
00006BF0  B43E              mov ah,0x3e
00006BF2  CD21              int 0x21
00006BF4  C3                ret
00006BF5  A1A307            mov ax,[0x7a3]
00006BF8  85C0              test ax,ax
00006BFA  7411              jz 0x6c0d
00006BFC  8EC0              mov es,ax
00006BFE  33DB              xor bx,bx
00006C00  BE9307            mov si,0x793
00006C03  8BCB              mov cx,bx
00006C05  8B16A107          mov dx,[0x7a1]
00006C09  B406              mov ah,0x6
00006C0B  CD40              int 0x40
00006C0D  C3                ret
00006C0E  E80600            call 0x6c17
00006C11  E80300            call 0x6c17
00006C14  E80000            call 0x6c17
00006C17  C1C004            rol ax,byte 0x4
00006C1A  50                push ax
00006C1B  240F              and al,0xf
00006C1D  3C0A              cmp al,0xa
00006C1F  7202              jc 0x6c23
00006C21  0407              add al,0x7
00006C23  0430              add al,0x30
00006C25  B40E              mov ah,0xe
00006C27  CD10              int 0x10
00006C29  58                pop ax
00006C2A  C3                ret
00006C2B  33ED              xor bp,bp
00006C2D  B91027            mov cx,0x2710
00006C30  F7F1              div cx
00006C32  85C0              test ax,ax
00006C34  7405              jz 0x6c3b
00006C36  52                push dx
00006C37  E80300            call 0x6c3d
00006C3A  5A                pop dx
00006C3B  8BC2              mov ax,dx
00006C3D  B9E803            mov cx,0x3e8
00006C40  E81000            call 0x6c53
00006C43  B96400            mov cx,0x64
00006C46  E80A00            call 0x6c53
00006C49  B90A00            mov cx,0xa
00006C4C  E80400            call 0x6c53
00006C4F  B90100            mov cx,0x1
00006C52  45                inc bp
00006C53  33D2              xor dx,dx
00006C55  F7F1              div cx
00006C57  85ED              test bp,bp
00006C59  7505              jnz 0x6c60
00006C5B  85C0              test ax,ax
00006C5D  7407              jz 0x6c66
00006C5F  45                inc bp
00006C60  0430              add al,0x30
00006C62  B40E              mov ah,0xe
00006C64  CD10              int 0x10
00006C66  8BC2              mov ax,dx
00006C68  C3                ret
00006C69  E80600            call 0x6c72
00006C6C  E80300            call 0x6c72
00006C6F  E80000            call 0x6c72
00006C72  C1C004            rol ax,byte 0x4
00006C75  50                push ax
00006C76  240F              and al,0xf
00006C78  3C0A              cmp al,0xa
00006C7A  7202              jc 0x6c7e
00006C7C  0407              add al,0x7
00006C7E  0430              add al,0x30
00006C80  AA                stosb
00006C81  58                pop ax
00006C82  C3                ret
00006C83  33F6              xor si,si
00006C85  B404              mov ah,0x4
00006C87  CD40              int 0x40
00006C89  8CC0              mov ax,es
00006C8B  0BC3              or ax,bx
00006C8D  7501              jnz 0x6c90
00006C8F  C3                ret
00006C90  BA1400            mov dx,0x14
00006C93  56                push si
00006C94  1E                push ds
00006C95  268B07            mov ax,[es:bx]
00006C98  43                inc bx
00006C99  43                inc bx
00006C9A  86C4              xchg al,ah
00006C9C  40                inc ax
00006C9D  8BF8              mov di,ax
00006C9F  56                push si
00006CA0  8BC6              mov ax,si
00006CA2  E8C4FF            call 0x6c69
00006CA5  B800C0            mov ax,0xc000
00006CA8  8ED8              mov ds,ax
00006CAA  B90800            mov cx,0x8
00006CAD  B020              mov al,0x20
00006CAF  AA                stosb
00006CB0  AD                lodsw
00006CB1  E8B5FF            call 0x6c69
00006CB4  E2F7              loop 0x6cad
00006CB6  B82020            mov ax,0x2020
00006CB9  AB                stosw
00006CBA  5E                pop si
00006CBB  B427              mov ah,0x27
00006CBD  AB                stosw
00006CBE  B90800            mov cx,0x8
00006CC1  AD                lodsw
00006CC2  3C20              cmp al,0x20
00006CC4  7204              jc 0x6cca
00006CC6  3C80              cmp al,0x80
00006CC8  7202              jc 0x6ccc
00006CCA  B02E              mov al,0x2e
00006CCC  80FC20            cmp ah,0x20
00006CCF  7205              jc 0x6cd6
00006CD1  80FC80            cmp ah,0x80
00006CD4  7202              jc 0x6cd8
00006CD6  B42E              mov ah,0x2e
00006CD8  AB                stosw
00006CD9  E2E6              loop 0x6cc1
00006CDB  B027              mov al,0x27
00006CDD  AA                stosb
00006CDE  4A                dec dx
00006CDF  75B4              jnz 0x6c95
00006CE1  268B07            mov ax,[es:bx]
00006CE4  86C4              xchg al,ah
00006CE6  40                inc ax
00006CE7  8BF8              mov di,ax
00006CE9  B82020            mov ax,0x2020
00006CEC  AB                stosw
00006CED  AB                stosw
00006CEE  33F6              xor si,si
00006CF0  33D2              xor dx,dx
00006CF2  B90080            mov cx,0x8000
00006CF5  AD                lodsw
00006CF6  03D0              add dx,ax
00006CF8  E2FB              loop 0x6cf5
00006CFA  8BC2              mov ax,dx
00006CFC  E86AFF            call 0x6c69
00006CFF  B82020            mov ax,0x2020
00006D02  AB                stosw
00006D03  1F                pop ds
00006D04  5E                pop si
00006D05  B400              mov ah,0x0
00006D07  CD40              int 0x40
00006D09  B401              mov ah,0x1
00006D0B  CD16              int 0x16
00006D0D  7418              jz 0x6d27
00006D0F  B400              mov ah,0x0
00006D11  CD16              int 0x16
00006D13  3C1B              cmp al,0x1b
00006D15  7413              jz 0x6d2a
00006D17  3C2B              cmp al,0x2b
00006D19  7408              jz 0x6d23
00006D1B  3C2D              cmp al,0x2d
00006D1D  7508              jnz 0x6d27
00006D1F  81EE0002          sub si,0x200
00006D23  81C60001          add si,0x100
00006D27  E95BFF            jmp 0x6c85
00006D2A  C3                ret
00006D2B  000D              add [di],cl
00006D2D  49                dec cx
00006D2E  EE                out dx,al
00006D2F  1909              sbb [bx+di],cx
00006D31  0E                push cs
00006D32  07                pop es
00006D33  0E                push cs
00006D34  07                pop es
00006D35  0E                push cs
00006D36  07                pop es
00006D37  0E                push cs
00006D38  07                pop es
00006D39  0E                push cs
00006D3A  07                pop es
00006D3B  0E                push cs
00006D3C  EE                out dx,al
00006D3D  1912              sbb [bp+si],dx
00006D3F  0E                push cs
00006D40  07                pop es
00006D41  0E                push cs
00006D42  C7                db 0xc7
00006D43  1907              sbb [bx],ax
00006D45  0E                push cs
00006D46  07                pop es
00006D47  0E                push cs
00006D48  07                pop es
00006D49  0E                push cs
00006D4A  07                pop es
00006D4B  0E                push cs
00006D4C  07                pop es
00006D4D  0E                push cs
00006D4E  07                pop es
00006D4F  0E                push cs
00006D50  07                pop es
00006D51  0E                push cs
00006D52  07                pop es
00006D53  0E                push cs
00006D54  07                pop es
00006D55  0E                push cs
00006D56  07                pop es
00006D57  0E                push cs
00006D58  07                pop es
00006D59  0E                push cs
00006D5A  07                pop es
00006D5B  0E                push cs
00006D5C  07                pop es
00006D5D  0E                push cs
00006D5E  07                pop es
00006D5F  0E                push cs
00006D60  07                pop es
00006D61  0E                push cs
00006D62  07                pop es
00006D63  0E                push cs
00006D64  07                pop es
00006D65  0E                push cs
00006D66  07                pop es
00006D67  0E                push cs
00006D68  07                pop es
00006D69  0E                push cs
00006D6A  07                pop es
00006D6B  0E                push cs
00006D6C  07                pop es
00006D6D  0E                push cs
00006D6E  07                pop es
00006D6F  0E                push cs
00006D70  07                pop es
00006D71  0E                push cs
00006D72  07                pop es
00006D73  0E                push cs
00006D74  07                pop es
00006D75  0E                push cs
00006D76  240E              and al,0xe
00006D78  07                pop es
00006D79  0E                push cs
00006D7A  07                pop es
00006D7B  0E                push cs
00006D7C  07                pop es
00006D7D  0E                push cs
00006D7E  07                pop es
00006D7F  0E                push cs
00006D80  B20E              mov dl,0xe
00006D82  07                pop es
00006D83  0E                push cs
00006D84  BF0E07            mov di,0x70e
00006D87  0E                push cs
00006D88  07                pop es
00006D89  0E                push cs
00006D8A  07                pop es
00006D8B  0E                push cs
00006D8C  3C0E              cmp al,0xe
00006D8E  CC                int3
00006D8F  48                dec ax
00006D90  07                pop es
00006D91  0E                push cs
00006D92  07                pop es
00006D93  0E                push cs
00006D94  47                inc di
00006D95  0E                push cs
00006D96  54                push sp
00006D97  0E                push cs
00006D98  07                pop es
00006D99  0E                push cs
00006D9A  07                pop es
00006D9B  0E                push cs
00006D9C  07                pop es
00006D9D  0E                push cs
00006D9E  07                pop es
00006D9F  0E                push cs
00006DA0  07                pop es
00006DA1  0E                push cs
00006DA2  07                pop es
00006DA3  0E                push cs
00006DA4  07                pop es
00006DA5  0E                push cs
00006DA6  5E                pop si
00006DA7  41                inc cx
00006DA8  394268            cmp [bp+si+0x68],ax
00006DAB  42                inc dx
00006DAC  EA42070E06        jmp 0x60e:0x742
00006DB1  43                inc bx
00006DB2  7543              jnz 0x6df7
00006DB4  8143070E07        add word [bp+di+0x7],0x70e
00006DB9  0E                push cs
00006DBA  07                pop es
00006DBB  0E                push cs
00006DBC  D23B              sar byte [bp+di],cl
00006DBE  3E3D953C          ds cmp ax,0x3c95
00006DC2  A2380F            mov [0xf38],al
00006DC5  49                dec cx
00006DC6  49                dec cx
00006DC7  49                dec cx
00006DC8  B043              mov al,0x43
00006DCA  FB                sti
00006DCB  43                inc bx
00006DCC  7F0E              jg 0x6ddc
00006DCE  6C                insb
00006DCF  0E                push cs
00006DD0  07                pop es
00006DD1  0E                push cs
00006DD2  07                pop es
00006DD3  0E                push cs
00006DD4  07                pop es
00006DD5  0E                push cs
00006DD6  07                pop es
00006DD7  0E                push cs
00006DD8  07                pop es
00006DD9  0E                push cs
00006DDA  07                pop es
00006DDB  0E                push cs
00006DDC  B03B              mov al,0x3b
00006DDE  07                pop es
00006DDF  0E                push cs
00006DE0  07                pop es
00006DE1  0E                push cs
00006DE2  07                pop es
00006DE3  0E                push cs
00006DE4  07                pop es
00006DE5  0E                push cs
00006DE6  07                pop es
00006DE7  0E                push cs
00006DE8  07                pop es
00006DE9  0E                push cs
00006DEA  07                pop es
00006DEB  0E                push cs
00006DEC  07                pop es
00006DED  0E                push cs
00006DEE  07                pop es
00006DEF  0E                push cs
00006DF0  6C                insb
00006DF1  0E                push cs
00006DF2  FB                sti
00006DF3  FC                cld
00006DF4  50                push ax
00006DF5  53                push bx
00006DF6  8ADC              mov bl,ah
00006DF8  32FF              xor bh,bh
00006DFA  03DB              add bx,bx
00006DFC  81FBC600          cmp bx,0xc6
00006E00  7305              jnc 0x6e07
00006E02  2EFFA72C0D        jmp [cs:bx+0xd2c]
00006E07  CD4F              int 0x4f
00006E09  8AC2              mov al,dl
00006E0B  B40E              mov ah,0xe
00006E0D  CD10              int 0x10
00006E0F  5B                pop bx
00006E10  58                pop ax
00006E11  CF                iret
00006E12  56                push si
00006E13  8BF2              mov si,dx
00006E15  AC                lodsb
00006E16  3C24              cmp al,0x24
00006E18  7406              jz 0x6e20
00006E1A  B40E              mov ah,0xe
00006E1C  CD10              int 0x10
00006E1E  EBF5              jmp short 0x6e15
00006E20  5E                pop si
00006E21  5B                pop bx
00006E22  58                pop ax
00006E23  CF                iret
00006E24  06                push es
00006E25  33DB              xor bx,bx
00006E27  8EC3              mov es,bx
00006E29  8AD8              mov bl,al
00006E2B  03DB              add bx,bx
00006E2D  03DB              add bx,bx
00006E2F  FA                cli
00006E30  268917            mov [es:bx],dx
00006E33  268C5F02          mov [es:bx+0x2],ds
00006E37  FB                sti
00006E38  07                pop es
00006E39  5B                pop bx
00006E3A  58                pop ax
00006E3B  CF                iret
00006E3C  B80303            mov ax,0x303
00006E3F  33DB              xor bx,bx
00006E41  8BCB              mov cx,bx
00006E43  83C404            add sp,byte +0x4
00006E46  CF                iret
00006E47  BB8EFE            mov bx,0xfe8e
00006E4A  8EC3              mov es,bx
00006E4C  BBA707            mov bx,0x7a7
00006E4F  83C402            add sp,byte +0x2
00006E52  58                pop ax
00006E53  CF                iret
00006E54  1E                push ds
00006E55  33DB              xor bx,bx
00006E57  8EDB              mov ds,bx
00006E59  8AD8              mov bl,al
00006E5B  03DB              add bx,bx
00006E5D  03DB              add bx,bx
00006E5F  FA                cli
00006E60  8E4702            mov es,[bx+0x2]
00006E63  8B1F              mov bx,[bx]
00006E65  FB                sti
00006E66  1F                pop ds
00006E67  83C402            add sp,byte +0x2
00006E6A  58                pop ax
00006E6B  CF                iret
00006E6C  1E                push ds
00006E6D  B84000            mov ax,0x40
00006E70  8ED8              mov ds,ax
00006E72  8B1E1409          mov bx,[0x914]
00006E76  8B5F04            mov bx,[bx+0x4]
00006E79  1F                pop ds
00006E7A  83C402            add sp,byte +0x2
00006E7D  58                pop ax
00006E7E  CF                iret
00006E7F  1E                push ds
00006E80  B84000            mov ax,0x40
00006E83  8ED8              mov ds,ax
00006E85  8BC3              mov ax,bx
00006E87  BBDE18            mov bx,0x18de
00006E8A  80BFA70000        cmp byte [bx+0xa7],0x0
00006E8F  7405              jz 0x6e96
00006E91  3B4704            cmp ax,[bx+0x4]
00006E94  7411              jz 0x6ea7
00006E96  81C3B800          add bx,0xb8
00006E9A  81FB5E24          cmp bx,0x245e
00006E9E  72EA              jc 0x6e8a
00006EA0  F9                stc
00006EA1  1F                pop ds
00006EA2  5B                pop bx
00006EA3  58                pop ax
00006EA4  CA0200            retf 0x2
00006EA7  891E1409          mov [0x914],bx
00006EAB  F8                clc
00006EAC  1F                pop ds
00006EAD  5B                pop bx
00006EAE  58                pop ax
00006EAF  CA0200            retf 0x2
00006EB2  B005              mov al,0x5
00006EB4  BA0D0B            mov dx,0xb0d
00006EB7  B9C807            mov cx,0x7c8
00006EBA  5B                pop bx
00006EBB  83C402            add sp,byte +0x2
00006EBE  CF                iret
00006EBF  1E                push ds
00006EC0  BB4000            mov bx,0x40
00006EC3  8EDB              mov ds,bx
00006EC5  B93700            mov cx,0x37
00006EC8  A16A09            mov ax,[0x96a]
00006ECB  33D2              xor dx,dx
00006ECD  F7F1              div cx
00006ECF  8BD8              mov bx,ax
00006ED1  A16809            mov ax,[0x968]
00006ED4  F7F1              div cx
00006ED6  52                push dx
00006ED7  B93C00            mov cx,0x3c
00006EDA  93                xchg ax,bx
00006EDB  33D2              xor dx,dx
00006EDD  F7F1              div cx
00006EDF  93                xchg ax,bx
00006EE0  F7F1              div cx
00006EE2  52                push dx
00006EE3  B93C00            mov cx,0x3c
00006EE6  93                xchg ax,bx
00006EE7  33D2              xor dx,dx
00006EE9  F7F1              div cx
00006EEB  93                xchg ax,bx
00006EEC  F7F1              div cx
00006EEE  52                push dx
00006EEF  B91800            mov cx,0x18
00006EF2  93                xchg ax,bx
00006EF3  33D2              xor dx,dx
00006EF5  F7F1              div cx
00006EF7  93                xchg ax,bx
00006EF8  F7F1              div cx
00006EFA  8AEA              mov ch,dl
00006EFC  58                pop ax
00006EFD  8AC8              mov cl,al
00006EFF  58                pop ax
00006F00  8AF0              mov dh,al
00006F02  58                pop ax
00006F03  B364              mov bl,0x64
00006F05  F6E3              mul bl
00006F07  B337              mov bl,0x37
00006F09  F6F3              div bl
00006F0B  8AD0              mov dl,al
00006F0D  1F                pop ds
00006F0E  5B                pop bx
00006F0F  58                pop ax
00006F10  CF                iret
00006F11  00FC              add ah,bh
00006F13  BBFFFF            mov bx,0xffff
00006F16  BD4400            mov bp,0x44
00006F19  BA4303            mov dx,0x343
00006F1C  8BC5              mov ax,bp
00006F1E  EE                out dx,al
00006F1F  83F540            xor bp,byte +0x40
00006F22  BA0000            mov dx,0x0
00006F25  8EC2              mov es,dx
00006F27  33FF              xor di,di
00006F29  B90080            mov cx,0x8000
00006F2C  8BC3              mov ax,bx
00006F2E  F3AB              rep stosw
00006F30  81C20010          add dx,0x1000
00006F34  81FA0080          cmp dx,0x8000
00006F38  72EB              jc 0x6f25
00006F3A  BA4303            mov dx,0x343
00006F3D  8BC5              mov ax,bp
00006F3F  EE                out dx,al
00006F40  83F540            xor bp,byte +0x40
00006F43  BA0000            mov dx,0x0
00006F46  8EC2              mov es,dx
00006F48  33FF              xor di,di
00006F4A  8BC3              mov ax,bx
00006F4C  B90080            mov cx,0x8000
00006F4F  F3AE              repe scasb
00006F51  756F              jnz 0x6fc2
00006F53  B90080            mov cx,0x8000
00006F56  F3AE              repe scasb
00006F58  7568              jnz 0x6fc2
00006F5A  81C20010          add dx,0x1000
00006F5E  81FA0080          cmp dx,0x8000
00006F62  72E2              jc 0x6f46
00006F64  81EA0010          sub dx,0x1000
00006F68  8EC2              mov es,dx
00006F6A  BFFFFF            mov di,0xffff
00006F6D  8AC3              mov al,bl
00006F6F  F6D0              not al
00006F71  AA                stosb
00006F72  BA4303            mov dx,0x343
00006F75  8BC5              mov ax,bp
00006F77  EE                out dx,al
00006F78  83F540            xor bp,byte +0x40
00006F7B  BA0000            mov dx,0x0
00006F7E  8EC2              mov es,dx
00006F80  33FF              xor di,di
00006F82  AA                stosb
00006F83  B9FFFF            mov cx,0xffff
00006F86  8BC3              mov ax,bx
00006F88  F3AE              repe scasb
00006F8A  753B              jnz 0x6fc7
00006F8C  81C20010          add dx,0x1000
00006F90  8EC2              mov es,dx
00006F92  33FF              xor di,di
00006F94  8BC3              mov ax,bx
00006F96  B90080            mov cx,0x8000
00006F99  F3AE              repe scasb
00006F9B  752A              jnz 0x6fc7
00006F9D  B90080            mov cx,0x8000
00006FA0  F3AE              repe scasb
00006FA2  7523              jnz 0x6fc7
00006FA4  81C20010          add dx,0x1000
00006FA8  81FA0070          cmp dx,0x7000
00006FAC  72E2              jc 0x6f90
00006FAE  8EC2              mov es,dx
00006FB0  33FF              xor di,di
00006FB2  B9FFFF            mov cx,0xffff
00006FB5  8BC3              mov ax,bx
00006FB7  F3AE              repe scasb
00006FB9  750C              jnz 0x6fc7
00006FBB  EB51              jmp short 0x700e
00006FBD  BB2F00            mov bx,0x2f
00006FC0  EB08              jmp short 0x6fca
00006FC2  BBEF01            mov bx,0x1ef
00006FC5  EB03              jmp short 0x6fca
00006FC7  BBAF00            mov bx,0xaf
00006FCA  D1EB              shr bx,1
00006FCC  731A              jnc 0x6fe8
00006FCE  BA4303            mov dx,0x343
00006FD1  B044              mov al,0x44
00006FD3  EE                out dx,al
00006FD4  B8B80B            mov ax,0xbb8
00006FD7  BA32FF            mov dx,0xff32
00006FDA  EE                out dx,al
00006FDB  BA34FF            mov dx,0xff34
00006FDE  EE                out dx,al
00006FDF  B803C0            mov ax,0xc003
00006FE2  BA36FF            mov dx,0xff36
00006FE5  EE                out dx,al
00006FE6  EB0D              jmp short 0x6ff5
00006FE8  BA4303            mov dx,0x343
00006FEB  B044              mov al,0x44
00006FED  EE                out dx,al
00006FEE  B80040            mov ax,0x4000
00006FF1  BA36FF            mov dx,0xff36
00006FF4  EE                out dx,al
00006FF5  E2FE              loop 0x6ff5
00006FF7  85DB              test bx,bx
00006FF9  75CF              jnz 0x6fca
00006FFB  B80040            mov ax,0x4000
00006FFE  BA36FF            mov dx,0xff36
00007001  EE                out dx,al
00007002  BA4303            mov dx,0x343
00007005  B044              mov al,0x44
00007007  EE                out dx,al
00007008  268A45FF          mov al,[es:di-0x1]
0000700C  EBFA              jmp short 0x7008
0000700E  85DB              test bx,bx
00007010  7406              jz 0x7018
00007012  43                inc bx
00007013  8AFB              mov bh,bl
00007015  E901FF            jmp 0x6f19
00007018  8CC8              mov ax,cs
0000701A  058EFE            add ax,0xfe8e
0000701D  2D00F6            sub ax,0xf600
00007020  8ED8              mov ds,ax
00007022  BA4000            mov dx,0x40
00007025  8EC2              mov es,dx
00007027  BE0000            mov si,0x0
0000702A  8BFE              mov di,si
0000702C  B9CA09            mov cx,0x9ca
0000702F  2BCE              sub cx,si
00007031  F3A4              rep movsb
00007033  BFCA09            mov di,0x9ca
00007036  B94C30            mov cx,0x304c
00007039  2BCF              sub cx,di
0000703B  7404              jz 0x7041
0000703D  32C0              xor al,al
0000703F  F3AA              rep stosb
00007041  8EDA              mov ds,dx
00007043  8ED2              mov ss,dx
00007045  BC4C32            mov sp,0x324c
00007048  B044              mov al,0x44
0000704A  A2B907            mov [0x7b9],al
0000704D  BA4303            mov dx,0x343
00007050  EE                out dx,al
00007051  33FF              xor di,di
00007053  8EC7              mov es,di
00007055  B90001            mov cx,0x100
00007058  B80400            mov ax,0x4
0000705B  AB                stosw
0000705C  8CC8              mov ax,cs
0000705E  AB                stosw
0000705F  E2F7              loop 0x7058
00007061  BF0C00            mov di,0xc
00007064  33C0              xor ax,ax
00007066  AB                stosw
00007067  B8FEFF            mov ax,0xfffe
0000706A  AB                stosw
0000706B  BFBC00            mov di,0xbc
0000706E  B8DB11            mov ax,0x11db
00007071  AB                stosw
00007072  BF7001            mov di,0x170
00007075  B8DB11            mov ax,0x11db
00007078  AB                stosw
00007079  BFA800            mov di,0xa8
0000707C  B8DB11            mov ax,0x11db
0000707F  AB                stosw
00007080  BF0001            mov di,0x100
00007083  B8DC11            mov ax,0x11dc
00007086  AB                stosw
00007087  BF8400            mov di,0x84
0000708A  B8F20D            mov ax,0xdf2
0000708D  AB                stosw
0000708E  BF6800            mov di,0x68
00007091  B81252            mov ax,0x5212
00007094  AB                stosw
00007095  BF5C00            mov di,0x5c
00007098  B8A93F            mov ax,0x3fa9
0000709B  AB                stosw
0000709C  BF5800            mov di,0x58
0000709F  B84815            mov ax,0x1548
000070A2  AB                stosw
000070A3  E8E441            call 0xb28a
000070A6  E80736            call 0xa6b0
000070A9  E8C82F            call 0xa074
000070AC  E84D3E            call 0xaefc
000070AF  E8FE04            call 0x75b0
000070B2  E80205            call 0x75b7
000070B5  E8EA2E            call 0x9fa2
000070B8  FB                sti
000070B9  B85B32            mov ax,0x325b
000070BC  C1E804            shr ax,byte 0x4
000070BF  054000            add ax,0x40
000070C2  BB0070            mov bx,0x7000
000070C5  2BD8              sub bx,ax
000070C7  E8452D            call 0x9e0f
000070CA  E88030            call 0xa14d
000070CD  E81A01            call 0x71ea
000070D0  7302              jnc 0x70d4
000070D2  CD4F              int 0x4f
000070D4  BBFFFF            mov bx,0xffff
000070D7  E8BF02            call 0x7399
000070DA  E8C8F8            call 0x69a5
000070DD  E8A638            call 0xa986
000070E0  E8FC41            call 0xb2df
000070E3  E8134C            call 0xbcf9
000070E6  BAE307            mov dx,0x7e3
000070E9  E8B135            call 0xa69d
000070EC  750B              jnz 0x70f9
000070EE  893E0008          mov [0x800],di
000070F2  8C060208          mov [0x802],es
000070F6  E8BE04            call 0x75b7
000070F9  B402              mov ah,0x2
000070FB  B9E803            mov cx,0x3e8
000070FE  BA7D00            mov dx,0x7d
00007101  CD40              int 0x40
00007103  1E                push ds
00007104  BADB07            mov dx,0x7db
00007107  E89335            call 0xa69d
0000710A  750D              jnz 0x7119
0000710C  8BD7              mov dx,di
0000710E  C606860901        mov byte [0x986],0x1
00007113  06                push es
00007114  1F                pop ds
00007115  B409              mov ah,0x9
00007117  CD21              int 0x21
00007119  0E                push cs
0000711A  BAF814            mov dx,0x14f8
0000711D  1F                pop ds
0000711E  B409              mov ah,0x9
00007120  CD21              int 0x21
00007122  1F                pop ds
00007123  B94002            mov cx,0x240
00007126  E82500            call 0x714e
00007129  B98008            mov cx,0x880
0000712C  E81F00            call 0x714e
0000712F  B92020            mov cx,0x2020
00007132  E81900            call 0x714e
00007135  B90880            mov cx,0x8008
00007138  E81300            call 0x714e
0000713B  A0F107            mov al,[0x7f1]
0000713E  8A26F207          mov ah,[0x7f2]
00007142  F6D4              not ah
00007144  22E0              and ah,al
00007146  744D              jz 0x7195
00007148  E85CF1            call 0x62a7
0000714B  E9C44A            jmp 0xbc12
0000714E  BF6400            mov di,0x64
00007151  B755              mov bh,0x55
00007153  B3E8              mov bl,0xe8
00007155  C606F00700        mov byte [0x7f0],0x0
0000715A  8AC7              mov al,bh
0000715C  BA4203            mov dx,0x342
0000715F  EE                out dx,al
00007160  E87F03            call 0x74e2
00007163  BA4003            mov dx,0x340
00007166  EC                in al,dx
00007167  8AE0              mov ah,al
00007169  32FD              xor bh,ch
0000716B  8AC7              mov al,bh
0000716D  BA4203            mov dx,0x342
00007170  EE                out dx,al
00007171  E86E03            call 0x74e2
00007174  BA4003            mov dx,0x340
00007177  EC                in al,dx
00007178  32E0              xor ah,al
0000717A  22DC              and bl,ah
0000717C  0826F007          or [0x7f0],ah
00007180  4F                dec di
00007181  75E4              jnz 0x7167
00007183  22D9              and bl,cl
00007185  081EF107          or [0x7f1],bl
00007189  F6D1              not cl
0000718B  A0F007            mov al,[0x7f0]
0000718E  22C1              and al,cl
00007190  0806F207          or [0x7f2],al
00007194  C3                ret
00007195  E817F2            call 0x63af
00007198  E9774A            jmp 0xbc12
0000719B  CA476E            retf 0x6e47
0000719E  4C                dec sp
0000719F  7B53              jpo 0x71f4
000071A1  1E                push ds
000071A2  44                inc sp
000071A3  4A                dec dx
000071A4  3F                aas
000071A5  F24A              repne dec dx
000071A7  57                push di
000071A8  4B                dec bx
000071A9  8C4BA6            mov [bp+di-0x5a],cs
000071AC  53                push bx
000071AD  6219              bound bx,[bx+di]
000071AF  6C                insb
000071B0  138B1485          adc cx,[bp+di-0x7aec]
000071B4  136F48            adc bp,[bx+0x48]
000071B7  B548              mov ch,0x48
000071B9  C8538D19          enter 0x8d53,0x19
000071BD  D95C11            fstp dword [si+0x11]
000071C0  4C                dec sp
000071C1  A31967            mov [0x6719],ax
000071C4  55                push bp
000071C5  254C3E            and ax,0x3e4c
000071C8  4C                dec sp
000071C9  06                push es
000071CA  44                inc sp
000071CB  52                push dx
000071CC  4C                dec sp
000071CD  A33BEC            mov [0xec3b],ax
000071D0  53                push bx
000071D1  B619              mov dh,0x19
000071D3  2A544D            sub dl,[si+0x4d]
000071D6  19FD              sbb bp,di
000071D8  51                push cx
000071D9  E811CF            call 0x40ed
000071DC  FB                sti
000071DD  53                push bx
000071DE  BB3E00            mov bx,0x3e
000071E1  22DC              and bl,ah
000071E3  2EFFA79B11        jmp [cs:bx+0x119b]
000071E8  CD4F              int 0x4f
000071EA  BAC807            mov dx,0x7c8
000071ED  B8003D            mov ax,0x3d00
000071F0  CD21              int 0x21
000071F2  7301              jnc 0x71f5
000071F4  C3                ret
000071F5  A3D307            mov [0x7d3],ax
000071F8  33D2              xor dx,dx
000071FA  8BCA              mov cx,dx
000071FC  8BD8              mov bx,ax
000071FE  B80242            mov ax,0x4202
00007201  CD21              int 0x21
00007203  72EF              jc 0x71f4
00007205  50                push ax
00007206  33D2              xor dx,dx
00007208  8BCA              mov cx,dx
0000720A  8B1ED307          mov bx,[0x7d3]
0000720E  B80042            mov ax,0x4200
00007211  CD21              int 0x21
00007213  5B                pop bx
00007214  72DE              jc 0x71f4
00007216  53                push bx
00007217  891ED707          mov [0x7d7],bx
0000721B  83C30F            add bx,byte +0xf
0000721E  C1EB04            shr bx,byte 0x4
00007221  B448              mov ah,0x48
00007223  CD21              int 0x21
00007225  72CD              jc 0x71f4
00007227  A3D507            mov [0x7d5],ax
0000722A  8B1ED307          mov bx,[0x7d3]
0000722E  59                pop cx
0000722F  1E                push ds
00007230  8ED8              mov ds,ax
00007232  33D2              xor dx,dx
00007234  B43F              mov ah,0x3f
00007236  CD21              int 0x21
00007238  1F                pop ds
00007239  72B9              jc 0x71f4
0000723B  8B1ED307          mov bx,[0x7d3]
0000723F  8B4702            mov ax,[bx+0x2]
00007242  3D00E0            cmp ax,0xe000
00007245  7303              jnc 0x724a
00007247  A3D907            mov [0x7d9],ax
0000724A  B43E              mov ah,0x3e
0000724C  CD21              int 0x21
0000724E  F8                clc
0000724F  C3                ret
00007250  833ED90700        cmp word [0x7d9],byte +0x0
00007255  7411              jz 0x7268
00007257  1E                push ds
00007258  FF36D507          push word [0x7d5]
0000725C  E88BFF            call 0x71ea
0000725F  7309              jnc 0x726a
00007261  83C402            add sp,byte +0x2
00007264  1F                pop ds
00007265  F9                stc
00007266  C3                ret
00007267  1F                pop ds
00007268  F8                clc
00007269  C3                ret
0000726A  8E06D507          mov es,[0x7d5]
0000726E  1F                pop ds
0000726F  33DB              xor bx,bx
00007271  8B37              mov si,[bx]
00007273  268B3F            mov di,[es:bx]
00007276  8A4414            mov al,[si+0x14]
00007279  263A4514          cmp al,[es:di+0x14]
0000727D  75E8              jnz 0x7267
0000727F  8A541E            mov dl,[si+0x1e]
00007282  32F6              xor dh,dh
00007284  03D2              add dx,dx
00007286  8BEA              mov bp,dx
00007288  03D2              add dx,dx
0000728A  03D5              add dx,bp
0000728C  3BD6              cmp dx,si
0000728E  7202              jc 0x7292
00007290  8BD6              mov dx,si
00007292  268A4D1E          mov cl,[es:di+0x1e]
00007296  32ED              xor ch,ch
00007298  03C9              add cx,cx
0000729A  03C9              add cx,cx
0000729C  3BCF              cmp cx,di
0000729E  7202              jc 0x72a2
000072A0  8BCF              mov cx,di
000072A2  268A4514          mov al,[es:di+0x14]
000072A6  268A651E          mov ah,[es:di+0x1e]
000072AA  50                push ax
000072AB  26FF751A          push word [es:di+0x1a]
000072AF  26FF751C          push word [es:di+0x1c]
000072B3  26FF7537          push word [es:di+0x37]
000072B7  33DB              xor bx,bx
000072B9  3BD1              cmp dx,cx
000072BB  7202              jc 0x72bf
000072BD  8BD1              mov dx,cx
000072BF  8CD8              mov ax,ds
000072C1  E84F00            call 0x7313
000072C4  7416              jz 0x72dc
000072C6  8BC8              mov cx,ax
000072C8  8CC0              mov ax,es
000072CA  E84600            call 0x7313
000072CD  740D              jz 0x72dc
000072CF  3BC1              cmp ax,cx
000072D1  7302              jnc 0x72d5
000072D3  8BC8              mov cx,ax
000072D5  8B37              mov si,[bx]
000072D7  268B3F            mov di,[es:bx]
000072DA  F3A4              rep movsb
000072DC  43                inc bx
000072DD  43                inc bx
000072DE  3BDD              cmp bx,bp
000072E0  7502              jnz 0x72e4
000072E2  03DD              add bx,bp
000072E4  3BDA              cmp bx,dx
000072E6  72D7              jc 0x72bf
000072E8  33FF              xor di,di
000072EA  268B3D            mov di,[es:di]
000072ED  268F4537          pop word [es:di+0x37]
000072F1  268F451C          pop word [es:di+0x1c]
000072F5  268F451A          pop word [es:di+0x1a]
000072F9  58                pop ax
000072FA  26884514          mov [es:di+0x14],al
000072FE  2688651E          mov [es:di+0x1e],ah
00007302  1F                pop ds
00007303  BEC807            mov si,0x7c8
00007306  33DB              xor bx,bx
00007308  8BCB              mov cx,bx
0000730A  8B16D707          mov dx,[0x7d7]
0000730E  B406              mov ah,0x6
00007310  CD40              int 0x40
00007312  C3                ret
00007313  1E                push ds
00007314  51                push cx
00007315  52                push dx
00007316  56                push si
00007317  8ED8              mov ds,ax
00007319  33F6              xor si,si
0000731B  8B14              mov dx,[si]
0000731D  8BF3              mov si,bx
0000731F  AD                lodsw
00007320  85C0              test ax,ax
00007322  741E              jz 0x7342
00007324  53                push bx
00007325  8BDA              mov bx,dx
00007327  8A4F1E            mov cl,[bx+0x1e]
0000732A  32ED              xor ch,ch
0000732C  5B                pop bx
0000732D  03C9              add cx,cx
0000732F  03C9              add cx,cx
00007331  3BCA              cmp cx,dx
00007333  7219              jc 0x734e
00007335  8BC8              mov cx,ax
00007337  3BF2              cmp si,dx
00007339  730C              jnc 0x7347
0000733B  AD                lodsw
0000733C  85C0              test ax,ax
0000733E  74F7              jz 0x7337
00007340  2BC1              sub ax,cx
00007342  5E                pop si
00007343  5A                pop dx
00007344  59                pop cx
00007345  1F                pop ds
00007346  C3                ret
00007347  B80300            mov ax,0x3
0000734A  0BC0              or ax,ax
0000734C  EBF4              jmp short 0x7342
0000734E  03DD              add bx,bp
00007350  8B07              mov ax,[bx]
00007352  2BDD              sub bx,bp
00007354  85C0              test ax,ax
00007356  EBEA              jmp short 0x7342
00007358  8E06D507          mov es,[0x7d5]
0000735C  33DB              xor bx,bx
0000735E  268B1F            mov bx,[es:bx]
00007361  32C0              xor al,al
00007363  2688472E          mov [es:bx+0x2e],al
00007367  26884725          mov [es:bx+0x25],al
0000736B  C3                ret
0000736C  BB4000            mov bx,0x40
0000736F  8EC3              mov es,bx
00007371  268E06D507        mov es,[es:0x7d5]
00007376  33DB              xor bx,bx
00007378  0AD8              or bl,al
0000737A  7405              jz 0x7381
0000737C  03DB              add bx,bx
0000737E  268B1F            mov bx,[es:bx]
00007381  83C402            add sp,byte +0x2
00007384  CF                iret
00007385  5B                pop bx
00007386  60                pusha
00007387  06                push es
00007388  1E                push ds
00007389  BA4000            mov dx,0x40
0000738C  8EDA              mov ds,dx
0000738E  84C0              test al,al
00007390  7503              jnz 0x7395
00007392  E80400            call 0x7399
00007395  1F                pop ds
00007396  07                pop es
00007397  61                popa
00007398  CF                iret
00007399  8E06D507          mov es,[0x7d5]
0000739D  33F6              xor si,si
0000739F  268B34            mov si,[es:si]
000073A2  268A4402          mov al,[es:si+0x2]
000073A6  A2AD07            mov [0x7ad],al
000073A9  A27C09            mov [0x97c],al
000073AC  268A4413          mov al,[es:si+0x13]
000073B0  A2AB07            mov [0x7ab],al
000073B3  268A4403          mov al,[es:si+0x3]
000073B7  A2AC07            mov [0x7ac],al
000073BA  268A4406          mov al,[es:si+0x6]
000073BE  A2B707            mov [0x7b7],al
000073C1  268A4405          mov al,[es:si+0x5]
000073C5  A2B807            mov [0x7b8],al
000073C8  268A4409          mov al,[es:si+0x9]
000073CC  A2A807            mov [0x7a8],al
000073CF  268A440D          mov al,[es:si+0xd]
000073D3  2602440B          add al,[es:si+0xb]
000073D7  A2A907            mov [0x7a9],al
000073DA  268A440A          mov al,[es:si+0xa]
000073DE  A2AA07            mov [0x7aa],al
000073E1  268A440F          mov al,[es:si+0xf]
000073E5  A2B507            mov [0x7b5],al
000073E8  268A4410          mov al,[es:si+0x10]
000073EC  A2B607            mov [0x7b6],al
000073EF  268A441F          mov al,[es:si+0x1f]
000073F3  A2B207            mov [0x7b2],al
000073F6  268A4420          mov al,[es:si+0x20]
000073FA  A2B307            mov [0x7b3],al
000073FD  268A440C          mov al,[es:si+0xc]
00007401  A2B407            mov [0x7b4],al
00007404  268A4416          mov al,[es:si+0x16]
00007408  A2AE07            mov [0x7ae],al
0000740B  268A4415          mov al,[es:si+0x15]
0000740F  A2AF07            mov [0x7af],al
00007412  268A04            mov al,[es:si]
00007415  A2B007            mov [0x7b0],al
00007418  268A4401          mov al,[es:si+0x1]
0000741C  A2B107            mov [0x7b1],al
0000741F  8BC3              mov ax,bx
00007421  A92000            test ax,0x20
00007424  7405              jz 0x742b
00007426  50                push ax
00007427  E88235            call 0xa9ac
0000742A  58                pop ax
0000742B  A808              test al,0x8
0000742D  742B              jz 0x745a
0000742F  50                push ax
00007430  8B1E7809          mov bx,[0x978]
00007434  B400              mov ah,0x0
00007436  8A879900          mov al,[bx+0x99]
0000743A  CD10              int 0x10
0000743C  B401              mov ah,0x1
0000743E  8AAF9C00          mov ch,[bx+0x9c]
00007442  8A8F9D00          mov cl,[bx+0x9d]
00007446  CD10              int 0x10
00007448  B402              mov ah,0x2
0000744A  8AB79E00          mov dh,[bx+0x9e]
0000744E  8A979F00          mov dl,[bx+0x9f]
00007452  CD10              int 0x10
00007454  C687A80001        mov byte [bx+0xa8],0x1
00007459  58                pop ax
0000745A  A802              test al,0x2
0000745C  7405              jz 0x7463
0000745E  50                push ax
0000745F  E8CC2A            call 0x9f2e
00007462  58                pop ax
00007463  A804              test al,0x4
00007465  7405              jz 0x746c
00007467  50                push ax
00007468  E84C01            call 0x75b7
0000746B  58                pop ax
0000746C  A810              test al,0x10
0000746E  7405              jz 0x7475
00007470  50                push ax
00007471  E8DB3A            call 0xaf4f
00007474  58                pop ax
00007475  C3                ret
00007476  06                push es
00007477  56                push si
00007478  8E06D507          mov es,[0x7d5]
0000747C  33F6              xor si,si
0000747E  268B34            mov si,[es:si]
00007481  268A4415          mov al,[es:si+0x15]
00007485  A2AF07            mov [0x7af],al
00007488  5E                pop si
00007489  07                pop es
0000748A  C3                ret
0000748B  50                push ax
0000748C  52                push dx
0000748D  1E                push ds
0000748E  BA4000            mov dx,0x40
00007491  8EDA              mov ds,dx
00007493  BA4303            mov dx,0x343
00007496  84C0              test al,al
00007498  7511              jnz 0x74ab
0000749A  B07F              mov al,0x7f
0000749C  FA                cli
0000749D  2206B907          and al,[0x7b9]
000074A1  A2B907            mov [0x7b9],al
000074A4  EE                out dx,al
000074A5  FB                sti
000074A6  1F                pop ds
000074A7  5A                pop dx
000074A8  58                pop ax
000074A9  5B                pop bx
000074AA  CF                iret
000074AB  B080              mov al,0x80
000074AD  FA                cli
000074AE  0A06B907          or al,[0x7b9]
000074B2  EBED              jmp short 0x74a1
000074B4  BEBA07            mov si,0x7ba
000074B7  33C0              xor ax,ax
000074B9  B90600            mov cx,0x6
000074BC  3B04              cmp ax,[si]
000074BE  7406              jz 0x74c6
000074C0  46                inc si
000074C1  46                inc si
000074C2  E2F8              loop 0x74bc
000074C4  F9                stc
000074C5  C3                ret
000074C6  8936C607          mov [0x7c6],si
000074CA  F8                clc
000074CB  C3                ret
000074CC  BEBA07            mov si,0x7ba
000074CF  B90600            mov cx,0x6
000074D2  3B1C              cmp bx,[si]
000074D4  7406              jz 0x74dc

; ---- 0x074d6-0x074f6  character-generator font / bitmap data  [H08/H21] ----
000074D6  46 46 e2 f8 f9 c3 c7 04 00 00 f8 c3 e8 00 00 e8  |FF..............|
000074E6  0f 00 e8 0c 00 e8 09 00 e8 06 00 e8 03 00 e8 00  |................|

; ---- 0x074f6-0x07536  ASCII text/messages  [H17] ----
000074F6  00 c3 4f 70 65 72 61 74 69 6e 67 20 4b 65 72 6e  |..Operating Kern|
00007506  65 6c 20 43 6f 70 79 72 69 67 68 74 20 28 63 29  |el Copyright (c)|
00007516  20 31 39 39 33 20 43 6f 6d 70 75 74 65 72 20 4c  | 1993 Computer L|
00007526  6f 67 69 63 73 20 4c 69 6d 69 74 65 64 20 2d 20  |ogics Limited - |

; ==== 0x07536-0x07692  CODE (CF-reached, conf 99) ====
00007536  56                push si
00007537  657273            gs jc 0x75ad
0000753A  696F6E2031        imul bp,[bx+0x6e],word 0x3120
0000753F  2E3033            xor [cs:bp+di],dh
00007542  350D0A            xor ax,0xa0d
00007545  2401              and al,0x1
00007547  23FB              and di,bx
00007549  53                push bx
0000754A  56                push si
0000754B  1E                push ds
0000754C  BB4000            mov bx,0x40
0000754F  8EDB              mov ds,bx
00007551  8AC4              mov al,ah
00007553  2403              and al,0x3
00007555  3C01              cmp al,0x1
00007557  7225              jc 0x757e
00007559  7407              jz 0x7562
0000755B  A0F507            mov al,[0x7f5]
0000755E  1F                pop ds
0000755F  5E                pop si
00007560  5B                pop bx
00007561  CF                iret
00007562  8B1E1409          mov bx,[0x914]
00007566  8BB79000          mov si,[bx+0x90]
0000756A  3BB78E00          cmp si,[bx+0x8e]
0000756E  7402              jz 0x7572
00007570  8B04              mov ax,[si]
00007572  1F                pop ds
00007573  5E                pop si
00007574  5B                pop bx
00007575  CA0200            retf 0x2
00007578  50                push ax
00007579  B400              mov ah,0x0
0000757B  CD40              int 0x40
0000757D  58                pop ax
0000757E  8B1E1409          mov bx,[0x914]
00007582  8BB79000          mov si,[bx+0x90]
00007586  3BB78E00          cmp si,[bx+0x8e]
0000758A  74EC              jz 0x7578
0000758C  80FC40            cmp ah,0x40
0000758F  AD                lodsw
00007590  750A              jnz 0x759c
00007592  8B14              mov dx,[si]
00007594  8A0EF407          mov cl,[0x7f4]
00007598  8A2EFB07          mov ch,[0x7fb]
0000759C  46                inc si
0000759D  46                inc si
0000759E  3BB78C00          cmp si,[bx+0x8c]
000075A2  7204              jc 0x75a8
000075A4  8BB78A00          mov si,[bx+0x8a]
000075A8  89B79000          mov [bx+0x90],si
000075AC  1F                pop ds
000075AD  5E                pop si
000075AE  5B                pop bx
000075AF  CF                iret
000075B0  A11409            mov ax,[0x914]
000075B3  A3FE07            mov [0x7fe],ax
000075B6  C3                ret
000075B7  1E                push ds
000075B8  07                pop es
000075B9  0E                push cs
000075BA  1F                pop ds
000075BB  BE241A            mov si,0x1a24
000075BE  BF4A0A            mov di,0xa4a
000075C1  B9CE00            mov cx,0xce
000075C4  F3A5              rep movsw
000075C6  BEC01B            mov si,0x1bc0
000075C9  BF4A0C            mov di,0xc4a
000075CC  B9CE00            mov cx,0xce
000075CF  F3A5              rep movsw
000075D1  BE5C1D            mov si,0x1d5c
000075D4  BF4A0E            mov di,0xe4a
000075D7  B9CE00            mov cx,0xce
000075DA  F3A5              rep movsw
000075DC  BEF81E            mov si,0x1ef8
000075DF  BF4A10            mov di,0x104a
000075E2  B9CE00            mov cx,0xce
000075E5  F3A5              rep movsw
000075E7  BE9420            mov si,0x2094
000075EA  BF4A12            mov di,0x124a
000075ED  B9CE00            mov cx,0xce
000075F0  F3A5              rep movsw
000075F2  BE9420            mov si,0x2094
000075F5  BF4A14            mov di,0x144a
000075F8  B9CE00            mov cx,0xce
000075FB  F3A5              rep movsw
000075FD  06                push es
000075FE  1F                pop ds
000075FF  C606FB0701        mov byte [0x7fb],0x1
00007604  A0B107            mov al,[0x7b1]
00007607  1E                push ds
00007608  E80200            call 0x760d
0000760B  1F                pop ds
0000760C  C3                ret
0000760D  32E4              xor ah,ah
0000760F  8BD8              mov bx,ax
00007611  03DB              add bx,bx
00007613  26C5360008        lds si,[es:0x800]
00007618  8CDA              mov dx,ds
0000761A  85D2              test dx,dx
0000761C  740B              jz 0x7629
0000761E  3A04              cmp al,[si]
00007620  7307              jnc 0x7629
00007622  8B5001            mov dx,[bx+si+0x1]
00007625  85D2              test dx,dx
00007627  7510              jnz 0x7639
00007629  0E                push cs
0000762A  1F                pop ds
0000762B  BE3022            mov si,0x2230
0000762E  3A04              cmp al,[si]
00007630  7359              jnc 0x768b
00007632  8B5001            mov dx,[bx+si+0x1]
00007635  85D2              test dx,dx
00007637  7452              jz 0x768b
00007639  03F2              add si,dx
0000763B  8AE0              mov ah,al
0000763D  AC                lodsb
0000763E  84C0              test al,al
00007640  7810              js 0x7652
00007642  1E                push ds
00007643  56                push si
00007644  3AC4              cmp al,ah
00007646  7505              jnz 0x764d
00007648  E8DEFF            call 0x7629
0000764B  EB03              jmp short 0x7650
0000764D  E8BDFF            call 0x760d
00007650  5E                pop si
00007651  1F                pop ds
00007652  AC                lodsb
00007653  A2FB07            mov [0x7fb],al
00007656  AC                lodsb
00007657  33D2              xor dx,dx
00007659  84C0              test al,al
0000765B  7529              jnz 0x7686
0000765D  B202              mov dl,0x2
0000765F  EB25              jmp short 0x7686
00007661  32E4              xor ah,ah
00007663  03C0              add ax,ax
00007665  BF4A0A            mov di,0xa4a
00007668  03F8              add di,ax
0000766A  A5                movsw
0000766B  81C7FE01          add di,0x1fe
0000766F  A5                movsw
00007670  81C7FE01          add di,0x1fe
00007674  A5                movsw
00007675  81C7FE01          add di,0x1fe
00007679  A5                movsw
0000767A  81C7FE01          add di,0x1fe
0000767E  A5                movsw
0000767F  81C7FE01          add di,0x1fe
00007683  2BF2              sub si,dx
00007685  A5                movsw
00007686  AC                lodsb
00007687  3CFF              cmp al,0xff
00007689  75D6              jnz 0x7661
0000768B  C3                ret
0000768C  C606720900        mov byte [0x972],0x0
00007691  84                db 0x84

; ---- 0x07692-0x076b2  ASCII text/messages  [H17] ----
00007692  e4 74 50 3c 2a 74 4f 3c 36 74 52 3c 45 74 55 3c  |.tP<*tO<6tR<EtU<|
000076A2  3a 74 58 3c 5b 74 5e 3c 1d 74 61 3c 5e 74 73 3c  |:tX<[t^<.ta<^ts<|

; ==== 0x076b2-0x07747  CODE (linear/orphan, conf 80) ====
000076B2  387476            cmp [si+0x76],dh
000076B5  3A067309          cmp al,[0x973]
000076B9  7505              jnz 0x76c0
000076BB  33C0              xor ax,ax
000076BD  A37409            mov [0x974],ax
000076C0  B5FF              mov ch,0xff
000076C2  8A26F507          mov ah,[0x7f5]
000076C6  8A0EF407          mov cl,[0x7f4]
000076CA  8A3EFB07          mov bh,[0x7fb]
000076CE  8A1EAC07          mov bl,[0x7ac]
000076D2  33D2              xor dx,dx
000076D4  8B3EFE07          mov di,[0x7fe]
000076D8  FF9D9200          call far [di+0x92]
000076DC  85D2              test dx,dx
000076DE  7407              jz 0x76e7
000076E0  8BC2              mov ax,dx
000076E2  E94401            jmp 0x7829
000076E5  EB5B              jmp short 0x7742
000076E7  C3                ret
000076E8  8026F507FD        and byte [0x7f5],0xfd
000076ED  EBC6              jmp short 0x76b5
000076EF  8026F507FE        and byte [0x7f5],0xfe
000076F4  EBBF              jmp short 0x76b5
000076F6  8026F607DF        and byte [0x7f6],0xdf
000076FB  EBB8              jmp short 0x76b5
000076FD  8026F607BF        and byte [0x7f6],0xbf
00007702  E83002            call 0x7935
00007705  EBAE              jmp short 0x76b5
00007707  8026F607FE        and byte [0x7f6],0xfe
0000770C  EB05              jmp short 0x7713
0000770E  8026F607FB        and byte [0x7f6],0xfb
00007713  F606F60705        test byte [0x7f6],0x5
00007718  759B              jnz 0x76b5
0000771A  8026F507FB        and byte [0x7f5],0xfb
0000771F  E81302            call 0x7935
00007722  EB91              jmp short 0x76b5
00007724  8026F607FD        and byte [0x7f6],0xfd
00007729  EB05              jmp short 0x7730
0000772B  8026F607F7        and byte [0x7f6],0xf7
00007730  F606F6070A        test byte [0x7f6],0xa
00007735  75EB              jnz 0x7722
00007737  8026F507F7        and byte [0x7f5],0xf7
0000773C  E8F601            call 0x7935
0000773F  E973FF            jmp 0x76b5
00007742  08067B09          or [0x97b],al
00007746  8A                db 0x8a

; ---- 0x07747-0x07767  ASCII text/messages  [H17] ----
00007747  e8 3c 2a 74 22 3c 36 74 25 3c 38 74 3b 3c 5e 74  |.<*t"<6t%<8t;<^t|
00007757  43 3c 1d 74 20 3c 5b 74 28 3c 3a 74 3e 3c 45 75  |C<.t <[t(<:t><Eu|

; ==== 0x07767-0x07a12  CODE (linear/orphan, conf 80) ====
00007767  5B                pop bx
00007768  B020              mov al,0x20
0000776A  B404              mov ah,0x4
0000776C  EB38              jmp short 0x77a6
0000776E  800EF50702        or byte [0x7f5],0x2
00007773  EB4A              jmp short 0x77bf
00007775  800EF50701        or byte [0x7f5],0x1
0000777A  EB43              jmp short 0x77bf
0000777C  800EF60704        or byte [0x7f6],0x4
00007781  800EF50704        or byte [0x7f5],0x4
00007786  EB37              jmp short 0x77bf
00007788  800EF60701        or byte [0x7f6],0x1
0000778D  EBF2              jmp short 0x7781
0000778F  800EF60708        or byte [0x7f6],0x8
00007794  800EF50708        or byte [0x7f5],0x8
00007799  EB24              jmp short 0x77bf
0000779B  800EF60702        or byte [0x7f6],0x2
000077A0  EBF2              jmp short 0x7794
000077A2  B040              mov al,0x40
000077A4  B402              mov ah,0x2
000077A6  8406F607          test [0x7f6],al
000077AA  7513              jnz 0x77bf
000077AC  0806F607          or [0x7f6],al
000077B0  F606F50704        test byte [0x7f5],0x4
000077B5  7508              jnz 0x77bf
000077B7  3006F507          xor [0x7f5],al
000077BB  3026F707          xor [0x7f7],ah
000077BF  33D2              xor dx,dx
000077C1  EB12              jmp short 0x77d5
000077C3  803E7A0900        cmp byte [0x97a],0x0
000077C8  754F              jnz 0x7819
000077CA  A0F507            mov al,[0x7f5]
000077CD  E80201            call 0x78d2
000077D0  7247              jc 0x7819
000077D2  E88D00            call 0x7862
000077D5  8A26F507          mov ah,[0x7f5]
000077D9  8AC5              mov al,ch
000077DB  A27309            mov [0x973],al
000077DE  8A0EF407          mov cl,[0x7f4]
000077E2  32ED              xor ch,ch
000077E4  8A3EFB07          mov bh,[0x7fb]
000077E8  8A1EAC07          mov bl,[0x7ac]
000077EC  8916F907          mov [0x7f9],dx
000077F0  8B3EFE07          mov di,[0x7fe]
000077F4  FF9D9200          call far [di+0x92]
000077F8  3B16F907          cmp dx,[0x7f9]
000077FC  751C              jnz 0x781a
000077FE  80FEFF            cmp dh,0xff
00007801  7517              jnz 0x781a
00007803  80FA06            cmp dl,0x6
00007806  7312              jnc 0x781a
00007808  32F6              xor dh,dh
0000780A  03D2              add dx,dx
0000780C  8BDA              mov bx,dx
0000780E  8B87BA07          mov ax,[bx+0x7ba]
00007812  85C0              test ax,ax
00007814  7403              jz 0x7819
00007816  A3FE07            mov [0x7fe],ax
00007819  C3                ret
0000781A  C606740901        mov byte [0x974],0x1
0000781F  85D2              test dx,dx
00007821  7433              jz 0x7856
00007823  84F6              test dh,dh
00007825  7502              jnz 0x7829
00007827  8AF0              mov dh,al
00007829  8B9D8E00          mov bx,[di+0x8e]
0000782D  8917              mov [bx],dx
0000782F  43                inc bx
00007830  43                inc bx
00007831  8907              mov [bx],ax
00007833  43                inc bx
00007834  43                inc bx
00007835  3B9D8C00          cmp bx,[di+0x8c]
00007839  7204              jc 0x783f
0000783B  8B9D8A00          mov bx,[di+0x8a]
0000783F  3B9D9000          cmp bx,[di+0x90]
00007843  7412              jz 0x7857
00007845  899D8E00          mov [di+0x8e],bx
00007849  803EAC0700        cmp byte [0x7ac],0x0
0000784E  7406              jz 0x7856
00007850  B402              mov ah,0x2
00007852  33D2              xor dx,dx
00007854  CD40              int 0x40
00007856  C3                ret
00007857  B402              mov ah,0x2
00007859  B9E803            mov cx,0x3e8
0000785C  BA7D00            mov dx,0x7d
0000785F  CD40              int 0x40
00007861  C3                ret
00007862  A804              test al,0x4
00007864  7535              jnz 0x789b
00007866  A808              test al,0x8
00007868  7542              jnz 0x78ac
0000786A  A803              test al,0x3
0000786C  7539              jnz 0x78a7
0000786E  80FD47            cmp ch,0x47
00007871  720B              jc 0x787e
00007873  80FD53            cmp ch,0x53
00007876  7706              ja 0x787e
00007878  A820              test al,0x20
0000787A  751A              jnz 0x7896
0000787C  EB3A              jmp short 0x78b8
0000787E  8B1EFE07          mov bx,[0x7fe]
00007882  80BF960000        cmp byte [bx+0x96],0x0
00007887  782F              js 0x78b8
00007889  7504              jnz 0x788f
0000788B  A840              test al,0x40
0000788D  7429              jz 0x78b8
0000788F  803EAB0700        cmp byte [0x7ab],0x0
00007894  7511              jnz 0x78a7
00007896  BB4A0C            mov bx,0xc4a
00007899  EB20              jmp short 0x78bb
0000789B  BB4A10            mov bx,0x104a
0000789E  A803              test al,0x3
000078A0  7419              jz 0x78bb
000078A2  BB4A14            mov bx,0x144a
000078A5  EB14              jmp short 0x78bb
000078A7  BB4A0E            mov bx,0xe4a
000078AA  EB0F              jmp short 0x78bb
000078AC  BB4A12            mov bx,0x124a
000078AF  A803              test al,0x3
000078B1  7408              jz 0x78bb
000078B3  BB4A14            mov bx,0x144a
000078B6  EB03              jmp short 0x78bb
000078B8  BB4A0A            mov bx,0xa4a
000078BB  8AC5              mov al,ch
000078BD  32E4              xor ah,ah
000078BF  03C0              add ax,ax
000078C1  03D8              add bx,ax
000078C3  8B17              mov dx,[bx]
000078C5  C3                ret
000078C6  07                pop es
000078C7  0809              or [bx+di],cl
000078C9  FF04              inc word [si]
000078CB  0506FF            add ax,0xff06
000078CE  0102              add [bp+si],ax
000078D0  0300              add ax,[bx+si]
000078D2  A804              test al,0x4
000078D4  7426              jz 0x78fc
000078D6  A808              test al,0x8
000078D8  7507              jnz 0x78e1
000078DA  F606F60740        test byte [0x7f6],0x40
000078DF  741B              jz 0x78fc
000078E1  80FD47            cmp ch,0x47
000078E4  720F              jc 0x78f5
000078E6  80FD53            cmp ch,0x53
000078E9  730A              jnc 0x78f5
000078EB  80FD4A            cmp ch,0x4a
000078EE  7405              jz 0x78f5
000078F0  80FD4E            cmp ch,0x4e
000078F3  7509              jnz 0x78fe
000078F5  803EFD0700        cmp byte [0x7fd],0x0
000078FA  7528              jnz 0x7924
000078FC  F8                clc
000078FD  C3                ret
000078FE  8AC5              mov al,ch
00007900  BB7F18            mov bx,0x187f
00007903  2ED7              cs xlatb
00007905  8AD8              mov bl,al
00007907  A0FC07            mov al,[0x7fc]
0000790A  B40A              mov ah,0xa
0000790C  F6E4              mul ah
0000790E  02C3              add al,bl
00007910  B401              mov ah,0x1
00007912  A3FC07            mov [0x7fc],ax
00007915  803EAC0700        cmp byte [0x7ac],0x0
0000791A  7406              jz 0x7922
0000791C  B402              mov ah,0x2
0000791E  33D2              xor dx,dx
00007920  CD40              int 0x40
00007922  F9                stc
00007923  C3                ret
00007924  B402              mov ah,0x2
00007926  B9E803            mov cx,0x3e8
00007929  BA7D00            mov dx,0x7d
0000792C  CD40              int 0x40
0000792E  33C0              xor ax,ax
00007930  A3FC07            mov [0x7fc],ax
00007933  F9                stc
00007934  C3                ret
00007935  803EFD0700        cmp byte [0x7fd],0x0
0000793A  7410              jz 0x794c
0000793C  60                pusha
0000793D  8A16FC07          mov dl,[0x7fc]
00007941  33C0              xor ax,ax
00007943  8AF4              mov dh,ah
00007945  A3FC07            mov [0x7fc],ax
00007948  E893FE            call 0x77de
0000794B  61                popa
0000794C  C3                ret
0000794D  1E                push ds
0000794E  BB4000            mov bx,0x40
00007951  8EDB              mov ds,bx
00007953  50                push ax
00007954  51                push cx
00007955  8AE8              mov ch,al
00007957  8AC4              mov al,ah
00007959  E806FF            call 0x7862
0000795C  59                pop cx
0000795D  58                pop ax
0000795E  1F                pop ds
0000795F  5B                pop bx
00007960  CF                iret
00007961  CB                retf
00007962  1E                push ds
00007963  BB4000            mov bx,0x40
00007966  8EDB              mov ds,bx
00007968  8CC3              mov bx,es
0000796A  0BDF              or bx,di
0000796C  8B1E1409          mov bx,[0x914]
00007970  740C              jz 0x797e
00007972  FA                cli
00007973  89BF9200          mov [bx+0x92],di
00007977  8C879400          mov [bx+0x94],es
0000797B  FB                sti
0000797C  EB0C              jmp short 0x798a
0000797E  FA                cli
0000797F  C78792006119      mov word [bx+0x92],0x1961
00007985  8C8F9400          mov [bx+0x94],cs
00007989  FB                sti
0000798A  1F                pop ds
0000798B  5B                pop bx
0000798C  CF                iret
0000798D  1E                push ds
0000798E  BB4000            mov bx,0x40
00007991  8EDB              mov ds,bx
00007993  8B1E1409          mov bx,[0x914]
00007997  88879700          mov [bx+0x97],al
0000799B  808F970080        or byte [bx+0x97],0x80
000079A0  1F                pop ds
000079A1  5B                pop bx
000079A2  CF                iret
000079A3  1E                push ds
000079A4  BB4000            mov bx,0x40
000079A7  8EDB              mov ds,bx
000079A9  A0F407            mov al,[0x7f4]
000079AC  2E8B0E4615        mov cx,[cs:0x1546]
000079B1  8BD1              mov dx,cx
000079B3  1F                pop ds
000079B4  5B                pop bx
000079B5  CF                iret
000079B6  1E                push ds
000079B7  BB4000            mov bx,0x40
000079BA  8EDB              mov ds,bx
000079BC  8B1E1409          mov bx,[0x914]
000079C0  88879600          mov [bx+0x96],al
000079C4  1F                pop ds
000079C5  5B                pop bx
000079C6  CF                iret
000079C7  1E                push ds
000079C8  BB4000            mov bx,0x40
000079CB  8EDB              mov ds,bx
000079CD  8B1E1409          mov bx,[0x914]
000079D1  80BF980000        cmp byte [bx+0x98],0x0
000079D6  750A              jnz 0x79e2
000079D8  8B879000          mov ax,[bx+0x90]
000079DC  3B878E00          cmp ax,[bx+0x8e]
000079E0  7406              jz 0x79e8
000079E2  1F                pop ds
000079E3  5B                pop bx
000079E4  58                pop ax
000079E5  B0FF              mov al,0xff
000079E7  CF                iret
000079E8  1F                pop ds
000079E9  5B                pop bx
000079EA  58                pop ax
000079EB  B000              mov al,0x0
000079ED  CF                iret
000079EE  1E                push ds
000079EF  BB4000            mov bx,0x40
000079F2  8EDB              mov ds,bx
000079F4  8B1E1409          mov bx,[0x914]
000079F8  8A879800          mov al,[bx+0x98]
000079FC  84C0              test al,al
000079FE  740B              jz 0x7a0b
00007A00  C687980000        mov byte [bx+0x98],0x0
00007A05  1F                pop ds
00007A06  5B                pop bx
00007A07  83C402            add sp,byte +0x2
00007A0A  CF                iret
00007A0B  50                push ax
00007A0C  32E4              xor ah,ah
00007A0E  CD16              int 0x16
00007A10  84C0              test al,al

; ---- 0x07a12-0x07c72  character-generator font / bitmap data  [H08/H21] ----
00007A12  74 06 3c e0 75 06 32 c0 88 a7 98 00 5b 8a e7 eb  |t.<.u.2.....[...|
00007A22  e2 00 00 00 1b 00 31 00 32 00 33 00 34 00 35 00  |......1.2.3.4.5.|
00007A32  36 00 37 00 38 00 39 00 30 00 2d 00 3d 00 08 00  |6.7.8.9.0.-.=...|
00007A42  09 00 71 00 77 00 65 00 72 00 74 00 79 00 75 00  |..q.w.e.r.t.y.u.|
00007A52  69 00 6f 00 70 00 5b 00 5d 00 0d 00 00 00 61 00  |i.o.p.[.].....a.|
00007A62  73 00 64 00 66 00 67 00 68 00 6a 00 6b 00 6c 00  |s.d.f.g.h.j.k.l.|
00007A72  3b 00 27 00 60 00 00 00 5c 00 7a 00 78 00 63 00  |;.'.`...\.z.x.c.|
00007A82  76 00 62 00 6e 00 6d 00 2c 00 2e 00 2f 00 00 00  |v.b.n.m.,.../...|
00007A92  ... (480 more bytes)

; ==== 0x07c72-0x07c87  CODE (linear/orphan, conf 80) ====
00007C72  0000              add [bx+si],al
00007C74  0D0000            or ax,0x0
00007C77  002F              add [bx],ch
00007C79  E000              loopne 0x7c7b
00007C7B  37                aaa
00007C7C  0000              add [bx+si],al
00007C7E  0045E0            add [di-0x20],al
00007C81  47                inc di
00007C82  E048              loopne 0x7ccc
00007C84  E049              loopne 0x7ccf
00007C86  E0                db 0xe0

; ---- 0x07c87-0x08227  character-generator font / bitmap data  [H08/H21] ----
00007C87  4b e0 4d e0 4f e0 50 e0 51 e0 52 e0 53 00 b0 00  |K.M.O.P.Q.R.S...|
00007C97  b1 00 b2 00 b3 00 b4 00 b5 00 b6 00 b7 00 b8 00  |................|
00007CA7  b9 00 ba 00 bb 00 bc 00 bd 00 be 00 bf 00 c0 00  |................|
00007CB7  c1 00 c2 00 c3 00 c4 5d 00 7d 00 7c 00 31 00 32  |.......].}.|.1.2|
00007CC7  00 33 00 34 00 35 00 36 00 37 00 38 00 39 00 30  |.3.4.5.6.7.8.9.0|
00007CD7  00 3a 00 3b 00 40 00 5e 00 7c 00 2c 00 2e 00 5b  |.:.;.@.^.|.,...[|
00007CE7  00 5d 00 2f 00 2d 00 3a 00 3c 00 00 f2 00 f3 00  |.]./.-.:.<......|
00007CF7  f4 00 f5 00 f6 00 f7 00 f8 00 f9 00 fa 00 fb 00  |................|
00007D07  ... (1312 more bytes)

; ==== 0x08227-0x0823a  CODE (linear/orphan, conf 80) ====
00008227  800081            add byte [bx+si],0x81
0000822A  0011              add [bx+di],dl
0000822C  002C              add [si],ch
0000822E  00FE              add dh,bh
00008230  1B00              sbb ax,[bx+si]
00008232  009001A7          add [bx+si-0x58ff],dl
00008236  02C4              add al,ah
00008238  0401              add al,0x1

; ---- 0x0823a-0x0988f  character-generator font / bitmap data  [H08/H21] ----
0000823A  08 f4 09 4d 0b 88 0b 94 0c 24 0e 59 10 4c 12 fe  |...M.....$.Y.L..|
0000824A  14 00 00 00 00 37 00 f4 15 00 00 00 00 c0 04 00  |.....7..........|
0000825A  00 00 00 00 00 00 00 00 00 00 00 92 12 0c 01 00  |................|
0000826A  29 b2 00 b2 00 b3 00 00 fe 00 29 02 26 00 26 00  |).........).&.&.|
0000827A  31 00 00 02 7c 00 03 e9 00 e9 00 32 00 00 03 40  |1...|......2...@|
0000828A  00 04 22 00 22 00 33 00 00 04 23 00 05 27 00 27  |..".".3...#..'.'|
0000829A  00 34 00 00 05 00 7b 06 28 00 28 00 35 00 00 06  |.4....{.(.(.5...|
000082AA  00 7c 07 a7 00 a7 00 36 00 00 07 5e 00 08 e8 00  |.|.....6...^....|
000082BA  ... (5589 more bytes)

; ==== 0x0988f-0x09f79  CODE (linear/orphan, conf 80) ====
0000988F  59                pop cx
00009890  0019              add [bx+di],bl
00009892  0000              add [bx+si],al
00009894  15CC79            adc ax,0x79cc
00009897  005900            add [bx+di+0x0],bl
0000989A  59                pop cx
0000989B  0019              add [bx+di],bl
0000989D  0000              add [bx+si],al
0000989F  15FF00            adc ax,0xff
000098A2  5B                pop bx
000098A3  58                pop ax
000098A4  53                push bx
000098A5  51                push cx
000098A6  52                push dx
000098A7  56                push si
000098A8  57                push di
000098A9  06                push es
000098AA  1E                push ds
000098AB  50                push ax
000098AC  1E                push ds
000098AD  52                push dx
000098AE  8BF2              mov si,dx
000098B0  8CDA              mov dx,ds
000098B2  B84000            mov ax,0x40
000098B5  8ED8              mov ds,ax
000098B7  891E0408          mov [0x804],bx
000098BB  8C060608          mov [0x806],es
000098BF  E8240E            call 0xa6e6
000098C2  8B1EC607          mov bx,[0x7c6]
000098C6  85DB              test bx,bx
000098C8  741C              jz 0x98e6
000098CA  A11409            mov ax,[0x914]
000098CD  8907              mov [bx],ax
000098CF  803E730800        cmp byte [0x873],0x0
000098D4  7406              jz 0x98dc
000098D6  A3FE07            mov [0x7fe],ax
000098D9  A37809            mov [0x978],ax
000098DC  33C0              xor ax,ax
000098DE  A3C607            mov [0x7c6],ax
000098E1  C606730800        mov byte [0x873],0x0
000098E6  5A                pop dx
000098E7  1F                pop ds
000098E8  E83A02            call 0x9b25
000098EB  BF4000            mov di,0x40
000098EE  8EDF              mov ds,di
000098F0  8EC7              mov es,di
000098F2  7306              jnc 0x98fa
000098F4  B80200            mov ax,0x2
000098F7  E91402            jmp 0x9b0e
000098FA  A30808            mov [0x808],ax
000098FD  BF1608            mov di,0x816
00009900  B91C00            mov cx,0x1c
00009903  E86A02            call 0x9b70
00009906  72EF              jc 0x98f7
00009908  A11608            mov ax,[0x816]
0000990B  3D4D5A            cmp ax,0x5a4d
0000990E  7429              jz 0x9939
00009910  33C0              xor ax,ax
00009912  A31E08            mov [0x81e],ax
00009915  A31C08            mov [0x81c],ax
00009918  A32008            mov [0x820],ax
0000991B  A32208            mov [0x822],ax
0000991E  A32608            mov [0x826],ax
00009921  B8F0FF            mov ax,0xfff0
00009924  A32C08            mov [0x82c],ax
00009927  A32408            mov [0x824],ax
0000992A  B80001            mov ax,0x100
0000992D  A32A08            mov [0x82a],ax
00009930  33D2              xor dx,dx
00009932  B800FF            mov ax,0xff00
00009935  8BCA              mov cx,dx
00009937  EB23              jmp short 0x995c
00009939  A11A08            mov ax,[0x81a]
0000993C  833E180800        cmp word [0x818],byte +0x0
00009941  7401              jz 0x9944
00009943  48                dec ax
00009944  BB0002            mov bx,0x200
00009947  F7E3              mul bx
00009949  03061808          add ax,[0x818]
0000994D  83D200            adc dx,byte +0x0
00009950  8B0E1E08          mov cx,[0x81e]
00009954  C1E104            shl cx,byte 0x4
00009957  2BC1              sub ax,cx
00009959  83DA00            sbb dx,byte +0x0
0000995C  52                push dx
0000995D  50                push ax
0000995E  E8CA01            call 0x9b2b
00009961  7243              jc 0x99a6
00009963  58                pop ax
00009964  5A                pop dx
00009965  52                push dx
00009966  50                push ax
00009967  050F00            add ax,0xf
0000996A  83D200            adc dx,byte +0x0
0000996D  D1EA              shr dx,1
0000996F  D1D8              rcr ax,1
00009971  D1EA              shr dx,1
00009973  D1D8              rcr ax,1
00009975  D1EA              shr dx,1
00009977  D1D8              rcr ax,1
00009979  D1EA              shr dx,1
0000997B  7526              jnz 0x99a3
0000997D  D1D8              rcr ax,1
0000997F  03062008          add ax,[0x820]
00009983  40                inc ax
00009984  803E720800        cmp byte [0x872],0x0
00009989  7403              jz 0x998e
0000998B  50                push ax
0000998C  EB0D              jmp short 0x999b
0000998E  051000            add ax,0x10
00009991  50                push ax
00009992  B80100            mov ax,0x1
00009995  E8F801            call 0x9b90
00009998  A30A08            mov [0x80a],ax
0000999B  E8FA01            call 0x9b98
0000999E  5B                pop bx
0000999F  3BC3              cmp ax,bx
000099A1  7309              jnc 0x99ac
000099A3  B80800            mov ax,0x8
000099A6  83C404            add sp,byte +0x4
000099A9  E96201            jmp 0x9b0e
000099AC  8B0E2208          mov cx,[0x822]
000099B0  2B0E2008          sub cx,[0x820]
000099B4  720A              jc 0x99c0
000099B6  03D9              add bx,cx
000099B8  7206              jc 0x99c0
000099BA  3BC3              cmp ax,bx
000099BC  7602              jna 0x99c0
000099BE  8BC3              mov ax,bx
000099C0  A30E08            mov [0x80e],ax
000099C3  E8CA01            call 0x9b90
000099C6  72DB              jc 0x99a3
000099C8  A30C08            mov [0x80c],ax
000099CB  803E720800        cmp byte [0x872],0x0
000099D0  750A              jnz 0x99dc
000099D2  8B1E1409          mov bx,[0x914]
000099D6  894704            mov [bx+0x4],ax
000099D9  051000            add ax,0x10
000099DC  A31008            mov [0x810],ax
000099DF  01062408          add [0x824],ax
000099E3  01062C08          add [0x82c],ax
000099E7  59                pop cx
000099E8  5A                pop dx
000099E9  8EC0              mov es,ax
000099EB  33FF              xor di,di
000099ED  E84901            call 0x9b39
000099F0  72B7              jc 0x99a9
000099F2  8B0E1C08          mov cx,[0x81c]
000099F6  E339              jcxz 0x9a31
000099F8  8B0E2E08          mov cx,[0x82e]
000099FC  E82C01            call 0x9b2b
000099FF  72A8              jc 0x99a9
00009A01  8B0E1C08          mov cx,[0x81c]
00009A05  33D2              xor dx,dx
00009A07  4A                dec dx
00009A08  7915              jns 0x9a1f
00009A0A  1E                push ds
00009A0B  07                pop es
00009A0C  BF3208            mov di,0x832
00009A0F  51                push cx
00009A10  B94000            mov cx,0x40
00009A13  E85A01            call 0x9b70
00009A16  59                pop cx
00009A17  7290              jc 0x99a9
00009A19  BE3208            mov si,0x832
00009A1C  BA0F00            mov dx,0xf
00009A1F  AD                lodsw
00009A20  8BD8              mov bx,ax
00009A22  AD                lodsw
00009A23  03061008          add ax,[0x810]
00009A27  8EC0              mov es,ax
00009A29  A11008            mov ax,[0x810]
00009A2C  260107            add [es:bx],ax
00009A2F  E2D6              loop 0x9a07
00009A31  E85301            call 0x9b87
00009A34  803E720800        cmp byte [0x872],0x0
00009A39  7402              jz 0x9a3d
00009A3B  CD4F              int 0x4f
00009A3D  8E060C08          mov es,[0x80c]
00009A41  33FF              xor di,di
00009A43  8BC7              mov ax,di
00009A45  B98000            mov cx,0x80
00009A48  F3AB              rep stosw
00009A4A  33FF              xor di,di
00009A4C  B8CD20            mov ax,0x20cd
00009A4F  AB                stosw
00009A50  A10C08            mov ax,[0x80c]
00009A53  03060E08          add ax,[0x80e]
00009A57  AB                stosw
00009A58  47                inc di
00009A59  B09A              mov al,0x9a
00009A5B  AA                stosb
00009A5C  B8243B            mov ax,0x3b24
00009A5F  AB                stosw
00009A60  8CC8              mov ax,cs
00009A62  AB                stosw
00009A63  B8243B            mov ax,0x3b24
00009A66  AB                stosw
00009A67  8CC8              mov ax,cs
00009A69  AB                stosw
00009A6A  B8243B            mov ax,0x3b24
00009A6D  AB                stosw
00009A6E  8CC8              mov ax,cs
00009A70  AB                stosw
00009A71  B8243B            mov ax,0x3b24
00009A74  AB                stosw
00009A75  8CC8              mov ax,cs
00009A77  AB                stosw
00009A78  BF5000            mov di,0x50
00009A7B  B8CD21            mov ax,0x21cd
00009A7E  AB                stosw
00009A7F  B0CB              mov al,0xcb
00009A81  AA                stosb
00009A82  B020              mov al,0x20
00009A84  1E                push ds
00009A85  C5360408          lds si,[0x804]
00009A89  C57406            lds si,[si+0x6]
00009A8C  BF5C00            mov di,0x5c
00009A8F  B90600            mov cx,0x6
00009A92  F3A5              rep movsw
00009A94  1F                pop ds
00009A95  1E                push ds
00009A96  C5360408          lds si,[0x804]
00009A9A  C5740A            lds si,[si+0xa]
00009A9D  BF6C00            mov di,0x6c
00009AA0  B106              mov cl,0x6
00009AA2  F3A5              rep movsw
00009AA4  1F                pop ds
00009AA5  1E                push ds
00009AA6  C5360408          lds si,[0x804]
00009AAA  C57402            lds si,[si+0x2]
00009AAD  BF8000            mov di,0x80
00009AB0  AC                lodsb
00009AB1  8AC8              mov cl,al
00009AB3  AA                stosb
00009AB4  41                inc cx
00009AB5  F3A4              rep movsb
00009AB7  1F                pop ds
00009AB8  A10A08            mov ax,[0x80a]
00009ABB  BF2C00            mov di,0x2c
00009ABE  AB                stosw
00009ABF  8EC0              mov es,ax
00009AC1  33FF              xor di,di
00009AC3  B8463D            mov ax,0x3d46
00009AC6  AB                stosw
00009AC7  B84D41            mov ax,0x414d
00009ACA  AB                stosw
00009ACB  33C0              xor ax,ax
00009ACD  AB                stosw
00009ACE  40                inc ax
00009ACF  AB                stosw
00009AD0  B8433A            mov ax,0x3a43
00009AD3  AB                stosw
00009AD4  B85C58            mov ax,0x585c
00009AD7  AB                stosw
00009AD8  33C0              xor ax,ax
00009ADA  AB                stosw
00009ADB  B9183B            mov cx,0x3b18
00009ADE  E8C50C            call 0xa7a6
00009AE1  33C0              xor ax,ax
00009AE3  8BD8              mov bx,ax
00009AE5  8BC8              mov cx,ax
00009AE7  8BD0              mov dx,ax
00009AE9  8BF0              mov si,ax
00009AEB  8BF8              mov di,ax
00009AED  8BE8              mov bp,ax
00009AEF  8E162408          mov ss,[0x824]
00009AF3  8B262608          mov sp,[0x826]
00009AF7  6A00              push byte +0x0
00009AF9  FF362C08          push word [0x82c]
00009AFD  FF362A08          push word [0x82a]
00009B01  8E060C08          mov es,[0x80c]
00009B05  8E1E0C08          mov ds,[0x80c]
00009B09  EA0000FDFF        jmp 0xfffd:0x0
00009B0E  83C402            add sp,byte +0x2
00009B11  50                push ax
00009B12  E87E0C            call 0xa793
00009B15  F9                stc
00009B16  EB01              jmp short 0x9b19
00009B18  F8                clc
00009B19  58                pop ax
00009B1A  1F                pop ds
00009B1B  07                pop es
00009B1C  5F                pop di
00009B1D  5E                pop si
00009B1E  5A                pop dx
00009B1F  59                pop cx
00009B20  5B                pop bx
00009B21  CA0200            retf 0x2
00009B24  CB                retf
00009B25  B8003D            mov ax,0x3d00
00009B28  CD21              int 0x21
00009B2A  C3                ret
00009B2B  8BD1              mov dx,cx
00009B2D  33C9              xor cx,cx
00009B2F  8B1E0808          mov bx,[0x808]
00009B33  B80042            mov ax,0x4200
00009B36  CD21              int 0x21
00009B38  C3                ret
00009B39  8B1E0808          mov bx,[0x808]
00009B3D  85D2              test dx,dx
00009B3F  742F              jz 0x9b70
00009B41  51                push cx
00009B42  52                push dx
00009B43  1E                push ds
00009B44  06                push es
00009B45  1F                pop ds
00009B46  8BD7              mov dx,di
00009B48  B90080            mov cx,0x8000
00009B4B  B8003F            mov ax,0x3f00
00009B4E  CD21              int 0x21
00009B50  7233              jc 0x9b85
00009B52  8CD8              mov ax,ds
00009B54  050008            add ax,0x800
00009B57  8ED8              mov ds,ax
00009B59  B90080            mov cx,0x8000
00009B5C  B8003F            mov ax,0x3f00
00009B5F  CD21              int 0x21
00009B61  7222              jc 0x9b85
00009B63  8CD8              mov ax,ds
00009B65  050008            add ax,0x800
00009B68  8EC0              mov es,ax
00009B6A  1F                pop ds
00009B6B  5A                pop dx
00009B6C  59                pop cx
00009B6D  4A                dec dx
00009B6E  75D1              jnz 0x9b41
00009B70  E311              jcxz 0x9b83
00009B72  8B1E0808          mov bx,[0x808]
00009B76  1E                push ds
00009B77  06                push es
00009B78  1F                pop ds
00009B79  8BD7              mov dx,di
00009B7B  B8003F            mov ax,0x3f00
00009B7E  CD21              int 0x21
00009B80  7203              jc 0x9b85
00009B82  1F                pop ds
00009B83  F8                clc
00009B84  C3                ret
00009B85  1F                pop ds
00009B86  C3                ret
00009B87  B43E              mov ah,0x3e
00009B89  8B1E0808          mov bx,[0x808]
00009B8D  CD21              int 0x21
00009B8F  C3                ret
00009B90  8BD8              mov bx,ax
00009B92  B80048            mov ax,0x4800
00009B95  CD21              int 0x21
00009B97  C3                ret
00009B98  BBFFFF            mov bx,0xffff
00009B9B  B80048            mov ax,0x4800
00009B9E  CD21              int 0x21
00009BA0  8BC3              mov ax,bx
00009BA2  C3                ret
00009BA3  1E                push ds
00009BA4  BB4000            mov bx,0x40
00009BA7  8EDB              mov ds,bx
00009BA9  A27408            mov [0x874],al
00009BAC  1F                pop ds
00009BAD  5B                pop bx
00009BAE  CF                iret
00009BAF  003C              add [si],bh
00009BB1  01720D            add [bp+si+0xd],si
00009BB4  7416              jz 0x9bcc
00009BB6  B80100            mov ax,0x1
00009BB9  5B                pop bx
00009BBA  83C402            add sp,byte +0x2
00009BBD  F9                stc
00009BBE  CA0200            retf 0x2
00009BC1  B80000            mov ax,0x0
00009BC4  5B                pop bx
00009BC5  83C402            add sp,byte +0x2
00009BC8  F8                clc
00009BC9  CA0200            retf 0x2
00009BCC  5B                pop bx
00009BCD  58                pop ax
00009BCE  F8                clc
00009BCF  CA0200            retf 0x2
00009BD2  5B                pop bx
00009BD3  53                push bx
00009BD4  06                push es
00009BD5  1E                push ds
00009BD6  51                push cx
00009BD7  52                push dx
00009BD8  56                push si
00009BD9  57                push di
00009BDA  B84000            mov ax,0x40
00009BDD  8ED8              mov ds,ax
00009BDF  8BC3              mov ax,bx
00009BE1  33F6              xor si,si
00009BE3  0BC0              or ax,ax
00009BE5  7503              jnz 0x9bea
00009BE7  EB15              jmp short 0x9bfe
00009BE9  90                nop
00009BEA  8B1E7608          mov bx,[0x876]
00009BEE  8EDB              mov ds,bx
00009BF0  807C0A00          cmp byte [si+0xa],0x0
00009BF4  7438              jz 0x9c2e
00009BF6  8B5C02            mov bx,[si+0x2]
00009BF9  83FB00            cmp bx,byte +0x0
00009BFC  75F0              jnz 0x9bee
00009BFE  B84000            mov ax,0x40
00009C01  8ED8              mov ds,ax
00009C03  A17608            mov ax,[0x876]
00009C06  8ED8              mov ds,ax
00009C08  807C0A00          cmp byte [si+0xa],0x0
00009C0C  7508              jnz 0x9c16
00009C0E  395C06            cmp [si+0x6],bx
00009C11  7203              jc 0x9c16
00009C13  8B5C06            mov bx,[si+0x6]
00009C16  8B4402            mov ax,[si+0x2]
00009C19  3D0000            cmp ax,0x0
00009C1C  75E8              jnz 0x9c06
00009C1E  B80800            mov ax,0x8
00009C21  5F                pop di
00009C22  5E                pop si
00009C23  5A                pop dx
00009C24  59                pop cx
00009C25  1F                pop ds
00009C26  07                pop es
00009C27  83C404            add sp,byte +0x4
00009C2A  F9                stc
00009C2B  CA0200            retf 0x2
00009C2E  394406            cmp [si+0x6],ax
00009C31  72C3              jc 0x9bf6
00009C33  8B5C06            mov bx,[si+0x6]
00009C36  2BD8              sub bx,ax
00009C38  83FB04            cmp bx,byte +0x4
00009C3B  7633              jna 0x9c70
00009C3D  8CDA              mov dx,ds
00009C3F  03D0              add dx,ax
00009C41  42                inc dx
00009C42  8EC2              mov es,dx
00009C44  26C6440A00        mov byte [es:si+0xa],0x0
00009C49  26C7040000        mov word [es:si],0x0
00009C4E  26C744080000      mov word [es:si+0x8],0x0
00009C54  894406            mov [si+0x6],ax
00009C57  4B                dec bx
00009C58  26895C06          mov [es:si+0x6],bx
00009C5C  8B4C02            mov cx,[si+0x2]
00009C5F  8C4402            mov [si+0x2],es
00009C62  268C5C04          mov [es:si+0x4],ds
00009C66  26894C02          mov [es:si+0x2],cx
00009C6A  8EC1              mov es,cx
00009C6C  26895404          mov [es:si+0x4],dx
00009C70  B84000            mov ax,0x40
00009C73  8EC0              mov es,ax
00009C75  26A11409          mov ax,[es:0x914]
00009C79  C7044C43          mov word [si],0x434c
00009C7D  C6440A01          mov byte [si+0xa],0x1
00009C81  894408            mov [si+0x8],ax
00009C84  8CD8              mov ax,ds
00009C86  40                inc ax
00009C87  5F                pop di
00009C88  5E                pop si
00009C89  5A                pop dx
00009C8A  59                pop cx
00009C8B  1F                pop ds
00009C8C  07                pop es
00009C8D  5B                pop bx
00009C8E  83C402            add sp,byte +0x2
00009C91  F8                clc
00009C92  CA0200            retf 0x2
00009C95  5B                pop bx
00009C96  53                push bx
00009C97  51                push cx
00009C98  52                push dx
00009C99  06                push es
00009C9A  1E                push ds
00009C9B  8BCB              mov cx,bx
00009C9D  33DB              xor bx,bx
00009C9F  8CC0              mov ax,es
00009CA1  85C0              test ax,ax
00009CA3  7445              jz 0x9cea
00009CA5  48                dec ax
00009CA6  8EC0              mov es,ax
00009CA8  26813F4C43        cmp word [es:bx],0x434c
00009CAD  7542              jnz 0x9cf1
00009CAF  26807F0A01        cmp byte [es:bx+0xa],0x1
00009CB4  753B              jnz 0x9cf1
00009CB6  268E5F02          mov ds,[es:bx+0x2]
00009CBA  807F0A00          cmp byte [bx+0xa],0x0
00009CBE  7512              jnz 0x9cd2
00009CC0  8B5706            mov dx,[bx+0x6]
00009CC3  42                inc dx
00009CC4  26015706          add [es:bx+0x6],dx
00009CC8  8E5F02            mov ds,[bx+0x2]
00009CCB  8C4704            mov [bx+0x4],es
00009CCE  268C5F02          mov [es:bx+0x2],ds
00009CD2  263B4F06          cmp cx,[es:bx+0x6]
00009CD6  7620              jna 0x9cf8
00009CD8  268B5F06          mov bx,[es:bx+0x6]
00009CDC  B80800            mov ax,0x8
00009CDF  1F                pop ds
00009CE0  07                pop es
00009CE1  5A                pop dx
00009CE2  59                pop cx
00009CE3  83C404            add sp,byte +0x4
00009CE6  F9                stc
00009CE7  CA0200            retf 0x2
00009CEA  B80900            mov ax,0x9
00009CED  33DB              xor bx,bx
00009CEF  EBEE              jmp short 0x9cdf
00009CF1  B80700            mov ax,0x7
00009CF4  33DB              xor bx,bx
00009CF6  EBE7              jmp short 0x9cdf
00009CF8  268B5706          mov dx,[es:bx+0x6]
00009CFC  2BD1              sub dx,cx
00009CFE  83FA04            cmp dx,byte +0x4
00009D01  7631              jna 0x9d34
00009D03  26894F06          mov [es:bx+0x6],cx
00009D07  8CC0              mov ax,es
00009D09  40                inc ax
00009D0A  03C1              add ax,cx
00009D0C  8ED8              mov ds,ax
00009D0E  4A                dec dx
00009D0F  4A                dec dx
00009D10  895706            mov [bx+0x6],dx
00009D13  C6470A00          mov byte [bx+0xa],0x0
00009D17  C7070000          mov word [bx],0x0
00009D1B  C747080000        mov word [bx+0x8],0x0
00009D20  268B5702          mov dx,[es:bx+0x2]
00009D24  268C5F02          mov [es:bx+0x2],ds
00009D28  8C4704            mov [bx+0x4],es
00009D2B  8EC2              mov es,dx
00009D2D  895702            mov [bx+0x2],dx
00009D30  268C5F04          mov [es:bx+0x4],ds
00009D34  1F                pop ds
00009D35  07                pop es
00009D36  5A                pop dx
00009D37  59                pop cx
00009D38  5B                pop bx
00009D39  58                pop ax
00009D3A  F8                clc
00009D3B  CA0200            retf 0x2
00009D3E  51                push cx
00009D3F  52                push dx
00009D40  1E                push ds
00009D41  56                push si
00009D42  57                push di
00009D43  8CC0              mov ax,es
00009D45  0BC0              or ax,ax
00009D47  7510              jnz 0x9d59
00009D49  B80900            mov ax,0x9
00009D4C  5F                pop di
00009D4D  5E                pop si
00009D4E  1F                pop ds
00009D4F  5A                pop dx
00009D50  59                pop cx
00009D51  5B                pop bx
00009D52  83C402            add sp,byte +0x2
00009D55  F9                stc
00009D56  CA0200            retf 0x2
00009D59  E8050C            call 0xa961
00009D5C  48                dec ax
00009D5D  8ED8              mov ds,ax
00009D5F  33F6              xor si,si
00009D61  B80700            mov ax,0x7
00009D64  813C4C43          cmp word [si],0x434c
00009D68  75E2              jnz 0x9d4c
00009D6A  8B4404            mov ax,[si+0x4]
00009D6D  8EC0              mov es,ax
00009D6F  268A5C0A          mov bl,[es:si+0xa]
00009D73  D0E3              shl bl,1
00009D75  8B4402            mov ax,[si+0x2]
00009D78  8EC0              mov es,ax
00009D7A  26025C0A          add bl,[es:si+0xa]
00009D7E  32FF              xor bh,bh
00009D80  D1E3              shl bx,1
00009D82  2EFFA7873D        jmp [cs:bx+0x3d87]
00009D87  8F                db 0x8f
00009D88  3DBB3D            cmp ax,0x3dbb
00009D8B  D93D              fnstcw [di]
00009D8D  F73D              idiv word [di]
00009D8F  8B4402            mov ax,[si+0x2]
00009D92  8B5C04            mov bx,[si+0x4]
00009D95  8EC0              mov es,ax
00009D97  268B4C02          mov cx,[es:si+0x2]
00009D9B  8EC3              mov es,bx
00009D9D  26894C02          mov [es:si+0x2],cx
00009DA1  8EC1              mov es,cx
00009DA3  26895C04          mov [es:si+0x4],bx
00009DA7  8B5406            mov dx,[si+0x6]
00009DAA  8EC0              mov es,ax
00009DAC  26035406          add dx,[es:si+0x6]
00009DB0  83C202            add dx,byte +0x2
00009DB3  8EC3              mov es,bx
00009DB5  26015406          add [es:si+0x6],dx
00009DB9  EB3C              jmp short 0x9df7
00009DBB  8B4402            mov ax,[si+0x2]
00009DBE  8B5C04            mov bx,[si+0x4]
00009DC1  8EC0              mov es,ax
00009DC3  26895C04          mov [es:si+0x4],bx
00009DC7  8EC3              mov es,bx
00009DC9  26894402          mov [es:si+0x2],ax
00009DCD  8B5406            mov dx,[si+0x6]
00009DD0  83C201            add dx,byte +0x1
00009DD3  26015406          add [es:si+0x6],dx
00009DD7  EB1E              jmp short 0x9df7
00009DD9  8B4402            mov ax,[si+0x2]
00009DDC  8EC0              mov es,ax
00009DDE  268B4C02          mov cx,[es:si+0x2]
00009DE2  894C02            mov [si+0x2],cx
00009DE5  8EC1              mov es,cx
00009DE7  268C5C04          mov [es:si+0x4],ds
00009DEB  8EC0              mov es,ax
00009DED  268B5406          mov dx,[es:si+0x6]
00009DF1  83C201            add dx,byte +0x1
00009DF4  015406            add [si+0x6],dx
00009DF7  C6440A00          mov byte [si+0xa],0x0
00009DFB  C7040000          mov word [si],0x0
00009DFF  C744080000        mov word [si+0x8],0x0
00009E04  5F                pop di
00009E05  5E                pop si
00009E06  1F                pop ds
00009E07  5A                pop dx
00009E08  59                pop cx
00009E09  5B                pop bx
00009E0A  58                pop ax
00009E0B  F8                clc
00009E0C  CA0200            retf 0x2
00009E0F  1E                push ds
00009E10  56                push si
00009E11  57                push di
00009E12  33F6              xor si,si
00009E14  A37608            mov [0x876],ax
00009E17  8BF8              mov di,ax
00009E19  8ED8              mov ds,ax
00009E1B  40                inc ax
00009E1C  C6440A01          mov byte [si+0xa],0x1
00009E20  894402            mov [si+0x2],ax
00009E23  C744040000        mov word [si+0x4],0x0
00009E28  C744060000        mov word [si+0x6],0x0
00009E2D  C744080000        mov word [si+0x8],0x0
00009E32  C7040000          mov word [si],0x0
00009E36  8EC0              mov es,ax
00009E38  8BCB              mov cx,bx
00009E3A  83E903            sub cx,byte +0x3
00009E3D  03DF              add bx,di
00009E3F  83EB01            sub bx,byte +0x1
00009E42  26C6440A00        mov byte [es:si+0xa],0x0
00009E47  26895C02          mov [es:si+0x2],bx
00009E4B  268C5C04          mov [es:si+0x4],ds
00009E4F  26894C06          mov [es:si+0x6],cx
00009E53  26C744080000      mov word [es:si+0x8],0x0
00009E59  26C7040000        mov word [es:si],0x0
00009E5E  8EC3              mov es,bx
00009E60  26C6440A01        mov byte [es:si+0xa],0x1
00009E65  26C744020000      mov word [es:si+0x2],0x0
00009E6B  26894404          mov [es:si+0x4],ax
00009E6F  26C744060000      mov word [es:si+0x6],0x0
00009E75  26C744080000      mov word [es:si+0x8],0x0
00009E7B  26C7040000        mov word [es:si],0x0
00009E80  5F                pop di
00009E81  5E                pop si
00009E82  1F                pop ds
00009E83  C3                ret
00009E84  A17608            mov ax,[0x876]
00009E87  33F6              xor si,si
00009E89  8EC0              mov es,ax
00009E8B  26807C0A01        cmp byte [es:si+0xa],0x1
00009E90  7506              jnz 0x9e98
00009E92  263B5C08          cmp bx,[es:si+0x8]
00009E96  7409              jz 0x9ea1
00009E98  268B4402          mov ax,[es:si+0x2]
00009E9C  85C0              test ax,ax
00009E9E  75E9              jnz 0x9e89
00009EA0  C3                ret
00009EA1  53                push bx
00009EA2  40                inc ax
00009EA3  8EC0              mov es,ax
00009EA5  B449              mov ah,0x49
00009EA7  CD21              int 0x21
00009EA9  5B                pop bx
00009EAA  73D8              jnc 0x9e84
00009EAC  CD4F              int 0x4f
00009EAE  56                push si
00009EAF  52                push dx
00009EB0  33F6              xor si,si
00009EB2  33C0              xor ax,ax
00009EB4  8B167608          mov dx,[0x876]
00009EB8  8EC2              mov es,dx
00009EBA  26807C0A01        cmp byte [es:si+0xa],0x1
00009EBF  750A              jnz 0x9ecb
00009EC1  263B5C08          cmp bx,[es:si+0x8]
00009EC5  7504              jnz 0x9ecb
00009EC7  26034406          add ax,[es:si+0x6]
00009ECB  268B5402          mov dx,[es:si+0x2]
00009ECF  85D2              test dx,dx
00009ED1  75E5              jnz 0x9eb8
00009ED3  5A                pop dx
00009ED4  5E                pop si
00009ED5  C3                ret
00009ED6  33DB              xor bx,bx
00009ED8  A17608            mov ax,[0x876]
00009EDB  8EC0              mov es,ax
00009EDD  40                inc ax
00009EDE  E82DCD            call 0x6c0e
00009EE1  BA7808            mov dx,0x878
00009EE4  B409              mov ah,0x9
00009EE6  CD21              int 0x21
00009EE8  268B4706          mov ax,[es:bx+0x6]
00009EEC  E81FCD            call 0x6c0e
00009EEF  BA7B08            mov dx,0x87b
00009EF2  B409              mov ah,0x9
00009EF4  CD21              int 0x21
00009EF6  268A470A          mov al,[es:bx+0xa]
00009EFA  3C00              cmp al,0x0
00009EFC  7418              jz 0x9f16
00009EFE  268B7708          mov si,[es:bx+0x8]
00009F02  8DB4AB00          lea si,[si+0xab]
00009F06  85F6              test si,si
00009F08  7413              jz 0x9f1d
00009F0A  B90C00            mov cx,0xc
00009F0D  AC                lodsb
00009F0E  B40E              mov ah,0xe
00009F10  CD10              int 0x10
00009F12  E2F9              loop 0x9f0d
00009F14  EB07              jmp short 0x9f1d
00009F16  BA8008            mov dx,0x880
00009F19  B409              mov ah,0x9
00009F1B  CD21              int 0x21
00009F1D  BA8808            mov dx,0x888
00009F20  B409              mov ah,0x9
00009F22  CD21              int 0x21
00009F24  268B4702          mov ax,[es:bx+0x2]
00009F28  85C0              test ax,ax
00009F2A  75AF              jnz 0x9edb
00009F2C  C3                ret
00009F2D  00A0B007          add [bx+si+0x7b0],ah
00009F31  A29708            mov [0x897],al
00009F34  BA9008            mov dx,0x890
00009F37  E86307            call 0xa69d
00009F3A  7405              jz 0x9f41
00009F3C  0E                push cs
00009F3D  07                pop es
00009F3E  BF7E3F            mov di,0x3f7e
00009F41  8C068E08          mov [0x88e],es
00009F45  893E8C08          mov [0x88c],di
00009F49  C3                ret
00009F4A  1E                push ds
00009F4B  56                push si
00009F4C  53                push bx
00009F4D  51                push cx
00009F4E  BE4000            mov si,0x40
00009F51  8EDE              mov ds,si
00009F53  C5368C08          lds si,[0x88c]
00009F57  AD                lodsw
00009F58  8BDA              mov bx,dx
00009F5A  3BD8              cmp bx,ax
00009F5C  7202              jc 0x9f60
00009F5E  33DB              xor bx,bx
00009F60  03DB              add bx,bx
00009F62  03C0              add ax,ax
00009F64  0330              add si,[bx+si]
00009F66  03F0              add si,ax
00009F68  33C0              xor ax,ax
00009F6A  E309              jcxz 0x9f75
00009F6C  803C00            cmp byte [si],0x0
00009F6F  7404              jz 0x9f75
00009F71  A4                movsb
00009F72  40                inc ax
00009F73  E2F7              loop 0x9f6c
00009F75  59                pop cx
00009F76  5B                pop bx
00009F77  5E                pop si
00009F78  1F                pop ds

; ---- 0x09f79-0x09f99  character-generator font / bitmap data  [H08/H21] ----
00009F79  f8 5b ca 02 00 04 00 00 00 05 00 0b 00 11 00 54  |.[.............T|
00009F89  65 78 74 00 54 65 78 74 31 00 54 65 78 74 32 00  |ext.Text1.Text2.|

; ==== 0x09f99-0x0ad64  CODE (CF-reached, conf 99) ====
00009F99  54                push sp
00009F9A  686520            push word 0x2065
00009F9D  45                inc bp
00009F9E  6E                outsb
00009F9F  640000            add [fs:bx+si],al
00009FA2  33D2              xor dx,dx
00009FA4  B401              mov ah,0x1
00009FA6  CD17              int 0x17
00009FA8  C3                ret
00009FA9  FB                sti
00009FAA  53                push bx
00009FAB  52                push dx
00009FAC  1E                push ds
00009FAD  50                push ax
00009FAE  BB4000            mov bx,0x40
00009FB1  8EDB              mov ds,bx
00009FB3  80FC01            cmp ah,0x1
00009FB6  7743              ja 0x9ffb
00009FB8  7447              jz 0xa001
00009FBA  85D2              test dx,dx
00009FBC  7549              jnz 0xa007
00009FBE  8AD8              mov bl,al
00009FC0  32FF              xor bh,bh
00009FC2  BA4003            mov dx,0x340
00009FC5  EC                in al,dx
00009FC6  A880              test al,0x80
00009FC8  7539              jnz 0xa003
00009FCA  8AC3              mov al,bl
00009FCC  BA4203            mov dx,0x342
00009FCF  EE                out dx,al
00009FD0  E812D5            call 0x74e5
00009FD3  BA4103            mov dx,0x341
00009FD6  B009              mov al,0x9
00009FD8  FA                cli
00009FD9  0A069A08          or al,[0x89a]
00009FDD  EE                out dx,al
00009FDE  E80DD5            call 0x74ee
00009FE1  24FE              and al,0xfe
00009FE3  A29A08            mov [0x89a],al
00009FE6  EE                out dx,al
00009FE7  FB                sti
00009FE8  32FF              xor bh,bh
00009FEA  BA4003            mov dx,0x340
00009FED  EC                in al,dx
00009FEE  24F8              and al,0xf8
00009FF0  34C8              xor al,0xc8
00009FF2  0AF8              or bh,al
00009FF4  58                pop ax
00009FF5  8AE7              mov ah,bh
00009FF7  1F                pop ds
00009FF8  5A                pop dx
00009FF9  5B                pop bx
00009FFA  CF                iret
00009FFB  85D2              test dx,dx
00009FFD  751F              jnz 0xa01e
00009FFF  EBE7              jmp short 0x9fe8
0000A001  EB3D              jmp short 0xa040
0000A003  B701              mov bh,0x1
0000A005  EBE3              jmp short 0x9fea
0000A007  B701              mov bh,0x1
0000A009  803EA80701        cmp byte [0x7a8],0x1
0000A00E  7407              jz 0xa017
0000A010  803EA80702        cmp byte [0x7a8],0x2
0000A015  7509              jnz 0xa020
0000A017  9AFC4B00F6        call 0xf600:0x4bfc
0000A01C  72E5              jc 0xa003
0000A01E  32FF              xor bh,bh
0000A020  53                push bx
0000A021  9A494B00F6        call 0xf600:0x4b49
0000A026  5B                pop bx
0000A027  A880              test al,0x80
0000A029  7504              jnz 0xa02f
0000A02B  A810              test al,0x10
0000A02D  7505              jnz 0xa034
0000A02F  80CF28            or bh,0x28
0000A032  EBC0              jmp short 0x9ff4
0000A034  80CF10            or bh,0x10
0000A037  A820              test al,0x20
0000A039  74B9              jz 0x9ff4
0000A03B  80CF80            or bh,0x80
0000A03E  EBB4              jmp short 0x9ff4
0000A040  85D2              test dx,dx
0000A042  752E              jnz 0xa072
0000A044  BA4103            mov dx,0x341
0000A047  FA                cli
0000A048  A09A08            mov al,[0x89a]
0000A04B  0C0C              or al,0xc
0000A04D  EE                out dx,al
0000A04E  A29A08            mov [0x89a],al
0000A051  FB                sti
0000A052  8B1E6809          mov bx,[0x968]
0000A056  B400              mov ah,0x0
0000A058  CD40              int 0x40
0000A05A  A16809            mov ax,[0x968]
0000A05D  2BC3              sub ax,bx
0000A05F  3D1900            cmp ax,0x19
0000A062  72F2              jc 0xa056
0000A064  FA                cli
0000A065  A09A08            mov al,[0x89a]
0000A068  24FB              and al,0xfb
0000A06A  EE                out dx,al
0000A06B  A29A08            mov [0x89a],al
0000A06E  FB                sti
0000A06F  E976FF            jmp 0x9fe8
0000A072  EBAA              jmp short 0xa01e
0000A074  33FF              xor di,di
0000A076  B800A0            mov ax,0xa000
0000A079  8EC0              mov es,ax
0000A07B  B090              mov al,0x90
0000A07D  268805            mov [es:di],al
0000A080  268B05            mov ax,[es:di]
0000A083  BBA908            mov bx,0x8a9
0000A086  3D8995            cmp ax,0x9589
0000A089  7413              jz 0xa09e
0000A08B  BBA108            mov bx,0x8a1
0000A08E  3D8994            cmp ax,0x9489
0000A091  740B              jz 0xa09e
0000A093  BAF108            mov dx,0x8f1
0000A096  B409              mov ah,0x9
0000A098  CD21              int 0x21
0000A09A  47                inc di
0000A09B  E91FCF            jmp 0x6fbd
0000A09E  B0FF              mov al,0xff
0000A0A0  268805            mov [es:di],al
0000A0A3  B80080            mov ax,0x8000
0000A0A6  8EC0              mov es,ax
0000A0A8  B090              mov al,0x90
0000A0AA  268805            mov [es:di],al
0000A0AD  268B05            mov ax,[es:di]
0000A0B0  BEA908            mov si,0x8a9
0000A0B3  3D8995            cmp ax,0x9589
0000A0B6  7408              jz 0xa0c0
0000A0B8  BEA108            mov si,0x8a1
0000A0BB  3D8994            cmp ax,0x9489
0000A0BE  75D3              jnz 0xa093
0000A0C0  B0FF              mov al,0xff
0000A0C2  268805            mov [es:di],al
0000A0C5  33ED              xor bp,bp
0000A0C7  B90800            mov cx,0x8
0000A0CA  BFB108            mov di,0x8b1
0000A0CD  AD                lodsw
0000A0CE  03C5              add ax,bp
0000A0D0  8905              mov [di],ax
0000A0D2  B81200            mov ax,0x12
0000A0D5  8B5502            mov dx,[di+0x2]
0000A0D8  2BD0              sub dx,ax
0000A0DA  894504            mov [di+0x4],ax
0000A0DD  895506            mov [di+0x6],dx
0000A0E0  81F50020          xor bp,0x2000
0000A0E4  87F3              xchg si,bx
0000A0E6  83C708            add di,byte +0x8
0000A0E9  E2E2              loop 0xa0cd
0000A0EB  BEB108            mov si,0x8b1
0000A0EE  8E04              mov es,[si]
0000A0F0  BF0E01            mov di,0x10e
0000A0F3  268A05            mov al,[es:di]
0000A0F6  84C0              test al,al
0000A0F8  7432              jz 0xa12c
0000A0FA  FEC0              inc al
0000A0FC  742E              jz 0xa12c
0000A0FE  268B4510          mov ax,[es:di+0x10]
0000A102  268B550C          mov dx,[es:di+0xc]
0000A106  268B4D0E          mov cx,[es:di+0xe]
0000A10A  83C20F            add dx,byte +0xf
0000A10D  83D100            adc cx,byte +0x0
0000A110  C1EA04            shr dx,byte 0x4
0000A113  C1C904            ror cx,byte 0x4
0000A116  0BD1              or dx,cx
0000A118  03C2              add ax,dx
0000A11A  3B4404            cmp ax,[si+0x4]
0000A11D  720D              jc 0xa12c
0000A11F  894404            mov [si+0x4],ax
0000A122  8B4C02            mov cx,[si+0x2]
0000A125  2BC8              sub cx,ax
0000A127  7217              jc 0xa140
0000A129  894C06            mov [si+0x6],cx
0000A12C  83EF12            sub di,byte +0x12
0000A12F  73C2              jnc 0xa0f3
0000A131  83C608            add si,byte +0x8
0000A134  81FEF108          cmp si,0x8f1
0000A138  72B4              jc 0xa0ee
0000A13A  C606A00800        mov byte [0x8a0],0x0
0000A13F  C3                ret
0000A140  BAFF08            mov dx,0x8ff
0000A143  B409              mov ah,0x9
0000A145  CD21              int 0x21
0000A147  C606A00801        mov byte [0x8a0],0x1
0000A14C  C3                ret
0000A14D  BB0002            mov bx,0x200
0000A150  B448              mov ah,0x48
0000A152  CD21              int 0x21
0000A154  7207              jc 0xa15d
0000A156  A39C08            mov [0x89c],ax
0000A159  891E9E08          mov [0x89e],bx
0000A15D  C3                ret
0000A15E  51                push cx
0000A15F  52                push dx
0000A160  56                push si
0000A161  57                push di
0000A162  1E                push ds
0000A163  06                push es
0000A164  E85100            call 0xa1b8
0000A167  E88E00            call 0xa1f8
0000A16A  7411              jz 0xa17d
0000A16C  B80200            mov ax,0x2
0000A16F  07                pop es
0000A170  1F                pop ds
0000A171  5F                pop di
0000A172  5E                pop si
0000A173  5A                pop dx
0000A174  59                pop cx
0000A175  5B                pop bx
0000A176  83C402            add sp,byte +0x2
0000A179  F9                stc
0000A17A  CA0200            retf 0x2
0000A17D  BB4A16            mov bx,0x164a
0000A180  33C0              xor ax,ax
0000A182  3B4708            cmp ax,[bx+0x8]
0000A185  740E              jz 0xa195
0000A187  83C30A            add bx,byte +0xa
0000A18A  81FBCA18          cmp bx,0x18ca
0000A18E  72F2              jc 0xa182
0000A190  B80400            mov ax,0x4
0000A193  EBDA              jmp short 0xa16f
0000A195  A11409            mov ax,[0x914]
0000A198  894708            mov [bx+0x8],ax
0000A19B  893F              mov [bx],di
0000A19D  8C4702            mov [bx+0x2],es
0000A1A0  33C0              xor ax,ax
0000A1A2  894704            mov [bx+0x4],ax
0000A1A5  894706            mov [bx+0x6],ax
0000A1A8  8BC3              mov ax,bx
0000A1AA  07                pop es
0000A1AB  1F                pop ds
0000A1AC  5F                pop di
0000A1AD  5E                pop si
0000A1AE  5A                pop dx
0000A1AF  59                pop cx
0000A1B0  5B                pop bx
0000A1B1  83C402            add sp,byte +0x2
0000A1B4  F8                clc
0000A1B5  CA0200            retf 0x2
0000A1B8  8BF2              mov si,dx
0000A1BA  BF4000            mov di,0x40
0000A1BD  8EC7              mov es,di
0000A1BF  BFCB18            mov di,0x18cb
0000A1C2  B90C00            mov cx,0xc
0000A1C5  AC                lodsb
0000A1C6  3C3A              cmp al,0x3a
0000A1C8  74F5              jz 0xa1bf
0000A1CA  3C5C              cmp al,0x5c
0000A1CC  74F1              jz 0xa1bf
0000A1CE  3C20              cmp al,0x20
0000A1D0  7610              jna 0xa1e2
0000A1D2  E3F1              jcxz 0xa1c5
0000A1D4  3C61              cmp al,0x61
0000A1D6  7206              jc 0xa1de
0000A1D8  3C7A              cmp al,0x7a
0000A1DA  7702              ja 0xa1de
0000A1DC  2C20              sub al,0x20
0000A1DE  AA                stosb
0000A1DF  49                dec cx
0000A1E0  EBE3              jmp short 0xa1c5
0000A1E2  268A45FF          mov al,[es:di-0x1]
0000A1E6  3C2E              cmp al,0x2e
0000A1E8  7502              jnz 0xa1ec
0000A1EA  4F                dec di
0000A1EB  41                inc cx
0000A1EC  E304              jcxz 0xa1f2
0000A1EE  B020              mov al,0x20
0000A1F0  F3AA              rep stosb
0000A1F2  B84000            mov ax,0x40
0000A1F5  8ED8              mov ds,ax
0000A1F7  C3                ret
0000A1F8  803EA00800        cmp byte [0x8a0],0x0
0000A1FD  7515              jnz 0xa214
0000A1FF  BEB108            mov si,0x8b1
0000A202  56                push si
0000A203  8B04              mov ax,[si]
0000A205  E81300            call 0xa21b
0000A208  5E                pop si
0000A209  740F              jz 0xa21a
0000A20B  83C608            add si,byte +0x8
0000A20E  81FEF108          cmp si,0x8f1
0000A212  72EE              jc 0xa202
0000A214  B800E0            mov ax,0xe000
0000A217  E80100            call 0xa21b
0000A21A  C3                ret
0000A21B  33FF              xor di,di
0000A21D  8EC0              mov es,ax
0000A21F  BECB18            mov si,0x18cb
0000A222  B90600            mov cx,0x6
0000A225  8BD7              mov dx,di
0000A227  F3A7              repe cmpsw
0000A229  8BFA              mov di,dx
0000A22B  740B              jz 0xa238
0000A22D  83C712            add di,byte +0x12
0000A230  81FF2001          cmp di,0x120
0000A234  72E9              jc 0xa21f
0000A236  0BFF              or di,di
0000A238  C3                ret
0000A239  5B                pop bx
0000A23A  1E                push ds
0000A23B  B84000            mov ax,0x40
0000A23E  8ED8              mov ds,ax
0000A240  81FB4A16          cmp bx,0x164a
0000A244  7217              jc 0xa25d
0000A246  81FBCA18          cmp bx,0x18ca
0000A24A  7311              jnc 0xa25d
0000A24C  A11409            mov ax,[0x914]
0000A24F  2B4708            sub ax,[bx+0x8]
0000A252  7509              jnz 0xa25d
0000A254  894708            mov [bx+0x8],ax
0000A257  1F                pop ds
0000A258  58                pop ax
0000A259  F8                clc
0000A25A  CA0200            retf 0x2
0000A25D  B80600            mov ax,0x6
0000A260  1F                pop ds
0000A261  83C402            add sp,byte +0x2
0000A264  F9                stc
0000A265  CA0200            retf 0x2
0000A268  5B                pop bx
0000A269  1E                push ds
0000A26A  B84000            mov ax,0x40
0000A26D  8ED8              mov ds,ax
0000A26F  81FB4A16          cmp bx,0x164a
0000A273  72E8              jc 0xa25d
0000A275  81FBCA18          cmp bx,0x18ca
0000A279  73E2              jnc 0xa25d
0000A27B  A11409            mov ax,[0x914]
0000A27E  3B4708            cmp ax,[bx+0x8]
0000A281  75DA              jnz 0xa25d
0000A283  58                pop ax
0000A284  50                push ax
0000A285  51                push cx
0000A286  52                push dx
0000A287  56                push si
0000A288  57                push di
0000A289  06                push es
0000A28A  50                push ax
0000A28B  52                push dx
0000A28C  C43F              les di,[bx]
0000A28E  268B450C          mov ax,[es:di+0xc]
0000A292  268B550E          mov dx,[es:di+0xe]
0000A296  2B4704            sub ax,[bx+0x4]
0000A299  1B5706            sbb dx,[bx+0x6]
0000A29C  7506              jnz 0xa2a4
0000A29E  3BC1              cmp ax,cx
0000A2A0  7302              jnc 0xa2a4
0000A2A2  8BC8              mov cx,ax
0000A2A4  E337              jcxz 0xa2dd
0000A2A6  8B4704            mov ax,[bx+0x4]
0000A2A9  8B5706            mov dx,[bx+0x6]
0000A2AC  BE0F00            mov si,0xf
0000A2AF  23F0              and si,ax
0000A2B1  C1E804            shr ax,byte 0x4
0000A2B4  C1CA04            ror dx,byte 0x4
0000A2B7  0BC2              or ax,dx
0000A2B9  26034510          add ax,[es:di+0x10]
0000A2BD  8CC2              mov dx,es
0000A2BF  03C2              add ax,dx
0000A2C1  014F04            add [bx+0x4],cx
0000A2C4  83570600          adc word [bx+0x6],byte +0x0
0000A2C8  8ED8              mov ds,ax
0000A2CA  5F                pop di
0000A2CB  07                pop es
0000A2CC  8BC1              mov ax,cx
0000A2CE  F3A4              rep movsb
0000A2D0  07                pop es
0000A2D1  5F                pop di
0000A2D2  5E                pop si
0000A2D3  5A                pop dx
0000A2D4  59                pop cx
0000A2D5  1F                pop ds
0000A2D6  83C402            add sp,byte +0x2
0000A2D9  F8                clc
0000A2DA  CA0200            retf 0x2
0000A2DD  83C404            add sp,byte +0x4
0000A2E0  33C0              xor ax,ax
0000A2E2  EBEC              jmp short 0xa2d0
0000A2E4  83C402            add sp,byte +0x2
0000A2E7  E973FF            jmp 0xa25d
0000A2EA  5B                pop bx
0000A2EB  83FB05            cmp bx,byte +0x5
0000A2EE  73F7              jnc 0xa2e7
0000A2F0  56                push si
0000A2F1  51                push cx
0000A2F2  8BF2              mov si,dx
0000A2F4  AC                lodsb
0000A2F5  B40E              mov ah,0xe
0000A2F7  CD10              int 0x10
0000A2F9  E2F9              loop 0xa2f4
0000A2FB  59                pop cx
0000A2FC  5E                pop si
0000A2FD  83C402            add sp,byte +0x2
0000A300  8BC1              mov ax,cx
0000A302  F8                clc
0000A303  CA0200            retf 0x2
0000A306  5B                pop bx
0000A307  1E                push ds
0000A308  50                push ax
0000A309  B84000            mov ax,0x40
0000A30C  8ED8              mov ds,ax
0000A30E  81FB4A16          cmp bx,0x164a
0000A312  72D0              jc 0xa2e4
0000A314  81FBCA18          cmp bx,0x18ca
0000A318  73CA              jnc 0xa2e4
0000A31A  A11409            mov ax,[0x914]
0000A31D  3B4708            cmp ax,[bx+0x8]
0000A320  75C2              jnz 0xa2e4
0000A322  58                pop ax
0000A323  06                push es
0000A324  57                push di
0000A325  51                push cx
0000A326  C43F              les di,[bx]
0000A328  3C01              cmp al,0x1
0000A32A  7208              jc 0xa334
0000A32C  7729              ja 0xa357
0000A32E  035704            add dx,[bx+0x4]
0000A331  134F06            adc cx,[bx+0x6]
0000A334  263B4D0E          cmp cx,[es:di+0xe]
0000A338  7731              ja 0xa36b
0000A33A  7206              jc 0xa342
0000A33C  263B550C          cmp dx,[es:di+0xc]
0000A340  7729              ja 0xa36b
0000A342  8BC2              mov ax,dx
0000A344  8BD1              mov dx,cx
0000A346  894704            mov [bx+0x4],ax
0000A349  895706            mov [bx+0x6],dx
0000A34C  59                pop cx
0000A34D  5F                pop di
0000A34E  07                pop es
0000A34F  1F                pop ds
0000A350  83C402            add sp,byte +0x2
0000A353  F8                clc
0000A354  CA0200            retf 0x2
0000A357  268B450C          mov ax,[es:di+0xc]
0000A35B  2BC2              sub ax,dx
0000A35D  268B550E          mov dx,[es:di+0xe]
0000A361  2BD1              sub dx,cx
0000A363  73E1              jnc 0xa346
0000A365  33C0              xor ax,ax
0000A367  8BD0              mov dx,ax
0000A369  EBDB              jmp short 0xa346
0000A36B  268B450C          mov ax,[es:di+0xc]
0000A36F  268B550E          mov dx,[es:di+0xe]
0000A373  EBD1              jmp short 0xa346
0000A375  84C0              test al,al
0000A377  7502              jnz 0xa37b
0000A379  33C9              xor cx,cx
0000A37B  5B                pop bx
0000A37C  58                pop ax
0000A37D  F8                clc
0000A37E  CA0200            retf 0x2
0000A381  5B                pop bx
0000A382  84C0              test al,al
0000A384  7402              jz 0xa388
0000A386  CD4F              int 0x4f
0000A388  81FB4A16          cmp bx,0x164a
0000A38C  720E              jc 0xa39c
0000A38E  81FBCA18          cmp bx,0x18ca
0000A392  7312              jnc 0xa3a6
0000A394  BA0200            mov dx,0x2
0000A397  58                pop ax
0000A398  F8                clc
0000A399  CA0200            retf 0x2
0000A39C  83FB05            cmp bx,byte +0x5
0000A39F  7305              jnc 0xa3a6
0000A3A1  BA8000            mov dx,0x80
0000A3A4  EBF1              jmp short 0xa397
0000A3A6  B80600            mov ax,0x6
0000A3A9  83C402            add sp,byte +0x2
0000A3AC  F9                stc
0000A3AD  CA0200            retf 0x2
0000A3B0  51                push cx
0000A3B1  52                push dx
0000A3B2  56                push si
0000A3B3  57                push di
0000A3B4  1E                push ds
0000A3B5  06                push es
0000A3B6  E8FFFD            call 0xa1b8
0000A3B9  E83CFE            call 0xa1f8
0000A3BC  7537              jnz 0xa3f5
0000A3BE  06                push es
0000A3BF  8BF7              mov si,di
0000A3C1  8B1E1409          mov bx,[0x914]
0000A3C5  8E4704            mov es,[bx+0x4]
0000A3C8  BF8000            mov di,0x80
0000A3CB  33C0              xor ax,ax
0000A3CD  B90D00            mov cx,0xd
0000A3D0  F3AB              rep stosw
0000A3D2  1F                pop ds
0000A3D3  8B440C            mov ax,[si+0xc]
0000A3D6  AB                stosw
0000A3D7  8B440E            mov ax,[si+0xe]
0000A3DA  AB                stosw
0000A3DB  B90C00            mov cx,0xc
0000A3DE  AC                lodsb
0000A3DF  3C20              cmp al,0x20
0000A3E1  7603              jna 0xa3e6
0000A3E3  AA                stosb
0000A3E4  E2F8              loop 0xa3de
0000A3E6  32C0              xor al,al
0000A3E8  AA                stosb
0000A3E9  07                pop es
0000A3EA  1F                pop ds
0000A3EB  5F                pop di
0000A3EC  5E                pop si
0000A3ED  5A                pop dx
0000A3EE  59                pop cx
0000A3EF  5B                pop bx
0000A3F0  58                pop ax
0000A3F1  F8                clc
0000A3F2  CA0200            retf 0x2
0000A3F5  07                pop es
0000A3F6  1F                pop ds
0000A3F7  5F                pop di
0000A3F8  5E                pop si
0000A3F9  5A                pop dx
0000A3FA  59                pop cx
0000A3FB  B80200            mov ax,0x2
0000A3FE  5B                pop bx
0000A3FF  83C402            add sp,byte +0x2
0000A402  F9                stc
0000A403  CA0200            retf 0x2
0000A406  1E                push ds
0000A407  BB4000            mov bx,0x40
0000A40A  8EDB              mov ds,bx
0000A40C  A19E08            mov ax,[0x89e]
0000A40F  8B169C08          mov dx,[0x89c]
0000A413  890E9E08          mov [0x89e],cx
0000A417  8C069C08          mov [0x89c],es
0000A41B  1F                pop ds
0000A41C  5B                pop bx
0000A41D  CF                iret
0000A41E  5B                pop bx
0000A41F  C8000000          enter 0x0,0x0
0000A423  1E                push ds
0000A424  56                push si
0000A425  06                push es
0000A426  53                push bx
0000A427  51                push cx
0000A428  52                push dx
0000A429  57                push di
0000A42A  BF4000            mov di,0x40
0000A42D  8EC7              mov es,di
0000A42F  BFCB18            mov di,0x18cb
0000A432  AC                lodsb
0000A433  3C20              cmp al,0x20
0000A435  7257              jc 0xa48e
0000A437  3C5C              cmp al,0x5c
0000A439  74F4              jz 0xa42f
0000A43B  3C61              cmp al,0x61
0000A43D  7206              jc 0xa445
0000A43F  3C7A              cmp al,0x7a
0000A441  7702              ja 0xa445
0000A443  2C20              sub al,0x20
0000A445  81FFD718          cmp di,0x18d7
0000A449  7301              jnc 0xa44c
0000A44B  AA                stosb
0000A44C  AC                lodsb
0000A44D  3C20              cmp al,0x20
0000A44F  77E6              ja 0xa437
0000A451  B020              mov al,0x20
0000A453  268A65FF          mov ah,[es:di-0x1]
0000A457  80FC2E            cmp ah,0x2e
0000A45A  7502              jnz 0xa45e
0000A45C  4F                dec di
0000A45D  AA                stosb
0000A45E  81FFD718          cmp di,0x18d7
0000A462  72F9              jc 0xa45d
0000A464  B84000            mov ax,0x40
0000A467  8ED8              mov ds,ax
0000A469  BEB108            mov si,0x8b1
0000A46C  803EA00800        cmp byte [0x8a0],0x0
0000A471  7517              jnz 0xa48a
0000A473  56                push si
0000A474  8B04              mov ax,[si]
0000A476  E8A2FD            call 0xa21b
0000A479  751F              jnz 0xa49a
0000A47B  BECA18            mov si,0x18ca
0000A47E  B90100            mov cx,0x1
0000A481  E8E000            call 0xa564
0000A484  740D              jz 0xa493
0000A486  B005              mov al,0x5
0000A488  EB06              jmp short 0xa490
0000A48A  B0FF              mov al,0xff
0000A48C  EB5A              jmp short 0xa4e8
0000A48E  B001              mov al,0x1
0000A490  5E                pop si
0000A491  EB55              jmp short 0xa4e8
0000A493  5E                pop si
0000A494  56                push si
0000A495  E8E900            call 0xa581
0000A498  75F6              jnz 0xa490
0000A49A  5E                pop si
0000A49B  83C608            add si,byte +0x8
0000A49E  81FEF108          cmp si,0x8f1
0000A4A2  72C8              jc 0xa46c
0000A4A4  8B46F4            mov ax,[bp-0xc]
0000A4A7  8B56F6            mov dx,[bp-0xa]
0000A4AA  A3D718            mov [0x18d7],ax
0000A4AD  8916D918          mov [0x18d9],dx
0000A4B1  050F00            add ax,0xf
0000A4B4  83D200            adc dx,byte +0x0
0000A4B7  83FA02            cmp dx,byte +0x2
0000A4BA  732A              jnc 0xa4e6
0000A4BC  C1CA04            ror dx,byte 0x4
0000A4BF  C1E804            shr ax,byte 0x4
0000A4C2  0BC2              or ax,dx
0000A4C4  BEB108            mov si,0x8b1
0000A4C7  B90800            mov cx,0x8
0000A4CA  3B4406            cmp ax,[si+0x6]
0000A4CD  7712              ja 0xa4e1
0000A4CF  8E04              mov es,[si]
0000A4D1  BF0E01            mov di,0x10e
0000A4D4  BAFFFF            mov dx,0xffff
0000A4D7  263B15            cmp dx,[es:di]
0000A4DA  7411              jz 0xa4ed
0000A4DC  83EF12            sub di,byte +0x12
0000A4DF  79F6              jns 0xa4d7
0000A4E1  83C608            add si,byte +0x8
0000A4E4  E2E4              loop 0xa4ca
0000A4E6  B002              mov al,0x2
0000A4E8  32E4              xor ah,ah
0000A4EA  F9                stc
0000A4EB  EB3D              jmp short 0xa52a
0000A4ED  56                push si
0000A4EE  8B4C04            mov cx,[si+0x4]
0000A4F1  890EDB18          mov [0x18db],cx
0000A4F5  294406            sub [si+0x6],ax
0000A4F8  014404            add [si+0x4],ax
0000A4FB  BECB18            mov si,0x18cb
0000A4FE  B91200            mov cx,0x12
0000A501  E86000            call 0xa564
0000A504  5E                pop si
0000A505  7559              jnz 0xa560
0000A507  A1DB18            mov ax,[0x18db]
0000A50A  0304              add ax,[si]
0000A50C  8EC0              mov es,ax
0000A50E  33FF              xor di,di
0000A510  C576F8            lds si,[bp-0x8]
0000A513  837EF600          cmp word [bp-0xa],byte +0x0
0000A517  751C              jnz 0xa535
0000A519  817EF40080        cmp word [bp-0xc],0x8000
0000A51E  7715              ja 0xa535
0000A520  8B4EF4            mov cx,[bp-0xc]
0000A523  E83E00            call 0xa564
0000A526  7534              jnz 0xa55c
0000A528  33C0              xor ax,ax
0000A52A  5F                pop di
0000A52B  5A                pop dx
0000A52C  59                pop cx
0000A52D  5B                pop bx
0000A52E  07                pop es
0000A52F  5E                pop si
0000A530  1F                pop ds
0000A531  C9                leave
0000A532  CA0200            retf 0x2
0000A535  B90080            mov cx,0x8000
0000A538  E82900            call 0xa564
0000A53B  751F              jnz 0xa55c
0000A53D  8CC0              mov ax,es
0000A53F  050008            add ax,0x800
0000A542  8EC0              mov es,ax
0000A544  33FF              xor di,di
0000A546  8CD8              mov ax,ds
0000A548  050008            add ax,0x800
0000A54B  8ED8              mov ds,ax
0000A54D  81EE0080          sub si,0x8000
0000A551  816EF40080        sub word [bp-0xc],0x8000
0000A556  835EF600          sbb word [bp-0xa],byte +0x0
0000A55A  EBB7              jmp short 0xa513
0000A55C  B003              mov al,0x3
0000A55E  EB88              jmp short 0xa4e8
0000A560  B004              mov al,0x4
0000A562  EB84              jmp short 0xa4e8
0000A564  B050              mov al,0x50
0000A566  AA                stosb
0000A567  4F                dec di
0000A568  B040              mov al,0x40
0000A56A  AA                stosb
0000A56B  AC                lodsb
0000A56C  4F                dec di
0000A56D  AA                stosb
0000A56E  268A45FF          mov al,[es:di-0x1]
0000A572  A880              test al,0x80
0000A574  74F8              jz 0xa56e
0000A576  E2F0              loop 0xa568
0000A578  B4FF              mov ah,0xff
0000A57A  268865FF          mov [es:di-0x1],ah
0000A57E  A810              test al,0x10
0000A580  C3                ret
0000A581  8B4402            mov ax,[si+0x2]
0000A584  3B069E08          cmp ax,[0x89e]
0000A588  7603              jna 0xa58d
0000A58A  32C0              xor al,al
0000A58C  C3                ret
0000A58D  55                push bp
0000A58E  56                push si
0000A58F  1E                push ds
0000A590  8E069C08          mov es,[0x89c]
0000A594  8E1C              mov ds,[si]
0000A596  3D0010            cmp ax,0x1000
0000A599  721C              jc 0xa5b7
0000A59B  B90080            mov cx,0x8000
0000A59E  33F6              xor si,si
0000A5A0  8BFE              mov di,si
0000A5A2  2D0010            sub ax,0x1000
0000A5A5  F3A5              rep movsw
0000A5A7  8CD9              mov cx,ds
0000A5A9  81C10010          add cx,0x1000
0000A5AD  8ED9              mov ds,cx
0000A5AF  8CC1              mov cx,es
0000A5B1  81C10010          add cx,0x1000
0000A5B5  8EC1              mov es,cx
0000A5B7  8BC8              mov cx,ax
0000A5B9  C1E103            shl cx,byte 0x3
0000A5BC  33F6              xor si,si
0000A5BE  8BFE              mov di,si
0000A5C0  F3A5              rep movsw
0000A5C2  1F                pop ds
0000A5C3  5B                pop bx
0000A5C4  8E07              mov es,[bx]
0000A5C6  33FF              xor di,di
0000A5C8  B050              mov al,0x50
0000A5CA  268805            mov [es:di],al
0000A5CD  B020              mov al,0x20
0000A5CF  268805            mov [es:di],al
0000A5D2  B0D0              mov al,0xd0
0000A5D4  268805            mov [es:di],al
0000A5D7  268A05            mov al,[es:di]
0000A5DA  A880              test al,0x80
0000A5DC  74F9              jz 0xa5d7
0000A5DE  B450              mov ah,0x50
0000A5E0  268825            mov [es:di],ah
0000A5E3  B4FF              mov ah,0xff
0000A5E5  268825            mov [es:di],ah
0000A5E8  A820              test al,0x20
0000A5EA  7406              jz 0xa5f2
0000A5EC  B006              mov al,0x6
0000A5EE  84C0              test al,al
0000A5F0  5D                pop bp
0000A5F1  C3                ret
0000A5F2  B81200            mov ax,0x12
0000A5F5  8B5702            mov dx,[bx+0x2]
0000A5F8  2BD0              sub dx,ax
0000A5FA  894704            mov [bx+0x4],ax
0000A5FD  895706            mov [bx+0x6],dx
0000A600  8CDA              mov dx,ds
0000A602  8E07              mov es,[bx]
0000A604  8E1E9C08          mov ds,[0x89c]
0000A608  BE0E01            mov si,0x10e
0000A60B  8BFE              mov di,si
0000A60D  8A04              mov al,[si]
0000A60F  84C0              test al,al
0000A611  747F              jz 0xa692
0000A613  3CFF              cmp al,0xff
0000A615  747B              jz 0xa692
0000A617  8B6C10            mov bp,[si+0x10]
0000A61A  8B440C            mov ax,[si+0xc]
0000A61D  8B4C0E            mov cx,[si+0xe]
0000A620  050F00            add ax,0xf
0000A623  83D100            adc cx,byte +0x0
0000A626  C1C904            ror cx,byte 0x4
0000A629  C1E804            shr ax,byte 0x4
0000A62C  0BC1              or ax,cx
0000A62E  06                push es
0000A62F  8EC2              mov es,dx
0000A631  268B4F04          mov cx,[es:bx+0x4]
0000A635  894C10            mov [si+0x10],cx
0000A638  26294706          sub [es:bx+0x6],ax
0000A63C  26014704          add [es:bx+0x4],ax
0000A640  07                pop es
0000A641  06                push es
0000A642  57                push di
0000A643  1E                push ds
0000A644  56                push si
0000A645  50                push ax
0000A646  8CC0              mov ax,es
0000A648  03C8              add cx,ax
0000A64A  51                push cx
0000A64B  B91200            mov cx,0x12
0000A64E  E813FF            call 0xa564
0000A651  07                pop es
0000A652  59                pop cx
0000A653  8CD8              mov ax,ds
0000A655  03C5              add ax,bp
0000A657  8ED8              mov ds,ax
0000A659  81F90008          cmp cx,0x800
0000A65D  7222              jc 0xa681
0000A65F  81E90008          sub cx,0x800
0000A663  51                push cx
0000A664  B90080            mov cx,0x8000
0000A667  33F6              xor si,si
0000A669  33FF              xor di,di
0000A66B  E8F6FE            call 0xa564
0000A66E  59                pop cx
0000A66F  8CD8              mov ax,ds
0000A671  050008            add ax,0x800
0000A674  8ED8              mov ds,ax
0000A676  8CC0              mov ax,es
0000A678  050008            add ax,0x800
0000A67B  8EC0              mov es,ax
0000A67D  EBDA              jmp short 0xa659
0000A67F  EB8C              jmp short 0xa60d
0000A681  C1E104            shl cx,byte 0x4
0000A684  33F6              xor si,si
0000A686  33FF              xor di,di
0000A688  E8D9FE            call 0xa564
0000A68B  5E                pop si
0000A68C  1F                pop ds
0000A68D  5F                pop di
0000A68E  07                pop es
0000A68F  83EF12            sub di,byte +0x12
0000A692  83EE12            sub si,byte +0x12
0000A695  73E8              jnc 0xa67f
0000A697  8EDA              mov ds,dx
0000A699  5D                pop bp
0000A69A  32C0              xor al,al
0000A69C  C3                ret
0000A69D  E818FB            call 0xa1b8
0000A6A0  E855FB            call 0xa1f8
0000A6A3  750A              jnz 0xa6af
0000A6A5  8CC0              mov ax,es
0000A6A7  26034510          add ax,[es:di+0x10]
0000A6AB  8EC0              mov es,ax
0000A6AD  33FF              xor di,di
0000A6AF  C3                ret
0000A6B0  33C0              xor ax,ax
0000A6B2  8EC0              mov es,ax
0000A6B4  BF8000            mov di,0x80
0000A6B7  B80D49            mov ax,0x490d
0000A6BA  FA                cli
0000A6BB  AB                stosw
0000A6BC  8CC8              mov ax,cs
0000A6BE  AB                stosw
0000A6BF  FB                sti
0000A6C0  BF9C00            mov di,0x9c
0000A6C3  B8C648            mov ax,0x48c6
0000A6C6  FA                cli
0000A6C7  AB                stosw
0000A6C8  8CC8              mov ax,cs
0000A6CA  AB                stosw
0000A6CB  FB                sti
0000A6CC  8CDA              mov dx,ds
0000A6CE  BE1A09            mov si,0x91a
0000A6D1  E81200            call 0xa6e6
0000A6D4  891E1609          mov [0x916],bx
0000A6D8  891E1409          mov [0x914],bx
0000A6DC  891EBA07          mov [0x7ba],bx
0000A6E0  C747040000        mov word [bx+0x4],0x0
0000A6E5  C3                ret
0000A6E6  8B1E1609          mov bx,[0x916]
0000A6EA  C687A600FF        mov byte [bx+0xa6],0xff
0000A6EF  BBDE18            mov bx,0x18de
0000A6F2  32C0              xor al,al
0000A6F4  3A87A700          cmp al,[bx+0xa7]
0000A6F8  740C              jz 0xa706
0000A6FA  81C3B800          add bx,0xb8
0000A6FE  81FB5E24          cmp bx,0x245e
0000A702  72F0              jc 0xa6f4
0000A704  CD4F              int 0x4f
0000A706  8DBFAB00          lea di,[bx+0xab]
0000A70A  1E                push ds
0000A70B  07                pop es
0000A70C  B90C00            mov cx,0xc
0000A70F  8EDA              mov ds,dx
0000A711  AC                lodsb
0000A712  84C0              test al,al
0000A714  7405              jz 0xa71b
0000A716  AA                stosb
0000A717  E2F8              loop 0xa711
0000A719  EB02              jmp short 0xa71d
0000A71B  F3AA              rep stosb
0000A71D  06                push es
0000A71E  1F                pop ds
0000A71F  C687990007        mov byte [bx+0x99],0x7
0000A724  C6879B0050        mov byte [bx+0x9b],0x50
0000A729  C6879C000F        mov byte [bx+0x9c],0xf
0000A72E  C6879D0010        mov byte [bx+0x9d],0x10
0000A733  C6879E0000        mov byte [bx+0x9e],0x0
0000A738  C6879F0000        mov byte [bx+0x9f],0x0
0000A73D  C687B70000        mov byte [bx+0xb7],0x0
0000A742  C687A00000        mov byte [bx+0xa0],0x0
0000A747  C687A10001        mov byte [bx+0xa1],0x1
0000A74C  C687A20002        mov byte [bx+0xa2],0x2
0000A751  C687A30003        mov byte [bx+0xa3],0x3
0000A756  C687A80001        mov byte [bx+0xa8],0x1
0000A75B  8D470A            lea ax,[bx+0xa]
0000A75E  89878A00          mov [bx+0x8a],ax
0000A762  89878E00          mov [bx+0x8e],ax
0000A766  89879000          mov [bx+0x90],ax
0000A76A  058000            add ax,0x80
0000A76D  89878C00          mov [bx+0x8c],ax
0000A771  B86119            mov ax,0x1961
0000A774  89879200          mov [bx+0x92],ax
0000A778  8C8F9400          mov [bx+0x94],cs
0000A77C  A11609            mov ax,[0x916]
0000A77F  894706            mov [bx+0x6],ax
0000A782  C74704FFFF        mov word [bx+0x4],0xffff
0000A787  FA                cli
0000A788  C687A700FF        mov byte [bx+0xa7],0xff
0000A78D  891E1409          mov [0x914],bx
0000A791  FB                sti
0000A792  C3                ret
0000A793  8B1E1409          mov bx,[0x914]
0000A797  C687A70000        mov byte [bx+0xa7],0x0
0000A79C  E8E5F6            call 0x9e84
0000A79F  A11609            mov ax,[0x916]
0000A7A2  A31409            mov [0x914],ax
0000A7A5  C3                ret
0000A7A6  58                pop ax
0000A7A7  9C                pushf
0000A7A8  0E                push cs
0000A7A9  51                push cx
0000A7AA  60                pusha
0000A7AB  06                push es
0000A7AC  1E                push ds
0000A7AD  8B1E1609          mov bx,[0x916]
0000A7B1  C687A700FF        mov byte [bx+0xa7],0xff
0000A7B6  8C17              mov [bx],ss
0000A7B8  896702            mov [bx+0x2],sp
0000A7BB  8B1E1409          mov bx,[0x914]
0000A7BF  891E1609          mov [0x916],bx
0000A7C3  C687A70001        mov byte [bx+0xa7],0x1
0000A7C8  FFE0              jmp ax
0000A7CA  FB                sti
0000A7CB  5B                pop bx
0000A7CC  60                pusha
0000A7CD  06                push es
0000A7CE  1E                push ds
0000A7CF  BB4000            mov bx,0x40
0000A7D2  8EDB              mov ds,bx
0000A7D4  8B1E1409          mov bx,[0x914]
0000A7D8  3B1E1609          cmp bx,[0x916]
0000A7DC  7405              jz 0xa7e3
0000A7DE  A11609            mov ax,[0x916]
0000A7E1  CD4F              int 0x4f
0000A7E3  8C17              mov [bx],ss
0000A7E5  896702            mov [bx+0x2],sp
0000A7E8  C687A700FF        mov byte [bx+0xa7],0xff
0000A7ED  A1FE07            mov ax,[0x7fe]
0000A7F0  3B067809          cmp ax,[0x978]
0000A7F4  7534              jnz 0xa82a
0000A7F6  81C3B800          add bx,0xb8
0000A7FA  81FB5E24          cmp bx,0x245e
0000A7FE  7203              jc 0xa803
0000A800  BBDE18            mov bx,0x18de
0000A803  80BFA70000        cmp byte [bx+0xa7],0x0
0000A808  79EC              jns 0xa7f6
0000A80A  FA                cli
0000A80B  891E1609          mov [0x916],bx
0000A80F  891E1409          mov [0x914],bx
0000A813  C687A70001        mov byte [bx+0xa7],0x1
0000A818  8E17              mov ss,[bx]
0000A81A  8B6702            mov sp,[bx+0x2]
0000A81D  FB                sti
0000A81E  32C0              xor al,al
0000A820  2A87A800          sub al,[bx+0xa8]
0000A824  1F                pop ds
0000A825  07                pop es
0000A826  61                popa
0000A827  CA0200            retf 0x2
0000A82A  53                push bx
0000A82B  8B1E7809          mov bx,[0x978]
0000A82F  891E1809          mov [0x918],bx
0000A833  A37809            mov [0x978],ax
0000A836  A31409            mov [0x914],ax
0000A839  8BD8              mov bx,ax
0000A83B  8AAF9C00          mov ch,[bx+0x9c]
0000A83F  8A8F9D00          mov cl,[bx+0x9d]
0000A843  8AB79E00          mov dh,[bx+0x9e]
0000A847  8A979F00          mov dl,[bx+0x9f]
0000A84B  52                push dx
0000A84C  51                push cx
0000A84D  B400              mov ah,0x0
0000A84F  8A879900          mov al,[bx+0x99]
0000A853  CD10              int 0x10
0000A855  B438              mov ah,0x38
0000A857  8A879A00          mov al,[bx+0x9a]
0000A85B  CD40              int 0x40
0000A85D  B401              mov ah,0x1
0000A85F  59                pop cx
0000A860  CD10              int 0x10
0000A862  B402              mov ah,0x2
0000A864  5A                pop dx
0000A865  CD10              int 0x10
0000A867  C687A80001        mov byte [bx+0xa8],0x1
0000A86C  5B                pop bx
0000A86D  EB87              jmp short 0xa7f6
0000A86F  1E                push ds
0000A870  BB4000            mov bx,0x40
0000A873  8EDB              mov ds,bx
0000A875  85D2              test dx,dx
0000A877  7410              jz 0xa889
0000A879  81FADE18          cmp dx,0x18de
0000A87D  7216              jc 0xa895
0000A87F  81FA5E24          cmp dx,0x245e
0000A883  7304              jnc 0xa889
0000A885  8916FE07          mov [0x7fe],dx
0000A889  A11809            mov ax,[0x918]
0000A88C  8BD8              mov bx,ax
0000A88E  8B97A900          mov dx,[bx+0xa9]
0000A892  1F                pop ds
0000A893  5B                pop bx
0000A894  CF                iret
0000A895  BBDE18            mov bx,0x18de
0000A898  80BFA70000        cmp byte [bx+0xa7],0x0
0000A89D  7406              jz 0xa8a5
0000A89F  3A97A900          cmp dl,[bx+0xa9]
0000A8A3  740C              jz 0xa8b1
0000A8A5  81C3B800          add bx,0xb8
0000A8A9  81FB5E24          cmp bx,0x245e
0000A8AD  72E9              jc 0xa898
0000A8AF  EBD8              jmp short 0xa889
0000A8B1  8BD3              mov dx,bx
0000A8B3  EBD0              jmp short 0xa885
0000A8B5  1E                push ds
0000A8B6  BB4000            mov bx,0x40
0000A8B9  8EDB              mov ds,bx
0000A8BB  8B1E1409          mov bx,[0x914]
0000A8BF  8997A900          mov [bx+0xa9],dx
0000A8C3  1F                pop ds
0000A8C4  5B                pop bx
0000A8C5  CF                iret
0000A8C6  83C20F            add dx,byte +0xf
0000A8C9  C1EA04            shr dx,byte 0x4
0000A8CC  BB4000            mov bx,0x40
0000A8CF  8EDB              mov ds,bx
0000A8D1  8B1E1409          mov bx,[0x914]
0000A8D5  3B1E1609          cmp bx,[0x916]
0000A8D9  7402              jz 0xa8dd
0000A8DB  CD4F              int 0x4f
0000A8DD  8B7F06            mov di,[bx+0x6]
0000A8E0  85FF              test di,di
0000A8E2  7409              jz 0xa8ed
0000A8E4  8885A500          mov [di+0xa5],al
0000A8E8  C685A60003        mov byte [di+0xa6],0x3
0000A8ED  C687A70002        mov byte [bx+0xa7],0x2
0000A8F2  8CD8              mov ax,ds
0000A8F4  8ED0              mov ss,ax
0000A8F6  BC5E25            mov sp,0x255e
0000A8F9  8E4704            mov es,[bx+0x4]
0000A8FC  8BDA              mov bx,dx
0000A8FE  B44A              mov ah,0x4a
0000A900  CD21              int 0x21
0000A902  8B1E1409          mov bx,[0x914]
0000A906  7302              jnc 0xa90a
0000A908  CD4F              int 0x4f
0000A90A  E9E9FE            jmp 0xa7f6
0000A90D  32C0              xor al,al
0000A90F  BB4000            mov bx,0x40
0000A912  8EDB              mov ds,bx
0000A914  8B1E1409          mov bx,[0x914]
0000A918  3B1E1609          cmp bx,[0x916]
0000A91C  7402              jz 0xa920
0000A91E  CD4F              int 0x4f
0000A920  8B7F06            mov di,[bx+0x6]
0000A923  85FF              test di,di
0000A925  7409              jz 0xa930
0000A927  8885A500          mov [di+0xa5],al
0000A92B  C685A60000        mov byte [di+0xa6],0x0
0000A930  E899CB            call 0x74cc
0000A933  C687A70000        mov byte [bx+0xa7],0x0
0000A938  8CD8              mov ax,ds
0000A93A  8ED0              mov ss,ax
0000A93C  BC5E25            mov sp,0x255e
0000A93F  E842F5            call 0x9e84
0000A942  8B1E1409          mov bx,[0x914]
0000A946  E9ADFE            jmp 0xa7f6
0000A949  1E                push ds
0000A94A  BB4000            mov bx,0x40
0000A94D  8EDB              mov ds,bx
0000A94F  8B1E1409          mov bx,[0x914]
0000A953  8A87A500          mov al,[bx+0xa5]
0000A957  8AA7A600          mov ah,[bx+0xa6]
0000A95B  1F                pop ds
0000A95C  5B                pop bx
0000A95D  83C402            add sp,byte +0x2
0000A960  CF                iret
0000A961  BE4000            mov si,0x40
0000A964  8EDE              mov ds,si
0000A966  BEDE18            mov si,0x18de
0000A969  80BCA70002        cmp byte [si+0xa7],0x2
0000A96E  7505              jnz 0xa975
0000A970  3B4404            cmp ax,[si+0x4]
0000A973  740B              jz 0xa980
0000A975  81C6B800          add si,0xb8
0000A979  81FE5E24          cmp si,0x245e
0000A97D  72EA              jc 0xa969
0000A97F  C3                ret
0000A980  C684A70000        mov byte [si+0xa7],0x0
0000A985  C3                ret
0000A986  33FF              xor di,di
0000A988  8EC7              mov es,di
0000A98A  BF5000            mov di,0x50
0000A98D  B8ED49            mov ax,0x49ed
0000A990  FA                cli
0000A991  AB                stosw
0000A992  8CC8              mov ax,cs
0000A994  AB                stosw
0000A995  FB                sti
0000A996  BF5400            mov di,0x54
0000A999  B8ED49            mov ax,0x49ed
0000A99C  FA                cli
0000A99D  AB                stosw
0000A99E  8CC8              mov ax,cs
0000A9A0  AB                stosw
0000A9A1  FB                sti
0000A9A2  BA14FF            mov dx,0xff14
0000A9A5  FA                cli
0000A9A6  ED                in ax,dx
0000A9A7  25F7FF            and ax,0xfff7
0000A9AA  EE                out dx,al
0000A9AB  FB                sti
0000A9AC  A0A907            mov al,[0x7a9]
0000A9AF  BB2609            mov bx,0x926
0000A9B2  D7                xlatb
0000A9B3  32E4              xor ah,ah
0000A9B5  A35109            mov [0x951],ax
0000A9B8  BA64FF            mov dx,0xff64
0000A9BB  EE                out dx,al
0000A9BC  A0A907            mov al,[0x7a9]
0000A9BF  BB2C09            mov bx,0x92c
0000A9C2  D7                xlatb
0000A9C3  A24E09            mov [0x94e],al
0000A9C6  A0AA07            mov al,[0x7aa]
0000A9C9  03C0              add ax,ax
0000A9CB  8BD8              mov bx,ax
0000A9CD  8B873209          mov ax,[bx+0x932]
0000A9D1  BA60FF            mov dx,0xff60
0000A9D4  EE                out dx,al
0000A9D5  BB3F00            mov bx,0x3f
0000A9D8  803EB40700        cmp byte [0x7b4],0x0
0000A9DD  7502              jnz 0xa9e1
0000A9DF  B780              mov bh,0x80
0000A9E1  BA5EFF            mov dx,0xff5e
0000A9E4  FA                cli
0000A9E5  ED                in ax,dx
0000A9E6  22C3              and al,bl
0000A9E8  0AC7              or al,bh
0000A9EA  EE                out dx,al
0000A9EB  FB                sti
0000A9EC  C3                ret
0000A9ED  FB                sti
0000A9EE  50                push ax
0000A9EF  52                push dx
0000A9F0  1E                push ds
0000A9F1  56                push si
0000A9F2  BA4000            mov dx,0x40
0000A9F5  8EDA              mov ds,dx
0000A9F7  BA66FF            mov dx,0xff66
0000A9FA  ED                in ax,dx
0000A9FB  A96000            test ax,0x60
0000A9FE  7417              jz 0xaa17
0000AA00  A94000            test ax,0x40
0000AA03  7516              jnz 0xaa1b
0000AA05  53                push bx
0000AA06  E86C00            call 0xaa75
0000AA09  5B                pop bx
0000AA0A  BA02FF            mov dx,0xff02
0000AA0D  B80080            mov ax,0x8000
0000AA10  FA                cli
0000AA11  EE                out dx,al
0000AA12  5E                pop si
0000AA13  1F                pop ds
0000AA14  5A                pop dx
0000AA15  58                pop ax
0000AA16  CF                iret
0000AA17  EBF1              jmp short 0xaa0a
0000AA19  CD4F              int 0x4f
0000AA1B  BA68FF            mov dx,0xff68
0000AA1E  50                push ax
0000AA1F  259403            and ax,0x394
0000AA22  0AE0              or ah,al
0000AA24  EC                in al,dx
0000AA25  22064E09          and al,[0x94e]
0000AA29  803EA80701        cmp byte [0x7a8],0x1
0000AA2E  7518              jnz 0xaa48
0000AA30  3A06B607          cmp al,[0x7b6]
0000AA34  7408              jz 0xaa3e
0000AA36  3A06B507          cmp al,[0x7b5]
0000AA3A  750C              jnz 0xaa48
0000AA3C  32C0              xor al,al
0000AA3E  A25009            mov [0x950],al
0000AA41  53                push bx
0000AA42  E82600            call 0xaa6b
0000AA45  5B                pop bx
0000AA46  EB1B              jmp short 0xaa63
0000AA48  8B364609          mov si,[0x946]
0000AA4C  8904              mov [si],ax
0000AA4E  46                inc si
0000AA4F  46                inc si
0000AA50  81FE5E27          cmp si,0x275e
0000AA54  7203              jc 0xaa59
0000AA56  BE5E25            mov si,0x255e
0000AA59  3B364809          cmp si,[0x948]
0000AA5D  7404              jz 0xaa63
0000AA5F  89364609          mov [0x946],si
0000AA63  58                pop ax
0000AA64  A92000            test ax,0x20
0000AA67  759C              jnz 0xaa05
0000AA69  EB9F              jmp short 0xaa0a
0000AA6B  FA                cli
0000AA6C  A04F09            mov al,[0x94f]
0000AA6F  84C0              test al,al
0000AA71  7403              jz 0xaa76
0000AA73  FB                sti
0000AA74  C3                ret
0000AA75  FA                cli
0000AA76  33C0              xor ax,ax
0000AA78  3A065009          cmp al,[0x950]
0000AA7C  755F              jnz 0xaadd
0000AA7E  A0A807            mov al,[0x7a8]
0000AA81  3C02              cmp al,0x2
0000AA83  7404              jz 0xaa89
0000AA85  3C01              cmp al,0x1
0000AA87  7534              jnz 0xaabd
0000AA89  BA5AFF            mov dx,0xff5a
0000AA8C  EC                in al,dx
0000AA8D  8AD0              mov dl,al
0000AA8F  33C0              xor ax,ax
0000AA91  F606B20702        test byte [0x7b2],0x2
0000AA96  740F              jz 0xaaa7
0000AA98  F606B20701        test byte [0x7b2],0x1
0000AA9D  7503              jnz 0xaaa2
0000AA9F  80F210            xor dl,0x10
0000AAA2  F6C210            test dl,0x10
0000AAA5  7536              jnz 0xaadd
0000AAA7  F606B30702        test byte [0x7b3],0x2
0000AAAC  740F              jz 0xaabd
0000AAAE  F606B30701        test byte [0x7b3],0x1
0000AAB3  7503              jnz 0xaab8
0000AAB5  80F220            xor dl,0x20
0000AAB8  F6C220            test dl,0x20
0000AABB  7520              jnz 0xaadd
0000AABD  8B1E4C09          mov bx,[0x94c]
0000AAC1  3B1E4A09          cmp bx,[0x94a]
0000AAC5  741B              jz 0xaae2
0000AAC7  8A07              mov al,[bx]
0000AAC9  43                inc bx
0000AACA  BA6AFF            mov dx,0xff6a
0000AACD  EE                out dx,al
0000AACE  81FB5E28          cmp bx,0x285e
0000AAD2  7203              jc 0xaad7
0000AAD4  BB5E27            mov bx,0x275e
0000AAD7  891E4C09          mov [0x94c],bx
0000AADB  B001              mov al,0x1
0000AADD  A24F09            mov [0x94f],al
0000AAE0  FB                sti
0000AAE1  C3                ret
0000AAE2  32C0              xor al,al
0000AAE4  EBF7              jmp short 0xaadd
0000AAE6  EB83              jmp short 0xaa6b
0000AAE8  A14C09            mov ax,[0x94c]
0000AAEB  3B064A09          cmp ax,[0x94a]
0000AAEF  75F5              jnz 0xaae6
0000AAF1  C3                ret
0000AAF2  1E                push ds
0000AAF3  BB4000            mov bx,0x40
0000AAF6  8EDB              mov ds,bx
0000AAF8  FF1E5B09          call far [0x95b]
0000AAFC  1F                pop ds
0000AAFD  5B                pop bx
0000AAFE  CF                iret
0000AAFF  B080              mov al,0x80
0000AB01  803EA80703        cmp byte [0x7a8],0x3
0000AB06  7540              jnz 0xab48
0000AB08  32C0              xor al,al
0000AB0A  8B1E4809          mov bx,[0x948]
0000AB0E  3B1E4609          cmp bx,[0x946]
0000AB12  7402              jz 0xab16
0000AB14  B040              mov al,0x40
0000AB16  8B1E4A09          mov bx,[0x94a]
0000AB1A  43                inc bx
0000AB1B  81FB5E28          cmp bx,0x285e
0000AB1F  7203              jc 0xab24
0000AB21  BB5E27            mov bx,0x275e
0000AB24  3B1E4C09          cmp bx,[0x94c]
0000AB28  7402              jz 0xab2c
0000AB2A  0C20              or al,0x20
0000AB2C  F606B20702        test byte [0x7b2],0x2
0000AB31  7404              jz 0xab37
0000AB33  0C10              or al,0x10
0000AB35  EB11              jmp short 0xab48
0000AB37  52                push dx
0000AB38  50                push ax
0000AB39  BA5AFF            mov dx,0xff5a
0000AB3C  EC                in al,dx
0000AB3D  8AD0              mov dl,al
0000AB3F  58                pop ax
0000AB40  F6C210            test dl,0x10
0000AB43  7502              jnz 0xab47
0000AB45  0C10              or al,0x10
0000AB47  5A                pop dx
0000AB48  CB                retf
0000AB49  A0A807            mov al,[0x7a8]
0000AB4C  3C01              cmp al,0x1
0000AB4E  74B8              jz 0xab08
0000AB50  3C02              cmp al,0x2
0000AB52  74B4              jz 0xab08
0000AB54  B080              mov al,0x80
0000AB56  CB                retf
0000AB57  1E                push ds
0000AB58  BB4000            mov bx,0x40
0000AB5B  8EDB              mov ds,bx
0000AB5D  FF1E5309          call far [0x953]
0000AB61  1F                pop ds
0000AB62  5B                pop bx
0000AB63  CA0200            retf 0x2
0000AB66  803EA80703        cmp byte [0x7a8],0x3
0000AB6B  751D              jnz 0xab8a
0000AB6D  8B1E4809          mov bx,[0x948]
0000AB71  3B1E4609          cmp bx,[0x946]
0000AB75  7413              jz 0xab8a
0000AB77  8B07              mov ax,[bx]
0000AB79  43                inc bx
0000AB7A  43                inc bx
0000AB7B  81FB5E27          cmp bx,0x275e
0000AB7F  7203              jc 0xab84
0000AB81  BB5E25            mov bx,0x255e
0000AB84  891E4809          mov [0x948],bx
0000AB88  F8                clc
0000AB89  CB                retf
0000AB8A  F9                stc
0000AB8B  CB                retf
0000AB8C  1E                push ds
0000AB8D  BB4000            mov bx,0x40
0000AB90  8EDB              mov ds,bx
0000AB92  FF1E5709          call far [0x957]
0000AB96  1F                pop ds
0000AB97  5B                pop bx
0000AB98  CA0200            retf 0x2
0000AB9B  52                push dx
0000AB9C  803EA80703        cmp byte [0x7a8],0x3
0000ABA1  7527              jnz 0xabca
0000ABA3  8B1E4A09          mov bx,[0x94a]
0000ABA7  FEC8              dec al
0000ABA9  7922              jns 0xabcd
0000ABAB  8AC2              mov al,dl
0000ABAD  8807              mov [bx],al
0000ABAF  43                inc bx
0000ABB0  81FB5E28          cmp bx,0x285e
0000ABB4  7203              jc 0xabb9
0000ABB6  BB5E27            mov bx,0x275e
0000ABB9  3B1E4C09          cmp bx,[0x94c]
0000ABBD  740B              jz 0xabca
0000ABBF  891E4A09          mov [0x94a],bx
0000ABC3  E8A5FE            call 0xaa6b
0000ABC6  F8                clc
0000ABC7  5A                pop dx
0000ABC8  CB                retf
0000ABC9  FB                sti
0000ABCA  F9                stc
0000ABCB  EBFA              jmp short 0xabc7
0000ABCD  98                cbw
0000ABCE  03C0              add ax,ax
0000ABD0  05F24B            add ax,0x4bf2
0000ABD3  3DFC4B            cmp ax,0x4bfc
0000ABD6  73F2              jnc 0xabca
0000ABD8  8BD8              mov bx,ax
0000ABDA  2EFF27            jmp [cs:bx]
0000ABDD  EBE7              jmp short 0xabc6
0000ABDF  B80001            mov ax,0x100
0000ABE2  EB02              jmp short 0xabe6
0000ABE4  33C0              xor ax,ax
0000ABE6  0B065109          or ax,[0x951]
0000ABEA  BA64FF            mov dx,0xff64
0000ABED  EE                out dx,al
0000ABEE  EBD6              jmp short 0xabc6
0000ABF0  EBD8              jmp short 0xabca
0000ABF2  DD4BDD            fisttp qword [bp+di-0x23]
0000ABF5  4B                dec bx
0000ABF6  DF4BE4            fisttp word [bp+di-0x1c]
0000ABF9  4B                dec bx
0000ABFA  F04B              lock dec bx
0000ABFC  52                push dx
0000ABFD  803EA80702        cmp byte [0x7a8],0x2
0000AC02  7407              jz 0xac0b
0000AC04  803EA80701        cmp byte [0x7a8],0x1
0000AC09  75BF              jnz 0xabca
0000AC0B  8B1E4A09          mov bx,[0x94a]
0000AC0F  EB9C              jmp short 0xabad
0000AC11  06                push es
0000AC12  57                push di
0000AC13  BB4000            mov bx,0x40
0000AC16  8EC3              mov es,bx
0000AC18  BF5309            mov di,0x953
0000AC1B  A5                movsw
0000AC1C  A5                movsw
0000AC1D  A5                movsw
0000AC1E  A5                movsw
0000AC1F  A5                movsw
0000AC20  A5                movsw
0000AC21  5F                pop di
0000AC22  07                pop es
0000AC23  5B                pop bx
0000AC24  CF                iret
0000AC25  1E                push ds
0000AC26  BB4000            mov bx,0x40
0000AC29  8EDB              mov ds,bx
0000AC2B  803EA80702        cmp byte [0x7a8],0x2
0000AC30  7509              jnz 0xac3b
0000AC32  0E                push cs
0000AC33  E837FF            call 0xab6d
0000AC36  1F                pop ds
0000AC37  5B                pop bx
0000AC38  CA0200            retf 0x2
0000AC3B  F9                stc
0000AC3C  EBF8              jmp short 0xac36
0000AC3E  1E                push ds
0000AC3F  BB4000            mov bx,0x40
0000AC42  8EDB              mov ds,bx
0000AC44  C606A80700        mov byte [0x7a8],0x0
0000AC49  0E                push cs
0000AC4A  E820FF            call 0xab6d
0000AC4D  1F                pop ds
0000AC4E  5B                pop bx
0000AC4F  CA0200            retf 0x2
0000AC52  1E                push ds
0000AC53  BB4000            mov bx,0x40
0000AC56  8EDB              mov ds,bx
0000AC58  C606A80700        mov byte [0x7a8],0x0
0000AC5D  0E                push cs
0000AC5E  E80500            call 0xac66
0000AC61  1F                pop ds
0000AC62  5B                pop bx
0000AC63  CA0200            retf 0x2
0000AC66  52                push dx
0000AC67  8B1E4A09          mov bx,[0x94a]
0000AC6B  E93FFF            jmp 0xabad
0000AC6E  50                push ax
0000AC6F  1E                push ds
0000AC70  51                push cx
0000AC71  52                push dx
0000AC72  52                push dx
0000AC73  B84000            mov ax,0x40
0000AC76  8ED8              mov ds,ax
0000AC78  A16009            mov ax,[0x960]
0000AC7B  8B166209          mov dx,[0x962]
0000AC7F  8BD9              mov bx,cx
0000AC81  D1EB              shr bx,1
0000AC83  03C3              add ax,bx
0000AC85  83D200            adc dx,byte +0x0
0000AC88  3BCA              cmp cx,dx
0000AC8A  761F              jna 0xacab
0000AC8C  F7F1              div cx
0000AC8E  A36409            mov [0x964],ax
0000AC91  58                pop ax
0000AC92  33D2              xor dx,dx
0000AC94  051B00            add ax,0x1b
0000AC97  13D2              adc dx,dx
0000AC99  B93700            mov cx,0x37
0000AC9C  F7F1              div cx
0000AC9E  85C0              test ax,ax
0000ACA0  740E              jz 0xacb0
0000ACA2  A36609            mov [0x966],ax
0000ACA5  5A                pop dx
0000ACA6  59                pop cx
0000ACA7  1F                pop ds
0000ACA8  58                pop ax
0000ACA9  5B                pop bx
0000ACAA  CF                iret
0000ACAB  B8FFFF            mov ax,0xffff
0000ACAE  EBDE              jmp short 0xac8e
0000ACB0  B8FF3F            mov ax,0x3fff
0000ACB3  A36409            mov [0x964],ax
0000ACB6  B80100            mov ax,0x1
0000ACB9  EBE7              jmp short 0xaca2
0000ACBB  33C0              xor ax,ax
0000ACBD  FA                cli
0000ACBE  87066409          xchg ax,[0x964]
0000ACC2  85C0              test ax,ax
0000ACC4  7508              jnz 0xacce
0000ACC6  3B066609          cmp ax,[0x966]
0000ACCA  7519              jnz 0xace5
0000ACCC  FB                sti
0000ACCD  C3                ret
0000ACCE  FB                sti
0000ACCF  BA32FF            mov dx,0xff32
0000ACD2  EE                out dx,al
0000ACD3  BA34FF            mov dx,0xff34
0000ACD6  EE                out dx,al
0000ACD7  33C0              xor ax,ax
0000ACD9  BA30FF            mov dx,0xff30
0000ACDC  EE                out dx,al
0000ACDD  B803C0            mov ax,0xc003
0000ACE0  BA36FF            mov dx,0xff36
0000ACE3  EE                out dx,al
0000ACE4  C3                ret
0000ACE5  FF0E6609          dec word [0x966]
0000ACE9  7525              jnz 0xad10
0000ACEB  BA32FF            mov dx,0xff32
0000ACEE  B80100            mov ax,0x1
0000ACF1  EE                out dx,al
0000ACF2  BA34FF            mov dx,0xff34
0000ACF5  B8FFFF            mov ax,0xffff
0000ACF8  EE                out dx,al
0000ACF9  BA30FF            mov dx,0xff30
0000ACFC  33C0              xor ax,ax
0000ACFE  EE                out dx,al
0000ACFF  BA36FF            mov dx,0xff36
0000AD02  B803C0            mov ax,0xc003
0000AD05  EE                out dx,al
0000AD06  ED                in ax,dx
0000AD07  A90010            test ax,0x1000
0000AD0A  74FA              jz 0xad06
0000AD0C  B807D0            mov ax,0xd007
0000AD0F  EE                out dx,al
0000AD10  FB                sti
0000AD11  C3                ret
0000AD12  4E                dec si
0000AD13  0D1C15            or ax,0x151c
0000AD16  3803              cmp [bp+di],al
0000AD18  2902              sub [bp+si],ax
0000AD1A  47                inc di
0000AD1B  3425              xor al,0x25
0000AD1D  16                push ss
0000AD1E  06                push es
0000AD1F  2B4401            sub ax,[si+0x1]
0000AD22  53                push bx
0000AD23  57                push di
0000AD24  351727            xor ax,0x2717
0000AD27  36002A            add [ss:bp+si],ch
0000AD2A  5A                pop dx
0000AD2B  335818            xor bx,[bx+si+0x18]
0000AD2E  45                inc bp
0000AD2F  3A1D              cmp bl,[di]
0000AD31  56                push si
0000AD32  5C                pop sp
0000AD33  2C26              sub al,0x26
0000AD35  0C5E              or al,0x5e
0000AD37  1B461A            sbb ax,[bp+0x1a]
0000AD3A  52                push dx
0000AD3B  49                dec cx
0000AD3C  4A                dec dx
0000AD3D  37                aaa
0000AD3E  2800              sub [bx+si],al
0000AD40  5B                pop bx
0000AD41  395032            cmp [bx+si+0x32],dx
0000AD44  2319              and bx,[bx+di]
0000AD46  056040            add ax,0x4060
0000AD49  644F              fs dec di
0000AD4B  3024              xor [si],ah
0000AD4D  1404              adc al,0x4
0000AD4F  68410E            push word 0xe41
0000AD52  4B                dec bx
0000AD53  2F                das
0000AD54  2011              and [bx+di],dl
0000AD56  07                pop es
0000AD57  693E66513122      imul di,[0x5166],word 0x2231
0000AD5D  130B              adc cx,[bp+di]
0000AD5F  623F              bound di,[bx]
0000AD61  61                popa
0000AD62  4D                dec bp
0000AD63  2E                cs

; ---- 0x0ad64-0x0ad84  character-generator font / bitmap data  [H08/H21] ----
0000AD64  1f 10 09 67 3c 5d 4c 2d 21 12 08 65 3d 63 00 00  |...g<]L-!..e=c..|
0000AD74  00 00 00 00 00 00 48 43 1e 42 0a 3b 5f 0f 00 00  |......HC.B.;_...|

; ==== 0x0ad84-0x0ae4c  CODE (linear/orphan, conf 80) ====
0000AD84  0000              add [bx+si],al
0000AD86  0000              add [bx+si],al
0000AD88  0000              add [bx+si],al
0000AD8A  53                push bx
0000AD8B  4C                dec sp
0000AD8C  6D                insw
0000AD8D  CC                int3
0000AD8E  C9                leave
0000AD8F  13BD3C52          adc di,[di+0x523c]
0000AD93  4B                dec bx
0000AD94  6B6CC80F          imul bp,[si-0x38],byte +0xf
0000AD98  1C3B              sbb al,0x3b
0000AD9A  664F              dec edi
0000AD9C  672DAA12          sub ax,0x12aa
0000ADA0  BC3E61            mov sp,0x613e
0000ADA3  4D                dec bp
0000ADA4  622ECACB          bound bp,[0xcbca]
0000ADA8  90                nop
0000ADA9  3D7A15            cmp ax,0x157a
0000ADAC  46                inc si
0000ADAD  5F                pop di
0000ADAE  5B                pop bx
0000ADAF  3A22              cmp ah,[bp+si]
0000ADB1  7164              jno 0xae17
0000ADB3  50                push ax
0000ADB4  47                inc di
0000ADB5  2F                das
0000ADB6  AB                stosw
0000ADB7  1039              adc [bx+di],bh
0000ADB9  3F                aas
0000ADBA  637F7B            arpl [bx+0x7b],di
0000ADBD  0E                push cs
0000ADBE  19807741          sbb [bx+si+0x4177],ax
0000ADC2  26252414          es and ax,0x1424
0000ADC6  237C2A            and di,[si+0x2a]
0000ADC9  40                inc ax
0000ADCA  C0BFBE38A9        sar byte [bx+0x38be],byte 0xa9
0000ADCF  1D1E43            sbb ax,0x431e
0000ADD2  C7C6C5C4          mov si,0xc4c5
0000ADD6  7697              jna 0xad6f
0000ADD8  3642              ss inc dx
0000ADDA  6F                outsw
0000ADDB  6A48              push byte +0x48
0000ADDD  30C2              xor dl,al
0000ADDF  17                pop ss
0000ADE0  217570            and [di+0x70],si
0000ADE3  7372              jnc 0xae57
0000ADE5  31C1              xor cx,ax
0000ADE7  16                push ss
0000ADE8  1F                pop ds
0000ADE9  44                inc sp
0000ADEA  60                pusha
0000ADEB  017D5D            add [di+0x5d],di
0000ADEE  7ECD              jng 0xadbd
0000ADF0  65686E51          gs push word 0x516e
0000ADF4  49                dec cx
0000ADF5  BBC318            mov bx,0x18c3
0000ADF8  207478            and [si+0x78],dh
0000ADFB  7900              jns 0xadfd
0000ADFD  0000              add [bx+si],al
0000ADFF  0000              add [bx+si],al
0000AE01  002A              add [bp+si],ch
0000AE03  1D0F81            sbb ax,0x810f
0000AE06  7E6B              jng 0xae73
0000AE08  686C00            push word 0x6c
0000AE0B  6664636160        o32 arpl [fs:bx+di+0x60],sp
0000AE10  696A2E2DAF        imul bp,[bp+si+0x2e],word 0xaf2d
0000AE15  AC                lodsb
0000AE16  1F                pop ds
0000AE17  B184              mov cl,0x84
0000AE19  7000              jo 0xae1b
0000AE1B  AE                scasb
0000AE1C  3AB08382          cmp dh,[bx+si-0x7d7d]
0000AE20  6E                outsb
0000AE21  6F                outsw
0000AE22  302F              xor [bx],ch
0000AE24  2322              and sp,[bp+si]
0000AE26  B5B4              mov ch,0xb4
0000AE28  88872120          mov [bx+0x2021],al
0000AE2C  B3B2              mov bl,0xb2
0000AE2E  86857978          xchg al,[di+0x7879]
0000AE32  92                xchg ax,dx
0000AE33  91                xchg ax,cx
0000AE34  2625B8B7          es and ax,0xb7b8
0000AE38  8A7C39            mov bh,[si+0x39]
0000AE3B  AD                lodsw
0000AE3C  3124              xor [si],sp
0000AE3E  B689              mov dh,0x89
0000AE40  7B7A              jpo 0xaebc
0000AE42  3694              ss xchg ax,sp
0000AE44  1C76              sbb al,0x76
0000AE46  93                xchg ax,bx
0000AE47  0E                push cs
0000AE48  8F                db 0x8f
0000AE49  5D                pop bp
0000AE4A  96                xchg ax,si
0000AE4B  8C                db 0x8c

; ---- 0x0ae4c-0x0ae62  character-generator font / bitmap data  [H08/H21] ----
0000AE4C  8d 8e b9 95 8b 7d 4a 4e 75 ba 51 4d 49 48 4c 50  |.....}JNu.QMIHLP|
0000AE5C  52 4f 4b 47 6d 5f                                |ROKGm_|

; ---- 0x0ae62-0x0ae7a  zero padding  [H07/H21] ----
0000AE62  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000AE72  00 00 00 00 00 00 00 00                          |........|

; ==== 0x0ae7a-0x0aecc  CODE (linear/orphan, conf 80) ====
0000AE7A  53                push bx
0000AE7B  4C                dec sp
0000AE7C  A22C0A            mov [0xa2c],al
0000AE7F  1328              adc bp,[bx+si]
0000AE81  3C52              cmp al,0x52
0000AE83  4B                dec bx
0000AE84  A15609            mov ax,[0x956]
0000AE87  0F1C3B            hint_nop39 word [bp+di]
0000AE8A  664F              dec edi
0000AE8C  A4                movsb
0000AE8D  2D0C12            sub ax,0x120c
0000AE90  27                daa
0000AE91  3E61              ds popa
0000AE93  4D                dec bp
0000AE94  A32E0B            mov [0xb2e],ax
0000AE97  112B              adc [bp+di],bp
0000AE99  3D9F9E            cmp ax,0x9e9f
0000AE9C  9D                popf
0000AE9D  9C                pushf
0000AE9E  9B9A99A56350      wait call 0x5063:0xa599
0000AEA4  47                inc di
0000AEA5  2F                das
0000AEA6  0D1039            or ax,0x3910
0000AEA9  3F                aas
0000AEAA  641B1A            sbb bx,[fs:bp+si]
0000AEAD  0E                push cs
0000AEAE  19681D            sbb [bx+si+0x1d],bp
0000AEB1  41                inc cx
0000AEB2  2625242A          es and ax,0x2a24
0000AEB6  2322              and sp,[bp+si]
0000AEB8  A04035            mov al,[0x3540]
0000AEBB  A8A7              test al,0xa7
0000AEBD  652915            sub [gs:di],dx
0000AEC0  1E                push ds
0000AEC1  43                inc bx
0000AEC2  0807              or [bx],al
0000AEC4  06                push es
0000AEC5  056914            add ax,0x1469
0000AEC8  3A425A            cmp al,[bp+si+0x5a]
0000AECB  67                a32

; ---- 0x0aecc-0x0aeec  character-generator font / bitmap data  [H08/H21] ----
0000AECC  48 30 03 17 21 57 a6 4a 62 31 02 16 1f 44 00 00  |H0..!W.Jb1...D..|
0000AEDC  00 00 00 00 00 00 60 51 49 32 04 18 20 58 00 00  |......`QI2.. X..|

; ==== 0x0aeec-0x0b24a  CODE (CF-reached, conf 99) ====
0000AEEC  0000              add [bx+si],al
0000AEEE  0000              add [bx+si],al
0000AEF0  0000              add [bx+si],al
0000AEF2  0104              add [si],ax
0000AEF4  0200              add al,[bx+si]
0000AEF6  0010              add [bx+si],dl
0000AEF8  0804              or [si],al
0000AEFA  0201              add al,[bx+di]
0000AEFC  BA5EFF            mov dx,0xff5e
0000AEFF  FA                cli
0000AF00  EC                in al,dx
0000AF01  24FD              and al,0xfd
0000AF03  EE                out dx,al
0000AF04  FB                sti
0000AF05  33C0              xor ax,ax
0000AF07  8EC0              mov es,ax
0000AF09  FA                cli
0000AF0A  BF7000            mov di,0x70
0000AF0D  B81152            mov ax,0x5211
0000AF10  AB                stosw
0000AF11  8CC8              mov ax,cs
0000AF13  AB                stosw
0000AF14  BF2000            mov di,0x20
0000AF17  B80752            mov ax,0x5207
0000AF1A  AB                stosw
0000AF1B  8CC8              mov ax,cs
0000AF1D  AB                stosw
0000AF1E  BF4C00            mov di,0x4c
0000AF21  B8EE4F            mov ax,0x4fee
0000AF24  AB                stosw
0000AF25  8CC8              mov ax,cs
0000AF27  AB                stosw
0000AF28  FB                sti
0000AF29  BA42FF            mov dx,0xff42
0000AF2C  B88CAE            mov ax,0xae8c
0000AF2F  EE                out dx,al
0000AF30  BA46FF            mov dx,0xff46
0000AF33  B801E0            mov ax,0xe001
0000AF36  EE                out dx,al
0000AF37  BA12FF            mov dx,0xff12
0000AF3A  FA                cli
0000AF3B  ED                in ax,dx
0000AF3C  25F7FF            and ax,0xfff7
0000AF3F  EE                out dx,al
0000AF40  FB                sti
0000AF41  BA3AFF            mov dx,0xff3a
0000AF44  33C0              xor ax,ax
0000AF46  EE                out dx,al
0000AF47  BA3EFF            mov dx,0xff3e
0000AF4A  B801C0            mov ax,0xc001
0000AF4D  EE                out dx,al
0000AF4E  C3                ret
0000AF4F  B005              mov al,0x5
0000AF51  F626B707          mul byte [0x7b7]
0000AF55  A27009            mov [0x970],al
0000AF58  A0B807            mov al,[0x7b8]
0000AF5B  8AE0              mov ah,al
0000AF5D  84C0              test al,al
0000AF5F  7450              jz 0xafb1
0000AF61  B437              mov ah,0x37
0000AF63  3C01              cmp al,0x1
0000AF65  764A              jna 0xafb1
0000AF67  B41C              mov ah,0x1c
0000AF69  3C02              cmp al,0x2
0000AF6B  7644              jna 0xafb1
0000AF6D  B412              mov ah,0x12
0000AF6F  3C03              cmp al,0x3
0000AF71  763E              jna 0xafb1
0000AF73  B40E              mov ah,0xe
0000AF75  3C04              cmp al,0x4
0000AF77  7638              jna 0xafb1
0000AF79  B40B              mov ah,0xb
0000AF7B  3C05              cmp al,0x5
0000AF7D  7632              jna 0xafb1
0000AF7F  B409              mov ah,0x9
0000AF81  3C06              cmp al,0x6
0000AF83  762C              jna 0xafb1
0000AF85  B408              mov ah,0x8
0000AF87  3C07              cmp al,0x7
0000AF89  7626              jna 0xafb1
0000AF8B  B407              mov ah,0x7
0000AF8D  3C08              cmp al,0x8
0000AF8F  7620              jna 0xafb1
0000AF91  B406              mov ah,0x6
0000AF93  3C09              cmp al,0x9
0000AF95  761A              jna 0xafb1
0000AF97  B405              mov ah,0x5
0000AF99  3C0C              cmp al,0xc
0000AF9B  7614              jna 0xafb1
0000AF9D  B404              mov ah,0x4
0000AF9F  3C10              cmp al,0x10
0000AFA1  760E              jna 0xafb1
0000AFA3  B403              mov ah,0x3
0000AFA5  3C17              cmp al,0x17
0000AFA7  7608              jna 0xafb1
0000AFA9  B402              mov ah,0x2
0000AFAB  3C2D              cmp al,0x2d
0000AFAD  7602              jna 0xafb1
0000AFAF  B401              mov ah,0x1
0000AFB1  88267109          mov [0x971],ah
0000AFB5  C3                ret
0000AFB6  2206F407          and al,[0x7f4]
0000AFBA  3A06F407          cmp al,[0x7f4]
0000AFBE  742A              jz 0xafea
0000AFC0  BA5EFF            mov dx,0xff5e
0000AFC3  FA                cli
0000AFC4  EC                in al,dx
0000AFC5  24FD              and al,0xfd
0000AFC7  EE                out dx,al
0000AFC8  FB                sti
0000AFC9  E9FF00            jmp 0xb0cb
0000AFCC  E90701            jmp 0xb0d6
0000AFCF  3C12              cmp al,0x12
0000AFD1  7414              jz 0xafe7
0000AFD3  3C13              cmp al,0x13
0000AFD5  7410              jz 0xafe7
0000AFD7  3C41              cmp al,0x41
0000AFD9  740C              jz 0xafe7
0000AFDB  3CC1              cmp al,0xc1
0000AFDD  7408              jz 0xafe7
0000AFDF  3C06              cmp al,0x6
0000AFE1  7404              jz 0xafe7
0000AFE3  3C10              cmp al,0x10
0000AFE5  75CF              jnz 0xafb6
0000AFE7  A2F407            mov [0x7f4],al
0000AFEA  EB7F              jmp short 0xb06b
0000AFEC  EBE1              jmp short 0xafcf
0000AFEE  FB                sti
0000AFEF  FC                cld
0000AFF0  1E                push ds
0000AFF1  50                push ax
0000AFF2  53                push bx
0000AFF3  52                push dx
0000AFF4  B84000            mov ax,0x40
0000AFF7  8ED8              mov ds,ax
0000AFF9  8306680901        add word [0x968],byte +0x1
0000AFFE  83166A0900        adc word [0x96a],byte +0x0
0000B003  BA02FF            mov dx,0xff02
0000B006  B80080            mov ax,0x8000
0000B009  EE                out dx,al
0000B00A  8B1E1409          mov bx,[0x914]
0000B00E  FF4708            inc word [bx+0x8]
0000B011  FE067209          inc byte [0x972]
0000B015  FE0E6D09          dec byte [0x96d]
0000B019  75B1              jnz 0xafcc
0000B01B  06                push es
0000B01C  56                push si
0000B01D  57                push di
0000B01E  51                push cx
0000B01F  B91000            mov cx,0x10
0000B022  E8B301            call 0xb1d8
0000B025  A35E28            mov [0x285e],ax
0000B028  B110              mov cl,0x10
0000B02A  E8AB01            call 0xb1d8
0000B02D  A36028            mov [0x2860],ax
0000B030  B110              mov cl,0x10
0000B032  E8A301            call 0xb1d8
0000B035  A36228            mov [0x2862],ax
0000B038  B110              mov cl,0x10
0000B03A  E89B01            call 0xb1d8
0000B03D  A36428            mov [0x2864],ax
0000B040  B110              mov cl,0x10
0000B042  E89301            call 0xb1d8
0000B045  A36628            mov [0x2866],ax
0000B048  B110              mov cl,0x10
0000B04A  E88B01            call 0xb1d8
0000B04D  A36828            mov [0x2868],ax
0000B050  B110              mov cl,0x10
0000B052  E88301            call 0xb1d8
0000B055  A36A28            mov [0x286a],ax
0000B058  B108              mov cl,0x8
0000B05A  E87B01            call 0xb1d8
0000B05D  A26C28            mov [0x286c],al
0000B060  B120              mov cl,0x20
0000B062  E87301            call 0xb1d8
0000B065  3A06F407          cmp al,[0x7f4]
0000B069  7581              jnz 0xafec
0000B06B  8B1E7809          mov bx,[0x978]
0000B06F  8A879700          mov al,[bx+0x97]
0000B073  84C0              test al,al
0000B075  7503              jnz 0xb07a
0000B077  A0F707            mov al,[0x7f7]
0000B07A  803EF40710        cmp byte [0x7f4],0x10
0000B07F  7433              jz 0xb0b4
0000B081  803EF40706        cmp byte [0x7f4],0x6
0000B086  742C              jz 0xb0b4
0000B088  B105              mov cl,0x5
0000B08A  BFF74E            mov di,0x4ef7
0000B08D  B420              mov ah,0x20
0000B08F  803EF40713        cmp byte [0x7f4],0x13
0000B094  740C              jz 0xb0a2
0000B096  803EF40712        cmp byte [0x7f4],0x12
0000B09B  7405              jz 0xb0a2
0000B09D  BFF24E            mov di,0x4ef2
0000B0A0  B408              mov ah,0x8
0000B0A2  D0E8              shr al,1
0000B0A4  7303              jnc 0xb0a9
0000B0A6  2E2A25            sub ah,[cs:di]
0000B0A9  47                inc di
0000B0AA  E2F6              loop 0xb0a2
0000B0AC  8ACC              mov cl,ah
0000B0AE  49                dec cx
0000B0AF  7403              jz 0xb0b4
0000B0B1  E82401            call 0xb1d8
0000B0B4  BA5EFF            mov dx,0xff5e
0000B0B7  FA                cli
0000B0B8  EC                in al,dx
0000B0B9  24FD              and al,0xfd
0000B0BB  EE                out dx,al
0000B0BC  FB                sti
0000B0BD  BE5E28            mov si,0x285e
0000B0C0  BF6D28            mov di,0x286d
0000B0C3  B10F              mov cl,0xf
0000B0C5  1E                push ds
0000B0C6  07                pop es
0000B0C7  F3A6              repe cmpsb
0000B0C9  754B              jnz 0xb116
0000B0CB  A17409            mov ax,[0x974]
0000B0CE  84C0              test al,al
0000B0D0  7541              jnz 0xb113
0000B0D2  59                pop cx
0000B0D3  5F                pop di
0000B0D4  5E                pop si
0000B0D5  07                pop es
0000B0D6  FE066D09          inc byte [0x96d]
0000B0DA  E8DEFB            call 0xacbb
0000B0DD  E82C02            call 0xb30c
0000B0E0  E805FA            call 0xaae8
0000B0E3  A06F09            mov al,[0x96f]
0000B0E6  FEC8              dec al
0000B0E8  7803              js 0xb0ed
0000B0EA  A26F09            mov [0x96f],al
0000B0ED  FE0E6E09          dec byte [0x96e]
0000B0F1  7517              jnz 0xb10a
0000B0F3  FE0E6C09          dec byte [0x96c]
0000B0F7  7511              jnz 0xb10a
0000B0F9  CD08              int 0x8
0000B0FB  83066C0001        add word [0x6c],byte +0x1
0000B100  83166E0000        adc word [0x6e],byte +0x0
0000B105  B003              mov al,0x3
0000B107  A26C09            mov [0x96c],al
0000B10A  FE066E09          inc byte [0x96e]
0000B10E  5A                pop dx
0000B10F  5B                pop bx
0000B110  58                pop ax
0000B111  1F                pop ds
0000B112  CF                iret
0000B113  E99800            jmp 0xb1ae
0000B116  51                push cx
0000B117  56                push si
0000B118  33D2              xor dx,dx
0000B11A  8BDE              mov bx,si
0000B11C  BE5E28            mov si,0x285e
0000B11F  B90F00            mov cx,0xf
0000B122  AC                lodsb
0000B123  3BF3              cmp si,bx
0000B125  740F              jz 0xb136
0000B127  2247FF            and al,[bx-0x1]
0000B12A  740A              jz 0xb136
0000B12C  8AE0              mov ah,al
0000B12E  FEC8              dec al
0000B130  22C4              and al,ah
0000B132  7402              jz 0xb136
0000B134  0AF4              or dh,ah
0000B136  E2EA              loop 0xb122
0000B138  5E                pop si
0000B139  F6D6              not dh
0000B13B  8A44FF            mov al,[si-0x1]
0000B13E  3245FF            xor al,[di-0x1]
0000B141  22C6              and al,dh
0000B143  740C              jz 0xb151
0000B145  B480              mov ah,0x80
0000B147  B108              mov cl,0x8
0000B149  84C4              test ah,al
0000B14B  750D              jnz 0xb15a
0000B14D  D0EC              shr ah,1
0000B14F  E2F8              loop 0xb149
0000B151  59                pop cx
0000B152  E303              jcxz 0xb157
0000B154  E96EFF            jmp 0xb0c5
0000B157  E971FF            jmp 0xb0cb
0000B15A  60                pusha
0000B15B  8BDE              mov bx,si
0000B15D  81EB5E28          sub bx,0x285e
0000B161  03DB              add bx,bx
0000B163  03DB              add bx,bx
0000B165  03DB              add bx,bx
0000B167  2BD9              sub bx,cx
0000B169  8AC3              mov al,bl
0000B16B  A27609            mov [0x976],al
0000B16E  8464FF            test [si-0x1],ah
0000B171  7506              jnz 0xb179
0000B173  3065FF            xor [di-0x1],ah
0000B176  EB0A              jmp short 0xb182
0000B178  90                nop
0000B179  0865FF            or [di-0x1],ah
0000B17C  B400              mov ah,0x0
0000B17E  88267509          mov [0x975],ah
0000B182  BB8A4D            mov bx,0x4d8a
0000B185  8A0EF407          mov cl,[0x7f4]
0000B189  80F912            cmp cl,0x12
0000B18C  7418              jz 0xb1a6
0000B18E  80F913            cmp cl,0x13
0000B191  7413              jz 0xb1a6
0000B193  BB024E            mov bx,0x4e02
0000B196  80F910            cmp cl,0x10
0000B199  740B              jz 0xb1a6
0000B19B  BB7A4E            mov bx,0x4e7a
0000B19E  80F906            cmp cl,0x6
0000B1A1  7403              jz 0xb1a6
0000B1A3  BB124D            mov bx,0x4d12
0000B1A6  2ED7              cs xlatb
0000B1A8  E8E1C4            call 0x768c
0000B1AB  61                popa
0000B1AC  EB9F              jmp short 0xb14d
0000B1AE  803E710900        cmp byte [0x971],0x0
0000B1B3  7420              jz 0xb1d5
0000B1B5  A07209            mov al,[0x972]
0000B1B8  84E4              test ah,ah
0000B1BA  7506              jnz 0xb1c2
0000B1BC  3A067009          cmp al,[0x970]
0000B1C0  EB04              jmp short 0xb1c6
0000B1C2  3A067109          cmp al,[0x971]
0000B1C6  720D              jc 0xb1d5
0000B1C8  A27509            mov [0x975],al
0000B1CB  53                push bx
0000B1CC  A07309            mov al,[0x973]
0000B1CF  32E4              xor ah,ah
0000B1D1  E8B8C4            call 0x768c
0000B1D4  5B                pop bx
0000B1D5  E9FAFE            jmp 0xb0d2
0000B1D8  BA5EFF            mov dx,0xff5e
0000B1DB  BB5AFF            mov bx,0xff5a
0000B1DE  FA                cli
0000B1DF  EC                in al,dx
0000B1E0  24FD              and al,0xfd
0000B1E2  EE                out dx,al
0000B1E3  0C02              or al,0x2
0000B1E5  8AE0              mov ah,al
0000B1E7  87D3              xchg dx,bx
0000B1E9  EC                in al,dx
0000B1EA  87D3              xchg dx,bx
0000B1EC  86C4              xchg al,ah
0000B1EE  EE                out dx,al
0000B1EF  FB                sti
0000B1F0  B001              mov al,0x1
0000B1F2  22E0              and ah,al
0000B1F4  2AE0              sub ah,al
0000B1F6  D1D7              rcl di,1
0000B1F8  E2E4              loop 0xb1de
0000B1FA  8BC7              mov ax,di
0000B1FC  C3                ret
0000B1FD  5B                pop bx
0000B1FE  BB4000            mov bx,0x40
0000B201  8EC3              mov es,bx
0000B203  BB6D09            mov bx,0x96d
0000B206  CF                iret
0000B207  FB                sti
0000B208  60                pusha
0000B209  06                push es
0000B20A  1E                push ds
0000B20B  CD1C              int 0x1c
0000B20D  1F                pop ds
0000B20E  07                pop es
0000B20F  61                popa
0000B210  CF                iret
0000B211  CF                iret
0000B212  1E                push ds
0000B213  84E4              test ah,ah
0000B215  7403              jz 0xb21a
0000B217  1F                pop ds
0000B218  CD4F              int 0x4f
0000B21A  BA4000            mov dx,0x40
0000B21D  8EDA              mov ds,dx
0000B21F  8B0E6E00          mov cx,[0x6e]
0000B223  8B166C00          mov dx,[0x6c]
0000B227  1F                pop ds
0000B228  CF                iret
0000B229  006256            add [bp+si+0x56],ah
0000B22C  055890            add ax,0x9058
0000B22F  58                pop ax
0000B230  E258              loop 0xb28a
0000B232  60                pusha
0000B233  56                push si
0000B234  F9                stc
0000B235  58                pop ax
0000B236  40                inc ax
0000B237  59                pop cx
0000B238  FC                cld
0000B239  58                pop ax
0000B23A  60                pusha
0000B23B  56                push si
0000B23C  60                pusha
0000B23D  56                push si
0000B23E  60                pusha
0000B23F  56                push si
0000B240  60                pusha
0000B241  56                push si
0000B242  60                pusha
0000B243  56                push si
0000B244  60                pusha
0000B245  56                push si
0000B246  CF                iret
0000B247  5A                pop dx
0000B248  01                db 0x01
0000B249  5C                pop sp

; ---- 0x0b24a-0x0b26a  character-generator font / bitmap data  [H08/H21] ----
0000B24A  04 01 07 00 00 00 00 00 20 08 38 24 24 09 3f 24  |........ .8$$.?$|
0000B25A  20 08 38 24 24 09 3f 24 04 01 07 00 00 00 00 00  | .8$$.?$........|

; ==== 0x0b26a-0x0be06  CODE (CF-reached, conf 99) ====
0000B26A  0219              add bl,[bx+di]
0000B26C  50                push ax
0000B26D  1003              adc [bp+di],al
0000B26F  195010            sbb [bx+si+0x10],dx
0000B272  07                pop es
0000B273  195010            sbb [bx+si+0x10],dx
0000B276  27                daa
0000B277  1B500E            sbb dx,[bx+si+0xe]
0000B27A  301E500E          xor [0xe50],bl
0000B27E  3219              xor bl,[bx+di]
0000B280  8410              test [bx+si],dl
0000B282  341B              xor al,0x1b
0000B284  840E371E          test [0x1e37],cl
0000B288  840E1E07          test [0x71e],cl
0000B28C  BF7C28            mov di,0x287c
0000B28F  B9D007            mov cx,0x7d0
0000B292  B020              mov al,0x20
0000B294  F3AA              rep stosb
0000B296  BA4303            mov dx,0x343
0000B299  B028              mov al,0x28
0000B29B  FA                cli
0000B29C  0A06B907          or al,[0x7b9]
0000B2A0  A2B907            mov [0x7b9],al
0000B2A3  EE                out dx,al
0000B2A4  FB                sti
0000B2A5  BF00D0            mov di,0xd000
0000B2A8  8EC7              mov es,di
0000B2AA  BF00D6            mov di,0xd600
0000B2AD  AA                stosb
0000B2AE  BF00D9            mov di,0xd900
0000B2B1  AA                stosb
0000B2B2  33FF              xor di,di
0000B2B4  8EC7              mov es,di
0000B2B6  BF4000            mov di,0x40
0000B2B9  B84756            mov ax,0x5647
0000B2BC  FA                cli
0000B2BD  AB                stosw
0000B2BE  8CC8              mov ax,cs
0000B2C0  AB                stosw
0000B2C1  FB                sti
0000B2C2  B90001            mov cx,0x100
0000B2C5  BA0203            mov dx,0x302
0000B2C8  B410              mov ah,0x10
0000B2CA  CD40              int 0x40
0000B2CC  A11409            mov ax,[0x914]
0000B2CF  A37809            mov [0x978],ax
0000B2D2  B80700            mov ax,0x7
0000B2D5  CD10              int 0x10
0000B2D7  B402              mov ah,0x2
0000B2D9  BA0018            mov dx,0x1800
0000B2DC  CD10              int 0x10
0000B2DE  C3                ret
0000B2DF  BAC109            mov dx,0x9c1
0000B2E2  E8B8F3            call 0xa69d
0000B2E5  7405              jz 0xb2ec
0000B2E7  2EC43E0800        les di,[cs:0x8]
0000B2EC  8C06BE09          mov [0x9be],es
0000B2F0  893EBC09          mov [0x9bc],di
0000B2F4  268B05            mov ax,[es:di]
0000B2F7  03C0              add ax,ax
0000B2F9  03F8              add di,ax
0000B2FB  268B4502          mov ax,[es:di+0x2]
0000B2FF  3D3412            cmp ax,0x1234
0000B302  B010              mov al,0x10
0000B304  7402              jz 0xb308
0000B306  B00E              mov al,0xe
0000B308  A2C009            mov [0x9c0],al
0000B30B  C3                ret
0000B30C  32C0              xor al,al
0000B30E  86067B09          xchg al,[0x97b]
0000B312  84C0              test al,al
0000B314  7536              jnz 0xb34c
0000B316  3A067A09          cmp al,[0x97a]
0000B31A  752F              jnz 0xb34b
0000B31C  FF0E7D09          dec word [0x97d]
0000B320  7529              jnz 0xb34b
0000B322  FE0E7C09          dec byte [0x97c]
0000B326  751D              jnz 0xb345
0000B328  803EAD0700        cmp byte [0x7ad],0x0
0000B32D  7416              jz 0xb345
0000B32F  53                push bx
0000B330  8B1E7809          mov bx,[0x978]
0000B334  80BFA40000        cmp byte [bx+0xa4],0x0
0000B339  5B                pop bx
0000B33A  7509              jnz 0xb345
0000B33C  FE067A09          inc byte [0x97a]
0000B340  B480              mov ah,0x80
0000B342  E81E00            call 0xb363
0000B345  C7067D09E40C      mov word [0x97d],0xce4
0000B34B  C3                ret
0000B34C  A0AD07            mov al,[0x7ad]
0000B34F  A27C09            mov [0x97c],al
0000B352  C7067D09E40C      mov word [0x97d],0xce4
0000B358  33C0              xor ax,ax
0000B35A  38067A09          cmp [0x97a],al
0000B35E  74EB              jz 0xb34b
0000B360  A27A09            mov [0x97a],al
0000B363  A08F09            mov al,[0x98f]
0000B366  247F              and al,0x7f
0000B368  0AC4              or al,ah
0000B36A  A28F09            mov [0x98f],al
0000B36D  06                push es
0000B36E  57                push di
0000B36F  BF00D0            mov di,0xd000
0000B372  8EC7              mov es,di
0000B374  BF00C2            mov di,0xc200
0000B377  AA                stosb
0000B378  5F                pop di
0000B379  07                pop es
0000B37A  C3                ret
0000B37B  BB4000            mov bx,0x40
0000B37E  8EC3              mov es,bx
0000B380  268B1E1409        mov bx,[es:0x914]
0000B385  263B1E7809        cmp bx,[es:0x978]
0000B38A  7512              jnz 0xb39e
0000B38C  26C687A80000      mov byte [es:bx+0xa8],0x0
0000B392  BB00D0            mov bx,0xd000
0000B395  8EC3              mov es,bx
0000B397  BB0000            mov bx,0x0
0000B39A  83C402            add sp,byte +0x2
0000B39D  CF                iret
0000B39E  33DB              xor bx,bx
0000B3A0  8EC3              mov es,bx
0000B3A2  83C402            add sp,byte +0x2
0000B3A5  CF                iret
0000B3A6  1E                push ds
0000B3A7  BB4000            mov bx,0x40
0000B3AA  8EDB              mov ds,bx
0000B3AC  8B1E1409          mov bx,[0x914]
0000B3B0  898FA000          mov [bx+0xa0],cx
0000B3B4  8997A200          mov [bx+0xa2],dx
0000B3B8  3B1E7809          cmp bx,[0x978]
0000B3BC  7507              jnz 0xb3c5
0000B3BE  60                pusha
0000B3BF  06                push es
0000B3C0  E8C600            call 0xb489
0000B3C3  07                pop es
0000B3C4  61                popa
0000B3C5  1F                pop ds
0000B3C6  5B                pop bx
0000B3C7  CF                iret
0000B3C8  1E                push ds
0000B3C9  BB4000            mov bx,0x40
0000B3CC  8EDB              mov ds,bx
0000B3CE  3C3C              cmp al,0x3c
0000B3D0  740A              jz 0xb3dc
0000B3D2  3C48              cmp al,0x48
0000B3D4  740E              jz 0xb3e4
0000B3D6  E89DC0            call 0x7476
0000B3D9  1F                pop ds
0000B3DA  5B                pop bx
0000B3DB  CF                iret
0000B3DC  C606AF0700        mov byte [0x7af],0x0
0000B3E1  1F                pop ds
0000B3E2  5B                pop bx
0000B3E3  CF                iret
0000B3E4  C606AF0701        mov byte [0x7af],0x1
0000B3E9  1F                pop ds
0000B3EA  5B                pop bx
0000B3EB  CF                iret
0000B3EC  1E                push ds
0000B3ED  BB4000            mov bx,0x40
0000B3F0  8EDB              mov ds,bx
0000B3F2  8B1E1409          mov bx,[0x914]
0000B3F6  3C03              cmp al,0x3
0000B3F8  7329              jnc 0xb423
0000B3FA  3C01              cmp al,0x1
0000B3FC  7710              ja 0xb40e
0000B3FE  7407              jz 0xb407
0000B400  C687A40001        mov byte [bx+0xa4],0x1
0000B405  EB19              jmp short 0xb420
0000B407  C687A40000        mov byte [bx+0xa4],0x0
0000B40C  EB12              jmp short 0xb420
0000B40E  50                push ax
0000B40F  B480              mov ah,0x80
0000B411  FA                cli
0000B412  E84EFF            call 0xb363
0000B415  FE067A09          inc byte [0x97a]
0000B419  C6067B0900        mov byte [0x97b],0x0
0000B41E  FB                sti
0000B41F  58                pop ax
0000B420  1F                pop ds
0000B421  5B                pop bx
0000B422  CF                iret
0000B423  C6067B0901        mov byte [0x97b],0x1
0000B428  EBF6              jmp short 0xb420
0000B42A  1E                push ds
0000B42B  BB4000            mov bx,0x40
0000B42E  8EDB              mov ds,bx
0000B430  8B1E1409          mov bx,[0x914]
0000B434  88879A00          mov [bx+0x9a],al
0000B438  3B1E7809          cmp bx,[0x978]
0000B43C  7548              jnz 0xb486
0000B43E  06                push es
0000B43F  50                push ax
0000B440  51                push cx
0000B441  56                push si
0000B442  57                push di
0000B443  BB00D0            mov bx,0xd000
0000B446  8EC3              mov es,bx
0000B448  8AE0              mov ah,al
0000B44A  BB00C5            mov bx,0xc500
0000B44D  A09209            mov al,[0x992]
0000B450  24FD              and al,0xfd
0000B452  D0EC              shr ah,1
0000B454  7302              jnc 0xb458
0000B456  0C02              or al,0x2
0000B458  268807            mov [es:bx],al
0000B45B  A29209            mov [0x992],al
0000B45E  BB00C8            mov bx,0xc800
0000B461  A09509            mov al,[0x995]
0000B464  24F0              and al,0xf0
0000B466  B91000            mov cx,0x10
0000B469  BE4A52            mov si,0x524a
0000B46C  BF00DE            mov di,0xde00
0000B46F  D0EC              shr ah,1
0000B471  7304              jnc 0xb477
0000B473  0C04              or al,0x4
0000B475  03F1              add si,cx
0000B477  268807            mov [es:bx],al
0000B47A  A29509            mov [0x995],al
0000B47D  0E                push cs
0000B47E  1F                pop ds
0000B47F  F3A4              rep movsb
0000B481  5F                pop di
0000B482  5E                pop si
0000B483  59                pop cx
0000B484  58                pop ax
0000B485  07                pop es
0000B486  1F                pop ds
0000B487  5B                pop bx
0000B488  CF                iret
0000B489  8B1E7809          mov bx,[0x978]
0000B48D  81C39F00          add bx,0x9f
0000B491  B90400            mov cx,0x4
0000B494  BF00D0            mov di,0xd000
0000B497  8EC7              mov es,di
0000B499  BF00A0            mov di,0xa000
0000B49C  43                inc bx
0000B49D  53                push bx
0000B49E  1E                push ds
0000B49F  51                push cx
0000B4A0  8A1F              mov bl,[bx]
0000B4A2  32ED              xor ch,ch
0000B4A4  E80A00            call 0xb4b1
0000B4A7  59                pop cx
0000B4A8  1F                pop ds
0000B4A9  5B                pop bx
0000B4AA  81C70008          add di,0x800
0000B4AE  E2EC              loop 0xb49c
0000B4B0  C3                ret
0000B4B1  1E                push ds
0000B4B2  56                push si
0000B4B3  57                push di
0000B4B4  BE4000            mov si,0x40
0000B4B7  8EDE              mov ds,si
0000B4B9  32FF              xor bh,bh
0000B4BB  8ACB              mov cl,bl
0000B4BD  8A368A09          mov dh,[0x98a]
0000B4C1  84ED              test ch,ch
0000B4C3  7515              jnz 0xb4da
0000B4C5  8A16C009          mov dl,[0x9c0]
0000B4C9  C536BC09          lds si,[0x9bc]
0000B4CD  3B1C              cmp bx,[si]
0000B4CF  7309              jnc 0xb4da
0000B4D1  03DB              add bx,bx
0000B4D3  3B5802            cmp bx,[bx+si+0x2]
0000B4D6  7211              jc 0xb4e9
0000B4D8  D1EB              shr bx,1
0000B4DA  2EC5360800        lds si,[cs:0x8]
0000B4DF  B20E              mov dl,0xe
0000B4E1  3B1C              cmp bx,[si]
0000B4E3  7202              jc 0xb4e7
0000B4E5  33DB              xor bx,bx
0000B4E7  03DB              add bx,bx
0000B4E9  8BEE              mov bp,si
0000B4EB  8B5802            mov bx,[bx+si+0x2]
0000B4EE  03DE              add bx,si
0000B4F0  8A07              mov al,[bx]
0000B4F2  43                inc bx
0000B4F3  3CFF              cmp al,0xff
0000B4F5  7413              jz 0xb50a
0000B4F7  53                push bx
0000B4F8  55                push bp
0000B4F9  52                push dx
0000B4FA  32ED              xor ch,ch
0000B4FC  3AC1              cmp al,cl
0000B4FE  7502              jnz 0xb502
0000B500  B501              mov ch,0x1
0000B502  8AD8              mov bl,al
0000B504  E8AAFF            call 0xb4b1
0000B507  5A                pop dx
0000B508  5D                pop bp
0000B509  5B                pop bx
0000B50A  8A07              mov al,[bx]
0000B50C  43                inc bx
0000B50D  3CFF              cmp al,0xff
0000B50F  7427              jz 0xb538
0000B511  84C0              test al,al
0000B513  7413              jz 0xb528
0000B515  3AD6              cmp dl,dh
0000B517  7523              jnz 0xb53c
0000B519  8B37              mov si,[bx]
0000B51B  03F5              add si,bp
0000B51D  43                inc bx
0000B51E  43                inc bx
0000B51F  B91000            mov cx,0x10
0000B522  F3A4              rep movsb
0000B524  FEC8              dec al
0000B526  75F1              jnz 0xb519
0000B528  8A07              mov al,[bx]
0000B52A  43                inc bx
0000B52B  3CFF              cmp al,0xff
0000B52D  7409              jz 0xb538
0000B52F  32E4              xor ah,ah
0000B531  C1E004            shl ax,byte 0x4
0000B534  03F8              add di,ax
0000B536  EBD2              jmp short 0xb50a
0000B538  5F                pop di
0000B539  5E                pop si
0000B53A  1F                pop ds
0000B53B  C3                ret
0000B53C  7317              jnc 0xb555
0000B53E  8AE0              mov ah,al
0000B540  32C0              xor al,al
0000B542  8B37              mov si,[bx]
0000B544  03F5              add si,bp
0000B546  43                inc bx
0000B547  43                inc bx
0000B548  AA                stosb
0000B549  B90E00            mov cx,0xe
0000B54C  F3A4              rep movsb
0000B54E  AA                stosb
0000B54F  FECC              dec ah
0000B551  75EF              jnz 0xb542
0000B553  EBD3              jmp short 0xb528
0000B555  8B37              mov si,[bx]
0000B557  03F5              add si,bp
0000B559  43                inc bx
0000B55A  43                inc bx
0000B55B  46                inc si
0000B55C  B91000            mov cx,0x10
0000B55F  F3A4              rep movsb
0000B561  FEC8              dec al
0000B563  75F0              jnz 0xb555
0000B565  EBC1              jmp short 0xb528
0000B567  1E                push ds
0000B568  BB4000            mov bx,0x40
0000B56B  8EDB              mov ds,bx
0000B56D  8B1E1409          mov bx,[0x914]
0000B571  3B1E7809          cmp bx,[0x978]
0000B575  7403              jz 0xb57a
0000B577  1F                pop ds
0000B578  5B                pop bx
0000B579  CF                iret
0000B57A  52                push dx
0000B57B  56                push si
0000B57C  57                push di
0000B57D  55                push bp
0000B57E  BF00A0            mov di,0xa000
0000B581  250300            and ax,0x3
0000B584  C1E00B            shl ax,byte 0xb
0000B587  03F8              add di,ax
0000B589  51                push cx
0000B58A  57                push di
0000B58B  26AC              es lodsb
0000B58D  257F00            and ax,0x7f
0000B590  C1E004            shl ax,byte 0x4
0000B593  03F8              add di,ax
0000B595  32E4              xor ah,ah
0000B597  26AC              es lodsb
0000B599  8BD8              mov bx,ax
0000B59B  26AC              es lodsb
0000B59D  8BC8              mov cx,ax
0000B59F  C606B709FF        mov byte [0x9b7],0xff
0000B5A4  56                push si
0000B5A5  1E                push ds
0000B5A6  8A268A09          mov ah,[0x98a]
0000B5AA  3A1EB709          cmp bl,[0x9b7]
0000B5AE  7418              jz 0xb5c8
0000B5B0  881EB709          mov [0x9b7],bl
0000B5B4  A0C009            mov al,[0x9c0]
0000B5B7  C536BC09          lds si,[0x9bc]
0000B5BB  3B1C              cmp bx,[si]
0000B5BD  7309              jnc 0xb5c8
0000B5BF  03DB              add bx,bx
0000B5C1  3B5802            cmp bx,[bx+si+0x2]
0000B5C4  720F              jc 0xb5d5
0000B5C6  D1EB              shr bx,1
0000B5C8  2EC5360800        lds si,[cs:0x8]
0000B5CD  B00E              mov al,0xe
0000B5CF  3B1C              cmp bx,[si]
0000B5D1  7352              jnc 0xb625
0000B5D3  03DB              add bx,bx
0000B5D5  8BEE              mov bp,si
0000B5D7  037002            add si,[bx+si+0x2]
0000B5DA  8A1C              mov bl,[si]
0000B5DC  8AF9              mov bh,cl
0000B5DE  46                inc si
0000B5DF  32F6              xor dh,dh
0000B5E1  8A14              mov dl,[si]
0000B5E3  46                inc si
0000B5E4  80FAFF            cmp dl,0xff
0000B5E7  7414              jz 0xb5fd
0000B5E9  3ACA              cmp cl,dl
0000B5EB  7220              jc 0xb60d
0000B5ED  2ACA              sub cl,dl
0000B5EF  03F2              add si,dx
0000B5F1  8A14              mov dl,[si]
0000B5F3  46                inc si
0000B5F4  80FAFF            cmp dl,0xff
0000B5F7  7404              jz 0xb5fd
0000B5F9  2ACA              sub cl,dl
0000B5FB  73E4              jnc 0xb5e1
0000B5FD  80FBFF            cmp bl,0xff
0000B600  7423              jz 0xb625
0000B602  1F                pop ds
0000B603  5E                pop si
0000B604  33C9              xor cx,cx
0000B606  86CF              xchg cl,bh
0000B608  EB9A              jmp short 0xb5a4
0000B60A  E97CFF            jmp 0xb589
0000B60D  03F1              add si,cx
0000B60F  03F1              add si,cx
0000B611  8B34              mov si,[si]
0000B613  03F5              add si,bp
0000B615  06                push es
0000B616  B900D0            mov cx,0xd000
0000B619  8EC1              mov es,cx
0000B61B  3AC4              cmp al,ah
0000B61D  7513              jnz 0xb632
0000B61F  B90800            mov cx,0x8
0000B622  F3A5              rep movsw
0000B624  07                pop es
0000B625  1F                pop ds
0000B626  5E                pop si
0000B627  5F                pop di
0000B628  59                pop cx
0000B629  E2DF              loop 0xb60a
0000B62B  5D                pop bp
0000B62C  5F                pop di
0000B62D  5E                pop si
0000B62E  5A                pop dx
0000B62F  1F                pop ds
0000B630  5B                pop bx
0000B631  CF                iret
0000B632  730B              jnc 0xb63f
0000B634  32C0              xor al,al
0000B636  AA                stosb
0000B637  B90700            mov cx,0x7
0000B63A  F3A5              rep movsw
0000B63C  AA                stosb
0000B63D  EBE5              jmp short 0xb624
0000B63F  46                inc si
0000B640  B90800            mov cx,0x8
0000B643  F3A5              rep movsw
0000B645  EBDD              jmp short 0xb624
0000B647  FB                sti
0000B648  FC                cld
0000B649  1E                push ds
0000B64A  53                push bx
0000B64B  BB4000            mov bx,0x40
0000B64E  8EDB              mov ds,bx
0000B650  8ADC              mov bl,ah
0000B652  32FF              xor bh,bh
0000B654  03DB              add bx,bx
0000B656  83FB20            cmp bx,byte +0x20
0000B659  7305              jnc 0xb660
0000B65B  2EFFA72A52        jmp [cs:bx+0x522a]
0000B660  CD4F              int 0x4f
0000B662  50                push ax
0000B663  56                push si
0000B664  247F              and al,0x7f
0000B666  BE6A52            mov si,0x526a
0000B669  2E3A04            cmp al,[cs:si]
0000B66C  740E              jz 0xb67c
0000B66E  83C604            add si,byte +0x4
0000B671  81FE8A52          cmp si,0x528a
0000B675  72F2              jc 0xb669
0000B677  CD4F              int 0x4f
0000B679  E97B01            jmp 0xb7f7
0000B67C  8B1E1409          mov bx,[0x914]
0000B680  46                inc si
0000B681  88879900          mov [bx+0x99],al
0000B685  2EAD              cs lodsw
0000B687  88A79B00          mov [bx+0x9b],ah
0000B68B  3B1E7809          cmp bx,[0x978]
0000B68F  75E8              jnz 0xb679
0000B691  A28809            mov [0x988],al
0000B694  88268909          mov [0x989],ah
0000B698  2EAC              cs lodsb
0000B69A  A28A09            mov [0x98a],al
0000B69D  B480              mov ah,0x80
0000B69F  E8C1FC            call 0xb363
0000B6A2  51                push cx
0000B6A3  52                push dx
0000B6A4  57                push di
0000B6A5  06                push es
0000B6A6  BB00D0            mov bx,0xd000
0000B6A9  8EC3              mov es,bx
0000B6AB  BE4A52            mov si,0x524a
0000B6AE  BF00DE            mov di,0xde00
0000B6B1  B91000            mov cx,0x10
0000B6B4  1E                push ds
0000B6B5  0E                push cs
0000B6B6  1F                pop ds
0000B6B7  F3A4              rep movsb
0000B6B9  1F                pop ds
0000B6BA  BB0000            mov bx,0x0
0000B6BD  BA2000            mov dx,0x20
0000B6C0  BF4000            mov di,0x40
0000B6C3  8BC7              mov ax,di
0000B6C5  86C4              xchg al,ah
0000B6C7  268907            mov [es:bx],ax
0000B6CA  43                inc bx
0000B6CB  43                inc bx
0000B6CC  32C0              xor al,al
0000B6CE  AA                stosb
0000B6CF  B82000            mov ax,0x20
0000B6D2  8A0E8909          mov cl,[0x989]
0000B6D6  32ED              xor ch,ch
0000B6D8  2688A50080        mov [es:di-0x8000],ah
0000B6DD  AA                stosb
0000B6DE  E2F8              loop 0xb6d8
0000B6E0  4A                dec dx
0000B6E1  75E0              jnz 0xb6c3
0000B6E3  4B                dec bx
0000B6E4  4B                dec bx
0000B6E5  891EA309          mov [0x9a3],bx
0000B6E9  BF00C0            mov di,0xc000
0000B6EC  BB8D09            mov bx,0x98d
0000B6EF  B000              mov al,0x0
0000B6F1  E80801            call 0xb7fc
0000B6F4  B000              mov al,0x0
0000B6F6  E80301            call 0xb7fc
0000B6F9  B08A              mov al,0x8a
0000B6FB  E8FE00            call 0xb7fc
0000B6FE  B000              mov al,0x0
0000B700  E8F900            call 0xb7fc
0000B703  B000              mov al,0x0
0000B705  E8F400            call 0xb7fc
0000B708  B028              mov al,0x28
0000B70A  E8EF00            call 0xb7fc
0000B70D  B000              mov al,0x0
0000B70F  E8EA00            call 0xb7fc
0000B712  B0C7              mov al,0xc7
0000B714  803E890950        cmp byte [0x989],0x50
0000B719  7402              jz 0xb71d
0000B71B  B007              mov al,0x7
0000B71D  E8DC00            call 0xb7fc
0000B720  B010              mov al,0x10
0000B722  E8D700            call 0xb7fc
0000B725  B001              mov al,0x1
0000B727  E8D200            call 0xb7fc
0000B72A  B0F0              mov al,0xf0
0000B72C  E8CD00            call 0xb7fc
0000B72F  B0F0              mov al,0xf0
0000B731  E8C800            call 0xb7fc
0000B734  803E8A0910        cmp byte [0x98a],0x10
0000B739  720C              jc 0xb747
0000B73B  B02D              mov al,0x2d
0000B73D  E8BC00            call 0xb7fc
0000B740  B0AF              mov al,0xaf
0000B742  E8B700            call 0xb7fc
0000B745  EB0A              jmp short 0xb751
0000B747  B02C              mov al,0x2c
0000B749  E8B000            call 0xb7fc
0000B74C  B08E              mov al,0x8e
0000B74E  E8AB00            call 0xb7fc
0000B751  803EAF0700        cmp byte [0x7af],0x0
0000B756  7507              jnz 0xb75f
0000B758  BA0B02            mov dx,0x20b
0000B75B  B508              mov ch,0x8
0000B75D  EB05              jmp short 0xb764
0000B75F  BAB901            mov dx,0x1b9
0000B762  B510              mov ch,0x10
0000B764  8A0E8A09          mov cl,[0x98a]
0000B768  51                push cx
0000B769  A08809            mov al,[0x988]
0000B76C  F6E1              mul cl
0000B76E  50                push ax
0000B76F  051400            add ax,0x14
0000B772  F7D8              neg ax
0000B774  03C2              add ax,dx
0000B776  7902              jns 0xb77a
0000B778  CD4F              int 0x4f
0000B77A  D1E8              shr ax,1
0000B77C  050F00            add ax,0xf
0000B77F  50                push ax
0000B780  E87900            call 0xb7fc
0000B783  59                pop cx
0000B784  58                pop ax
0000B785  03C1              add ax,cx
0000B787  50                push ax
0000B788  E87100            call 0xb7fc
0000B78B  8BC2              mov ax,dx
0000B78D  E86C00            call 0xb7fc
0000B790  B0FF              mov al,0xff
0000B792  E86700            call 0xb7fc
0000B795  58                pop ax
0000B796  8AC4              mov al,ah
0000B798  D0E0              shl al,1
0000B79A  D0E0              shl al,1
0000B79C  02C6              add al,dh
0000B79E  D0E0              shl al,1
0000B7A0  D0E0              shl al,1
0000B7A2  0403              add al,0x3
0000B7A4  E85500            call 0xb7fc
0000B7A7  59                pop cx
0000B7A8  FEC9              dec cl
0000B7AA  8AC1              mov al,cl
0000B7AC  E84D00            call 0xb7fc
0000B7AF  E84A00            call 0xb7fc
0000B7B2  B000              mov al,0x0
0000B7B4  E84500            call 0xb7fc
0000B7B7  8B1E7809          mov bx,[0x978]
0000B7BB  C6879C000F        mov byte [bx+0x9c],0xf
0000B7C0  C6879D0010        mov byte [bx+0x9d],0x10
0000B7C5  C6879E00FF        mov byte [bx+0x9e],0xff
0000B7CA  C6879F0000        mov byte [bx+0x9f],0x0
0000B7CF  BA4303            mov dx,0x343
0000B7D2  FA                cli
0000B7D3  A0B907            mov al,[0x7b9]
0000B7D6  24E7              and al,0xe7
0000B7D8  0AC5              or al,ch
0000B7DA  EE                out dx,al
0000B7DB  A2B907            mov [0x7b9],al
0000B7DE  FB                sti
0000B7DF  55                push bp
0000B7E0  E8A6FC            call 0xb489
0000B7E3  5D                pop bp
0000B7E4  32E4              xor ah,ah
0000B7E6  E87AFB            call 0xb363
0000B7E9  C6067B0901        mov byte [0x97b],0x1
0000B7EE  C6067A0900        mov byte [0x97a],0x0
0000B7F3  07                pop es
0000B7F4  5F                pop di
0000B7F5  5A                pop dx
0000B7F6  59                pop cx
0000B7F7  5E                pop si
0000B7F8  58                pop ax
0000B7F9  5B                pop bx
0000B7FA  1F                pop ds
0000B7FB  CF                iret
0000B7FC  8807              mov [bx],al
0000B7FE  AA                stosb
0000B7FF  81C7FF00          add di,0xff
0000B803  43                inc bx
0000B804  C3                ret
0000B805  8B1E1409          mov bx,[0x914]
0000B809  88AF9C00          mov [bx+0x9c],ch
0000B80D  888F9D00          mov [bx+0x9d],cl
0000B811  3B1E7809          cmp bx,[0x978]
0000B815  7576              jnz 0xb88d
0000B817  06                push es
0000B818  50                push ax
0000B819  B800D0            mov ax,0xd000
0000B81C  8EC0              mov es,ax
0000B81E  8A1EA009          mov bl,[0x9a0]
0000B822  43                inc bx
0000B823  8BC1              mov ax,cx
0000B825  257F7F            and ax,0x7f7f
0000B828  80FC20            cmp ah,0x20
0000B82B  7411              jz 0xb83e
0000B82D  2AC4              sub al,ah
0000B82F  3C03              cmp al,0x3
0000B831  7219              jc 0xb84c
0000B833  80FC02            cmp ah,0x2
0000B836  720D              jc 0xb845
0000B838  8AFB              mov bh,bl
0000B83A  D0EF              shr bh,1
0000B83C  EB13              jmp short 0xb851
0000B83E  A09409            mov al,[0x994]
0000B841  24FE              and al,0xfe
0000B843  EB3C              jmp short 0xb881
0000B845  A09409            mov al,[0x994]
0000B848  24FB              and al,0xfb
0000B84A  EB2B              jmp short 0xb877
0000B84C  8AFB              mov bh,bl
0000B84E  80EF02            sub bh,0x2
0000B851  C0E303            shl bl,byte 0x3
0000B854  C1EB03            shr bx,byte 0x3
0000B857  8AE3              mov ah,bl
0000B859  C0E705            shl bh,byte 0x5
0000B85C  A09909            mov al,[0x999]
0000B85F  241F              and al,0x1f
0000B861  0AC7              or al,bh
0000B863  33DB              xor bx,bx
0000B865  A39909            mov [0x999],ax
0000B868  26888700CC        mov [es:bx-0x3400],al
0000B86D  2688A700CD        mov [es:bx-0x3300],ah
0000B872  A09409            mov al,[0x994]
0000B875  0C04              or al,0x4
0000B877  24FD              and al,0xfd
0000B879  84C9              test cl,cl
0000B87B  7802              js 0xb87f
0000B87D  0C02              or al,0x2
0000B87F  0C01              or al,0x1
0000B881  33DB              xor bx,bx
0000B883  A29409            mov [0x994],al
0000B886  26888700C7        mov [es:bx-0x3900],al
0000B88B  58                pop ax
0000B88C  07                pop es
0000B88D  5B                pop bx
0000B88E  1F                pop ds
0000B88F  CF                iret
0000B890  8B1E1409          mov bx,[0x914]
0000B894  88B79E00          mov [bx+0x9e],dh
0000B898  88979F00          mov [bx+0x9f],dl
0000B89C  3B1E7809          cmp bx,[0x978]
0000B8A0  753D              jnz 0xb8df
0000B8A2  88267B09          mov [0x97b],ah
0000B8A6  06                push es
0000B8A7  50                push ax
0000B8A8  BB00D0            mov bx,0xd000
0000B8AB  8EC3              mov es,bx
0000B8AD  33DB              xor bx,bx
0000B8AF  871E8B09          xchg bx,[0x98b]
0000B8B3  85DB              test bx,bx
0000B8B5  7404              jz 0xb8bb
0000B8B7  268027F7          and byte [es:bx],0xf7
0000B8BB  3A368809          cmp dh,[0x988]
0000B8BF  731C              jnc 0xb8dd
0000B8C1  BB00C9            mov bx,0xc900
0000B8C4  8AC2              mov al,dl
0000B8C6  40                inc ax
0000B8C7  268807            mov [es:bx],al
0000B8CA  8ADE              mov bl,dh
0000B8CC  32FF              xor bh,bh
0000B8CE  03DB              add bx,bx
0000B8D0  268B1F            mov bx,[es:bx]
0000B8D3  86DF              xchg bl,bh
0000B8D5  891E8B09          mov [0x98b],bx
0000B8D9  26800F08          or byte [es:bx],0x8
0000B8DD  58                pop ax
0000B8DE  07                pop es
0000B8DF  5B                pop bx
0000B8E0  1F                pop ds
0000B8E1  CF                iret
0000B8E2  8B1E1409          mov bx,[0x914]
0000B8E6  8AAF9C00          mov ch,[bx+0x9c]
0000B8EA  8A8F9D00          mov cl,[bx+0x9d]
0000B8EE  8AB79E00          mov dh,[bx+0x9e]
0000B8F2  8A979F00          mov dl,[bx+0x9f]
0000B8F6  5B                pop bx
0000B8F7  1F                pop ds
0000B8F8  CF                iret
0000B8F9  5B                pop bx
0000B8FA  1F                pop ds
0000B8FB  CF                iret
0000B8FC  8B1E1409          mov bx,[0x914]
0000B900  3B1E7809          cmp bx,[0x978]
0000B904  75F3              jnz 0xb8f9
0000B906  5B                pop bx
0000B907  53                push bx
0000B908  51                push cx
0000B909  52                push dx
0000B90A  8ACE              mov cl,dh
0000B90C  8AD5              mov dl,ch
0000B90E  FD                std
0000B90F  EB42              jmp short 0xb953
0000B911  FC                cld
0000B912  32F6              xor dh,dh
0000B914  03FA              add di,dx
0000B916  03FA              add di,dx
0000B918  268B05            mov ax,[es:di]
0000B91B  86C4              xchg al,ah
0000B91D  8BF8              mov di,ax
0000B91F  32C0              xor al,al
0000B921  AA                stosb
0000B922  8A0E8909          mov cl,[0x989]
0000B926  32ED              xor ch,ch
0000B928  8BD1              mov dx,cx
0000B92A  B020              mov al,0x20
0000B92C  F3AA              rep stosb
0000B92E  8BCA              mov cx,dx
0000B930  2BF9              sub di,cx
0000B932  81C70080          add di,0x8000
0000B936  8AC7              mov al,bh
0000B938  F3AA              rep stosb
0000B93A  E99D00            jmp 0xb9da
0000B93D  E9DF00            jmp 0xba1f
0000B940  8B1E1409          mov bx,[0x914]
0000B944  3B1E7809          cmp bx,[0x978]
0000B948  75AF              jnz 0xb8f9
0000B94A  5B                pop bx
0000B94B  53                push bx
0000B94C  51                push cx
0000B94D  52                push dx
0000B94E  8ACD              mov cl,ch
0000B950  8AD6              mov dl,dh
0000B952  FC                cld
0000B953  50                push ax
0000B954  06                push es
0000B955  56                push si
0000B956  57                push di
0000B957  BE00D0            mov si,0xd000
0000B95A  8EC6              mov es,si
0000B95C  BF0000            mov di,0x0
0000B95F  2AF5              sub dh,ch
0000B961  72D7              jc 0xb93a
0000B963  74AC              jz 0xb911
0000B965  8B361409          mov si,[0x914]
0000B969  F684B70001        test byte [si+0xb7],0x1
0000B96E  75CD              jnz 0xb93d
0000B970  32ED              xor ch,ch
0000B972  03F9              add di,cx
0000B974  03F9              add di,cx
0000B976  84C0              test al,al
0000B978  7469              jz 0xb9e3
0000B97A  33F6              xor si,si
0000B97C  87368B09          xchg si,[0x98b]
0000B980  85F6              test si,si
0000B982  7404              jz 0xb988
0000B984  268024F7          and byte [es:si],0xf7
0000B988  8ACE              mov cl,dh
0000B98A  8A168909          mov dl,[0x989]
0000B98E  32F6              xor dh,dh
0000B990  8BF7              mov si,di
0000B992  1E                push ds
0000B993  06                push es
0000B994  1F                pop ds
0000B995  AD                lodsw
0000B996  F3A5              rep movsw
0000B998  1F                pop ds
0000B999  8BCA              mov cx,dx
0000B99B  57                push di
0000B99C  50                push ax
0000B99D  86C4              xchg al,ah
0000B99F  8BF8              mov di,ax
0000B9A1  FC                cld
0000B9A2  32C0              xor al,al
0000B9A4  AA                stosb
0000B9A5  B020              mov al,0x20
0000B9A7  F3AA              rep stosb
0000B9A9  8BCA              mov cx,dx
0000B9AB  2BF9              sub di,cx
0000B9AD  81C70080          add di,0x8000
0000B9B1  8AC7              mov al,bh
0000B9B3  F3AA              rep stosb
0000B9B5  58                pop ax
0000B9B6  5F                pop di
0000B9B7  AB                stosw
0000B9B8  8B1E1409          mov bx,[0x914]
0000B9BC  8A879E00          mov al,[bx+0x9e]
0000B9C0  3A068809          cmp al,[0x988]
0000B9C4  7314              jnc 0xb9da
0000B9C6  32E4              xor ah,ah
0000B9C8  03C0              add ax,ax
0000B9CA  8BF8              mov di,ax
0000B9CC  268B05            mov ax,[es:di]
0000B9CF  86C4              xchg al,ah
0000B9D1  A38B09            mov [0x98b],ax
0000B9D4  8BF8              mov di,ax
0000B9D6  26800D08          or byte [es:di],0x8
0000B9DA  5F                pop di
0000B9DB  5E                pop si
0000B9DC  07                pop es
0000B9DD  58                pop ax
0000B9DE  5A                pop dx
0000B9DF  59                pop cx
0000B9E0  5B                pop bx
0000B9E1  1F                pop ds
0000B9E2  CF                iret
0000B9E3  FC                cld
0000B9E4  8AC5              mov al,ch
0000B9E6  32E4              xor ah,ah
0000B9E8  03C0              add ax,ax
0000B9EA  8A0E8909          mov cl,[0x989]
0000B9EE  32ED              xor ch,ch
0000B9F0  BE0000            mov si,0x0
0000B9F3  03F0              add si,ax
0000B9F5  8ADE              mov bl,dh
0000B9F7  FEC3              inc bl
0000B9F9  8BD1              mov dx,cx
0000B9FB  26AD              es lodsw
0000B9FD  86C4              xchg al,ah
0000B9FF  8BF8              mov di,ax
0000BA01  32C0              xor al,al
0000BA03  AA                stosb
0000BA04  B020              mov al,0x20
0000BA06  F3AA              rep stosb
0000BA08  8BCA              mov cx,dx
0000BA0A  2BF9              sub di,cx
0000BA0C  81C70080          add di,0x8000
0000BA10  8AC7              mov al,bh
0000BA12  F3AA              rep stosb
0000BA14  8BCA              mov cx,dx
0000BA16  FECB              dec bl
0000BA18  75E1              jnz 0xb9fb
0000BA1A  EBBE              jmp short 0xb9da
0000BA1C  E951FF            jmp 0xb970
0000BA1F  803EB60900        cmp byte [0x9b6],0x0
0000BA24  75F6              jnz 0xba1c
0000BA26  32E4              xor ah,ah
0000BA28  3ACA              cmp cl,dl
0000BA2A  7232              jc 0xba5e
0000BA2C  B01F              mov al,0x1f
0000BA2E  2AC2              sub al,dl
0000BA30  A3A909            mov [0x9a9],ax
0000BA33  B01E              mov al,0x1e
0000BA35  2AC1              sub al,cl
0000BA37  A3AB09            mov [0x9ab],ax
0000BA3A  8AC1              mov al,cl
0000BA3C  40                inc ax
0000BA3D  03C0              add ax,ax
0000BA3F  A3AD09            mov [0x9ad],ax
0000BA42  B83E00            mov ax,0x3e
0000BA45  A3A509            mov [0x9a5],ax
0000BA48  8AC1              mov al,cl
0000BA4A  03C0              add ax,ax
0000BA4C  A3A709            mov [0x9a7],ax
0000BA4F  C606B409FF        mov byte [0x9b4],0xff
0000BA54  A08A09            mov al,[0x98a]
0000BA57  2C02              sub al,0x2
0000BA59  A2B309            mov [0x9b3],al
0000BA5C  EB27              jmp short 0xba85
0000BA5E  C606B30902        mov byte [0x9b3],0x2
0000BA63  C606B40901        mov byte [0x9b4],0x1
0000BA68  B01E              mov al,0x1e
0000BA6A  2AC2              sub al,dl
0000BA6C  A3A909            mov [0x9a9],ax
0000BA6F  B01F              mov al,0x1f
0000BA71  2AC1              sub al,cl
0000BA73  A3AB09            mov [0x9ab],ax
0000BA76  8AC1              mov al,cl
0000BA78  03C0              add ax,ax
0000BA7A  A3A509            mov [0x9a5],ax
0000BA7D  A3AD09            mov [0x9ad],ax
0000BA80  B03E              mov al,0x3e
0000BA82  A3A709            mov [0x9a7],ax
0000BA85  33F6              xor si,si
0000BA87  87368B09          xchg si,[0x98b]
0000BA8B  85F6              test si,si
0000BA8D  7404              jz 0xba93
0000BA8F  268024F7          and byte [es:si],0xf7
0000BA93  8B36A309          mov si,[0x9a3]
0000BA97  268B04            mov ax,[es:si]
0000BA9A  86C4              xchg al,ah
0000BA9C  8BF8              mov di,ax
0000BA9E  FC                cld
0000BA9F  32C0              xor al,al
0000BAA1  AA                stosb
0000BAA2  8A0E8909          mov cl,[0x989]
0000BAA6  32ED              xor ch,ch
0000BAA8  8BD1              mov dx,cx
0000BAAA  B020              mov al,0x20
0000BAAC  F3AA              rep stosb
0000BAAE  8BCA              mov cx,dx
0000BAB0  2BF9              sub di,cx
0000BAB2  81C70080          add di,0x8000
0000BAB6  8AC7              mov al,bh
0000BAB8  F3AA              rep stosb
0000BABA  C606B50901        mov byte [0x9b5],0x1
0000BABF  C7068309335D      mov word [0x983],0x5d33
0000BAC5  803EB50900        cmp byte [0x9b5],0x0
0000BACA  75F9              jnz 0xbac5
0000BACC  E9E9FE            jmp 0xb9b8
0000BACF  56                push si
0000BAD0  52                push dx
0000BAD1  06                push es
0000BAD2  BE00D0            mov si,0xd000
0000BAD5  8EC6              mov es,si
0000BAD7  8B36BA07          mov si,[0x7ba]
0000BADB  8B16BA09          mov dx,[0x9ba]
0000BADF  3C08              cmp al,0x8
0000BAE1  747C              jz 0xbb5f
0000BAE3  3C0D              cmp al,0xd
0000BAE5  747B              jz 0xbb62
0000BAE7  3C07              cmp al,0x7
0000BAE9  747B              jz 0xbb66
0000BAEB  3C0A              cmp al,0xa
0000BAED  744C              jz 0xbb3b
0000BAEF  8B1EB809          mov bx,[0x9b8]
0000BAF3  03DA              add bx,dx
0000BAF5  8807              mov [bx],al
0000BAF7  3B367809          cmp si,[0x978]
0000BAFB  7529              jnz 0xbb26
0000BAFD  803E860900        cmp byte [0x986],0x0
0000BB02  7522              jnz 0xbb26
0000BB04  88267B09          mov [0x97b],ah
0000BB08  BB3000            mov bx,0x30
0000BB0B  268B1F            mov bx,[es:bx]
0000BB0E  86DF              xchg bl,bh
0000BB10  03DA              add bx,dx
0000BB12  26884701          mov [es:bx+0x1],al
0000BB16  26C687018000      mov byte [es:bx-0x7fff],0x0
0000BB1C  84C0              test al,al
0000BB1E  7906              jns 0xbb26
0000BB20  26C687018040      mov byte [es:bx-0x7fff],0x40
0000BB26  42                inc dx
0000BB27  3A168909          cmp dl,[0x989]
0000BB2B  7210              jc 0xbb3d
0000BB2D  50                push ax
0000BB2E  B80D0E            mov ax,0xe0d
0000BB31  CD10              int 0x10
0000BB33  B80A0E            mov ax,0xe0a
0000BB36  CD10              int 0x10
0000BB38  58                pop ax
0000BB39  EB1E              jmp short 0xbb59
0000BB3B  EB3D              jmp short 0xbb7a
0000BB3D  8916BA09          mov [0x9ba],dx
0000BB41  3B367809          cmp si,[0x978]
0000BB45  7512              jnz 0xbb59
0000BB47  803E860900        cmp byte [0x986],0x0
0000BB4C  750B              jnz 0xbb59
0000BB4E  88949F00          mov [si+0x9f],dl
0000BB52  42                inc dx
0000BB53  BE00C9            mov si,0xc900
0000BB56  268814            mov [es:si],dl
0000BB59  07                pop es
0000BB5A  5A                pop dx
0000BB5B  5E                pop si
0000BB5C  5B                pop bx
0000BB5D  1F                pop ds
0000BB5E  CF                iret
0000BB5F  4A                dec dx
0000BB60  79DB              jns 0xbb3d
0000BB62  33D2              xor dx,dx
0000BB64  EBD7              jmp short 0xbb3d
0000BB66  3B367809          cmp si,[0x978]
0000BB6A  75ED              jnz 0xbb59
0000BB6C  51                push cx
0000BB6D  B402              mov ah,0x2
0000BB6F  B9E803            mov cx,0x3e8
0000BB72  BA7D00            mov dx,0x7d
0000BB75  CD40              int 0x40
0000BB77  59                pop cx
0000BB78  EBDF              jmp short 0xbb59
0000BB7A  A1B809            mov ax,[0x9b8]
0000BB7D  055000            add ax,0x50
0000BB80  3D4C30            cmp ax,0x304c
0000BB83  7203              jc 0xbb88
0000BB85  B87C28            mov ax,0x287c
0000BB88  57                push di
0000BB89  51                push cx
0000BB8A  A3B809            mov [0x9b8],ax
0000BB8D  8BF8              mov di,ax
0000BB8F  1E                push ds
0000BB90  07                pop es
0000BB91  B82020            mov ax,0x2020
0000BB94  B92800            mov cx,0x28
0000BB97  F3AB              rep stosw
0000BB99  B800D0            mov ax,0xd000
0000BB9C  8EC0              mov es,ax
0000BB9E  3B367809          cmp si,[0x978]
0000BBA2  7558              jnz 0xbbfc
0000BBA4  803E860900        cmp byte [0x986],0x0
0000BBA9  7551              jnz 0xbbfc
0000BBAB  33FF              xor di,di
0000BBAD  873E8B09          xchg di,[0x98b]
0000BBB1  85FF              test di,di
0000BBB3  7404              jz 0xbbb9
0000BBB5  268025F7          and byte [es:di],0xf7
0000BBB9  BF0000            mov di,0x0
0000BBBC  8A0E8809          mov cl,[0x988]
0000BBC0  32ED              xor ch,ch
0000BBC2  49                dec cx
0000BBC3  8A168909          mov dl,[0x989]
0000BBC7  32F6              xor dh,dh
0000BBC9  8BF7              mov si,di
0000BBCB  1E                push ds
0000BBCC  06                push es
0000BBCD  1F                pop ds
0000BBCE  AD                lodsw
0000BBCF  F3A5              rep movsw
0000BBD1  1F                pop ds
0000BBD2  8BCA              mov cx,dx
0000BBD4  57                push di
0000BBD5  50                push ax
0000BBD6  86C4              xchg al,ah
0000BBD8  8BF8              mov di,ax
0000BBDA  32C0              xor al,al
0000BBDC  AA                stosb
0000BBDD  B020              mov al,0x20
0000BBDF  F3AA              rep stosb
0000BBE1  8BCA              mov cx,dx
0000BBE3  2BF9              sub di,cx
0000BBE5  81C70080          add di,0x8000
0000BBE9  B000              mov al,0x0
0000BBEB  F3AA              rep stosb
0000BBED  58                pop ax
0000BBEE  5F                pop di
0000BBEF  AB                stosw
0000BBF0  8BD8              mov bx,ax
0000BBF2  86DF              xchg bl,bh
0000BBF4  891E8B09          mov [0x98b],bx
0000BBF8  26800F08          or byte [es:bx],0x8
0000BBFC  59                pop cx
0000BBFD  5F                pop di
0000BBFE  E958FF            jmp 0xbb59
0000BC01  8B1E1409          mov bx,[0x914]
0000BC05  8AA79B00          mov ah,[bx+0x9b]
0000BC09  8A879900          mov al,[bx+0x99]
0000BC0D  5B                pop bx
0000BC0E  32FF              xor bh,bh
0000BC10  1F                pop ds
0000BC11  CF                iret
0000BC12  C606860900        mov byte [0x986],0x0
0000BC17  B400              mov ah,0x0
0000BC19  CD40              int 0x40
0000BC1B  B404              mov ah,0x4
0000BC1D  CD40              int 0x40
0000BC1F  8CC0              mov ax,es
0000BC21  0BC3              or ax,bx
0000BC23  74ED              jz 0xbc12
0000BC25  53                push bx
0000BC26  8B36B809          mov si,[0x9b8]
0000BC2A  83C650            add si,byte +0x50
0000BC2D  BA1900            mov dx,0x19
0000BC30  81FE4C30          cmp si,0x304c
0000BC34  7203              jc 0xbc39
0000BC36  BE7C28            mov si,0x287c
0000BC39  268B07            mov ax,[es:bx]
0000BC3C  43                inc bx
0000BC3D  43                inc bx
0000BC3E  86C4              xchg al,ah
0000BC40  8BF8              mov di,ax
0000BC42  33C0              xor ax,ax
0000BC44  AA                stosb
0000BC45  B95000            mov cx,0x50
0000BC48  2688A50080        mov [es:di-0x8000],ah
0000BC4D  AC                lodsb
0000BC4E  AA                stosb
0000BC4F  84C0              test al,al
0000BC51  7906              jns 0xbc59
0000BC53  26C685FF7F40      mov byte [es:di+0x7fff],0x40
0000BC59  E2ED              loop 0xbc48
0000BC5B  4A                dec dx
0000BC5C  75D2              jnz 0xbc30
0000BC5E  B402              mov ah,0x2
0000BC60  8B16BA09          mov dx,[0x9ba]
0000BC64  B618              mov dh,0x18
0000BC66  CD10              int 0x10
0000BC68  5B                pop bx
0000BC69  268B4702          mov ax,[es:bx+0x2]
0000BC6D  86C4              xchg al,ah
0000BC6F  8BF8              mov di,ax
0000BC71  47                inc di
0000BC72  8A26F407          mov ah,[0x7f4]
0000BC76  E84C00            call 0xbcc5
0000BC79  47                inc di
0000BC7A  8A267609          mov ah,[0x976]
0000BC7E  E84400            call 0xbcc5
0000BC81  B401              mov ah,0x1
0000BC83  CD16              int 0x16
0000BC85  7427              jz 0xbcae
0000BC87  B400              mov ah,0x0
0000BC89  CD16              int 0x16
0000BC8B  3CE0              cmp al,0xe0
0000BC8D  7502              jnz 0xbc91
0000BC8F  32C0              xor al,al
0000BC91  3C20              cmp al,0x20
0000BC93  7312              jnc 0xbca7
0000BC95  E8FEA4            call 0x6196
0000BC98  803E850900        cmp byte [0x985],0x0
0000BC9D  740F              jz 0xbcae
0000BC9F  C606850900        mov byte [0x985],0x0
0000BCA4  E974FF            jmp 0xbc1b
0000BCA7  E83FA5            call 0x61e9
0000BCAA  B40E              mov ah,0xe
0000BCAC  CD10              int 0x10
0000BCAE  B400              mov ah,0x0
0000BCB0  CD40              int 0x40
0000BCB2  B404              mov ah,0x4
0000BCB4  CD40              int 0x40
0000BCB6  8CC0              mov ax,es
0000BCB8  0BC3              or ax,bx
0000BCBA  75AD              jnz 0xbc69
0000BCBC  E953FF            jmp 0xbc12
0000BCBF  E80600            call 0xbcc8
0000BCC2  E80300            call 0xbcc8
0000BCC5  E80000            call 0xbcc8
0000BCC8  C1C004            rol ax,byte 0x4
0000BCCB  50                push ax
0000BCCC  240F              and al,0xf
0000BCCE  3C0A              cmp al,0xa
0000BCD0  7202              jc 0xbcd4
0000BCD2  0407              add al,0x7
0000BCD4  0430              add al,0x30
0000BCD6  AA                stosb
0000BCD7  58                pop ax
0000BCD8  C3                ret
0000BCD9  1E                push ds
0000BCDA  BB4000            mov bx,0x40
0000BCDD  8EDB              mov ds,bx
0000BCDF  8B1E1409          mov bx,[0x914]
0000BCE3  80A7B700FE        and byte [bx+0xb7],0xfe
0000BCE8  2401              and al,0x1
0000BCEA  0887B700          or [bx+0xb7],al
0000BCEE  893E7F09          mov [0x97f],di
0000BCF2  8C068109          mov [0x981],es
0000BCF6  1F                pop ds
0000BCF7  5B                pop bx
0000BCF8  CF                iret
0000BCF9  C7068309D45D      mov word [0x983],0x5dd4
0000BCFF  C606B60901        mov byte [0x9b6],0x1
0000BD04  33FF              xor di,di
0000BD06  8EC7              mov es,di
0000BD08  BF3800            mov di,0x38
0000BD0B  B81F5D            mov ax,0x5d1f
0000BD0E  FA                cli
0000BD0F  AB                stosw
0000BD10  8CC8              mov ax,cs
0000BD12  AB                stosw
0000BD13  FB                sti
0000BD14  BA1CFF            mov dx,0xff1c
0000BD17  FA                cli
0000BD18  ED                in ax,dx
0000BD19  25F7FF            and ax,0xfff7
0000BD1C  EE                out dx,al
0000BD1D  FB                sti
0000BD1E  C3                ret
0000BD1F  FB                sti
0000BD20  FC                cld
0000BD21  50                push ax
0000BD22  52                push dx
0000BD23  1E                push ds
0000BD24  06                push es
0000BD25  BA4000            mov dx,0x40
0000BD28  8EDA              mov ds,dx
0000BD2A  B800D0            mov ax,0xd000
0000BD2D  8EC0              mov es,ax
0000BD2F  FF268309          jmp [0x983]
0000BD33  57                push di
0000BD34  53                push bx
0000BD35  51                push cx
0000BD36  56                push si
0000BD37  8B3EA509          mov di,[0x9a5]
0000BD3B  268B1D            mov bx,[es:di]
0000BD3E  86DF              xchg bl,bh
0000BD40  26800F02          or byte [es:bx],0x2
0000BD44  891EAF09          mov [0x9af],bx
0000BD48  8B3EA709          mov di,[0x9a7]
0000BD4C  268B1D            mov bx,[es:di]
0000BD4F  86DF              xchg bl,bh
0000BD51  26800F03          or byte [es:bx],0x3
0000BD55  891EB109          mov [0x9b1],bx
0000BD59  8B36A309          mov si,[0x9a3]
0000BD5D  FD                std
0000BD5E  8B0EA909          mov cx,[0x9a9]
0000BD62  1E                push ds
0000BD63  B800D0            mov ax,0xd000
0000BD66  8ED8              mov ds,ax
0000BD68  8BFE              mov di,si
0000BD6A  AD                lodsw
0000BD6B  F3A5              rep movsw
0000BD6D  AB                stosw
0000BD6E  FC                cld
0000BD6F  1F                pop ds
0000BD70  C70683097A5D      mov word [0x983],0x5d7a
0000BD76  5E                pop si
0000BD77  59                pop cx
0000BD78  5B                pop bx
0000BD79  5F                pop di
0000BD7A  57                push di
0000BD7B  A0B309            mov al,[0x9b3]
0000BD7E  BF00C3            mov di,0xc300
0000BD81  AA                stosb
0000BD82  0206B409          add al,[0x9b4]
0000BD86  A2B309            mov [0x9b3],al
0000BD89  3C01              cmp al,0x1
0000BD8B  7606              jna 0xbd93
0000BD8D  3A068A09          cmp al,[0x98a]
0000BD91  7240              jc 0xbdd3
0000BD93  C70683099B5D      mov word [0x983],0x5d9b
0000BD99  EB38              jmp short 0xbdd3
0000BD9B  57                push di
0000BD9C  56                push si
0000BD9D  51                push cx
0000BD9E  8B36AD09          mov si,[0x9ad]
0000BDA2  83C600            add si,byte +0x0
0000BDA5  8B0EAB09          mov cx,[0x9ab]
0000BDA9  1E                push ds
0000BDAA  BF00D0            mov di,0xd000
0000BDAD  8EDF              mov ds,di
0000BDAF  8BFE              mov di,si
0000BDB1  AD                lodsw
0000BDB2  F3A5              rep movsw
0000BDB4  AB                stosw
0000BDB5  1F                pop ds
0000BDB6  59                pop cx
0000BDB7  5E                pop si
0000BDB8  8B3EB109          mov di,[0x9b1]
0000BDBC  268025FC          and byte [es:di],0xfc
0000BDC0  8B3EAF09          mov di,[0x9af]
0000BDC4  268025FD          and byte [es:di],0xfd
0000BDC8  32C0              xor al,al
0000BDCA  A2B509            mov [0x9b5],al
0000BDCD  C7068309D45D      mov word [0x983],0x5dd4
0000BDD3  5F                pop di
0000BDD4  BA02FF            mov dx,0xff02
0000BDD7  B80080            mov ax,0x8000
0000BDDA  A2B609            mov [0x9b6],al
0000BDDD  FA                cli
0000BDDE  EE                out dx,al
0000BDDF  07                pop es
0000BDE0  1F                pop ds
0000BDE1  5A                pop dx
0000BDE2  58                pop ax
0000BDE3  CF                iret
0000BDE4  1B00              sbb ax,[bx+si]
0000BDE6  2B21              sub sp,[bx+di]
0000BDE8  6E                outsb
0000BDE9  2134              and [si],si
0000BDEB  23E4              and sp,sp
0000BDED  25F723            and ax,0x23f7
0000BDF0  FE                db 0xfe
0000BDF1  2328              and bp,[bx+si]
0000BDF3  207122            and [bx+di+0x22],dh
0000BDF6  0125              add [di],sp
0000BDF8  16                push ss
0000BDF9  251D25            and ax,0x251d
0000BDFC  36254B25          ss and ax,0x254b
0000BE00  5C                pop sp
0000BE01  257D25            and ax,0x257d
0000BE04  98                cbw
0000BE05  25                db 0x25

; ---- 0x0be06-0x0be1c  character-generator font / bitmap data  [H08/H21] ----
0000BE06  c1 25 a7 26 c4 26 45 27 08 28 cb 28 5a 29 fe 23  |.%.&.&E'.(.(Z).#|
0000BE16  1d 2a fe 23 e2 2a                                |.*.#.*|

; ---- 0x0be1c-0x0be2c  zero padding  [H07/H21] ----
0000BE1C  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|

; ---- 0x0be2c-0x0bfd8  character-generator font / bitmap data  [H08/H21] ----
0000BE2C  7c 82 aa 82 82 ba 92 82 7c 00 00 00 00 00 7c fe  ||.......|.....|.|
0000BE3C  d6 fe fe c6 ee fe 7c 00 00 00 00 00 00 6c fe fe  |......|......l..|
0000BE4C  fe fe 7c 38 10 00 00 00 00 00 00 10 38 7c fe 7c  |..|8........8|.||
0000BE5C  38 10 00 00 00 00 00 00 38 7c 38 fe fe fe 10 10  |8.......8|8.....|
0000BE6C  38 00 00 00 00 00 10 38 7c fe fe fe 54 10 38 00  |8......8|...T.8.|
0000BE7C  00 00 00 00 00 00 00 18 3c 3c 18 00 00 00 00 00  |........<<......|
0000BE8C  ff ff ff ff ff e7 c3 c3 e7 ff ff ff ff ff 00 00  |................|
0000BE9C  00 00 3c 66 42 42 66 3c 00 00 00 00 ff ff ff ff  |..<fBBf<........|
0000BEAC  ... (300 more bytes)

; ---- 0x0bfd8-0x0bfec  zero padding  [H07/H21] ----
0000BFD8  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000BFE8  00 00 00 00                                      |....|

; ---- 0x0bfec-0x0c099  character-generator font / bitmap data  [H08/H21] ----
0000BFEC  10 38 38 38 10 10 10 00 10 00 00 00 00 00 24 24  |.888..........$$|
0000BFFC  24 00 00 00 00 00 00 00 00 00 00 00 00 24 24 7e  |$............$$~|
0000C00C  24 24 7e 24 24 00 00 00 00 10 10 7c 92 90 7c 12  |$$~$$......|..|.|
0000C01C  12 92 7c 10 10 00 00 00 00 00 c2 c4 08 10 20 46  |..|........... F|
0000C02C  86 00 00 00 00 00 10 28 28 30 32 54 88 88 76 00  |.......((02T..v.|
0000C03C  00 00 00 10 10 10 20 00 00 00 00 00 00 00 00 00  |...... .........|
0000C04C  00 00 08 10 20 20 20 20 20 10 08 00 00 00 00 00  |....     .......|
0000C05C  10 08 04 04 04 04 04 08 10 00 00 00 00 00 00 00  |................|
0000C06C  24 18 7e 18 24 00 00 00 00 00 00 00 00 10 10 10  |$.~.$...........|
0000C07C  fe 10 10 10 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000C08C  00 00 10 20 00 00 00 00 00 00 00 00 fe           |... .........|

; ---- 0x0c099-0x0c0aa  zero padding  [H07/H21] ----
0000C099  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000C0A9  00                                               |.|

; ---- 0x0c0aa-0x0c76f  character-generator font / bitmap data  [H08/H21] ----
0000C0AA  10 00 00 00 00 00 00 02 04 08 10 20 40 80 00 00  |........... @...|
0000C0BA  00 00 00 00 00 7c 82 82 92 92 82 82 7c 00 00 00  |.....|......|...|
0000C0CA  00 00 00 10 30 10 10 10 10 10 38 00 00 00 00 00  |....0.....8.....|
0000C0DA  00 78 84 04 08 10 20 42 fe 00 00 00 00 00 00 7c  |.x.... B.......||
0000C0EA  82 02 3c 02 02 82 7c 00 00 00 00 00 00 04 0c 14  |..<...|.........|
0000C0FA  24 44 fe 04 0e 00 00 00 00 00 00 fe 80 80 fc 02  |$D..............|
0000C10A  02 82 7c 00 00 00 00 00 00 3c 40 80 fc 82 82 82  |..|......<@.....|
0000C11A  7c 00 00 00 00 00 00 fe 82 02 04 08 10 20 20 00  ||............  .|
0000C12A  ... (1605 more bytes)

; ==== 0x0c76f-0x0c781  CODE (linear/orphan, conf 80) ====
0000C76F  0202              add al,[bp+si]
0000C771  0200              add al,[bx+si]
0000C773  0000              add [bx+si],al
0000C775  0000              add [bx+si],al
0000C777  40                inc ax
0000C778  40                inc ax
0000C779  42                inc dx
0000C77A  44                inc sp
0000C77B  48                dec ax
0000C77C  1020              adc [bx+si],ah
0000C77E  5C                pop sp
0000C77F  82                db 0x82
0000C780  0C                db 0x0c

; ---- 0x0c781-0x0c7c1  character-generator font / bitmap data  [H08/H21] ----
0000C781  10 1e 00 00 40 40 42 44 48 10 24 4c 94 3e 04 04  |....@@BDH.$L.>..|
0000C791  00 00 00 08 00 08 08 08 1c 1c 1c 08 00 00 00 00  |................|
0000C7A1  00 00 00 12 24 48 24 12 00 00 00 00 00 00 00 00  |....$H$.........|
0000C7B1  00 48 24 12 24 48 00 00 00 00 00 88 22 88 22 88  |.H$.$H......".".|

; ==== 0x0c7c1-0x0c80f  CODE (linear/orphan, conf 80) ====
0000C7C1  22882288          and cl,[bx+si-0x77de]
0000C7C5  22882288          and cl,[bx+si-0x77de]
0000C7C9  2254AA            and dl,[si-0x56]
0000C7CC  54                push sp
0000C7CD  AA                stosb
0000C7CE  54                push sp
0000C7CF  AA                stosb
0000C7D0  54                push sp
0000C7D1  AA                stosb
0000C7D2  54                push sp
0000C7D3  AA                stosb
0000C7D4  54                push sp
0000C7D5  AA                stosb
0000C7D6  54                push sp
0000C7D7  AA                stosb
0000C7D8  DD77DD            fnsave [bx-0x23]
0000C7DB  77DD              ja 0xc7ba
0000C7DD  77DD              ja 0xc7bc
0000C7DF  77DD              ja 0xc7be
0000C7E1  77DD              ja 0xc7c0
0000C7E3  77DD              ja 0xc7c2
0000C7E5  7708              ja 0xc7ef
0000C7E7  0808              or [bx+si],cl
0000C7E9  0808              or [bx+si],cl
0000C7EB  0808              or [bx+si],cl
0000C7ED  0808              or [bx+si],cl
0000C7EF  0808              or [bx+si],cl
0000C7F1  0808              or [bx+si],cl
0000C7F3  0808              or [bx+si],cl
0000C7F5  0808              or [bx+si],cl
0000C7F7  0808              or [bx+si],cl
0000C7F9  0808              or [bx+si],cl
0000C7FB  F8                clc
0000C7FC  0808              or [bx+si],cl
0000C7FE  0808              or [bx+si],cl
0000C800  0808              or [bx+si],cl
0000C802  0808              or [bx+si],cl
0000C804  0808              or [bx+si],cl
0000C806  08F8              or al,bh
0000C808  08F8              or al,bh
0000C80A  0808              or [bx+si],cl
0000C80C  0808              or [bx+si],cl
0000C80E  08                db 0x08

; ---- 0x0c80f-0x0c82f  character-generator font / bitmap data  [H08/H21] ----
0000C80F  08 12 12 12 12 12 12 12 f2 12 12 12 12 12 12 00  |................|
0000C81F  00 00 00 00 00 00 fe 12 12 12 12 12 12 00 00 00  |................|

; ==== 0x0c82f-0x0c851  CODE (linear/orphan, conf 80) ====
0000C82F  0000              add [bx+si],al
0000C831  F8                clc
0000C832  08F8              or al,bh
0000C834  0808              or [bx+si],cl
0000C836  0808              or [bx+si],cl
0000C838  0808              or [bx+si],cl
0000C83A  1212              adc dl,[bp+si]
0000C83C  1212              adc dl,[bp+si]
0000C83E  12F2              adc dh,dl
0000C840  02F2              add dh,dl
0000C842  1212              adc dl,[bp+si]
0000C844  1212              adc dl,[bp+si]
0000C846  1212              adc dl,[bp+si]
0000C848  1212              adc dl,[bp+si]
0000C84A  1212              adc dl,[bp+si]
0000C84C  1212              adc dl,[bp+si]
0000C84E  1212              adc dl,[bp+si]
0000C850  12                db 0x12

; ---- 0x0c851-0x0c888  character-generator font / bitmap data  [H08/H21] ----
0000C851  12 12 12 12 12 00 00 00 00 00 fe 02 f2 12 12 12  |................|
0000C861  12 12 12 12 12 12 12 12 f2 02 fe 00 00 00 00 00  |................|
0000C871  00 12 12 12 12 12 12 12 fe 00 00 00 00 00 00 08  |................|
0000C881  08 08 08 08 f8 08 f8                             |.......|

; ---- 0x0c888-0x0c895  zero padding  [H07/H21] ----
0000C888  00 00 00 00 00 00 00 00 00 00 00 00 00           |.............|

; ==== 0x0c895-0x0c896  CODE (linear/orphan, conf 80) ====
0000C895  F8                clc

; ---- 0x0c896-0x0c8df  character-generator font / bitmap data  [H08/H21] ----
0000C896  08 08 08 08 08 08 08 08 08 08 08 08 08 0f 00 00  |................|
0000C8A6  00 00 00 00 08 08 08 08 08 08 08 ff 00 00 00 00  |................|
0000C8B6  00 00 00 00 00 00 00 00 00 ff 08 08 08 08 08 08  |................|
0000C8C6  08 08 08 08 08 08 08 0f 08 08 08 08 08 08 00 00  |................|
0000C8D6  00 00 00 00 00 ff 00 00 00                       |.........|

; ==== 0x0c8df-0x0c8fe  CODE (linear/orphan, conf 80) ====
0000C8DF  0000              add [bx+si],al
0000C8E1  0008              add [bx+si],cl
0000C8E3  0808              or [bx+si],cl
0000C8E5  0808              or [bx+si],cl
0000C8E7  0808              or [bx+si],cl
0000C8E9  FF08              dec word [bx+si]
0000C8EB  0808              or [bx+si],cl
0000C8ED  0808              or [bx+si],cl
0000C8EF  0808              or [bx+si],cl
0000C8F1  0808              or [bx+si],cl
0000C8F3  0808              or [bx+si],cl
0000C8F5  0F08              invd
0000C8F7  0F08              invd
0000C8F9  0808              or [bx+si],cl
0000C8FB  0808              or [bx+si],cl
0000C8FD  08                db 0x08

; ---- 0x0c8fe-0x0c984  character-generator font / bitmap data  [H08/H21] ----
0000C8FE  12 12 12 12 12 12 12 13 12 12 12 12 12 12 12 12  |................|
0000C90E  12 12 12 13 10 1f 00 00 00 00 00 00 00 00 00 00  |................|
0000C91E  00 1f 10 13 12 12 12 12 12 12 12 12 12 12 12 f3  |................|
0000C92E  00 ff 00 00 00 00 00 00 00 00 00 00 00 ff 00 f3  |................|
0000C93E  12 12 12 12 12 12 12 12 12 12 12 13 10 13 12 12  |................|
0000C94E  12 12 12 12 00 00 00 00 00 ff 00 ff 00 00 00 00  |................|
0000C95E  00 00 12 12 12 12 12 f3 00 f3 12 12 12 12 12 12  |................|
0000C96E  08 08 08 08 08 ff 00 ff 00 00 00 00 00 00 12 12  |................|
0000C97E  12 12 12 12 12 ff                                |......|

; ---- 0x0c984-0x0c98f  zero padding  [H07/H21] ----
0000C984  00 00 00 00 00 00 00 00 00 00 00                 |...........|

; ==== 0x0c98f-0x0c990  CODE (linear/orphan, conf 80) ====
0000C98F  FF                db 0xff

; ---- 0x0c990-0x0c9d0  character-generator font / bitmap data  [H08/H21] ----
0000C990  00 ff 08 08 08 08 08 08 00 00 00 00 00 00 00 ff  |................|
0000C9A0  12 12 12 12 12 12 12 12 12 12 12 12 12 1f 00 00  |................|
0000C9B0  00 00 00 00 08 08 08 08 08 0f 08 0f 00 00 00 00  |................|
0000C9C0  00 00 00 00 00 00 00 0f 08 0f 08 08 08 08 08 08  |................|

; ==== 0x0c9d0-0x0c9ec  CODE (linear/orphan, conf 80) ====
0000C9D0  0000              add [bx+si],al
0000C9D2  0000              add [bx+si],al
0000C9D4  0000              add [bx+si],al
0000C9D6  001F              add [bx],bl
0000C9D8  1212              adc dl,[bp+si]
0000C9DA  1212              adc dl,[bp+si]
0000C9DC  1212              adc dl,[bp+si]
0000C9DE  1212              adc dl,[bp+si]
0000C9E0  1212              adc dl,[bp+si]
0000C9E2  1212              adc dl,[bp+si]
0000C9E4  12FF              adc bh,bh
0000C9E6  1212              adc dl,[bp+si]
0000C9E8  1212              adc dl,[bp+si]
0000C9EA  1212              adc dl,[bp+si]

; ---- 0x0c9ec-0x0ca02  character-generator font / bitmap data  [H08/H21] ----
0000C9EC  08 08 08 08 08 ff 08 ff 08 08 08 08 08 08 08 08  |................|
0000C9FC  08 08 08 08 08 f8                                |......|

; ---- 0x0ca02-0x0ca0f  zero padding  [H07/H21] ----
0000CA02  00 00 00 00 00 00 00 00 00 00 00 00 00           |.............|

; ==== 0x0ca0f-0x0ca16  CODE (linear/orphan, conf 80) ====
0000CA0F  0F08              invd
0000CA11  0808              or [bx+si],cl
0000CA13  0808              or [bx+si],cl
0000CA15  08                db 0x08

; ---- 0x0ca16-0x0ca24  erased (0xFF fill)  [H21] ----
0000CA16  ff ff ff ff ff ff ff ff ff ff ff ff ff ff        |..............|

; ==== 0x0ca24-0x0ca3f  CODE (linear/orphan, conf 80) ====
0000CA24  0000              add [bx+si],al
0000CA26  0000              add [bx+si],al
0000CA28  0000              add [bx+si],al
0000CA2A  00FF              add bh,bh
0000CA2C  FF                db 0xff
0000CA2D  FF                db 0xff
0000CA2E  FF                db 0xff
0000CA2F  FF                db 0xff
0000CA30  FF                db 0xff
0000CA31  FF                db 0xff
0000CA32  F8                clc
0000CA33  F8                clc
0000CA34  F8                clc
0000CA35  F8                clc
0000CA36  F8                clc
0000CA37  F8                clc
0000CA38  F8                clc
0000CA39  F8                clc
0000CA3A  F8                clc
0000CA3B  F8                clc
0000CA3C  F8                clc
0000CA3D  F8                clc
0000CA3E  F8                clc

; ---- 0x0ca3f-0x0ca4e  character-generator font / bitmap data  [H08/H21] ----
0000CA3F  f8 07 07 07 07 07 07 07 07 07 07 07 07 07 07     |...............|

; ---- 0x0ca4e-0x0ca55  erased (0xFF fill)  [H21] ----
0000CA4E  ff ff ff ff ff ff ff                             |.......|

; ---- 0x0ca55-0x0ca61  zero padding  [H07/H21] ----
0000CA55  00 00 00 00 00 00 00 00 00 00 00 00              |............|

; ---- 0x0ca61-0x0cc0a  character-generator font / bitmap data  [H08/H21] ----
0000CA61  72 8c 88 88 8c 72 00 00 00 00 00 00 00 78 84 f8  |r....r.......x..|
0000CA71  84 82 fc 80 80 40 00 00 00 fe 82 80 80 80 80 80  |.....@..........|
0000CA81  80 80 00 00 00 00 00 00 00 fe 44 44 44 44 44 44  |..........DDDDDD|
0000CA91  00 00 00 00 00 00 fe 42 20 10 10 20 42 fe 00 00  |.......B .. B...|
0000CAA1  00 00 00 00 00 00 7e 88 88 88 88 70 00 00 00 00  |......~....p....|
0000CAB1  00 00 00 42 42 42 42 7c 40 40 c0 00 00 00 00 00  |...BBBB|@@......|
0000CAC1  00 32 4c 08 08 08 08 08 00 00 00 00 00 38 10 7c  |.2L..........8.||
0000CAD1  82 82 82 7c 10 38 00 00 00 00 00 00 38 44 82 fe  |...|.8......8D..|
0000CAE1  ... (297 more bytes)

; ---- 0x0cc0a-0x0cc1e  zero padding  [H07/H21] ----
0000CC0A  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000CC1A  00 00 00 00                                      |....|

; ---- 0x0cc1e-0x0cc48  character-generator font / bitmap data  [H08/H21] ----
0000CC1E  08 14 22 00 08 08 00 08 08 00 00 00 00 00 00 00  |..".............|
0000CC2E  00 00 00 10 38 7c fe 00 00 00 7e 24 7e 24 7e 24  |....8|....~$~$~$|
0000CC3E  7e 24 7e 24 7e 00 00 00 00 ff                    |~$~$~.....|

; ---- 0x0cc48-0x0cc58  zero padding  [H07/H21] ----
0000CC48  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|

; ---- 0x0cc58-0x0cc59  character-generator font / bitmap data  [H08/H21] ----
0000CC58  ff                                               |.|

; ---- 0x0cc59-0x0cc69  zero padding  [H07/H21] ----
0000CC59  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|

; ---- 0x0cc69-0x0cc6a  character-generator font / bitmap data  [H08/H21] ----
0000CC69  ff                                               |.|

; ---- 0x0cc6a-0x0cc7a  zero padding  [H07/H21] ----
0000CC6A  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|

; ---- 0x0cc7a-0x0cc7b  character-generator font / bitmap data  [H08/H21] ----
0000CC7A  ff                                               |.|

; ---- 0x0cc7b-0x0cc8b  zero padding  [H07/H21] ----
0000CC7B  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|

; ---- 0x0cc8b-0x0cfc6  character-generator font / bitmap data  [H08/H21] ----
0000CC8B  ff 00 00 00 00 04 7e 08 10 7e 20 00 00 00 00 08  |......~..~ .....|
0000CC9B  10 20 00 38 44 82 82 fe 82 82 00 00 00 00 44 38  |. .8D.........D8|
0000CCAB  00 38 44 82 82 fe 82 82 00 00 00 10 28 44 00 38  |.8D.........(D.8|
0000CCBB  44 82 82 fe 82 82 00 00 00 20 10 08 00 38 44 82  |D........ ...8D.|
0000CCCB  82 fe 82 82 00 00 00 38 44 38 00 38 44 82 82 fe  |.......8D8.8D...|
0000CCDB  82 82 00 00 00 00 7c 00 00 38 44 82 82 fe 82 82  |......|..8D.....|
0000CCEB  00 00 00 00 00 00 10 28 44 82 82 fe 82 82 04 06  |.......(D.......|
0000CCFB  00 00 72 9c 00 38 44 82 82 fe 82 82 00 00 00 00  |..r..8D.........|
0000CD0B  ... (699 more bytes)

; ==== 0x0cfc6-0x0cfe0  CODE (linear/orphan, conf 80) ====
0000CFC6  0018              add [bx+si],bl
0000CFC8  2018              and [bx+si],bl
0000CFCA  007A84            add [bp+si-0x7c],bh
0000CFCD  84847C04          test [si+0x47c],al
0000CFD1  847800            test [bx+si+0x0],bh
0000CFD4  0000              add [bx+si],al
0000CFD6  1000              adc [bx+si],al
0000CFD8  007A84            add [bp+si-0x7c],bh
0000CFDB  84847C04          test [si+0x47c],al
0000CFDF  84                db 0x84

; ---- 0x0cfe0-0x0d78c  character-generator font / bitmap data  [H08/H21] ----
0000CFE0  78 00 00 44 28 10 00 7a 84 84 84 7c 04 84 78 00  |x..D(..z...|..x.|
0000CFF0  10 28 44 00 82 82 82 fe 82 82 82 00 00 00 00 00  |.(D.............|
0000D000  00 44 fe 44 7c 44 44 44 44 00 00 00 08 14 22 c0  |.D.D|DDDD.....".|
0000D010  40 40 7c 42 42 42 42 00 00 00 00 00 00 40 f0 40  |@@|BBBB......@.@|
0000D020  7c 42 42 42 42 00 00 00 04 08 10 00 1c 08 08 08  ||BBBB...........|
0000D030  08 08 1c 00 00 00 08 14 22 00 1c 08 08 08 08 08  |........".......|
0000D040  1c 00 00 00 00 08 00 1c 08 08 08 08 08 08 1c 00  |................|
0000D050  00 00 10 08 04 00 1c 08 08 08 08 08 1c 00 00 00  |................|
0000D060  ... (1836 more bytes)

; ---- 0x0d78c-0x0d79f  zero padding  [H07/H21] ----
0000D78C  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000D79C  00 00 00                                         |...|

; ---- 0x0d79f-0x0d7e1  character-generator font / bitmap data  [H08/H21] ----
0000D79F  7e 00 00 00 00 00 00 00 22 00 00 00 00 00 00 00  |~.......".......|
0000D7AF  00 00 00 00 00 04 08 10 00 00 00 00 00 00 00 00  |................|
0000D7BF  00 00 00 22 44 88 00 00 00 00 00 00 00 00 00 00  |..."D...........|
0000D7CF  00 44 38 00 00 00 00 00 00 00 00 00 00 00 00 44  |.D8............D|
0000D7DF  28 10                                            |(.|

; ---- 0x0d7e1-0x0d7f5  zero padding  [H07/H21] ----
0000D7E1  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000D7F1  00 00 00 00                                      |....|

; ---- 0x0d7f5-0x0dab6  character-generator font / bitmap data  [H08/H21] ----
0000D7F5  10 08 30 00 00 00 00 00 00 00 00 00 00 00 00 00  |..0.............|
0000D805  10 18 00 00 00 00 28 10 7c 82 80 80 82 7c 00 00  |......(.|....|..|
0000D815  00 00 00 00 00 7e 7e 7e 7e 7e 7e 00 00 00 00 00  |.....~~~~~~.....|
0000D825  00 00 c0 50 60 dc 62 42 42 7c 00 00 00 10 10 20  |...P`.bBB|..... |
0000D835  00 50 00 20 20 20 24 18 00 00 00 00 00 00 10 10  |.P.   $.........|
0000D845  28 28 44 7c 82 82 00 00 00 00 00 00 fe 42 40 40  |((D|.........B@@|
0000D855  40 40 40 e0 00 00 00 00 00 00 10 10 28 28 44 44  |@@@.........((DD|
0000D865  82 fe 00 00 00 00 00 00 38 44 82 fe 82 82 44 38  |........8D....D8|
0000D875  ... (577 more bytes)

; ==== 0x0dab6-0x0db14  CODE (linear/orphan, conf 80) ====
0000DAB6  0008              add [bx+si],cl
0000DAB8  1020              adc [bx+si],ah
0000DABA  008890E0          add [bx+si-0x1f70],cl
0000DABE  90                nop
0000DABF  88840000          mov [si+0x0],al
0000DAC3  004040            add [bx+si+0x40],al
0000DAC6  40                inc ax
0000DAC7  90                nop
0000DAC8  1028              adc [bx+si],ch
0000DACA  28447C            sub [si+0x7c],al
0000DACD  82                db 0x82
0000DACE  82                db 0x82
0000DACF  0000              add [bx+si],al
0000DAD1  004040            add [bx+si+0x40],al
0000DAD4  807E2220          cmp byte [bp+0x22],0x20
0000DAD8  3C20              cmp al,0x20
0000DADA  2022              and [bp+si],ah
0000DADC  7E00              jng 0xdade
0000DADE  0000              add [bx+si],al
0000DAE0  40                inc ax
0000DAE1  40                inc ax
0000DAE2  80424242          add byte [bp+si+0x42],0x42
0000DAE6  7E42              jng 0xdb2a
0000DAE8  42                inc dx
0000DAE9  42                inc dx
0000DAEA  42                inc dx
0000DAEB  0000              add [bx+si],al
0000DAED  0020              add [bx+si],ah
0000DAEF  20401C            and [bx+si+0x1c],al
0000DAF2  0808              or [bx+si],cl
0000DAF4  0808              or [bx+si],cl
0000DAF6  0808              or [bx+si],cl
0000DAF8  1C00              sbb al,0x0
0000DAFA  0000              add [bx+si],al
0000DAFC  40                inc ax
0000DAFD  40                inc ax
0000DAFE  803844            cmp byte [bx+si],0x44
0000DB01  82                db 0x82
0000DB02  82                db 0x82
0000DB03  82                db 0x82
0000DB04  82                db 0x82
0000DB05  44                inc sp
0000DB06  3800              cmp [bx+si],al
0000DB08  0000              add [bx+si],al
0000DB0A  40                inc ax
0000DB0B  40                inc ax
0000DB0C  8044AA92          add byte [si-0x56],0x92
0000DB10  1010              adc [bx+si],dl
0000DB12  1010              adc [bx+si],dl

; ---- 0x0db14-0x0de14  character-generator font / bitmap data  [H08/H21] ----
0000DB14  38 00 00 00 40 40 80 38 44 82 82 44 28 28 ee 00  |8...@@.8D..D((..|
0000DB24  00 00 08 10 00 fe 42 40 40 40 40 40 e0 00 00 00  |......B@@@@@....|
0000DB34  08 08 10 00 00 00 00 00 00 00 00 00 00 00 08 08  |................|
0000DB44  10 00 24 00 00 00 00 00 00 00 00 00 00 00 00 f8  |..$.............|
0000DB54  a8 20 2c 32 22 22 24 00 00 00 00 00 00 3e 42 80  |. ,2""$......>B.|
0000DB64  f8 80 82 42 3c 00 00 00 00 00 00 fc 50 50 50 5c  |...B<.......PPP\|
0000DB74  52 52 9c 00 00 00 00 00 00 90 90 90 f0 9c 92 92  |RR..............|
0000DB84  9c 00 00 00 00 00 00 f8 a8 20 2c 32 22 22 22 00  |......... ,2""".|
0000DB94  ... (640 more bytes)

; ==== 0x0de14-0x0df03  CODE (linear/orphan, conf 80) ====
0000DE14  6207              bound ax,[bx]
0000DE16  7007              jo 0xde1f
0000DE18  7E07              jng 0xde21
0000DE1A  8C07              mov [bx],es
0000DE1C  9A07A807B6        call 0xb607:0xa807
0000DE21  07                pop es
0000DE22  C407              les ax,[bx]
0000DE24  D207              rol byte [bx],cl
0000DE26  E007              loopne 0xde2f
0000DE28  EE                out dx,al
0000DE29  07                pop es
0000DE2A  FC                cld
0000DE2B  07                pop es
0000DE2C  0A08              or cl,[bx+si]
0000DE2E  1808              sbb [bx+si],cl
0000DE30  260834            or [es:si],dh
0000DE33  084208            or [bp+si+0x8],al
0000DE36  50                push ax
0000DE37  085E08            or [bp+0x8],bl
0000DE3A  6C                insb
0000DE3B  087A08            or [bp+si+0x8],bh
0000DE3E  8808              mov [bx+si],cl
0000DE40  96                xchg ax,si
0000DE41  08A408B2          or [si-0x4df8],ah
0000DE45  08C0              or al,al
0000DE47  08CE              or dh,cl
0000DE49  08DC              or ah,bl
0000DE4B  08EA              or dl,ch
0000DE4D  08F8              or al,bh
0000DE4F  01060214          add [0x1402],ax
0000DE53  0222              add ah,[bp+si]
0000DE55  0230              add dh,[bx+si]
0000DE57  023E024C          add bh,[0x4c02]
0000DE5B  025A02            add bl,[bp+si+0x2]
0000DE5E  680276            push word 0x7602
0000DE61  02840292          add al,[si-0x6dfe]
0000DE65  02A002AE          add ah,[bx+si-0x51fe]
0000DE69  02BC02CA          add bh,[si-0x35fe]
0000DE6D  02D8              add bl,al
0000DE6F  02E6              add ah,dh
0000DE71  02F4              add dh,ah
0000DE73  0202              add al,[bp+si]
0000DE75  0310              add dx,[bx+si]
0000DE77  031E032C          add bx,[0x2c03]
0000DE7B  033A              add di,[bp+si]
0000DE7D  034803            add cx,[bx+si+0x3]
0000DE80  56                push si
0000DE81  036403            add sp,[si+0x3]
0000DE84  7203              jc 0xde89
0000DE86  80038E            add byte [bp+di],0x8e
0000DE89  039C03AA          add bx,[si-0x55fd]
0000DE8D  03B803C6          add di,[bx+si-0x39fd]
0000DE91  03D4              add dx,sp
0000DE93  03E2              add sp,dx
0000DE95  03F0              add si,ax
0000DE97  03FE              add di,si
0000DE99  030C              add cx,[si]
0000DE9B  041A              add al,0x1a
0000DE9D  0428              add al,0x28
0000DE9F  0436              add al,0x36
0000DEA1  0444              add al,0x44
0000DEA3  0452              add al,0x52
0000DEA5  0460              add al,0x60
0000DEA7  046E              add al,0x6e
0000DEA9  047C              add al,0x7c
0000DEAB  048A              add al,0x8a
0000DEAD  0498              add al,0x98
0000DEAF  04A6              add al,0xa6
0000DEB1  04B4              add al,0xb4
0000DEB3  04C2              add al,0xc2
0000DEB5  04D0              add al,0xd0
0000DEB7  04DE              add al,0xde
0000DEB9  04EC              add al,0xec
0000DEBB  04FA              add al,0xfa
0000DEBD  0408              add al,0x8
0000DEBF  051605            add ax,0x516
0000DEC2  2405              and al,0x5
0000DEC4  3205              xor al,[di]
0000DEC6  40                inc ax
0000DEC7  054E05            add ax,0x54e
0000DECA  5C                pop sp
0000DECB  056A05            add ax,0x56a
0000DECE  7805              js 0xded5
0000DED0  8605              xchg al,[di]
0000DED2  94                xchg ax,sp
0000DED3  05A205            add ax,0x5a2
0000DED6  B005              mov al,0x5
0000DED8  BE05CC            mov si,0xcc05
0000DEDB  05DA05            add ax,0x5da
0000DEDE  E805F6            call 0xd4e6
0000DEE1  050406            add ax,0x604
0000DEE4  12062006          adc al,[0x620]
0000DEE8  2E06              cs push es
0000DEEA  3C06              cmp al,0x6
0000DEEC  4A                dec dx
0000DEED  06                push es
0000DEEE  58                pop ax
0000DEEF  06                push es
0000DEF0  6606              o32 push es
0000DEF2  7406              jz 0xdefa
0000DEF4  82                db 0x82
0000DEF5  06                push es
0000DEF6  90                nop
0000DEF7  06                push es
0000DEF8  9E                sahf
0000DEF9  06                push es
0000DEFA  AC                lodsb
0000DEFB  06                push es
0000DEFC  BA06C8            mov dx,0xc806
0000DEFF  06                push es
0000DF00  D6                salc
0000DF01  06                push es
0000DF02  E4                db 0xe4

; ---- 0x0df03-0x0df23  character-generator font / bitmap data  [H08/H21] ----
0000DF03  06 f2 06 00 07 0e 07 1c 07 2a 07 ff 06 20 38 00  |.........*... 8.|
0000DF13  46 00 54 00 62 00 70 00 7e 00 8c 00 9a 00 a8 00  |F.T.b.p.~.......|

; ==== 0x0df23-0x0e8c6  CODE (linear/orphan, conf 80) ====
0000DF23  B600              mov dh,0x0
0000DF25  C400              les ax,[bx+si]
0000DF27  D200              rol byte [bx+si],cl
0000DF29  E000              loopne 0xdf2b
0000DF2B  EE                out dx,al
0000DF2C  00FC              add ah,bh
0000DF2E  000A              add [bp+si],cl
0000DF30  0118              add [bx+si],bx
0000DF32  01260134          add [0x3401],sp
0000DF36  014201            add [bp+si+0x1],ax
0000DF39  50                push ax
0000DF3A  015E01            add [bp+0x1],bx
0000DF3D  6C                insb
0000DF3E  017A01            add [bp+si+0x1],di
0000DF41  8801              mov [bx+di],al
0000DF43  96                xchg ax,si
0000DF44  01A401B2          add [si-0x4dff],sp
0000DF48  01C0              add ax,ax
0000DF4A  01CE              add si,cx
0000DF4C  01DC              add sp,bx
0000DF4E  01EA              add dx,bp
0000DF50  01FF              add di,di
0000DF52  FF80EA0F          inc word [bx+si+0xfea]
0000DF56  1018              adc [bx+si],bl
0000DF58  1011              adc [bx+di],dl
0000DF5A  5E                pop si
0000DF5B  0FB20F            lss cx,[bx]
0000DF5E  6C                insb
0000DF5F  0F                db 0x0f
0000DF60  7A0F              jpe 0xdf71
0000DF62  3010              xor [bx+si],dl
0000DF64  1E                push ds
0000DF65  116411            adc [si+0x11],sp
0000DF68  3A11              cmp dl,[bx+di]
0000DF6A  2413              and al,0x13
0000DF6C  D012              rcl byte [bp+si],1
0000DF6E  DE12              ficom word [bp+si]
0000DF70  260FEE0EA010      pmaxsw mm1,[es:0x10a0]
0000DF76  C00F34            ror byte [bx],byte 0x34
0000DF79  0F6215            punpckldq mm2,[di]
0000DF7C  A815              test al,0x15
0000DF7E  7015              jo 0xdf95
0000DF80  BC17D8            mov sp,0xd817
0000DF83  17                pop ss
0000DF84  80182A            sbb byte [bx+si],0x2a
0000DF87  158417            adc ax,0x1784
0000DF8A  06                push es
0000DF8B  0914              or [si],dx
0000DF8D  0922              or [bp+si],sp
0000DF8F  0930              or [bx+si],si
0000DF91  093E0942          or [0x4209],di
0000DF95  0FC21246          cmpps xmm2,oword [bp+si],byte 0x46
0000DF99  159217            adc ax,0x1792
0000DF9C  7414              jz 0xdfb2
0000DF9E  3C14              cmp al,0x14
0000DFA0  4C                dec sp
0000DFA1  095A09            or [bp+si+0x9],bx
0000DFA4  680976            push word 0x7609
0000DFA7  09840992          or [si-0x6df7],ax
0000DFAB  09A009AE          or [bx+si-0x51f7],sp
0000DFAF  09BC09CA          or [si-0x35f7],di
0000DFB3  09D8              or ax,bx
0000DFB5  09E6              or si,sp
0000DFB7  09F4              or sp,si
0000DFB9  0902              or [bp+si],ax
0000DFBB  0A10              or dl,[bx+si]
0000DFBD  0A1E0A2C          or bl,[0x2c0a]
0000DFC1  0A3A              or bh,[bp+si]
0000DFC3  0A480A            or cl,[bx+si+0xa]
0000DFC6  56                push si
0000DFC7  0A640A            or ah,[si+0xa]
0000DFCA  720A              jc 0xdfd6
0000DFCC  800A8E            or byte [bp+si],0x8e
0000DFCF  0A9C0AAA          or bl,[si-0x55f6]
0000DFD3  0AB80AC6          or bh,[bx+si-0x39f6]
0000DFD7  0AD4              or dl,ah
0000DFD9  0AE2              or ah,dl
0000DFDB  0AF0              or dh,al
0000DFDD  0AFE              or bh,dh
0000DFDF  0A0C              or cl,[si]
0000DFE1  0B1A              or bx,[bp+si]
0000DFE3  0B28              or bp,[bx+si]
0000DFE5  0B360B44          or si,[0x440b]
0000DFE9  0B520B            or dx,[bp+si+0xb]
0000DFEC  60                pusha
0000DFED  0B6E0B            or bp,[bp+0xb]
0000DFF0  7C0B              jl 0xdffd
0000DFF2  8A0B              mov cl,[bp+di]
0000DFF4  98                cbw
0000DFF5  0BA60BB4          or sp,[bp-0x4bf5]
0000DFF9  0BC2              or ax,dx
0000DFFB  0BD0              or dx,ax
0000DFFD  0BDE              or bx,si
0000DFFF  0BEC              or bp,sp
0000E001  0BFA              or di,dx
0000E003  0B08              or cx,[bx+si]
0000E005  0C16              or al,0x16
0000E007  0C24              or al,0x24
0000E009  0C32              or al,0x32
0000E00B  0C40              or al,0x40
0000E00D  0C4E              or al,0x4e
0000E00F  0C5C              or al,0x5c
0000E011  0C6A              or al,0x6a
0000E013  0C78              or al,0x78
0000E015  0C86              or al,0x86
0000E017  0C94              or al,0x94
0000E019  0CA2              or al,0xa2
0000E01B  0CB0              or al,0xb0
0000E01D  0CBE              or al,0xbe
0000E01F  0CCC              or al,0xcc
0000E021  0CDA              or al,0xda
0000E023  0CE8              or al,0xe8
0000E025  0CF6              or al,0xf6
0000E027  0C04              or al,0x4
0000E029  0D120D            or ax,0xd12
0000E02C  200D              and [di],cl
0000E02E  2E0D3C0D          cs or ax,0xd3c
0000E032  4A                dec dx
0000E033  0D580D            or ax,0xd58
0000E036  660D740D820D      or eax,0xd820d74
0000E03C  90                nop
0000E03D  0D9E0D            or ax,0xd9e
0000E040  AC                lodsb
0000E041  0DBA0D            or ax,0xdba
0000E044  C80DD60D          enter 0xd60d,0xd
0000E048  E40D              in al,0xd
0000E04A  F20D000E          repne or ax,0xe00
0000E04E  0E                push cs
0000E04F  0E                push cs
0000E050  1C0E              sbb al,0xe
0000E052  2A0EFF06          sub cl,[0x6ff]
0000E056  0021              add [bx+di],ah
0000E058  5F                pop di
0000E059  AE                scasb
0000E05A  09060914          or [0x1409],ax
0000E05E  09F8              or ax,di
0000E060  0122              add [bp+si],sp
0000E062  09F8              or ax,di
0000E064  015E01            add [bp+0x1],bx
0000E067  2819              sub [bx+di],bl
0000E069  1A19              sbb bl,[bx+di]
0000E06B  4C                dec sp
0000E06C  09BC09F8          or [si-0x7f7],di
0000E070  01F8              add ax,di
0000E072  01F8              add ax,di
0000E074  01F8              add ax,di
0000E076  01C8              add ax,cx
0000E078  0D660D            or ax,0xd66
0000E07B  0E                push cs
0000E07C  0E                push cs
0000E07D  8A19              mov bl,[bx+di]
0000E07F  F8                clc
0000E080  01CC              add sp,cx
0000E082  0C50              or al,0x50
0000E084  01D6              add si,dx
0000E086  0DF801            or ax,0x1f8
0000E089  7C19              jl 0xe0a4
0000E08B  5A                pop dx
0000E08C  09CA              or dx,cx
0000E08E  09A00992          or [bx+si-0x6df7],sp
0000E092  09F8              or ax,di
0000E094  016809            add [bx+si+0x9],bp
0000E097  E00E              loopne 0xe0a7
0000E099  B60E              mov dh,0xe
0000E09B  D20E180F          ror byte [0xf18],cl
0000E09F  260FD20E340F      psrld mm1,[es:0xf34]
0000E0A5  EA0FCA10A0        jmp 0xa010:0xca0f
0000E0AA  10AE10F4          adc [bp-0xbf0],ch
0000E0AE  106E12            adc [bp+0x12],ch
0000E0B1  44                inc sp
0000E0B2  125212            adc dl,[bp+si+0x12]
0000E0B5  A6                cmpsb
0000E0B6  12F8              adc bh,al
0000E0B8  013C              add [si],di
0000E0BA  14F2              adc al,0xf2
0000E0BC  14C8              adc al,0xc8
0000E0BE  14E4              adc al,0xe4
0000E0C0  141C              adc al,0x1c
0000E0C2  152A15            adc ax,0x152a
0000E0C5  3815              cmp [di],dl
0000E0C7  0E                push cs
0000E0C8  154C17            adc ax,0x174c
0000E0CB  06                push es
0000E0CC  17                pop ss
0000E0CD  3017              xor [bx],dl
0000E0CF  8417              test [bx],dl
0000E0D1  56                push si
0000E0D2  18F8              sbb al,bh
0000E0D4  0188166C          add [bx+si+0x6c16],cx
0000E0D8  0F420F            cmovc cx,[bx]
0000E0DB  5E                pop si
0000E0DC  0FA40FB2          shld [bx],cx,0xb2
0000E0E0  0F                db 0x0f
0000E0E1  7A0F              jpe 0xe0f2
0000E0E3  C00F30            ror byte [bx],byte 0x30
0000E0E6  103A              adc [bp+si],bh
0000E0E8  1110              adc [bx+si],dx
0000E0EA  111E1164          adc [0x6411],bx
0000E0EE  11DE              adc si,bx
0000E0F0  12C2              adc al,dl
0000E0F2  12D0              adc dl,al
0000E0F4  1224              adc ah,[si]
0000E0F6  13F8              adc di,ax
0000E0F8  017414            add [si+0x14],si
0000E0FB  7015              jo 0xe112
0000E0FD  46                inc si
0000E0FE  156215            adc ax,0x1562
0000E101  9A15A815B6        call 0xb615:0xa815
0000E106  158C15            adc ax,0x158c
0000E109  D817              fcom dword [bx]
0000E10B  92                xchg ax,dx
0000E10C  17                pop ss
0000E10D  BC1710            mov sp,0x1017
0000E110  188018F8          sbb [bx+si-0x7e8],al
0000E114  01F8              add ax,di
0000E116  01FF              add di,di
0000E118  06                push es
0000E119  0021              add [bx+di],ah
0000E11B  5F                pop di
0000E11C  06                push es
0000E11D  0214              add dl,[si]
0000E11F  0222              add ah,[bp+si]
0000E121  0230              add dh,[bx+si]
0000E123  023E024C          add bh,[0x4c02]
0000E127  025A02            add bl,[bp+si+0x2]
0000E12A  680276            push word 0x7602
0000E12D  02840292          add al,[si-0x6dfe]
0000E131  02A002AE          add ah,[bx+si-0x51fe]
0000E135  02BC02CA          add bh,[si-0x35fe]
0000E139  02D8              add bl,al
0000E13B  02E6              add ah,dh
0000E13D  02F4              add dh,ah
0000E13F  0202              add al,[bp+si]
0000E141  0310              add dx,[bx+si]
0000E143  031E032C          add bx,[0x2c03]
0000E147  033A              add di,[bp+si]
0000E149  034803            add cx,[bx+si+0x3]
0000E14C  56                push si
0000E14D  036403            add sp,[si+0x3]
0000E150  7203              jc 0xe155
0000E152  80038E            add byte [bp+di],0x8e
0000E155  039C03AA          add bx,[si-0x55fd]
0000E159  03B803C6          add di,[bx+si-0x39fd]
0000E15D  03D4              add dx,sp
0000E15F  03E2              add sp,dx
0000E161  03F0              add si,ax
0000E163  03FE              add di,si
0000E165  030C              add cx,[si]
0000E167  041A              add al,0x1a
0000E169  0428              add al,0x28
0000E16B  0436              add al,0x36
0000E16D  0444              add al,0x44
0000E16F  0452              add al,0x52
0000E171  0460              add al,0x60
0000E173  046E              add al,0x6e
0000E175  047C              add al,0x7c
0000E177  048A              add al,0x8a
0000E179  0498              add al,0x98
0000E17B  04A6              add al,0xa6
0000E17D  04B4              add al,0xb4
0000E17F  04C2              add al,0xc2
0000E181  04D0              add al,0xd0
0000E183  04DE              add al,0xde
0000E185  04EC              add al,0xec
0000E187  04FA              add al,0xfa
0000E189  0408              add al,0x8
0000E18B  051605            add ax,0x516
0000E18E  2405              and al,0x5
0000E190  3205              xor al,[di]
0000E192  40                inc ax
0000E193  054E05            add ax,0x54e
0000E196  5C                pop sp
0000E197  05F801            add ax,0x1f8
0000E19A  7000              jo 0xe19c
0000E19C  54                push sp
0000E19D  0E                push cs
0000E19E  B607              mov dh,0x7
0000E1A0  E007              loopne 0xe1a9
0000E1A2  EE                out dx,al
0000E1A3  07                pop es
0000E1A4  C407              les ax,[bx]
0000E1A6  C80D660D          enter 0x660d,0xd
0000E1AA  F8                clc
0000E1AB  08D2              or dl,dl
0000E1AD  07                pop es
0000E1AE  16                push ss
0000E1AF  0CAA              or al,0xaa
0000E1B1  0A24              or ah,[si]
0000E1B3  0CB8              or al,0xb8
0000E1B5  0AFE              or bh,dh
0000E1B7  0A620E            or ah,[bp+si+0xe]
0000E1BA  700E              jo 0xe1ca
0000E1BC  7E0E              jng 0xe1cc
0000E1BE  8C0E9A0E          mov [0xe9a],cs
0000E1C2  E20A              loop 0xe1ce
0000E1C4  100A              adc [bp+si],cl
0000E1C6  C6                db 0xc6
0000E1C7  0AD4              or dl,ah
0000E1C9  0A02              or al,[bp+si]
0000E1CB  0A820D74          or al,[bp+si+0x740d]
0000E1CF  0D0E1C            or ax,0x1c0e
0000E1D2  A80E              test al,0xe
0000E1D4  1409              adc al,0x9
0000E1D6  D6                salc
0000E1D7  0D2A07            or ax,0x72a
0000E1DA  FF06007C          inc word [0x7c00]
0000E1DE  0124              add [si],sp
0000E1E0  1AFF              sbb bh,bh
0000E1E2  FF80240C          inc word [bx+si+0xc24]
0000E1E6  020A              add cl,[bp+si]
0000E1E8  B80AD6            mov ax,0xd60a
0000E1EB  0D1801            or ax,0x118
0000E1EE  8801              mov [bx+di],al
0000E1F0  96                xchg ax,si
0000E1F1  0138              add [bx+si],di
0000E1F3  0E                push cs
0000E1F4  60                pusha
0000E1F5  196E19            sbb [bp+0x19],bp
0000E1F8  E20A              loop 0xe204
0000E1FA  D40A              aam
0000E1FC  F8                clc
0000E1FD  01F8              add ax,di
0000E1FF  01F8              add ax,di
0000E201  01F8              add ax,di
0000E203  01AA0AF0          add [bp+si-0xff6],bp
0000E207  0A160C30          or dl,[0x300c]
0000E20B  095219            or [bp+si+0x19],dx
0000E20E  44                inc sp
0000E20F  193619F8          sbb [0xf819],si
0000E213  01F8              add ax,di
0000E215  01FE              add si,di
0000E217  0A10              or dl,[bx+si]
0000E219  0AC6              or al,dh
0000E21B  0AF8              or bh,al
0000E21D  01F8              add ax,di
0000E21F  01F8              add ax,di
0000E221  01F8              add ax,di
0000E223  01F8              add ax,di
0000E225  01AE0906          add [bp+0x609],bp
0000E229  0914              or [si],dx
0000E22B  0928              or [bx+si],bp
0000E22D  1922              sbb [bp+si],sp
0000E22F  0900              or [bx+si],ax
0000E231  07                pop es
0000E232  5E                pop si
0000E233  01C2              add dx,ax
0000E235  191A              sbb [bp+si],bx
0000E237  194C09            sbb [si+0x9],cx
0000E23A  BC09FE            mov sp,0xfe09
0000E23D  18F8              sbb al,bh
0000E23F  010C              add [si],cx
0000E241  199819C8          sbb [bx+si-0x37e7],bx
0000E245  0D660D            or ax,0xd66
0000E248  0E                push cs
0000E249  0E                push cs
0000E24A  8A19              mov bl,[bx+di]
0000E24C  D019              rcr byte [bx+di],1
0000E24E  CC                int3
0000E24F  0C50              or al,0x50
0000E251  01D6              add si,dx
0000E253  0D081A            or ax,0x1a08
0000E256  7C19              jl 0xe271
0000E258  5A                pop dx
0000E259  09CA              or dx,cx
0000E25B  09A00992          or [bx+si-0x6df7],sp
0000E25F  09F0              or ax,si
0000E261  186809            sbb [bx+si+0x9],ch
0000E264  E00E              loopne 0xe274
0000E266  B60E              mov dh,0xe
0000E268  D20E180F          ror byte [0xf18],cl
0000E26C  260FEE0E340F      pmaxsw mm1,[es:0xf34]
0000E272  EA0FCA10A0        jmp 0xa010:0xca0f
0000E277  10AE10F4          adc [bp-0xbf0],ch
0000E27B  106E12            adc [bp+0x12],ch
0000E27E  44                inc sp
0000E27F  125212            adc dl,[bp+si+0x12]
0000E282  A6                cmpsb
0000E283  125A10            adc bl,[bp+si+0x10]
0000E286  3C14              cmp al,0x14
0000E288  F214C8            repne adc al,0xc8
0000E28B  14E4              adc al,0xe4
0000E28D  141C              adc al,0x1c
0000E28F  152A15            adc ax,0x152a
0000E292  E218              loop 0xe2ac
0000E294  0E                push cs
0000E295  154C17            adc ax,0x174c
0000E298  06                push es
0000E299  17                pop ss
0000E29A  3017              xor [bx],dl
0000E29C  8417              test [bx],dl
0000E29E  3A18              cmp bl,[bx+si]
0000E2A0  EA1688166C        jmp 0x6c16:0x8816
0000E2A5  0F420F            cmovc cx,[bx]
0000E2A8  5E                pop si
0000E2A9  0FA40FB2          shld [bx],cx,0xb2
0000E2AD  0F                db 0x0f
0000E2AE  7A0F              jpe 0xe2bf
0000E2B0  C00F30            ror byte [bx],byte 0x30
0000E2B3  103A              adc [bp+si],bh
0000E2B5  1110              adc [bx+si],dx
0000E2B7  111E1164          adc [0x6411],bx
0000E2BB  11DE              adc si,bx
0000E2BD  12C2              adc al,dl
0000E2BF  12D0              adc dl,al
0000E2C1  1224              adc ah,[si]
0000E2C3  13921074          adc dx,[bp+si+0x7410]
0000E2C7  1470              adc al,0x70
0000E2C9  154615            adc ax,0x1546
0000E2CC  6215              bound dx,[di]
0000E2CE  9A15A815AC        call 0xac15:0xa815
0000E2D3  0D8C15            or ax,0x158c
0000E2D6  D817              fcom dword [bx]
0000E2D8  92                xchg ax,dx
0000E2D9  17                pop ss
0000E2DA  BC1710            mov sp,0x1017
0000E2DD  186418            sbb [si+0x18],ah
0000E2E0  F8                clc
0000E2E1  16                push ss
0000E2E2  8018FF            sbb byte [bx+si],0xff
0000E2E5  06                push es
0000E2E6  001C              add [si],bl
0000E2E8  0470              add al,0x70
0000E2EA  00460E            add [bp+0xe],al
0000E2ED  260118            add [es:bx+si],bx
0000E2F0  015C01            add [si+0x1],bx
0000E2F3  241A              and al,0x1a
0000E2F5  0201              add al,[bx+di]
0000E2F7  321A              xor bl,[bp+si]
0000E2F9  FF08              dec word [bx+si]
0000E2FB  0023              add [bp+di],ah
0000E2FD  0114              add [si],dx
0000E2FF  09FF              or di,di
0000E301  0900              or [bx+si],ax
0000E303  40                inc ax
0000E304  015E01            add [bp+0x1],bx
0000E307  1A03              sbb al,[bp+di]
0000E309  260F2A15          cvtpi2ps xmm2,qword [es:di]
0000E30D  8417              test [bx],dl
0000E30F  1D04B2            sbb ax,0xb204
0000E312  0FA8              push gs
0000E314  151018            adc ax,0x1810
0000E317  8816FF08          mov [0x8ff],dl
0000E31B  005B03            add [bp+di+0x3],bl
0000E31E  1C15              sbb al,0x15
0000E320  EA0F180F1D        jmp 0x1d0f:0x180f
0000E325  049A              add al,0x9a
0000E327  153010            adc ax,0x1030
0000E32A  A4                movsb
0000E32B  0F                db 0x0f
0000E32C  98                cbw
0000E32D  19FF              sbb di,di
0000E32F  0800              or [bx+si],al
0000E331  5C                pop sp
0000E332  013C              add [si],di
0000E334  141E              adc al,0x1e
0000E336  04AE              add al,0xae
0000E338  097414            or [si+0x14],si
0000E33B  680998            push word 0x9809
0000E33E  19FF              sbb di,di
0000E340  0900              or [bx+si],ax
0000E342  40                inc ax
0000E343  012A              add [bp+si],bp
0000E345  151A06            adc ax,0x61a
0000E348  340F              xor al,0xf
0000E34A  0E                push cs
0000E34B  15EE0E            adc ax,0xeee
0000E34E  8417              test [bx],dl
0000E350  260FA8            es push gs
0000E353  151A05            adc ax,0x51a
0000E356  C00F8C            ror byte [bx],byte 0x8c
0000E359  157A0F            adc ax,0xf7a
0000E35C  1018              adc [bx+si],bl
0000E35E  B20F              mov dl,0xf
0000E360  FF09              dec word [bx+di]
0000E362  004001            add [bx+si+0x1],al
0000E365  5E                pop si
0000E366  011A              add [bp+si],bx
0000E368  04CE              add al,0xce
0000E36A  0F06              clts
0000E36C  104216            adc [bp+si+0x16],al
0000E36F  AA                stosb
0000E370  181C              sbb [si],bl
0000E372  0414              add al,0x14
0000E374  104C10            adc [si+0x10],cl
0000E377  7A16              jpe 0xe38f
0000E379  D418              aam 0x18
0000E37B  FF08              dec word [bx+si]
0000E37D  0023              add [bp+di],ah
0000E37F  0136191C          add [0x1c19],si
0000E383  01EA              add dx,bp
0000E385  0F1A066012        bndldx bnd0,[0x1260]
0000E38A  2A15              sub dl,[di]
0000E38C  3416              xor al,0x16
0000E38E  8417              test [bx],dl
0000E390  B81130            mov ax,0x3011
0000E393  1008              adc [bx+si],cl
0000E395  01FA              add dx,di
0000E397  1211              adc dl,[bx+di]
0000E399  05F605            add ax,0x5f6
0000E39C  A815              test al,0x15
0000E39E  6C                insb
0000E39F  16                push ss
0000E3A0  1018              adc [bx+si],bl
0000E3A2  FE                db 0xfe
0000E3A3  11FF              adc di,di
0000E3A5  0800              or [bx+si],al
0000E3A7  2401              and al,0x1
0000E3A9  2819              sub [bx+di],bl
0000E3AB  1B01              sbb ax,[bx+di]
0000E3AD  A0101A            mov al,[0x1a10]
0000E3B0  0426              add al,0x26
0000E3B2  0F2A15            cvtpi2ps xmm2,qword [di]
0000E3B5  EE                out dx,al
0000E3B6  0E                push cs
0000E3B7  8417              test [bx],dl
0000E3B9  0101              add [bx+di],ax
0000E3BB  1011              adc [bx+di],dl
0000E3BD  1A04              sbb al,[si]
0000E3BF  B20F              mov dl,0xf
0000E3C1  A815              test al,0x15
0000E3C3  7A0F              jpe 0xe3d4
0000E3C5  1018              adc [bx+si],bl
0000E3C7  FF05              inc word [di]
0000E3C9  0021              add [bx+di],ah
0000E3CB  5F                pop di
0000E3CC  E00E              loopne 0xe3dc
0000E3CE  B60E              mov dh,0xe
0000E3D0  D20E180F          ror byte [0xf18],cl
0000E3D4  260FEE0E340F      pmaxsw mm1,[es:0xf34]
0000E3DA  CE                into
0000E3DB  0FEA0F            pminsw mm1,[bx]
0000E3DE  06                push es
0000E3DF  105A10            adc [bp+si+0x10],bl
0000E3E2  F8                clc
0000E3E3  01CA              add dx,cx
0000E3E5  10A010AE          adc [bx+si-0x51f0],ah
0000E3E9  10F4              adc ah,dh
0000E3EB  10B8116E          adc [bx+si+0x6e11],bh
0000E3EF  124412            adc al,[si+0x12]
0000E3F2  52                push dx
0000E3F3  126012            adc ah,[bx+si+0x12]
0000E3F6  A6                cmpsb
0000E3F7  12B41240          adc dh,[si+0x4012]
0000E3FB  13BE133C          adc di,[bp+0x3c13]
0000E3FF  1438              adc al,0x38
0000E401  15F214            adc ax,0x14f2
0000E404  C814E414          enter 0xe414,0x14
0000E408  1C15              sbb al,0x15
0000E40A  2A15              sub dl,[di]
0000E40C  0E                push cs
0000E40D  153416            adc ax,0x1634
0000E410  42                inc dx
0000E411  16                push ss
0000E412  F8                clc
0000E413  01EA              add dx,bp
0000E415  16                push ss
0000E416  4C                dec sp
0000E417  17                pop ss
0000E418  06                push es
0000E419  17                pop ss
0000E41A  3017              xor [bx],dl
0000E41C  8417              test [bx],dl
0000E41E  1E                push ds
0000E41F  183A              sbb [bp+si],bh
0000E421  184818            sbb [bx+si+0x18],cl
0000E424  56                push si
0000E425  18AA18F8          sbb [bp+si-0x7e8],ch
0000E429  0190146C          add [bx+si+0x6c14],dx
0000E42D  0F420F            cmovc cx,[bx]
0000E430  5E                pop si
0000E431  0FA40FB2          shld [bx],cx,0xb2
0000E435  0F                db 0x0f
0000E436  7A0F              jpe 0xe447
0000E438  C00F14            ror byte [bx],byte 0x14
0000E43B  1030              adc [bx+si],dh
0000E43D  104C10            adc [si+0x10],cl
0000E440  92                xchg ax,dx
0000E441  107610            adc [bp+0x10],dh
0000E444  3A11              cmp dl,[bx+di]
0000E446  1011              adc [bx+di],dl
0000E448  1E                push ds
0000E449  116411            adc [si+0x11],sp
0000E44C  FE                db 0xfe
0000E44D  11DE              adc si,bx
0000E44F  12C2              adc al,dl
0000E451  12D0              adc dl,al
0000E453  12FA              adc bh,dl
0000E455  1224              adc ah,[si]
0000E457  1332              adc si,[bp+si]
0000E459  136A13            adc bp,[bp+si+0x13]
0000E45C  0414              add al,0x14
0000E45E  7414              jz 0xe474
0000E460  B615              mov dh,0x15
0000E462  7015              jo 0xe479
0000E464  46                inc si
0000E465  156215            adc ax,0x1562
0000E468  9A15A8158C        call 0x8c15:0xa815
0000E46D  156C16            adc ax,0x166c
0000E470  7A16              jpe 0xe488
0000E472  8816F816          mov [0x16f8],dl
0000E476  D817              fcom dword [bx]
0000E478  92                xchg ax,dx
0000E479  17                pop ss
0000E47A  BC1710            mov sp,0x1017
0000E47D  182C              sbb [si],ch
0000E47F  186418            sbb [si+0x18],ah
0000E482  7218              jc 0xe49c
0000E484  8018D4            sbb byte [bx+si],0xd4
0000E487  18F8              sbb al,bh
0000E489  01FF              add di,di
0000E48B  0300              add ax,[bx+si]
0000E48D  1102              adc [bp+si],ax
0000E48F  C219D0            ret 0xd019
0000E492  190D              sbb [di],cx
0000E494  01401A            add [bx+si+0x1a],ax
0000E497  0B01              or ax,[bx+di]
0000E499  5E                pop si
0000E49A  0117              add [bx],dx
0000E49C  0114              add [si],dx
0000E49E  090A              or [bp+si],cx
0000E4A0  01C8              add ax,cx
0000E4A2  0D2F01            or ax,0x12f
0000E4A5  321A              xor bl,[bp+si]
0000E4A7  FF03              inc word [bp+di]
0000E4A9  00413E            add [bx+di+0x3e],al
0000E4AC  5C                pop sp
0000E4AD  1AD4              sbb dl,ah
0000E4AF  036A1A            add bp,[bp+si+0x1a]
0000E4B2  781A              js 0xe4ce
0000E4B4  FE03              inc byte [bp+di]
0000E4B6  2405              and al,0x5
0000E4B8  2804              sub [si],al
0000E4BA  861A              xchg bl,[bp+si]
0000E4BC  360452            ss add al,0x52
0000E4BF  0494              add al,0x94
0000E4C1  1A6E04            sbb ch,[bp+0x4]
0000E4C4  7C04              jl 0xe4ca
0000E4C6  A21A8A            mov [0x8a1a],al
0000E4C9  04B0              add al,0xb0
0000E4CB  1A9804B0          sbb bl,[bx+si-0x4ffc]
0000E4CF  0CD0              or al,0xd0
0000E4D1  04BE              add al,0xbe
0000E4D3  1ACC              sbb cl,ah
0000E4D5  1A08              sbb cl,[bx+si]
0000E4D7  05DA1A            add ax,0x1ada
0000E4DA  040D              add al,0xd
0000E4DC  F8                clc
0000E4DD  01F8              add ax,di
0000E4DF  01780C            add [bx+si+0xc],di
0000E4E2  041B              add al,0x1b
0000E4E4  4A                dec dx
0000E4E5  1B581B            sbb bx,[bx+si+0x1b]
0000E4E8  661B741B          sbb esi,[si+0x1b]
0000E4EC  121B              adc bl,[bp+di]
0000E4EE  82                db 0x82
0000E4EF  1B901B20          sbb dx,[bx+si+0x201b]
0000E4F3  1BAC1BBA          sbb bp,[si-0x45e5]
0000E4F7  1B2E1B8C          sbb bp,[0x8c1b]
0000E4FB  1CC8              sbb al,0xc8
0000E4FD  1BD6              sbb dx,si
0000E4FF  1BE4              sbb sp,sp
0000E501  1BF2              sbb si,dx
0000E503  1B00              sbb ax,[bx+si]
0000E505  1C4A              sbb al,0x4a
0000E507  06                push es
0000E508  A81C              test al,0x1c
0000E50A  0E                push cs
0000E50B  1C1C              sbb al,0x1c
0000E50D  1CBE              sbb al,0xbe
0000E50F  0C2A              or al,0x2a
0000E511  1C38              sbb al,0x38
0000E513  1C46              sbb al,0x46
0000E515  1CB6              sbb al,0xb6
0000E517  1C9A              sbb al,0x9a
0000E519  1C62              sbb al,0x62
0000E51B  1CC8              sbb al,0xc8
0000E51D  06                push es
0000E51E  701C              jo 0xe53c
0000E520  7E1C              jng 0xe53e
0000E522  C41C              les bx,[si]
0000E524  50                push ax
0000E525  1DC219            sbb ax,0x19c2
0000E528  FF05              inc word [di]
0000E52A  0021              add [bx+di],ah
0000E52C  5F                pop di
0000E52D  0A0F              or cl,[bx]
0000E52F  EC                in al,dx
0000E530  19A21328          sbb [bp+si+0x2813],sp
0000E534  19CC              sbb sp,cx
0000E536  1318              adc bx,[bx+si]
0000E538  16                push ss
0000E539  5E                pop si
0000E53A  01C2              add dx,ax
0000E53C  194216            sbb [bp+si+0x16],ax
0000E53F  3416              xor al,0x16
0000E541  B216              mov dl,0x16
0000E543  8E18              mov ds,[bx+si]
0000E545  F8                clc
0000E546  01AA189C          add [bp+si-0x63e8],bp
0000E54A  18C8              sbb al,cl
0000E54C  0D960F            or ax,0xf96
0000E54F  16                push ss
0000E550  1AE8              sbb ch,al
0000E552  13D0              adc dx,ax
0000E554  1912              sbb [bp+si],dx
0000E556  1450              adc al,0x50
0000E558  16                push ss
0000E559  FA                cli
0000E55A  1908              sbb [bx+si],cx
0000E55C  1A7A16            sbb bh,[bp+si+0x16]
0000E55F  6C                insb
0000E560  16                push ss
0000E561  DC16B818          fcom qword [0x18b8]
0000E565  DE19              ficomp word [bx+di]
0000E567  D418              aam 0x18
0000E569  C6                db 0xc6
0000E56A  18C4              sbb ah,al
0000E56C  15B60E            adc ax,0xeb6
0000E56F  D20EC40E          ror byte [0xec4],cl
0000E573  26                es
0000E574  0F                db 0x0f
0000E575  94                xchg ax,sp
0000E576  13CE              adc cx,si
0000E578  0FEA0F            pminsw mm1,[bx]
0000E57B  06                push es
0000E57C  10A010E6          adc [bx+si-0x19f0],ah
0000E580  10F4              adc ah,dh
0000E582  1002              adc [bp+si],al
0000E584  114412            adc [si+0x12],ax
0000E587  52                push dx
0000E588  126810            adc ch,[bx+si+0x10]
0000E58B  5A                pop dx
0000E58C  1020              adc [bx+si],ah
0000E58E  144A              adc al,0x4a
0000E590  14C8              adc al,0xc8
0000E592  14E4              adc al,0xe4
0000E594  14D6              adc al,0xd6
0000E596  142A              adc al,0x2a
0000E598  15E218            adc ax,0x18e2
0000E59B  E015              loopne 0xe5b2
0000E59D  3E17              ds pop ss
0000E59F  06                push es
0000E5A0  17                pop ss
0000E5A1  1417              adc al,0x17
0000E5A3  8417              test [bx],dl
0000E5A5  3A18              cmp bl,[bx+si]
0000E5A7  A4                movsb
0000E5A8  16                push ss
0000E5A9  8816EE15          mov [0x15ee],dl
0000E5AD  42                inc dx
0000E5AE  0F5E0F            divps xmm1,oword [bx]
0000E5B1  50                push ax
0000E5B2  0FB20F            lss cx,[bx]
0000E5B5  DA13              ficom dword [bp+di]
0000E5B7  1410              adc al,0x10
0000E5B9  3010              xor [bx+si],dl
0000E5BB  4C                dec sp
0000E5BC  1010              adc [bx+si],dl
0000E5BE  115611            adc [bp+0x11],dx
0000E5C1  64117211          adc [fs:bp+si+0x11],si
0000E5C5  C212D0            ret 0xd012
0000E5C8  12841076          adc al,[si+0x7610]
0000E5CC  105814            adc [bx+si+0x14],bl
0000E5CF  82                db 0x82
0000E5D0  1446              adc al,0x46
0000E5D2  156215            adc ax,0x1562
0000E5D5  54                push sp
0000E5D6  15A815            adc ax,0x15a8
0000E5D9  AC                lodsb
0000E5DA  0D0A16            or ax,0x160a
0000E5DD  CA1792            retf 0x9217
0000E5E0  17                pop ss
0000E5E1  A01710            mov al,[0x1017]
0000E5E4  186418            sbb [si+0x18],ah
0000E5E7  CE                into
0000E5E8  16                push ss
0000E5E9  A6                cmpsb
0000E5EA  19FF              sbb di,di
0000E5EC  050021            add ax,0x2100
0000E5EF  5F                pop di
0000E5F0  1A12              sbb dl,[bp+si]
0000E5F2  EC                in al,dx
0000E5F3  1914              sbb [si],dx
0000E5F5  0928              or [bx+si],bp
0000E5F7  19F8              sbb ax,di
0000E5F9  010C              add [si],cx
0000E5FB  125E01            adc bl,[bp+0x1]
0000E5FE  C21960            ret 0x6019
0000E601  1234              adc dh,[si]
0000E603  16                push ss
0000E604  80114E            adc byte [bx+di],0x4e
0000E607  13F8              adc di,ax
0000E609  01F8              add ax,di
0000E60B  019C18C8          add [si-0x37e8],bx
0000E60F  0D3612            or ax,0x1236
0000E612  0E                push cs
0000E613  0E                push cs
0000E614  8A19              mov bl,[bx+di]
0000E616  D019              rcr byte [bx+di],1
0000E618  E41B              in al,0x1b
0000E61A  2812              sub [bp+si],dl
0000E61C  D6                salc
0000E61D  0D081A            or ax,0x1a08
0000E620  FA                cli
0000E621  126C16            adc ch,[si+0x16]
0000E624  C6                db 0xc6
0000E625  115C13            adc [si+0x13],bx
0000E628  92                xchg ax,dx
0000E629  09F8              or ax,di
0000E62B  01C6              add si,ax
0000E62D  18E0              sbb al,ah
0000E62F  0E                push cs
0000E630  B60E              mov dh,0xe
0000E632  D20EF801          ror byte [0x1f8],cl
0000E636  260FF80F          psubb mm1,[es:bx]
0000E63A  DC0F              fmul qword [bx]
0000E63C  EA0FCA10A0        jmp 0xa010:0xca0f
0000E641  10AE10F4          adc [bp-0xbf0],ch
0000E645  106E12            adc [bp+0x12],ch
0000E648  44                inc sp
0000E649  125212            adc dl,[bp+si+0x12]
0000E64C  A6                cmpsb
0000E64D  12F8              adc bh,al
0000E64F  013C              add [si],di
0000E651  14F2              adc al,0xf2
0000E653  14C8              adc al,0xc8
0000E655  14E4              adc al,0xe4
0000E657  14AA              adc al,0xaa
0000E659  112A              adc [bp+si],bp
0000E65B  15E218            adc ax,0x18e2
0000E65E  8E11              mov ss,[bx+di]
0000E660  4C                dec sp
0000E661  17                pop ss
0000E662  06                push es
0000E663  17                pop ss
0000E664  3017              xor [bx],dl
0000E666  8417              test [bx],dl
0000E668  2217              and dl,[bx]
0000E66A  2616              es push ss
0000E66C  88166C0F          mov [0xf6c],dl
0000E670  42                inc dx
0000E671  0F5E0F            divps xmm1,oword [bx]
0000E674  F8                clc
0000E675  01B20F3E          add [bp+si+0x3e0f],si
0000E679  1022              adc [bp+si],ah
0000E67B  1030              adc [bx+si],dh
0000E67D  103A              adc [bp+si],bh
0000E67F  1110              adc [bx+si],dx
0000E681  111E1164          adc [0x6411],bx
0000E685  11DE              adc si,bx
0000E687  12C2              adc al,dl
0000E689  12D0              adc dl,al
0000E68B  1224              adc ah,[si]
0000E68D  13F8              adc di,ax
0000E68F  017414            add [si+0x14],si
0000E692  7015              jo 0xe6a9
0000E694  46                inc si
0000E695  156215            adc ax,0x1562
0000E698  F011A815AC        lock adc [bx+si-0x53eb],bp
0000E69D  0DD411            or ax,0x11d4
0000E6A0  D817              fcom dword [bx]
0000E6A2  92                xchg ax,dx
0000E6A3  17                pop ss
0000E6A4  BC1710            mov sp,0x1017
0000E6A7  18AE175E          sbb [bp+0x5e17],ch
0000E6AB  16                push ss
0000E6AC  A6                cmpsb
0000E6AD  19FF              sbb di,di
0000E6AF  050021            add ax,0x2100
0000E6B2  030A              add cx,[bp+si]
0000E6B4  0F                db 0x0f
0000E6B5  C81BD215          enter 0xd21b,0x15
0000E6B9  0102              add [bp+si],ax
0000E6BB  98                cbw
0000E6BC  12B01302          adc dh,[bx+si+0x213]
0000E6C0  0442              add al,0x42
0000E6C2  16                push ss
0000E6C3  D810              fcom dword [bx+si]
0000E6C5  9C                pushf
0000E6C6  11961601          adc [bp+0x116],dx
0000E6CA  01AA1802          add [bp+si+0x218],bp
0000E6CE  03960F16          add dx,[bp+0x160f]
0000E6D2  1AFC              sbb bh,ah
0000E6D4  150103            adc ax,0x301
0000E6D7  16                push ss
0000E6D8  13F6              adc si,si
0000E6DA  13FA              adc di,dx
0000E6DC  1901              sbb [bx+di],ax
0000E6DE  087A16            or [bp+si+0x16],bh
0000E6E1  48                dec ax
0000E6E2  11E2              adc dx,sp
0000E6E4  11C0              adc ax,ax
0000E6E6  16                push ss
0000E6E7  AC                lodsb
0000E6E8  14D4              adc al,0xd4
0000E6EA  18BA14FC          sbb [bp+si-0x3ec],bh
0000E6EE  0E                push cs
0000E6EF  06                push es
0000E6F0  028A1206          add cl,[bp+si+0x612]
0000E6F4  1001              adc [bx+di],al
0000E6F6  01E6              add si,sp
0000E6F8  1001              adc [bx+di],al
0000E6FA  01BC1002          add [si+0x210],di
0000E6FE  017C12            add [si+0x12],di
0000E701  0103              add [bp+di],ax
0000E703  2E1400            cs adc al,0x0
0000E706  157813            adc ax,0x1378
0000E709  050168            add ax,0x6801
0000E70C  17                pop ss
0000E70D  0302              add ax,[bp+si]
0000E70F  7617              jna 0xe728
0000E711  5A                pop dx
0000E712  17                pop ss
0000E713  0101              add [bx+di],ax
0000E715  880F              mov [bx],cl
0000E717  06                push es
0000E718  0208              add cl,[bx+si]
0000E71A  134C10            adc cx,[si+0x10]
0000E71D  0101              add [bx+di],ax
0000E71F  56                push si
0000E720  1101              adc [bx+di],ax
0000E722  012C              add [si],bp
0000E724  1102              adc [bp+si],ax
0000E726  05EC12            add ax,0x12ec
0000E729  7610              jna 0xe73b
0000E72B  66147E            o32 adc al,0x7e
0000E72E  158613            adc ax,0x1386
0000E731  0501F4            add ax,0xf401
0000E734  17                pop ss
0000E735  0303              add ax,[bp+di]
0000E737  0218              add bl,[bx+si]
0000E739  E617              out 0x17,al
0000E73B  A6                cmpsb
0000E73C  19FF              sbb di,di
0000E73E  050021            add ax,0x2100
0000E741  5F                pop di
0000E742  F4                hlt
0000E743  106C1D            adc [si+0x1d],ch
0000E746  42                inc dx
0000E747  1D7A1D            sbb ax,0x1d7a
0000E74A  C20436            ret 0x3604
0000E74D  04A6              add al,0xa6
0000E74F  124404            adc al,[si+0x4]
0000E752  881D              mov [di],bl
0000E754  96                xchg ax,si
0000E755  1DA41D            sbb ax,0x1da4
0000E758  B21D              mov dl,0x1d
0000E75A  F8                clc
0000E75B  015618            add [bp+0x18],dx
0000E75E  C01DC6            rcr byte [di],byte 0xc6
0000E761  03CE              add cx,si
0000E763  1DD403            sbb ax,0x3d4
0000E766  6A1A              push byte +0x1a
0000E768  DC1D              fcomp qword [di]
0000E76A  FE03              inc byte [bp+di]
0000E76C  EA1D0203F8        jmp 0xf803:0x21d
0000E771  1D061E            sbb ax,0x1e06
0000E774  52                push dx
0000E775  0414              add al,0x14
0000E777  1E                push ds
0000E778  6E                outsb
0000E779  0428              add al,0x28
0000E77B  048A              add al,0x8a
0000E77D  04B0              add al,0xb0
0000E77F  1A9804E2          sbb bl,[bx+si-0x1dfc]
0000E783  03D0              add dx,ax
0000E785  0416              add al,0x16
0000E787  05CC1A            add ax,0x1acc
0000E78A  0805              or [di],al
0000E78C  221E301E          and bl,[0x1e30]
0000E790  3E1E              ds push ds
0000E792  4C                dec sp
0000E793  1E                push ds
0000E794  5A                pop dx
0000E795  1E                push ds
0000E796  681E94            push word 0x941e
0000E799  05761E            add ax,0x1e76
0000E79C  841E921E          test [0x1e92],bl
0000E7A0  8605              xchg al,[di]
0000E7A2  A01EAE            mov al,[0xae1e]
0000E7A5  1E                push ds
0000E7A6  BC1ECA            mov sp,0xca1e
0000E7A9  1E                push ds
0000E7AA  BE05D8            mov si,0xd805
0000E7AD  1E                push ds
0000E7AE  E61E              out 0x1e,al
0000E7B0  F4                hlt
0000E7B1  1E                push ds
0000E7B2  021F              add bl,[bx]
0000E7B4  C81B101F          enter 0x101b,0x1f
0000E7B8  1E                push ds
0000E7B9  1F                pop ds
0000E7BA  2C1F              sub al,0x1f
0000E7BC  4A                dec dx
0000E7BD  06                push es
0000E7BE  3A1F              cmp bl,[bx]
0000E7C0  58                pop ax
0000E7C1  06                push es
0000E7C2  A20538            mov [0x3805],al
0000E7C5  1CD6              sbb al,0xd6
0000E7C7  06                push es
0000E7C8  54                push sp
0000E7C9  1CC8              sbb al,0xc8
0000E7CB  06                push es
0000E7CC  48                dec ax
0000E7CD  1F                pop ds
0000E7CE  56                push si
0000E7CF  1F                pop ds
0000E7D0  641F              fs pop ds
0000E7D2  721F              jc 0xe7f3
0000E7D4  801F8E            sbb byte [bx],0x8e
0000E7D7  1F                pop ds
0000E7D8  9C                pushf
0000E7D9  1F                pop ds
0000E7DA  AA                stosb
0000E7DB  1F                pop ds
0000E7DC  B81FC6            mov ax,0xc61f
0000E7DF  1F                pop ds
0000E7E0  9E                sahf
0000E7E1  1464              adc al,0x64
0000E7E3  11D4              adc sp,dx
0000E7E5  1F                pop ds
0000E7E6  E21F              loop 0xe807
0000E7E8  F01F              lock pop ds
0000E7EA  82                db 0x82
0000E7EB  06                push es
0000E7EC  F60524            test byte [di],0x24
0000E7EF  1304              adc ax,[si]
0000E7F1  06                push es
0000E7F2  FE                db 0xfe
0000E7F3  1F                pop ds
0000E7F4  0C20              or al,0x20
0000E7F6  3612D2            ss adc dl,dl
0000E7F9  1C5E              sbb al,0x5e
0000E7FB  0180181A          add [bx+si+0x1a18],ax
0000E7FF  20FF              and bh,bh
0000E801  050020            add ax,0x2000
0000E804  60                pusha
0000E805  F8                clc
0000E806  017805            add [bx+si+0x5],di
0000E809  5A                pop dx
0000E80A  0214              add dl,[si]
0000E80C  09F8              or ax,di
0000E80E  01F8              add ax,di
0000E810  0100              add [bx+si],ax
0000E812  07                pop es
0000E813  5E                pop si
0000E814  0114              add [si],dx
0000E816  021A              add bl,[bp+si]
0000E818  19F8              sbb ax,di
0000E81A  01BC09FE          add [si-0x1f7],di
0000E81E  18F8              sbb al,bh
0000E820  01F8              add ax,di
0000E822  01B419C8          add [si-0x37e7],si
0000E826  0D660D            or ax,0xd66
0000E829  0E                push cs
0000E82A  0E                push cs
0000E82B  8A19              mov bl,[bx+di]
0000E82D  50                push ax
0000E82E  1D5E1D            sbb ax,0x1d5e
0000E831  E01C              loopne 0xe84f
0000E833  D6                salc
0000E834  0DEE1C            or ax,0x1cee
0000E837  FC                cld
0000E838  1C0A              sbb al,0xa
0000E83A  1DCA09            sbb ax,0x9ca
0000E83D  181D              sbb [di],bl
0000E83F  92                xchg ax,dx
0000E840  09261D34          or [0x341d],sp
0000E844  1D4E1A            sbb ax,0x1a4e
0000E847  5C                pop sp
0000E848  1AD4              sbb dl,ah
0000E84A  036A1A            add bp,[bp+si+0x1a]
0000E84D  781A              js 0xe869
0000E84F  FE03              inc byte [bp+di]
0000E851  2405              and al,0x5
0000E853  2804              sub [si],al
0000E855  861A              xchg bl,[bp+si]
0000E857  360452            ss add al,0x52
0000E85A  0494              add al,0x94
0000E85C  1A6E04            sbb ch,[bp+0x4]
0000E85F  7C04              jl 0xe865
0000E861  A21A8A            mov [0x8a1a],al
0000E864  04B0              add al,0xb0
0000E866  1A9804F8          sbb bl,[bx+si-0x7fc]
0000E86A  01B00CD0          add [bx+si-0x2ff4],si
0000E86E  04BE              add al,0xbe
0000E870  1ACC              sbb cl,ah
0000E872  1A08              sbb cl,[bx+si]
0000E874  05DA1A            add ax,0x1ada
0000E877  040D              add al,0xd
0000E879  E81AF6            call 0xde96
0000E87C  1A04              sbb al,[si]
0000E87E  1B12              sbb dx,[bp+si]
0000E880  1B20              sbb sp,[bx+si]
0000E882  1B2E1B3C          sbb bp,[0x3c1b]
0000E886  1B780C            sbb di,[bx+si+0xc]
0000E889  4A                dec dx
0000E88A  1B581B            sbb bx,[bx+si+0x1b]
0000E88D  661B741B          sbb esi,[si+0x1b]
0000E891  82                db 0x82
0000E892  1B901B9E          sbb dx,[bx+si-0x61e5]
0000E896  1BBA1BC8          sbb di,[bp+si-0x37e5]
0000E89A  1BD6              sbb dx,si
0000E89C  1BE4              sbb sp,sp
0000E89E  1BF2              sbb si,dx
0000E8A0  1B00              sbb ax,[bx+si]
0000E8A2  1C4A              sbb al,0x4a
0000E8A4  06                push es
0000E8A5  0E                push cs
0000E8A6  1C1C              sbb al,0x1c
0000E8A8  1C2A              sbb al,0x2a
0000E8AA  1CBE              sbb al,0xbe
0000E8AC  0C38              or al,0x38
0000E8AE  1C46              sbb al,0x46
0000E8B0  1C54              sbb al,0x54
0000E8B2  1CC8              sbb al,0xc8
0000E8B4  06                push es
0000E8B5  701C              jo 0xe8d3
0000E8B7  7E1C              jng 0xe8d5
0000E8B9  8C1C              mov [si],ds
0000E8BB  9A1CA81CB6        call 0xb61c:0xa81c
0000E8C0  1CC4              sbb al,0xc4
0000E8C2  1CF8              sbb al,0xf8
0000E8C4  01FF              add di,di

; ---- 0x0e8c6-0x0e8dd  character-generator font / bitmap data  [H08/H21] ----
0000E8C6  05 00 50 01 80 11 0c 02 60 12 34 16 11 01 c6 11  |..P.....`.4.....|
0000E8D6  0c 02 fa 12 6c 16 ff                             |....l..|

; ---- 0x0e8dd-0x0e8fa  zero padding  [H07/H21] ----
0000E8DD  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000E8ED  00 00 00 00 00 00 00 00 00 00 00 00 00           |.............|

; ---- 0x0e8fa-0x0e8fd  character-generator font / bitmap data  [H08/H21] ----
0000E8FA  1e 00 1e                                         |...|

; ---- 0x0e8fd-0x0e960  zero padding  [H07/H21] ----
0000E8FD  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000E90D  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000E91D  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000E92D  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000E93D  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000E94D  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000E95D  00 00 00                                         |...|

; ==== 0x0e960-0x0e961  CODE (linear/orphan, conf 80) ====
0000E960  1E                push ds

; ---- 0x0e961-0x0ea01  ASCII text/messages  [H17] ----
0000E961  00 3e 00 30 31 32 33 34 35 36 37 38 39 41 42 43  |.>.0123456789ABC|
0000E971  44 45 46 0d 0a 0a 0a 2a 2a 2a 2a 2a 2a 20 20 49  |DEF....******  I|
0000E981  6e 74 65 72 6e 61 6c 20 45 72 72 6f 72 20 61 74  |nternal Error at|
0000E991  20 24 20 20 41 63 74 69 76 65 20 54 61 73 6b 3a  | $  Active Task:|
0000E9A1  20 24 20 20 2a 2a 2a 2a 2a 2a 0d 0a 0a 41 58 3a  | $  ******...AX:|
0000E9B1  20 24 20 20 20 42 58 3a 20 24 20 20 20 43 58 3a  | $   BX: $   CX:|
0000E9C1  20 24 20 20 20 44 58 3a 20 24 0d 0a 53 49 3a 20  | $   DX: $..SI: |
0000E9D1  24 20 20 20 44 49 3a 20 24 20 20 20 53 50 3a 20  |$   DI: $   SP: |
0000E9E1  24 20 20 20 42 50 3a 20 24 0d 0a 44 53 3a 20 24  |$   BP: $..DS: $|
0000E9F1  20 20 20 45 53 3a 20 24 20 20 20 53 53 3a 20 24  |   ES: $   SS: $|

; ==== 0x0ea01-0x0ea16  CODE (linear/orphan, conf 80) ====
0000EA01  2020              and [bx+si],ah
0000EA03  20466C            and [bp+0x6c],al
0000EA06  61                popa
0000EA07  67733A            jnc 0xea44
0000EA0A  2024              and [si],ah
0000EA0C  0A0D              or cl,[di]
0000EA0E  0A24              or ah,[si]
0000EA10  0000              add [bx+si],al
0000EA12  0000              add [bx+si],al
0000EA14  0000              add [bx+si],al

; ---- 0x0ea16-0x0ea36  ASCII text/messages  [H17] ----
0000EA16  4d 46 47 54 45 53 54 2e 45 58 45 00 43 4f 4e 46  |MFGTEST.EXE.CONF|
0000EA26  49 47 2e 53 59 53 00 45 4d 55 4c 41 54 4f 52 2e  |IG.SYS.EMULATOR.|

; ---- 0x0ea36-0x0ea46  character-generator font / bitmap data  [H08/H21] ----
0000EA36  45 58 45 00 44 4f 57 4e 4c 4f 41 44 2e 45 58 45  |EXE.DOWNLOAD.EXE|

; ---- 0x0ea46-0x0ea95  zero padding  [H07/H21] ----
0000EA46  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000EA56  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000EA66  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000EA76  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000EA86  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00     |...............|

; ==== 0x0ea95-0x0eab1  CODE (linear/orphan, conf 80) ====
0000EA95  2020              and [bx+si],ah
0000EA97  2020              and [bx+si],ah
0000EA99  2020              and [bx+si],ah
0000EA9B  2020              and [bx+si],ah
0000EA9D  2020              and [bx+si],ah
0000EA9F  2000              and [bx+si],al
0000EAA1  007401            add [si+0x1],dh
0000EAA4  8EFE              mov segr7,si
0000EAA6  B401              mov ah,0x1
0000EAA8  8EFE              mov segr7,si
0000EAAA  B401              mov ah,0x1
0000EAAC  8EFE              mov segr7,si
0000EAAE  670100            add [eax],ax

; ---- 0x0eab1-0x0f031  ASCII text/messages  [H17] ----
0000EAB1  00 00 4e 61 6d 65 20 6f 66 20 46 69 6c 65 20 74  |..Name of File t|
0000EAC1  6f 20 52 75 6e 3a 20 24 4e 56 4d 3a 20 24 52 4f  |o Run: $NVM: $RO|
0000EAD1  4d 3a 20 24 20 20 24 0d 0a 24 42 79 74 65 73 20  |M: $  $..$Bytes |
0000EAE1  41 76 61 69 6c 61 62 6c 65 3a 0d 0a 24 20 20 4e  |Available:..$  N|
0000EAF1  56 4d 20 24 3a 24 20 30 78 24 20 2d 20 52 75 6e  |VM $:$ 0x$ - Run|
0000EB01  6e 69 6e 67 20 2d 20 24 20 2d 20 52 65 61 64 79  |ning - $ - Ready|
0000EB11  20 20 20 2d 20 24 20 2d 20 54 53 52 20 20 20 20  |   - $ - TSR    |
0000EB21  20 2d 20 24 20 62 79 74 65 73 2e 24 41 55 49 20  | - $ bytes.$AUI |
0000EB31  ... (1280 more bytes)

; ==== 0x0f031-0x0f034  CODE (linear/orphan, conf 80) ====
0000F031  2D2043            sub ax,0x4320

; ---- 0x0f034-0x0f04e  character-generator font / bitmap data  [H08/H21] ----
0000F034  68 65 63 6b 73 75 6d 3a 20 24 0d 0a 24 00 00 00  |hecksum: $..$...|
0000F044  00 4e 65 77 20 55 54 32 30 30                    |.New UT200|

; ---- 0x0f04e-0x0f063  zero padding  [H07/H21] ----
0000F04E  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000F05E  00 00 00 00 00                                   |.....|

; ==== 0x0f063-0x0f068  CODE (linear/orphan, conf 80) ====
0000F063  4F                dec di
0000F064  7065              jo 0xf0cb
0000F066  6E                outsb
0000F067  2C                db 0x2c

; ---- 0x0f068-0x0f0dc  character-generator font / bitmap data  [H08/H21] ----
0000F068  20 4f 68 20 53 65 73 61 6d 65 21 53 4f 46 54 4b  | Oh Sesame!SOFTK|
0000F078  45 59 2e 44 41 54 00 00 00 00 00 00 00 00 00 00  |EY.DAT..........|
0000F088  03 05 08 00 01 00 01 01 31 00 00 00 01 11 13 05  |........1.......|
0000F098  0b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000F0A8  43 4f 4e 46 49 47 2e 42 4c 4b 00 00 00 00 00 00  |CONFIG.BLK......|
0000F0B8  00 00 00 50 52 4f 44 55 43 54 00 4b 45 59 42 4f  |...PRODUCT.KEYBO|
0000F0C8  41 52 44 2e 54 42 32 00 00 00 00 00 00 20 00 04  |ARD.TB2...... ..|
0000F0D8  00 00 00 01                                      |....|

; ---- 0x0f0dc-0x0f158  zero padding  [H07/H21] ----
0000F0DC  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000F0EC  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000F0FC  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000F10C  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000F11C  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000F12C  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000F13C  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000F14C  00 00 00 00 00 00 00 00 00 00 00 00              |............|

; ==== 0x0f158-0x0f160  CODE (linear/orphan, conf 80) ====
0000F158  2020              and [bx+si],ah
0000F15A  2430              and al,0x30
0000F15C  202D              and [di],ch
0000F15E  2024              and [si],ah

; ---- 0x0f160-0x0f1c2  character-generator font / bitmap data  [H08/H21] ----
0000F160  20 28 66 72 65 65 29 24 0d 0a 24 00 7e 3f 00 f6  | (free)$..$.~?..|
0000F170  54 45 52 4d 4d 53 47 31 00 00 00 00 00 00 00 00  |TERMMSG1........|
0000F180  00 00 9c 00 9d 00 9e 00 80 00 82 00 83 00 80 00  |................|
0000F190  84 00 82 00 01 12 00 ee 00 00 a2 00 01 12 00 ee  |................|
0000F1A0  00 00 83 00 01 12 00 ee 00 00 a3 00 01 12 00 ee  |................|
0000F1B0  00 00 80 00 02 12 00 ee 01 00 a0 00 02 12 00 ee  |................|
0000F1C0  01 00                                            |..|

; ==== 0x0f1c2-0x0f1cf  CODE (linear/orphan, conf 80) ====
0000F1C2  8400              test [bx+si],al
0000F1C4  1C12              sbb al,0x12
0000F1C6  00EE              add dh,ch
0000F1C8  1B00              sbb ax,[bx+si]
0000F1CA  A4                movsb
0000F1CB  001C              add [si],bl
0000F1CD  1200              adc al,[bx+si]

; ---- 0x0f1cf-0x0f1ef  ASCII text/messages  [H17] ----
0000F1CF  ee 1b 4e 56 4d 20 46 61 69 6c 75 72 65 0d 0a 24  |..NVM Failure..$|
0000F1DF  4e 56 4d 20 44 61 74 61 20 43 6f 72 72 75 70 74  |NVM Data Corrupt|

; ==== 0x0f1ef-0x0f224  CODE (linear/orphan, conf 80) ====
0000F1EF  65640D0A24        fs or ax,0x240a
0000F1F4  DE18              ficomp word [bx+si]
0000F1F6  DE18              ficomp word [bx+si]
0000F1F8  DE18              ficomp word [bx+si]
0000F1FA  4B                dec bx
0000F1FB  65726E            gs jc 0xf26c
0000F1FE  656C              gs insb
0000F200  2E52              cs push dx
0000F202  4F                dec di
0000F203  4D                dec bp
0000F204  0000              add [bx+si],al
0000F206  2439              and al,0x39
0000F208  2921              sub [bx+di],sp
0000F20A  3B2B              cmp bp,[bp+di]
0000F20C  7F7F              jg 0xf28d
0000F20E  7FFF              jg 0xf20f
0000F210  FF                db 0xff
0000F211  FF                db 0xff
0000F212  FF8FFF83          dec word [bx-0x7c01]
0000F216  FF81FF80          inc word [bx+di-0x7f01]
0000F21A  7F80              jg 0xf19c
0000F21C  55                push bp
0000F21D  803F80            cmp byte [bx],0x80
0000F220  29801F80          sub [bx+si-0x7fe1],ax

; ---- 0x0f224-0x0f268  character-generator font / bitmap data  [H08/H21] ----
0000F224  15 80 5e 25 5e 25 5e 27 5e 27 ff 00 00 00 00 66  |..^%^%^'^'.....f|
0000F234  4b 00 f6 9b 4b 00 f6 ff 4a 00 f6 00 00 c0 12 00  |K...K...J.......|
0000F244  00 00 00 00 00 00 00 00 03 01 01 00 1c 05 00 00  |................|
0000F254  00 00 00 00 00 00 00 00 00 e4 0c 00 00 00 00 00  |................|
0000F264  00 00 00 02                                      |....|

; ---- 0x0f268-0x0f298  zero padding  [H07/H21] ----
0000F268  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000F278  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000F288  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|

; ==== 0x0f298-0x0f2aa  CODE (linear/orphan, conf 80) ====
0000F298  7C28              jl 0xf2c2
0000F29A  0000              add [bx+si],al
0000F29C  E45D              in al,0x5d
0000F29E  00F6              add dh,dh
0000F2A0  0E                push cs
0000F2A1  46                inc si
0000F2A2  4F                dec di
0000F2A3  4E                dec si
0000F2A4  54                push sp
0000F2A5  46                inc si
0000F2A6  49                dec cx
0000F2A7  4C                dec sp
0000F2A8  45                inc bp
0000F2A9  00                db 0x00

; ---- 0x0f2aa-0x0fe00  erased (0xFF fill)  [H21] ----
0000F2AA  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
0000F2BA  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
0000F2CA  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
0000F2DA  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
0000F2EA  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
0000F2FA  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
0000F30A  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
0000F31A  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
0000F32A  ... (2774 more bytes)

; ==== 0x0fe00-0x0fef9  CODE (CF-reached, conf 99) ====
0000FE00  BAA4FF            mov dx,0xffa4
0000FE03  B801E0            mov ax,0xe001
0000FE06  EE                out dx,al
0000FE07  BAA6FF            mov dx,0xffa6
0000FE0A  B80E00            mov ax,0xe
0000FE0D  EE                out dx,al
0000FE0E  BAA0FF            mov dx,0xffa0
0000FE11  B80000            mov ax,0x0
0000FE14  EE                out dx,al
0000FE15  BAA2FF            mov dx,0xffa2
0000FE18  B80A80            mov ax,0x800a
0000FE1B  EE                out dx,al
0000FE1C  BA80FF            mov dx,0xff80
0000FE1F  B80180            mov ax,0x8001
0000FE22  EE                out dx,al
0000FE23  BA82FF            mov dx,0xff82
0000FE26  B80AA0            mov ax,0xa00a
0000FE29  EE                out dx,al
0000FE2A  BA84FF            mov dx,0xff84
0000FE2D  B801A0            mov ax,0xa001
0000FE30  EE                out dx,al
0000FE31  BA86FF            mov dx,0xff86
0000FE34  B80AC0            mov ax,0xc00a
0000FE37  EE                out dx,al
0000FE38  BA88FF            mov dx,0xff88
0000FE3B  B802C0            mov ax,0xc002
0000FE3E  EE                out dx,al
0000FE3F  BA8AFF            mov dx,0xff8a
0000FE42  B80AD0            mov ax,0xd00a
0000FE45  EE                out dx,al
0000FE46  BA8CFF            mov dx,0xff8c
0000FE49  B805D0            mov ax,0xd005
0000FE4C  EE                out dx,al
0000FE4D  BA8EFF            mov dx,0xff8e
0000FE50  B80AE0            mov ax,0xe00a
0000FE53  EE                out dx,al
0000FE54  BA90FF            mov dx,0xff90
0000FE57  B84003            mov ax,0x340
0000FE5A  EE                out dx,al
0000FE5B  BA92FF            mov dx,0xff92
0000FE5E  B88903            mov ax,0x389
0000FE61  EE                out dx,al
0000FE62  BA94FF            mov dx,0xff94
0000FE65  B80003            mov ax,0x300
0000FE68  EE                out dx,al
0000FE69  BA96FF            mov dx,0xff96
0000FE6C  B84903            mov ax,0x349
0000FE6F  EE                out dx,al
0000FE70  BAB0FF            mov dx,0xffb0
0000FE73  B80000            mov ax,0x0
0000FE76  EE                out dx,al
0000FE77  BAB2FF            mov dx,0xffb2
0000FE7A  B88C00            mov ax,0x8c
0000FE7D  EE                out dx,al
0000FE7E  BAB4FF            mov dx,0xffb4
0000FE81  B80080            mov ax,0x8000
0000FE84  EE                out dx,al
0000FE85  BA36FF            mov dx,0xff36
0000FE88  B80040            mov ax,0x4000
0000FE8B  EE                out dx,al
0000FE8C  BA3EFF            mov dx,0xff3e
0000FE8F  EE                out dx,al
0000FE90  BA46FF            mov dx,0xff46
0000FE93  EE                out dx,al
0000FE94  BA64FF            mov dx,0xff64
0000FE97  B80100            mov ax,0x1
0000FE9A  EE                out dx,al
0000FE9B  BA74FF            mov dx,0xff74
0000FE9E  EE                out dx,al
0000FE9F  BA58FF            mov dx,0xff58
0000FEA2  B83500            mov ax,0x35
0000FEA5  EE                out dx,al
0000FEA6  BA54FF            mov dx,0xff54
0000FEA9  B83F00            mov ax,0x3f
0000FEAC  EE                out dx,al
0000FEAD  BA5CFF            mov dx,0xff5c
0000FEB0  B80000            mov ax,0x0
0000FEB3  EE                out dx,al
0000FEB4  BA5EFF            mov dx,0xff5e
0000FEB7  B8C000            mov ax,0xc0
0000FEBA  EE                out dx,al
0000FEBB  BA4303            mov dx,0x343
0000FEBE  32C0              xor al,al
0000FEC0  EE                out dx,al
0000FEC1  B80000            mov ax,0x0
0000FEC4  8ED0              mov ss,ax
0000FEC6  BCFEFF            mov sp,0xfffe
0000FEC9  B80F00            mov ax,0xf
0000FECC  BA1CFF            mov dx,0xff1c
0000FECF  EE                out dx,al
0000FED0  BA1EFF            mov dx,0xff1e
0000FED3  EE                out dx,al
0000FED4  BA16FF            mov dx,0xff16
0000FED7  EE                out dx,al
0000FED8  BA18FF            mov dx,0xff18
0000FEDB  B80800            mov ax,0x8
0000FEDE  EE                out dx,al
0000FEDF  BA14FF            mov dx,0xff14
0000FEE2  B80A00            mov ax,0xa
0000FEE5  EE                out dx,al
0000FEE6  BA1AFF            mov dx,0xff1a
0000FEE9  B80C00            mov ax,0xc
0000FEEC  EE                out dx,al
0000FEED  BA12FF            mov dx,0xff12
0000FEF0  B80E00            mov ax,0xe
0000FEF3  EE                out dx,al
0000FEF4  EA000000F6        jmp 0xf600:0x0

; ---- 0x0fef9-0x0ffd0  zero padding  [H07/H21] ----
0000FEF9  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000FF09  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000FF19  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000FF29  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000FF39  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000FF49  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000FF59  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000FF69  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000FF79  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000FF89  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000FF99  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000FFA9  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000FFB9  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000FFC9  00 00 00 00 00 00 00                             |.......|

; ---- 0x0ffd0-0x0ffe1  character-generator font / bitmap data  [H08/H21] ----
0000FFD0  cb 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
0000FFE0  cf                                               |.|

; ---- 0x0ffe1-0x0fff0  zero padding  [H07/H21] ----
0000FFE1  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00     |...............|

; ==== 0x0fff0-0x0fff5  CODE (CF-reached, conf 99) ====
0000FFF0  EA0000E0FF        jmp 0xffe0:0x0

; ---- 0x0fff5-0x10000  zero padding  [H07/H21] ----
0000FFF5  00 00 00 00 00 00 00 00 00 00 00                 |...........|
