; DOWNLOAD.EXE - MS-DOS MZ executable extracted from LT300/UT200 ROM
; image 2042 B, header 512 B (32 paragraphs)
; entry CS:IP = 0x0000:0x0000  SS:SP = 0x0060:0x0400
; 1 relocations: 0x0000:0x0002
; load module disassembled below (origin = CS base 0x0); >>> marks entry point
;
; --- MZ header (512 bytes) ---
; 0000  4d 5a fa 01 04 00 01 00 20 00 41 00 ff ff 60 00  MZ...... .A...`.
; 0010  00 04 03 eb 00 00 00 00 1e 00 00 00 01 00 02 00  ................
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
    00000001  B83B00            mov ax,0x3b
    00000004  8ED8              mov ds,ax
    00000006  B409              mov ah,0x9
    00000008  BAD500            mov dx,0xd5
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
    00000022  B80700            mov ax,0x7
    00000025  CD10              int 0x10
    00000027  B448              mov ah,0x48
    00000029  BB0020            mov bx,0x2000
    0000002C  CD21              int 0x21
    0000002E  7224              jc 0x54
    00000030  A31C00            mov [0x1c],ax
    00000033  B448              mov ah,0x48
    00000035  BB001C            mov bx,0x1c00
    00000038  CD21              int 0x21
    0000003A  7218              jc 0x54
    0000003C  8EC0              mov es,ax
    0000003E  B9001C            mov cx,0x1c00
    00000041  B42E              mov ah,0x2e
    00000043  CD40              int 0x40
    00000045  E81800            call 0x60
    00000048  E8B101            call 0x1fc
    0000004B  E8CB01            call 0x219
    0000004E  B400              mov ah,0x0
    00000050  CD40              int 0x40
    00000052  EBF1              jmp short 0x45
    00000054  B409              mov ah,0x9
    00000056  BAFC00            mov dx,0xfc
    00000059  CD21              int 0x21
    0000005B  B8014C            mov ax,0x4c01
    0000005E  CD21              int 0x21
    00000060  B42C              mov ah,0x2c
    00000062  CD40              int 0x40
    00000064  7301              jnc 0x67
    00000066  C3                ret
    00000067  84E4              test ah,ah
    00000069  756B              jnz 0xd6
    0000006B  FE063701          inc byte [0x137]
    0000006F  8026370103        and byte [0x137],0x3
    00000074  FF161200          call [0x12]
    00000078  EBE6              jmp short 0x60
    0000007A  3C02              cmp al,0x2
    0000007C  7506              jnz 0x84
    0000007E  C70612008500      mov word [0x12],0x85
    00000084  C3                ret
    00000085  A23A01            mov [0x13a],al
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
    000000A8  741E              jz 0xc8
    000000AA  C7061200B100      mov word [0x12],0xb1
    000000B0  C3                ret
    000000B1  8B3E1A00          mov di,[0x1a]
    000000B5  8805              mov [di],al
    000000B7  47                inc di
    000000B8  893E1A00          mov [0x1a],di
    000000BC  32E4              xor ah,ah
    000000BE  01061800          add [0x18],ax
    000000C2  FE0E3C01          dec byte [0x13c]
    000000C6  75BC              jnz 0x84
    000000C8  C7061200E600      mov word [0x12],0xe6
    000000CE  C3                ret
    000000CF  C606380160        mov byte [0x138],0x60
    000000D4  EB05              jmp short 0xdb
    000000D6  C606380140        mov byte [0x138],0x40
    000000DB  FF062800          inc word [0x28]
    000000DF  C70612007A00      mov word [0x12],0x7a
    000000E5  C3                ret
    000000E6  3C03              cmp al,0x3
    000000E8  75E5              jnz 0xcf
    000000EA  C7061200F100      mov word [0x12],0xf1
    000000F0  C3                ret
    000000F1  3A061800          cmp al,[0x18]
    000000F5  75D8              jnz 0xcf
    000000F7  C7061200FE00      mov word [0x12],0xfe
    000000FD  C3                ret
    000000FE  3A061900          cmp al,[0x19]
    00000102  75CB              jnz 0xcf
    00000104  C70612007A00      mov word [0x12],0x7a
    0000010A  FF261400          jmp [0x14]
    0000010E  A03B01            mov al,[0x13b]
    00000111  3C0C              cmp al,0xc
    00000113  7540              jnz 0x155
    00000115  BE4A01            mov si,0x14a
    00000118  A03A01            mov al,[0x13a]
    0000011B  3C0F              cmp al,0xf
    0000011D  7536              jnz 0x155
    0000011F  1E                push ds
    00000120  07                pop es
    00000121  BF3D01            mov di,0x13d
    00000124  B90C00            mov cx,0xc
    00000127  F3A4              rep movsb
    00000129  33C0              xor ax,ax
    0000012B  A23901            mov [0x139],al
    0000012E  A32600            mov [0x26],ax
    00000131  A32800            mov [0x28],ax
    00000134  A31E00            mov [0x1e],ax
    00000137  A32000            mov [0x20],ax
    0000013A  A32200            mov [0x22],ax
    0000013D  A11C00            mov ax,[0x1c]
    00000140  A32400            mov [0x24],ax
    00000143  C606380130        mov byte [0x138],0x30
    00000148  C70616004200      mov word [0x16],0x42
    0000014E  C70614005F01      mov word [0x14],0x15f
    00000154  C3                ret
    00000155  C606380120        mov byte [0x138],0x20
    0000015A  FF062800          inc word [0x28]
    0000015E  C3                ret
    0000015F  BE4A01            mov si,0x14a
    00000162  A03A01            mov al,[0x13a]
    00000165  3C0F              cmp al,0xf
    00000167  74A5              jz 0x10e
    00000169  3A063901          cmp al,[0x139]
    0000016D  7537              jnz 0x1a6
    0000016F  8A0E3B01          mov cl,[0x13b]
    00000173  32ED              xor ch,ch
    00000175  E335              jcxz 0x1ac
    00000177  C43E2200          les di,[0x22]
    0000017B  010E1E00          add [0x1e],cx
    0000017F  8316200000        adc word [0x20],byte +0x0
    00000184  F3A4              rep movsb
    00000186  8BC7              mov ax,di
    00000188  250F00            and ax,0xf
    0000018B  C1EF04            shr di,byte 0x4
    0000018E  8CC3              mov bx,es
    00000190  03DF              add bx,di
    00000192  A32200            mov [0x22],ax
    00000195  891E2400          mov [0x24],bx
    00000199  FE063901          inc byte [0x139]
    0000019D  8026390107        and byte [0x139],0x7
    000001A2  FF062600          inc word [0x26]
    000001A6  C606380130        mov byte [0x138],0x30
    000001AB  C3                ret
    000001AC  C60639010F        mov byte [0x139],0xf
    000001B1  C606380130        mov byte [0x138],0x30
    000001B6  C70616005A00      mov word [0x16],0x5a
    000001BC  C70614000E01      mov word [0x14],0x10e
    000001C2  C606370104        mov byte [0x137],0x4
    000001C7  E83200            call 0x1fc
    000001CA  E84C00            call 0x219
    000001CD  BE3D01            mov si,0x13d
    000001D0  8E061C00          mov es,[0x1c]
    000001D4  33DB              xor bx,bx
    000001D6  8B0E2000          mov cx,[0x20]
    000001DA  8B161E00          mov dx,[0x1e]
    000001DE  B406              mov ah,0x6
    000001E0  CD40              int 0x40
    000001E2  720C              jc 0x1f0
    000001E4  C70616007200      mov word [0x16],0x72
    000001EA  C606380150        mov byte [0x138],0x50
    000001EF  C3                ret
    000001F0  C70616008A00      mov word [0x16],0x8a
    000001F6  C606380170        mov byte [0x138],0x70
    000001FB  C3                ret
    000001FC  A03801            mov al,[0x138]
    000001FF  84C0              test al,al
    00000201  7501              jnz 0x204
    00000203  C3                ret
    00000204  8A263901          mov ah,[0x139]
    00000208  80E40F            and ah,0xf
    0000020B  0AC4              or al,ah
    0000020D  B430              mov ah,0x30
    0000020F  CD40              int 0x40
    00000211  7205              jc 0x218
    00000213  C606380100        mov byte [0x138],0x0
    00000218  C3                ret
    00000219  B404              mov ah,0x4
    0000021B  CD40              int 0x40
    0000021D  8CC0              mov ax,es
    0000021F  0BC3              or ax,bx
    00000221  7504              jnz 0x227
    00000223  A30C00            mov [0xc],ax
    00000226  C3                ret
    00000227  891E0E00          mov [0xe],bx
    0000022B  8C061000          mov [0x10],es
    0000022F  833E0C0000        cmp word [0xc],byte +0x0
    00000234  7529              jnz 0x25f
    00000236  8C060C00          mov [0xc],es
    0000023A  53                push bx
    0000023B  BA1E00            mov dx,0x1e
    0000023E  268B07            mov ax,[es:bx]
    00000241  43                inc bx
    00000242  43                inc bx
    00000243  86C4              xchg al,ah
    00000245  8BF8              mov di,ax
    00000247  32C0              xor al,al
    00000249  AA                stosb
    0000024A  B82000            mov ax,0x20
    0000024D  B98400            mov cx,0x84
    00000250  2688A50080        mov [es:di-0x8000],ah
    00000255  AA                stosb
    00000256  E2F8              loop 0x250
    00000258  4A                dec dx
    00000259  75E3              jnz 0x23e
    0000025B  5B                pop bx
    0000025C  E8E300            call 0x342
    0000025F  C41E0E00          les bx,[0xe]
    00000263  268B4708          mov ax,[es:bx+0x8]
    00000267  86C4              xchg al,ah
    00000269  8BF8              mov di,ax
    0000026B  83C71E            add di,byte +0x1e
    0000026E  8B361600          mov si,[0x16]
    00000272  E88C00            call 0x301
    00000275  268B470C          mov ax,[es:bx+0xc]
    00000279  86C4              xchg al,ah
    0000027B  8BF8              mov di,ax
    0000027D  83C726            add di,byte +0x26
    00000280  53                push bx
    00000281  BB3201            mov bx,0x132
    00000284  A03701            mov al,[0x137]
    00000287  D7                xlatb
    00000288  AA                stosb
    00000289  5B                pop bx
    0000028A  268B4710          mov ax,[es:bx+0x10]
    0000028E  86C4              xchg al,ah
    00000290  8BF8              mov di,ax
    00000292  83C71B            add di,byte +0x1b
    00000295  BEA200            mov si,0xa2
    00000298  E86600            call 0x301
    0000029B  BE3D01            mov si,0x13d
    0000029E  E86000            call 0x301
    000002A1  268B4714          mov ax,[es:bx+0x14]
    000002A5  86C4              xchg al,ah
    000002A7  8BF8              mov di,ax
    000002A9  83C71B            add di,byte +0x1b
    000002AC  BEA900            mov si,0xa9
    000002AF  E84F00            call 0x301
    000002B2  A12600            mov ax,[0x26]
    000002B5  33D2              xor dx,dx
    000002B7  E84D00            call 0x307
    000002BA  E83B00            call 0x2f8
    000002BD  268B4718          mov ax,[es:bx+0x18]
    000002C1  86C4              xchg al,ah
    000002C3  8BF8              mov di,ax
    000002C5  83C71B            add di,byte +0x1b
    000002C8  BEBB00            mov si,0xbb
    000002CB  E83300            call 0x301
    000002CE  A11E00            mov ax,[0x1e]
    000002D1  8B162000          mov dx,[0x20]
    000002D5  E82F00            call 0x307
    000002D8  E81D00            call 0x2f8
    000002DB  268B471C          mov ax,[es:bx+0x1c]
    000002DF  86C4              xchg al,ah
    000002E1  8BF8              mov di,ax
    000002E3  83C71B            add di,byte +0x1b
    000002E6  BECC00            mov si,0xcc
    000002E9  E81500            call 0x301
    000002EC  A12800            mov ax,[0x28]
    000002EF  33D2              xor dx,dx
    000002F1  E81300            call 0x307
    000002F4  E80100            call 0x2f8
    000002F7  C3                ret
    000002F8  B82020            mov ax,0x2020
    000002FB  AB                stosw
    000002FC  AB                stosw
    000002FD  AB                stosw
    000002FE  AB                stosw
    000002FF  C3                ret
    00000300  AA                stosb
    00000301  AC                lodsb
    00000302  84C0              test al,al
    00000304  75FA              jnz 0x300
    00000306  C3                ret
    00000307  33ED              xor bp,bp
    00000309  B91027            mov cx,0x2710
    0000030C  F7F1              div cx
    0000030E  85C0              test ax,ax
    00000310  7405              jz 0x317
    00000312  52                push dx
    00000313  E80300            call 0x319
    00000316  5A                pop dx
    00000317  8BC2              mov ax,dx
    00000319  B9E803            mov cx,0x3e8
    0000031C  E81000            call 0x32f
    0000031F  B96400            mov cx,0x64
    00000322  E80A00            call 0x32f
    00000325  B90A00            mov cx,0xa
    00000328  E80400            call 0x32f
    0000032B  B90100            mov cx,0x1
    0000032E  45                inc bp
    0000032F  33D2              xor dx,dx
    00000331  F7F1              div cx
    00000333  85ED              test bp,bp
    00000335  7505              jnz 0x33c
    00000337  85C0              test ax,ax
    00000339  7404              jz 0x33f
    0000033B  45                inc bp
    0000033C  0430              add al,0x30
    0000033E  AA                stosb
    0000033F  8BC2              mov ax,dx
    00000341  C3                ret
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
    00000360  2688A50080        mov [es:di-0x8000],ah
    00000365  AA                stosb
    00000366  E2F8              loop 0x360
    00000368  B03B              mov al,0x3b
    0000036A  2688A50080        mov [es:di-0x8000],ah
    0000036F  AA                stosb
    00000370  B90F00            mov cx,0xf
    00000373  268B17            mov dx,[es:bx]
    00000376  83C302            add bx,byte +0x2
    00000379  86D6              xchg dl,dh
    0000037B  8BFA              mov di,dx
    0000037D  83C715            add di,byte +0x15
    00000380  B03A              mov al,0x3a
    00000382  2688A50080        mov [es:di-0x8000],ah
    00000387  AA                stosb
    00000388  83C728            add di,byte +0x28
    0000038B  2688A50080        mov [es:di-0x8000],ah
    00000390  AA                stosb
    00000391  E2E0              loop 0x373
    00000393  268B17            mov dx,[es:bx]
    00000396  86D6              xchg dl,dh
    00000398  8BFA              mov di,dx
    0000039A  83C715            add di,byte +0x15
    0000039D  B048              mov al,0x48
    0000039F  2688A50080        mov [es:di-0x8000],ah
    000003A4  AA                stosb
    000003A5  B04D              mov al,0x4d
    000003A7  B92800            mov cx,0x28
    000003AA  2688A50080        mov [es:di-0x8000],ah
    000003AF  AA                stosb
    000003B0  E2F8              loop 0x3aa
    000003B2  B03C              mov al,0x3c
    000003B4  2688A50080        mov [es:di-0x8000],ah
    000003B9  AA                stosb
    000003BA  5B                pop bx
    000003BB  C3                ret
    000003BC  0000              add [bx+si],al
    000003BE  0000              add [bx+si],al
    000003C0  0000              add [bx+si],al
    000003C2  7A00              jpe 0x3c4
    000003C4  0E                push cs
    000003C5  012A              add [bp+si],bp
    000003C7  0000              add [bx+si],al
    000003C9  004A01            add [bp+si+0x1],cl
    000003CC  0000              add [bx+si],al
    000003CE  0000              add [bx+si],al
    000003D0  0000              add [bx+si],al
    000003D2  0000              add [bx+si],al
    000003D4  0000              add [bx+si],al
    000003D6  0000              add [bx+si],al
    000003D8  0000              add [bx+si],al
    000003DA  54                push sp
    000003DB  7261              jc 0x43e
    000003DD  6E                outsb
    000003DE  7366              jnc 0x446
    000003E0  657220            gs jc 0x403
    000003E3  49                dec cx
    000003E4  4E                dec si
    000003E5  41                inc cx
    000003E6  43                inc bx
    000003E7  54                push sp
    000003E8  49                dec cx
    000003E9  56                push si
    000003EA  45                inc bp
    000003EB  2020              and [bx+si],ah
    000003ED  2020              and [bx+si],ah
    000003EF  2020              and [bx+si],ah
    000003F1  004669            add [bp+0x69],al
    000003F4  6C                insb
    000003F5  65205472          and [gs:si+0x72],dl
    000003F9  61                popa
    000003FA  6E                outsb
    000003FB  7366              jnc 0x463
    000003FD  657220            gs jc 0x420
    00000400  41                inc cx
    00000401  43                inc bx
    00000402  54                push sp
    00000403  49                dec cx
    00000404  56                push si
    00000405  45                inc bp
    00000406  2020              and [bx+si],ah
    00000408  2000              and [bx+si],al
    0000040A  46                inc si
    0000040B  696C652042        imul bp,[si+0x65],word 0x4220
    00000410  65696E672057      imul bp,[gs:bp+0x67],word 0x5720
    00000416  52                push dx
    00000417  49                dec cx
    00000418  54                push sp
    00000419  54                push sp
    0000041A  45                inc bp
    0000041B  4E                dec si
    0000041C  2020              and [bx+si],ah
    0000041E  2020              and [bx+si],ah
    00000420  2000              and [bx+si],al
    00000422  46                inc si
    00000423  696C652054        imul bp,[si+0x65],word 0x5420
    00000428  7261              jc 0x48b
    0000042A  6E                outsb
    0000042B  7366              jnc 0x493
    0000042D  657220            gs jc 0x450
    00000430  43                inc bx
    00000431  4F                dec di
    00000432  4D                dec bp
    00000433  50                push ax
    00000434  4C                dec sp
    00000435  45                inc bp
    00000436  54                push sp
    00000437  45                inc bp
    00000438  2000              and [bx+si],al
    0000043A  46                inc si
    0000043B  696C652054        imul bp,[si+0x65],word 0x5420
    00000440  7261              jc 0x4a3
    00000442  6E                outsb
    00000443  7366              jnc 0x4ab
    00000445  657220            gs jc 0x468
    00000448  46                inc si
    00000449  41                inc cx
    0000044A  49                dec cx
    0000044B  4C                dec sp
    0000044C  45                inc bp
    0000044D  44                inc sp
    0000044E  2121              and [bx+di],sp
    00000450  2100              and [bx+si],ax
    00000452  46                inc si
    00000453  696C653A20        imul bp,[si+0x65],word 0x203a
    00000458  00426C            add [bp+si+0x6c],al
    0000045B  6F                outsw
    0000045C  636B73            arpl [bp+di+0x73],bp
    0000045F  205265            and [bp+si+0x65],dl
    00000462  636569            arpl [di+0x69],sp
    00000465  7665              jna 0x4cc
    00000467  643A20            cmp ah,[fs:bx+si]
    0000046A  004279            add [bp+si+0x79],al
    0000046D  7465              jz 0x4d4
    0000046F  7320              jnc 0x491
    00000471  52                push dx
    00000472  65636569          arpl [gs:di+0x69],sp
    00000476  7665              jna 0x4dd
    00000478  643A20            cmp ah,[fs:bx+si]
    0000047B  004572            add [di+0x72],al
    0000047E  726F              jc 0x4ef
    00000480  7273              jc 0x4f5
    00000482  3A20              cmp ah,[bx+si]
    00000484  004669            add [bp+0x69],al
    00000487  6C                insb
    00000488  65205472          and [gs:si+0x72],dl
    0000048C  61                popa
    0000048D  6E                outsb
    0000048E  7366              jnc 0x4f6
    00000490  657220            gs jc 0x4b3
    00000493  56                push si
    00000494  657273            gs jc 0x50a
    00000497  696F6E2030        imul bp,[bx+0x6e],word 0x3020
    0000049C  2E3320            xor sp,[cs:bx+si]
    0000049F  6973204163        imul si,[bp+di+0x20],word 0x6341
    000004A4  7469              jz 0x50f
    000004A6  7665              jna 0x50d
    000004A8  2E0D0A24          cs or ax,0x240a
    000004AC  46                inc si
    000004AD  696C652054        imul bp,[si+0x65],word 0x5420
    000004B2  7261              jc 0x515
    000004B4  6E                outsb
    000004B5  7366              jnc 0x51d
    000004B7  657220            gs jc 0x4da
    000004BA  6973205465        imul si,[bp+di+0x20],word 0x6554
    000004BF  726D              jc 0x52e
    000004C1  696E617469        imul bp,[bp+0x61],word 0x6974
    000004C6  6E                outsb
    000004C7  6720647565        and [dword ebp+esi*2+0x65],ah
    000004CC  20746F            and [si+0x6f],dh
    000004CF  204C61            and [si+0x61],cl
    000004D2  636B20            arpl [bp+di+0x20],bp
    000004D5  6F                outsw
    000004D6  66204D65          o32 and [di+0x65],cl
    000004DA  6D                insw
    000004DB  6F                outsw
    000004DC  7279              jc 0x557
    000004DE  2E0D0A24          cs or ax,0x240a
    000004E2  2F                das
    000004E3  2D5C7C            sub ax,0x7c5c
    000004E6  2004              and [si],al
    000004E8  000F              add [bx],cl
    000004EA  0000              add [bx+si],al
    000004EC  0020              add [bx+si],ah
    000004EE  2020              and [bx+si],ah
    000004F0  2020              and [bx+si],ah
    000004F2  2020              and [bx+si],ah
    000004F4  2020              and [bx+si],ah
    000004F6  2020              and [bx+si],ah
    000004F8  2000              and [bx+si],al
    000004FA  0000              add [bx+si],al
    000004FC  0000              add [bx+si],al
    000004FE  0000              add [bx+si],al
    00000500  0000              add [bx+si],al
    00000502  0000              add [bx+si],al
    00000504  0000              add [bx+si],al
    00000506  0000              add [bx+si],al
    00000508  0000              add [bx+si],al
    0000050A  0000              add [bx+si],al
    0000050C  0000              add [bx+si],al
    0000050E  0000              add [bx+si],al
    00000510  0000              add [bx+si],al
    00000512  0000              add [bx+si],al
    00000514  0000              add [bx+si],al
    00000516  0000              add [bx+si],al
    00000518  0000              add [bx+si],al
    0000051A  0000              add [bx+si],al
    0000051C  0000              add [bx+si],al
    0000051E  0000              add [bx+si],al
    00000520  0000              add [bx+si],al
    00000522  0000              add [bx+si],al
    00000524  0000              add [bx+si],al
    00000526  0000              add [bx+si],al
    00000528  0000              add [bx+si],al
    0000052A  0000              add [bx+si],al
    0000052C  0000              add [bx+si],al
    0000052E  0000              add [bx+si],al
    00000530  0000              add [bx+si],al
    00000532  0000              add [bx+si],al
    00000534  0000              add [bx+si],al
    00000536  0000              add [bx+si],al
    00000538  0000              add [bx+si],al
    0000053A  0000              add [bx+si],al
    0000053C  0000              add [bx+si],al
    0000053E  0000              add [bx+si],al
    00000540  0000              add [bx+si],al
    00000542  0000              add [bx+si],al
    00000544  0000              add [bx+si],al
    00000546  0000              add [bx+si],al
    00000548  0000              add [bx+si],al
    0000054A  0000              add [bx+si],al
    0000054C  0000              add [bx+si],al
    0000054E  0000              add [bx+si],al
    00000550  0000              add [bx+si],al
    00000552  0000              add [bx+si],al
    00000554  0000              add [bx+si],al
    00000556  0000              add [bx+si],al
    00000558  0000              add [bx+si],al
    0000055A  0000              add [bx+si],al
    0000055C  0000              add [bx+si],al
    0000055E  0000              add [bx+si],al
    00000560  0000              add [bx+si],al
    00000562  0000              add [bx+si],al
    00000564  0000              add [bx+si],al
    00000566  0000              add [bx+si],al
    00000568  0000              add [bx+si],al
    0000056A  0000              add [bx+si],al
    0000056C  0000              add [bx+si],al
    0000056E  0000              add [bx+si],al
    00000570  0000              add [bx+si],al
    00000572  0000              add [bx+si],al
    00000574  0000              add [bx+si],al
    00000576  0000              add [bx+si],al
    00000578  0000              add [bx+si],al
    0000057A  0000              add [bx+si],al
    0000057C  0000              add [bx+si],al
    0000057E  0000              add [bx+si],al
    00000580  0000              add [bx+si],al
    00000582  0000              add [bx+si],al
    00000584  0000              add [bx+si],al
    00000586  0000              add [bx+si],al
    00000588  0000              add [bx+si],al
    0000058A  0000              add [bx+si],al
    0000058C  0000              add [bx+si],al
    0000058E  0000              add [bx+si],al
    00000590  0000              add [bx+si],al
    00000592  0000              add [bx+si],al
    00000594  0000              add [bx+si],al
    00000596  0000              add [bx+si],al
    00000598  0000              add [bx+si],al
    0000059A  0000              add [bx+si],al
    0000059C  0000              add [bx+si],al
    0000059E  0000              add [bx+si],al
    000005A0  0000              add [bx+si],al
    000005A2  0000              add [bx+si],al
    000005A4  0000              add [bx+si],al
    000005A6  0000              add [bx+si],al
    000005A8  0000              add [bx+si],al
    000005AA  0000              add [bx+si],al
    000005AC  0000              add [bx+si],al
    000005AE  0000              add [bx+si],al
    000005B0  0000              add [bx+si],al
    000005B2  0000              add [bx+si],al
    000005B4  0000              add [bx+si],al
    000005B6  0000              add [bx+si],al
    000005B8  0000              add [bx+si],al
    000005BA  0000              add [bx+si],al
    000005BC  0000              add [bx+si],al
    000005BE  0000              add [bx+si],al
    000005C0  0000              add [bx+si],al
    000005C2  0000              add [bx+si],al
    000005C4  0000              add [bx+si],al
    000005C6  0000              add [bx+si],al
    000005C8  0000              add [bx+si],al
    000005CA  0000              add [bx+si],al
    000005CC  0000              add [bx+si],al
    000005CE  0000              add [bx+si],al
    000005D0  0000              add [bx+si],al
    000005D2  0000              add [bx+si],al
    000005D4  0000              add [bx+si],al
    000005D6  0000              add [bx+si],al
    000005D8  0000              add [bx+si],al
    000005DA  0000              add [bx+si],al
    000005DC  0000              add [bx+si],al
    000005DE  0000              add [bx+si],al
    000005E0  0000              add [bx+si],al
    000005E2  0000              add [bx+si],al
    000005E4  0000              add [bx+si],al
    000005E6  0000              add [bx+si],al
    000005E8  0000              add [bx+si],al
    000005EA  0000              add [bx+si],al
    000005EC  0000              add [bx+si],al
    000005EE  0000              add [bx+si],al
    000005F0  0000              add [bx+si],al
    000005F2  0000              add [bx+si],al
    000005F4  0000              add [bx+si],al
    000005F6  0000              add [bx+si],al
    000005F8  0000              add [bx+si],al
