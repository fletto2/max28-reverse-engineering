; EMULATOR.EXE - MS-DOS MZ executable extracted from LT300/UT200 ROM
; image 1172 B, header 512 B (32 paragraphs)
; entry CS:IP = 0x0000:0x0000  SS:SP = 0x002a:0x0400
; 1 relocations: 0x0000:0x0002
; load module disassembled below (origin = CS base 0x0); >>> marks entry point
;
; --- MZ header (512 bytes) ---
; 0000  4d 5a 94 00 03 00 01 00 20 00 41 00 ff ff 2a 00  MZ...... .A...*.
; 0010  00 04 2f e3 00 00 00 00 1e 00 00 00 01 00 02 00  ../.............
; 0020  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
; 0030  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
; 0040  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
; 0050  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
; 0060  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
; 0070  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
; 0080  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
; 0090  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
; 00A0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
; 00B0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
; 00C0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
; 00D0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
; 00E0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
; 00F0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
; 0100  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
; 0110  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
; 0120  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
; 0130  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
; 0140  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
; 0150  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
; 0160  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
; 0170  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
; 0180  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
; 0190  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
; 01A0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
; 01B0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
; 01C0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
; 01D0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
; 01E0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
; 01F0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
;
; --- code/data (load module) ---
>>> 00000000  1E                push ds
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
    000000D7  3C35              cmp al,0x35
    000000D9  7441              jz 0x11c
    000000DB  B427              mov ah,0x27
    000000DD  3C37              cmp al,0x37
    000000DF  743B              jz 0x11c
    000000E1  B430              mov ah,0x30
    000000E3  3C33              cmp al,0x33
    000000E5  7435              jz 0x11c
    000000E7  B432              mov ah,0x32
    000000E9  3C32              cmp al,0x32
    000000EB  742F              jz 0x11c
    000000ED  B434              mov ah,0x34
    000000EF  3C34              cmp al,0x34
    000000F1  7429              jz 0x11c
    000000F3  B437              mov ah,0x37
    000000F5  3C36              cmp al,0x36
    000000F7  7423              jz 0x11c
    000000F9  3C2B              cmp al,0x2b
    000000FB  743D              jz 0x13a
    000000FD  3C2D              cmp al,0x2d
    000000FF  7441              jz 0x142
    00000101  3C1B              cmp al,0x1b
    00000103  7429              jz 0x12e
    00000105  3C70              cmp al,0x70
    00000107  7447              jz 0x150
    00000109  3C73              cmp al,0x73
    0000010B  744A              jz 0x157
    0000010D  3C62              cmp al,0x62
    0000010F  746B              jz 0x17c
    00000111  3C64              cmp al,0x64
    00000113  7467              jz 0x17c
    00000115  3C65              cmp al,0x65
    00000117  7463              jz 0x17c
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
    0000019D  0000              add [bx+si],al
    0000019F  0000              add [bx+si],al
    000001A1  0000              add [bx+si],al
    000001A3  0007              add [bx],al
    000001A5  54                push sp
    000001A6  686520            push word 0x2065
    000001A9  45                inc bp
    000001AA  6D                insw
    000001AB  756C              jnz 0x219
    000001AD  61                popa
    000001AE  746F              jz 0x21f
    000001B0  7220              jc 0x1d2
    000001B2  285665            sub [bp+0x65],dl
    000001B5  7273              jc 0x22a
    000001B7  696F6E2030        imul bp,[bx+0x6e],word 0x3020
    000001BC  2E3137            xor [cs:bx],si
    000001BF  37                aaa
    000001C0  2920              sub [bx+si],sp
    000001C2  6973205275        imul si,[bp+di+0x20],word 0x7552
    000001C7  6E                outsb
    000001C8  6E                outsb
    000001C9  696E672E0D        imul bp,[bp+0x67],word 0xd2e
    000001CE  0A24              or ah,[si]
    000001D0  54                push sp
    000001D1  686520            push word 0x2065
    000001D4  45                inc bp
    000001D5  6D                insw
    000001D6  756C              jnz 0x244
    000001D8  61                popa
    000001D9  746F              jz 0x24a
    000001DB  7220              jc 0x1fd
    000001DD  285665            sub [bp+0x65],dl
    000001E0  7273              jc 0x255
    000001E2  696F6E2030        imul bp,[bx+0x6e],word 0x3020
    000001E7  2E3137            xor [cs:bx],si
    000001EA  37                aaa
    000001EB  2920              sub [bx+si],sp
    000001ED  6973205465        imul si,[bp+di+0x20],word 0x6554
    000001F2  726D              jc 0x261
    000001F4  696E617469        imul bp,[bp+0x61],word 0x6974
    000001F9  6E                outsb
    000001FA  672E0D0A24        cs or ax,0x240a
    000001FF  005468            add [si+0x68],dl
    00000202  6973206973        imul si,[bp+di+0x20],word 0x7369
    00000207  206120            and [bx+di+0x20],ah
    0000020A  7465              jz 0x271
    0000020C  7374              jnc 0x282
    0000020E  206F66            and [bx+0x66],ch
    00000211  207468            and [si+0x68],dh
    00000214  65205061          and [gs:bx+si+0x61],dl
    00000218  7261              jc 0x27b
    0000021A  6C                insb
    0000021B  6C                insb
    0000021C  656C              gs insb
    0000021E  205072            and [bx+si+0x72],dl
    00000221  696E746572        imul bp,[bp+0x74],word 0x7265
    00000226  20506F            and [bx+si+0x6f],dl
    00000229  7274              jc 0x29f
    0000022B  206F66            and [bx+0x66],ch
    0000022E  207468            and [si+0x68],dh
    00000231  65204C54          and [gs:si+0x54],cl
    00000235  3330              xor si,[bx+si]
    00000237  302F              xor [bx],ch
    00000239  55                push bp
    0000023A  54                push sp
    0000023B  3230              xor dh,[bx+si]
    0000023D  3020              xor [bx+si],ah
    0000023F  54                push sp
    00000240  65726D            gs jc 0x2b0
    00000243  696E616C2E        imul bp,[bp+0x61],word 0x2e6c
    00000248  0D0A24            or ax,0x240a
    0000024B  54                push sp
    0000024C  686973            push word 0x7369
    0000024F  206973            and [bx+di+0x73],ch
    00000252  206120            and [bx+di+0x20],ah
    00000255  7465              jz 0x2bc
    00000257  7374              jnc 0x2cd
    00000259  206F66            and [bx+0x66],ch
    0000025C  207468            and [si+0x68],dh
    0000025F  65205365          and [gs:bp+di+0x65],dl
    00000263  7269              jc 0x2ce
    00000265  61                popa
    00000266  6C                insb
    00000267  205072            and [bx+si+0x72],dl
    0000026A  696E746572        imul bp,[bp+0x74],word 0x7265
    0000026F  20506F            and [bx+si+0x6f],dl
    00000272  7274              jc 0x2e8
    00000274  206F66            and [bx+0x66],ch
    00000277  207468            and [si+0x68],dh
    0000027A  65204C54          and [gs:si+0x54],cl
    0000027E  3330              xor si,[bx+si]
    00000280  302F              xor [bx],ch
    00000282  55                push bp
    00000283  54                push sp
    00000284  3230              xor dh,[bx+si]
    00000286  3020              xor [bx+si],ah
    00000288  54                push sp
    00000289  65726D            gs jc 0x2f9
    0000028C  696E616C2E        imul bp,[bp+0x61],word 0x2e6c
    00000291  0D0A24            or ax,0x240a
