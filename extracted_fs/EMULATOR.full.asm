; EMULATOR.EXE - code/data-separated disassembly (MZ load module, 660 B, header 512 B stripped)
; entry @0x0000; 1 relocs. Classified CODE-unless-data-filter-fires
; (recursive descent under-covers C-runtime startups). Bytes: 365 code / 288 string / 7 data.
;

; ---- 0x0000-0x00d7 CODE ----
00000000  1E                push ds
00000001  B81900            mov ax,0x19
00000004  8ED8              mov ds,ax
00000006  B409              mov ah,0x9
00000008  BA1500            mov dx,0x15
0000000B  CD21              int 0x21
0000000D  07                pop es
0000000E  8BDC              mov bx,sp
00000010  83C30F            add bx,byte +0xf
00000013  C1EB04            shr bx,byte 0x4
00000016  8CD0              mov ax,ss
00000018  03D8              add bx,ax
0000001A  8CC0              mov ax,es
0000001C  2BD8              sub bx,ax
0000001E  B44A              mov ah,0x4a
00000020  CD21              int 0x21
00000022  B83200            mov ax,0x32
00000025  A21400            mov [0x14],al
00000028  CD10              int 0x10
0000002A  EB04              jmp short 0x30
0000002C  B400              mov ah,0x0
0000002E  CD40              int 0x40
00000030  B404              mov ah,0x4
00000032  CD40              int 0x40
00000034  8CC0              mov ax,es
00000036  0BC3              or ax,bx
00000038  7505              jnz 0x3f
0000003A  A30E00            mov [0xe],ax
0000003D  EBED              jmp short 0x2c
0000003F  891E1000          mov [0x10],bx
00000043  8C061200          mov [0x12],es
00000047  833E0E0000        cmp word [0xe],byte +0x0
0000004C  7579              jnz 0xc7
0000004E  8C060E00          mov [0xe],es
00000052  53                push bx
00000053  BA1E00            mov dx,0x1e
00000056  BD4000            mov bp,0x40
00000059  268B07            mov ax,[es:bx]
0000005C  43                inc bx
0000005D  43                inc bx
0000005E  86C4              xchg al,ah
00000060  8BF8              mov di,ax
00000062  32C0              xor al,al
00000064  AA                stosb
00000065  2688850080        mov [es:di-0x8000],al
0000006A  8BC5              mov ax,bp
0000006C  AA                stosb
0000006D  45                inc bp
0000006E  B82000            mov ax,0x20
00000071  B98300            mov cx,0x83
00000074  803E140030        cmp byte [0x14],0x30
00000079  7703              ja 0x7e
0000007B  B94F00            mov cx,0x4f
0000007E  2688A50080        mov [es:di-0x8000],ah
00000083  AA                stosb
00000084  E2F8              loop 0x7e
00000086  4A                dec dx
00000087  75D0              jnz 0x59
00000089  5B                pop bx
0000008A  268B07            mov ax,[es:bx]
0000008D  86C4              xchg al,ah
0000008F  8BF8              mov di,ax
00000091  47                inc di
00000092  B98400            mov cx,0x84
00000095  B031              mov al,0x31
00000097  803E140030        cmp byte [0x14],0x30
0000009C  7703              ja 0xa1
0000009E  B95000            mov cx,0x50
000000A1  AA                stosb
000000A2  FEC0              inc al
000000A4  3C39              cmp al,0x39
000000A6  7602              jna 0xaa
000000A8  B030              mov al,0x30
000000AA  E2F5              loop 0xa1
000000AC  268B4714          mov ax,[es:bx+0x14]
000000B0  86C4              xchg al,ah
000000B2  8BF8              mov di,ax
000000B4  47                inc di
000000B5  83C70A            add di,byte +0xa
000000B8  BE1500            mov si,0x15
000000BB  B92800            mov cx,0x28
000000BE  F3A4              rep movsb
000000C0  B402              mov ah,0x2
000000C2  BA0018            mov dx,0x1800
000000C5  CD10              int 0x10
000000C7  B401              mov ah,0x1
000000C9  CD16              int 0x16
000000CB  744C              jz 0x119
000000CD  B400              mov ah,0x0
000000CF  CD16              int 0x16
000000D1  84C0              test al,al
000000D3  7444              jz 0x119
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
00000119  E910FF            jmp 0x2c
0000011C  8AC4              mov al,ah
0000011E  A21400            mov [0x14],al
00000121  B400              mov ah,0x0
00000123  CD10              int 0x10
00000125  C7060E000000      mov word [0xe],0x0
0000012B  E902FF            jmp 0x30
0000012E  B409              mov ah,0x9
00000130  BA4000            mov dx,0x40
00000133  CD21              int 0x21
00000135  B8004C            mov ax,0x4c00
00000138  CD21              int 0x21
0000013A  FE066F00          inc byte [0x6f]
0000013E  FE066F00          inc byte [0x6f]
00000142  FE0E6F00          dec byte [0x6f]
00000146  A06F00            mov al,[0x6f]
00000149  B420              mov ah,0x20
0000014B  CD40              int 0x40
0000014D  E9DCFE            jmp 0x2c
00000150  33D2              xor dx,dx
00000152  BE7000            mov si,0x70
00000155  EB06              jmp short 0x15d
00000157  BA0100            mov dx,0x1
0000015A  BEBB00            mov si,0xbb
0000015D  B402              mov ah,0x2
0000015F  CD17              int 0x17
00000161  80F480            xor ah,0x80
00000164  F6C4A9            test ah,0xa9
00000167  7426              jz 0x18f
00000169  B400              mov ah,0x0
0000016B  CD40              int 0x40
0000016D  720A              jc 0x179
0000016F  B404              mov ah,0x4
00000171  CD40              int 0x40
00000173  8CC0              mov ax,es
00000175  0BC3              or ax,bx
00000177  75E4              jnz 0x15d
00000179  E9B0FE            jmp 0x2c
0000017C  B434              mov ah,0x34
0000017E  3C64              cmp al,0x64
00000180  B002              mov al,0x2
00000182  7206              jc 0x18a
00000184  B000              mov al,0x0
00000186  7402              jz 0x18a
00000188  B001              mov al,0x1
0000018A  CD40              int 0x40
0000018C  E99DFE            jmp 0x2c
0000018F  AC                lodsb
00000190  3C24              cmp al,0x24
00000192  7503              jnz 0x197
00000194  E995FE            jmp 0x2c
00000197  32E4              xor ah,ah
00000199  CD17              int 0x17
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
