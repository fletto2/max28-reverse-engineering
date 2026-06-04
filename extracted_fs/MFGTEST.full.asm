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
00000061  AC                lodsb
00000062  03D0              add dx,ax
00000064  0BF6              or si,si
00000066  75F9              jnz 0x61
00000068  81FB00E0          cmp bx,0xe000
0000006C  7508              jnz 0x76
0000006E  8BCA              mov cx,dx
00000070  81C30010          add bx,0x1000
00000074  EBE5              jmp short 0x5b
00000076  58                pop ax
00000077  8ED8              mov ds,ax
00000079  8EC0              mov es,ax
0000007B  8D3EAB01          lea di,[0x1ab]
0000007F  3BCA              cmp cx,dx
00000081  7402              jz 0x85
00000083  03D1              add dx,cx
00000085  B90400            mov cx,0x4
00000088  B80F00            mov ax,0xf
0000008B  C1C204            rol dx,byte 0x4
0000008E  23C2              and ax,dx
00000090  8BF0              mov si,ax
00000092  8A848501          mov al,[si+0x185]
00000096  AA                stosb
00000097  E2EF              loop 0x88
00000099  E84410            call 0x10e0
0000009C  E85110            call 0x10f0
0000009F  E85910            call 0x10fb
000000A2  E87F11            call 0x1224
000000A5  E8FA11            call 0x12a2
000000A8  E8BB10            call 0x1166
000000AB  E8450F            call 0xff3
000000AE  E83F10            call 0x10f0
000000B1  32DB              xor bl,bl
000000B3  881E5902          mov [0x259],bl
000000B7  BA08FF            mov dx,0xff08
000000BA  ED                in ax,dx
000000BB  25BFFF            and ax,0xffbf
000000BE  EF                out dx,ax
000000BF  B80200            mov ax,0x2
000000C2  E8670F            call 0x102c
000000C5  0A1E5902          or bl,[0x259]
000000C9  751F              jnz 0xea
000000CB  E8250F            call 0xff3
000000CE  E8770F            call 0x1048
000000D1  75F2              jnz 0xc5
000000D3  0A1E5902          or bl,[0x259]
000000D7  7511              jnz 0xea
000000D9  750F              jnz 0xea
000000DB  B80100            mov ax,0x1
000000DE  A32A01            mov [0x12a],ax
000000E1  D1E0              shl ax,1
000000E3  09060A01          or [0x10a],ax
000000E7  EB01              jmp short 0xea
000000E9  90                nop
000000EA  E8060F            call 0xff3
000000ED  BB0000            mov bx,0x0
000000F0  E8B00D            call 0xea3
000000F3  740C              jz 0x101
000000F5  B80100            mov ax,0x1
000000F8  A32A01            mov [0x12a],ax
000000FB  D1E0              shl ax,1
000000FD  09060A00          or [0xa],ax
00000101  BA0EFF            mov dx,0xff0e
00000104  ED                in ax,dx
00000105  A98000            test ax,0x80
00000108  750D              jnz 0x117
0000010A  B80100            mov ax,0x1
0000010D  A32A01            mov [0x12a],ax
00000110  C1E007            shl ax,byte 0x7
00000113  09060A00          or [0xa],ax
00000117  BB5740            mov bx,0x4057
0000011A  E8860D            call 0xea3
0000011D  740D              jz 0x12c
0000011F  B80100            mov ax,0x1
00000122  A32A01            mov [0x12a],ax
00000125  C1E002            shl ax,byte 0x2
00000128  09060A00          or [0xa],ax
0000012C  BA0EFF            mov dx,0xff0e
0000012F  ED                in ax,dx
00000130  A98000            test ax,0x80
00000133  740D              jz 0x142
00000135  B80100            mov ax,0x1
00000138  A32A01            mov [0x12a],ax
0000013B  C1E006            shl ax,byte 0x6
0000013E  09060A00          or [0xa],ax
00000142  BB5D80            mov bx,0x805d
00000145  E85B0D            call 0xea3
00000148  740D              jz 0x157
0000014A  B80100            mov ax,0x1
0000014D  A32A01            mov [0x12a],ax
00000150  C1E003            shl ax,byte 0x3
00000153  09060A00          or [0xa],ax
00000157  BB7520            mov bx,0x2075
0000015A  E8460D            call 0xea3
0000015D  740D              jz 0x16c
0000015F  B80100            mov ax,0x1
00000162  A32A01            mov [0x12a],ax
00000165  C1E004            shl ax,byte 0x4
00000168  09060A00          or [0xa],ax
0000016C  BBD508            mov bx,0x8d5
0000016F  E8310D            call 0xea3
00000172  740D              jz 0x181
00000174  B80100            mov ax,0x1
00000177  A32A01            mov [0x12a],ax
0000017A  C1E005            shl ax,byte 0x5
0000017D  09060A00          or [0xa],ax
00000181  E86F0E            call 0xff3
00000184  BA0103            mov dx,0x301
00000187  B809C0            mov ax,0xc009
0000018A  E8280D            call 0xeb5
0000018D  B80400            mov ax,0x4
00000190  E8220D            call 0xeb5
00000193  B803C2            mov ax,0xc203
00000196  E81C0D            call 0xeb5
00000199  B80560            mov ax,0x6005
0000019C  E8160D            call 0xeb5
0000019F  B80616            mov ax,0x1606
000001A2  E8100D            call 0xeb5
000001A5  B80716            mov ax,0x1607
000001A8  E80A0D            call 0xeb5
000001AB  B80B00            mov ax,0xb
000001AE  E8040D            call 0xeb5
000001B1  B80E10            mov ax,0x100e
000001B4  E8FE0C            call 0xeb5
000001B7  B80F00            mov ax,0xf
000001BA  E8F80C            call 0xeb5
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
000001F6  EC                in al,dx
000001F7  02D8              add bl,al
000001F9  8AC7              mov al,bh
000001FB  EE                out dx,al
000001FC  EE                out dx,al
000001FD  EE                out dx,al
000001FE  EC                in al,dx
000001FF  02D8              add bl,al
00000201  8AC7              mov al,bh
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
0000020F  02D8              add bl,al
00000211  80FB78            cmp bl,0x78
00000214  740C              jz 0x222
00000216  B80100            mov ax,0x1
00000219  A32A01            mov [0x12a],ax
0000021C  D1E0              shl ax,1
0000021E  09064A00          or [0x4a],ax
00000222  B80016            mov ax,0x1600
00000225  CD40              int 0x40
00000227  BA56FF            mov dx,0xff56
0000022A  ED                in ax,dx
0000022B  8BC8              mov cx,ax
0000022D  0C40              or al,0x40
0000022F  EE                out dx,al
00000230  E8660C            call 0xe99
00000233  BA0103            mov dx,0x301
00000236  B000              mov al,0x0
00000238  E87F0C            call 0xeba
0000023B  A820              test al,0x20
0000023D  740C              jz 0x24b
0000023F  B80100            mov ax,0x1
00000242  A32A01            mov [0x12a],ax
00000245  D1E0              shl ax,1
00000247  09066A00          or [0x6a],ax
0000024B  BA5AFF            mov dx,0xff5a
0000024E  ED                in ax,dx
0000024F  A804              test al,0x4
00000251  750D              jnz 0x260
00000253  B80100            mov ax,0x1
00000256  A32A01            mov [0x12a],ax
00000259  C1E002            shl ax,byte 0x2
0000025C  09066A00          or [0x6a],ax
00000260  BA56FF            mov dx,0xff56
00000263  8BC1              mov ax,cx
00000265  24BF              and al,0xbf
00000267  EE                out dx,al
00000268  E82E0C            call 0xe99
0000026B  BA5AFF            mov dx,0xff5a
0000026E  ED                in ax,dx
0000026F  A804              test al,0x4
00000271  740D              jz 0x280
00000273  B80100            mov ax,0x1
00000276  A32A01            mov [0x12a],ax
00000279  C1E003            shl ax,byte 0x3
0000027C  09066A00          or [0x6a],ax
00000280  BA0103            mov dx,0x301
00000283  B000              mov al,0x0
00000285  E8320C            call 0xeba
00000288  A820              test al,0x20
0000028A  750D              jnz 0x299
0000028C  B80100            mov ax,0x1
0000028F  A32A01            mov [0x12a],ax
00000292  C1E004            shl ax,byte 0x4
00000295  09066A00          or [0x6a],ax
00000299  B80116            mov ax,0x1601
0000029C  CD40              int 0x40
0000029E  E8F80B            call 0xe99
000002A1  B000              mov al,0x0
000002A3  E8140C            call 0xeba
000002A6  A820              test al,0x20
000002A8  740D              jz 0x2b7
000002AA  B80100            mov ax,0x1
000002AD  A32A01            mov [0x12a],ax
000002B0  C1E005            shl ax,byte 0x5
000002B3  09066A00          or [0x6a],ax
000002B7  B80562            mov ax,0x6205
000002BA  E8F80B            call 0xeb5
000002BD  E8D90B            call 0xe99
000002C0  B000              mov al,0x0
000002C2  E8F50B            call 0xeba
000002C5  A820              test al,0x20
000002C7  750D              jnz 0x2d6
000002C9  B80100            mov ax,0x1
000002CC  A32A01            mov [0x12a],ax
000002CF  C1E006            shl ax,byte 0x6
000002D2  09066A00          or [0x6a],ax
000002D6  B8056A            mov ax,0x6a05
000002D9  E8D90B            call 0xeb5
000002DC  B90500            mov cx,0x5
000002DF  BA0303            mov dx,0x303
000002E2  B0AA              mov al,0xaa
000002E4  EE                out dx,al
000002E5  BA0103            mov dx,0x301
000002E8  B000              mov al,0x0
000002EA  E8CD0B            call 0xeba
000002ED  A840              test al,0x40
000002EF  E1EE              loope 0x2df
000002F1  750D              jnz 0x300
000002F3  B80100            mov ax,0x1
000002F6  A32A01            mov [0x12a],ax
000002F9  C1E007            shl ax,byte 0x7
000002FC  09064A00          or [0x4a],ax
00000300  B91400            mov cx,0x14
00000303  B80568            mov ax,0x6805
00000306  E8AC0B            call 0xeb5
00000309  B8056A            mov ax,0x6a05
0000030C  E8A60B            call 0xeb5
0000030F  E2F2              loop 0x303
00000311  B000              mov al,0x0
00000313  E8A40B            call 0xeba
00000316  A840              test al,0x40
00000318  750D              jnz 0x327
0000031A  B80100            mov ax,0x1
0000031D  A32A01            mov [0x12a],ax
00000320  C1E008            shl ax,byte 0x8
00000323  09066A00          or [0x6a],ax
00000327  BA0103            mov dx,0x301
0000032A  B80B28            mov ax,0x280b
0000032D  E8850B            call 0xeb5
00000330  B90500            mov cx,0x5
00000333  BA0303            mov dx,0x303
00000336  B0AA              mov al,0xaa
00000338  EE                out dx,al
00000339  BA0103            mov dx,0x301
0000033C  B000              mov al,0x0
0000033E  E8790B            call 0xeba
00000341  A840              test al,0x40
00000343  E1EE              loope 0x333
00000345  750D              jnz 0x354
00000347  B80100            mov ax,0x1
0000034A  A32A01            mov [0x12a],ax
0000034D  C1E009            shl ax,byte 0x9
00000350  09064A00          or [0x4a],ax
00000354  BA56FF            mov dx,0xff56
00000357  ED                in ax,dx
00000358  8BD8              mov bx,ax
0000035A  B91400            mov cx,0x14
0000035D  8BC3              mov ax,bx
0000035F  0C40              or al,0x40
00000361  EE                out dx,al
00000362  24BF              and al,0xbf
00000364  EE                out dx,al
00000365  E2F6              loop 0x35d
00000367  BA0103            mov dx,0x301
0000036A  B000              mov al,0x0
0000036C  E84B0B            call 0xeba
0000036F  A840              test al,0x40
00000371  750D              jnz 0x380
00000373  B80100            mov ax,0x1
00000376  A32A01            mov [0x12a],ax
00000379  C1E00A            shl ax,byte 0xa
0000037C  09066A00          or [0x6a],ax
00000380  BA5EFF            mov dx,0xff5e
00000383  ED                in ax,dx
00000384  250FFF            and ax,0xff0f
00000387  8BD8              mov bx,ax
00000389  EE                out dx,al
0000038A  E80C0B            call 0xe99
0000038D  BA5AFF            mov dx,0xff5a
00000390  ED                in ax,dx
00000391  24F0              and al,0xf0
00000393  740C              jz 0x3a1
00000395  B80100            mov ax,0x1
00000398  A32A01            mov [0x12a],ax
0000039B  D1E0              shl ax,1
0000039D  09062A00          or [0x2a],ax
000003A1  BA5EFF            mov dx,0xff5e
000003A4  8BC3              mov ax,bx
000003A6  0C80              or al,0x80
000003A8  EE                out dx,al
000003A9  E8ED0A            call 0xe99
000003AC  BA5AFF            mov dx,0xff5a
000003AF  ED                in ax,dx
000003B0  24F0              and al,0xf0
000003B2  3C90              cmp al,0x90
000003B4  740D              jz 0x3c3
000003B6  B80100            mov ax,0x1
000003B9  A32A01            mov [0x12a],ax
000003BC  C1E002            shl ax,byte 0x2
000003BF  09062A00          or [0x2a],ax
000003C3  BA5EFF            mov dx,0xff5e
000003C6  8BC3              mov ax,bx
000003C8  0C40              or al,0x40
000003CA  EE                out dx,al
000003CB  E8CB0A            call 0xe99
000003CE  BA5AFF            mov dx,0xff5a
000003D1  ED                in ax,dx
000003D2  25F000            and ax,0xf0
000003D5  3D6000            cmp ax,0x60
000003D8  740D              jz 0x3e7
000003DA  B80100            mov ax,0x1
000003DD  A32A01            mov [0x12a],ax
000003E0  C1E003            shl ax,byte 0x3
000003E3  09062A00          or [0x2a],ax
000003E7  E8090C            call 0xff3
000003EA  BA0103            mov dx,0x301
000003ED  B809C0            mov ax,0xc009
000003F0  E8C20A            call 0xeb5
000003F3  B80405            mov ax,0x504
000003F6  E8BC0A            call 0xeb5
000003F9  B80104            mov ax,0x401
000003FC  E8B60A            call 0xeb5
000003FF  B80200            mov ax,0x2
00000402  E8B00A            call 0xeb5
00000405  B803C0            mov ax,0xc003
00000408  E8AA0A            call 0xeb5
0000040B  B80560            mov ax,0x6005
0000040E  E8A40A            call 0xeb5
00000411  B80901            mov ax,0x109
00000414  E89E0A            call 0xeb5
00000417  B80B50            mov ax,0x500b
0000041A  E8980A            call 0xeb5
0000041D  B80C7E            mov ax,0x7e0c
00000420  E8920A            call 0xeb5
00000423  B80D00            mov ax,0xd
00000426  E88C0A            call 0xeb5
00000429  B80E02            mov ax,0x20e
0000042C  E8860A            call 0xeb5
0000042F  B80E03            mov ax,0x30e
00000432  E8800A            call 0xeb5
00000435  B803C1            mov ax,0xc103
00000438  E87A0A            call 0xeb5
0000043B  B80568            mov ax,0x6805
0000043E  E8740A            call 0xeb5
00000441  B80F00            mov ax,0xf
00000444  E86E0A            call 0xeb5
00000447  B80010            mov ax,0x1000
0000044A  E8680A            call 0xeb5
0000044D  B80010            mov ax,0x1000
00000450  E8620A            call 0xeb5
00000453  B80030            mov ax,0x3000
00000456  E85C0A            call 0xeb5
00000459  B80114            mov ax,0x1401
0000045C  E8560A            call 0xeb5
0000045F  BA0EFF            mov dx,0xff0e
00000462  ED                in ax,dx
00000463  A91000            test ax,0x10
00000466  7410              jz 0x478
00000468  B80100            mov ax,0x1
0000046B  A32A01            mov [0x12a],ax
0000046E  C1E002            shl ax,byte 0x2
00000471  09064A00          or [0x4a],ax
00000475  EB12              jmp short 0x489
00000477  90                nop
00000478  BA0103            mov dx,0x301
0000047B  B80909            mov ax,0x909
0000047E  E8340A            call 0xeb5
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
00000498  E8910B            call 0x102c
0000049B  E8550B            call 0xff3
0000049E  E8A70B            call 0x1048
000004A1  75F8              jnz 0x49b
000004A3  BA0103            mov dx,0x301
000004A6  B000              mov al,0x0
000004A8  E80F0A            call 0xeba
000004AB  A98000            test ax,0x80
000004AE  750D              jnz 0x4bd
000004B0  B80100            mov ax,0x1
000004B3  A32A01            mov [0x12a],ax
000004B6  C1E002            shl ax,byte 0x2
000004B9  0906AA00          or [0xaa],ax
000004BD  B80116            mov ax,0x1601
000004C0  CD40              int 0x40
000004C2  B80200            mov ax,0x2
000004C5  E8640B            call 0x102c
000004C8  E8280B            call 0xff3
000004CB  E87A0B            call 0x1048
000004CE  75F8              jnz 0x4c8
000004D0  BA0103            mov dx,0x301
000004D3  B000              mov al,0x0
000004D5  E8E209            call 0xeba
000004D8  A98000            test ax,0x80
000004DB  740C              jz 0x4e9
000004DD  B80100            mov ax,0x1
000004E0  A32A01            mov [0x12a],ax
000004E3  D1E0              shl ax,1
000004E5  0906AA00          or [0xaa],ax
000004E9  C606570200        mov byte [0x257],0x0
000004EE  C70655020000      mov word [0x255],0x0
000004F4  B83600            mov ax,0x36
000004F7  E8320B            call 0x102c
000004FA  C706E5010000      mov word [0x1e5],0x0
00000500  E8F40D            call 0x12f7
00000503  A15502            mov ax,[0x255]
00000506  3D3600            cmp ax,0x36
00000509  7349              jnc 0x554
0000050B  E8E50A            call 0xff3
0000050E  E8370B            call 0x1048
00000511  75ED              jnz 0x500
00000513  A05702            mov al,[0x257]
00000516  3C01              cmp al,0x1
00000518  7410              jz 0x52a
0000051A  B80100            mov ax,0x1
0000051D  A32A01            mov [0x12a],ax
00000520  C1E003            shl ax,byte 0x3
00000523  09064A00          or [0x4a],ax
00000527  EB47              jmp short 0x570
00000529  90                nop
0000052A  A1E501            mov ax,[0x1e5]
0000052D  3D3600            cmp ax,0x36
00000530  7310              jnc 0x542
00000532  B80100            mov ax,0x1
00000535  A32A01            mov [0x12a],ax
00000538  C1E004            shl ax,byte 0x4
0000053B  09064A00          or [0x4a],ax
0000053F  EB2F              jmp short 0x570
00000541  90                nop
00000542  7210              jc 0x554
00000544  B80100            mov ax,0x1
00000547  A32A01            mov [0x12a],ax
0000054A  C1E005            shl ax,byte 0x5
0000054D  09064A00          or [0x4a],ax
00000551  EB1D              jmp short 0x570
00000553  90                nop
00000554  1E                push ds
00000555  07                pop es
00000556  BF1F02            mov di,0x21f
00000559  BEAF01            mov si,0x1af
0000055C  B93600            mov cx,0x36
0000055F  F3A6              repe cmpsb
00000561  740D              jz 0x570
00000563  B80100            mov ax,0x1
00000566  A32A01            mov [0x12a],ax
00000569  C1E006            shl ax,byte 0x6
0000056C  09064A00          or [0x4a],ax
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
00000586  BA66FF            mov dx,0xff66
00000589  ED                in ax,dx
0000058A  BA68FF            mov dx,0xff68
0000058D  ED                in ax,dx
0000058E  BA08FF            mov dx,0xff08
00000591  ED                in ax,dx
00000592  25FBFF            and ax,0xfffb
00000595  EF                out dx,ax
00000596  E85A0A            call 0xff3
00000599  C606580200        mov byte [0x258],0x0
0000059E  C7061D020000      mov word [0x21d],0x0
000005A4  B83600            mov ax,0x36
000005A7  E8820A            call 0x102c
000005AA  C706E5010100      mov word [0x1e5],0x1
000005B0  BA6AFF            mov dx,0xff6a
000005B3  A0AF01            mov al,[0x1af]
000005B6  EE                out dx,al
000005B7  A11D02            mov ax,[0x21d]
000005BA  3D3600            cmp ax,0x36
000005BD  7349              jnc 0x608
000005BF  E8310A            call 0xff3
000005C2  E8830A            call 0x1048
000005C5  75F0              jnz 0x5b7
000005C7  A05802            mov al,[0x258]
000005CA  3C01              cmp al,0x1
000005CC  7410              jz 0x5de
000005CE  B80100            mov ax,0x1
000005D1  A32A01            mov [0x12a],ax
000005D4  C1E004            shl ax,byte 0x4
000005D7  09062A00          or [0x2a],ax
000005DB  EB47              jmp short 0x624
000005DD  90                nop
000005DE  A1E501            mov ax,[0x1e5]
000005E1  3D3600            cmp ax,0x36
000005E4  7310              jnc 0x5f6
000005E6  B80100            mov ax,0x1
000005E9  A32A01            mov [0x12a],ax
000005EC  C1E005            shl ax,byte 0x5
000005EF  09062A00          or [0x2a],ax
000005F3  EB2F              jmp short 0x624
000005F5  90                nop
000005F6  7210              jc 0x608
000005F8  B80100            mov ax,0x1
000005FB  A32A01            mov [0x12a],ax
000005FE  C1E006            shl ax,byte 0x6
00000601  09062A00          or [0x2a],ax
00000605  EB1D              jmp short 0x624
00000607  90                nop
00000608  1E                push ds
00000609  07                pop es
0000060A  BFE701            mov di,0x1e7
0000060D  BEAF01            mov si,0x1af
00000610  B93600            mov cx,0x36
00000613  F3A6              repe cmpsb
00000615  740D              jz 0x624
00000617  B80100            mov ax,0x1
0000061A  A32A01            mov [0x12a],ax
0000061D  C1E007            shl ax,byte 0x7
00000620  09062A00          or [0x2a],ax
00000624  E984FA            jmp 0xab
00000627  E8C60A            call 0x10f0
0000062A  E8960B            call 0x11c3
0000062D  E8A10C            call 0x12d1
00000630  E8270C            call 0x125a
00000633  E8D40A            call 0x110a
00000636  E8AF0A            call 0x10e8
00000639  B000              mov al,0x0
0000063B  B41E              mov ah,0x1e
0000063D  CD40              int 0x40
0000063F  B8004C            mov ax,0x4c00
00000642  CD21              int 0x21
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
0000065B  8AF8              mov bh,al
0000065D  BA0020            mov dx,0x2000
00000660  CD10              int 0x10
00000662  5B                pop bx
00000663  07                pop es
00000664  8BF3              mov si,bx
00000666  33D2              xor dx,dx
00000668  B91E00            mov cx,0x1e
0000066B  26AD              es lodsw
0000066D  86C4              xchg al,ah
0000066F  8BF8              mov di,ax
00000671  268815            mov [es:di],dl
00000674  E2F5              loop 0x66b
00000676  BF0100            mov di,0x1
00000679  033E2E01          add di,[0x12e]
0000067D  53                push bx
0000067E  8BC3              mov ax,bx
00000680  03062C01          add ax,[0x12c]
00000684  03062C01          add ax,[0x12c]
00000688  8B160A00          mov dx,[0xa]
0000068C  33F6              xor si,si
0000068E  83C602            add si,byte +0x2
00000691  83FE20            cmp si,byte +0x20
00000694  7424              jz 0x6ba
00000696  D1EA              shr dx,1
00000698  F7C20100          test dx,0x1
0000069C  74F0              jz 0x68e
0000069E  8BD8              mov bx,ax
000006A0  268B1F            mov bx,[es:bx]
000006A3  86FB              xchg bh,bl
000006A5  26C60150          mov byte [es:bx+di],0x50
000006A9  8B8C0A00          mov cx,[si+0xa]
000006AD  26884901          mov [es:bx+di+0x1],cl
000006B1  26886902          mov [es:bx+di+0x2],ch
000006B5  050400            add ax,0x4
000006B8  EBD4              jmp short 0x68e
000006BA  5B                pop bx
000006BB  83C706            add di,byte +0x6
000006BE  53                push bx
000006BF  8BC3              mov ax,bx
000006C1  03062C01          add ax,[0x12c]
000006C5  03062C01          add ax,[0x12c]
000006C9  8B162A00          mov dx,[0x2a]
000006CD  33F6              xor si,si
000006CF  83C602            add si,byte +0x2
000006D2  83FE20            cmp si,byte +0x20
000006D5  7424              jz 0x6fb
000006D7  D1EA              shr dx,1
000006D9  F7C20100          test dx,0x1
000006DD  74F0              jz 0x6cf
000006DF  8BD8              mov bx,ax
000006E1  268B1F            mov bx,[es:bx]
000006E4  86FB              xchg bh,bl
000006E6  26C60141          mov byte [es:bx+di],0x41
000006EA  8B8C2A00          mov cx,[si+0x2a]
000006EE  26884901          mov [es:bx+di+0x1],cl
000006F2  26886902          mov [es:bx+di+0x2],ch
000006F6  050400            add ax,0x4
000006F9  EBD4              jmp short 0x6cf
000006FB  5B                pop bx
000006FC  83C706            add di,byte +0x6
000006FF  53                push bx
00000700  8BC3              mov ax,bx
00000702  03062C01          add ax,[0x12c]
00000706  03062C01          add ax,[0x12c]
0000070A  8B164A00          mov dx,[0x4a]
0000070E  33F6              xor si,si
00000710  83C602            add si,byte +0x2
00000713  83FE20            cmp si,byte +0x20
00000716  7424              jz 0x73c
00000718  D1EA              shr dx,1
0000071A  F7C20100          test dx,0x1
0000071E  74F0              jz 0x710
00000720  8BD8              mov bx,ax
00000722  268B1F            mov bx,[es:bx]
00000725  86FB              xchg bh,bl
00000727  26C60153          mov byte [es:bx+di],0x53
0000072B  8B8C4A00          mov cx,[si+0x4a]
0000072F  26884901          mov [es:bx+di+0x1],cl
00000733  26886902          mov [es:bx+di+0x2],ch
00000737  050400            add ax,0x4
0000073A  EBD4              jmp short 0x710
0000073C  5B                pop bx
0000073D  83C706            add di,byte +0x6
00000740  53                push bx
00000741  8BC3              mov ax,bx
00000743  03062C01          add ax,[0x12c]
00000747  03062C01          add ax,[0x12c]
0000074B  8B166A00          mov dx,[0x6a]
0000074F  33F6              xor si,si
00000751  83C602            add si,byte +0x2
00000754  83FE20            cmp si,byte +0x20
00000757  7424              jz 0x77d
00000759  D1EA              shr dx,1
0000075B  F7C20100          test dx,0x1
0000075F  74F0              jz 0x751
00000761  8BD8              mov bx,ax
00000763  268B1F            mov bx,[es:bx]
00000766  86FB              xchg bh,bl
00000768  26C60143          mov byte [es:bx+di],0x43
0000076C  8B8C6A00          mov cx,[si+0x6a]
00000770  26884901          mov [es:bx+di+0x1],cl
00000774  26886902          mov [es:bx+di+0x2],ch
00000778  050400            add ax,0x4
0000077B  EBD4              jmp short 0x751
0000077D  5B                pop bx
0000077E  83C706            add di,byte +0x6
00000781  53                push bx
00000782  8BC3              mov ax,bx
00000784  03062C01          add ax,[0x12c]
00000788  03062C01          add ax,[0x12c]
0000078C  8B168A00          mov dx,[0x8a]
00000790  33F6              xor si,si
00000792  83C602            add si,byte +0x2
00000795  83FE20            cmp si,byte +0x20
00000798  7424              jz 0x7be
0000079A  D1EA              shr dx,1
0000079C  F7C20100          test dx,0x1
000007A0  74F0              jz 0x792
000007A2  8BD8              mov bx,ax
000007A4  268B1F            mov bx,[es:bx]
000007A7  86FB              xchg bh,bl
000007A9  26C60155          mov byte [es:bx+di],0x55
000007AD  8B8C8A00          mov cx,[si+0x8a]
000007B1  26884901          mov [es:bx+di+0x1],cl
000007B5  26886902          mov [es:bx+di+0x2],ch
000007B9  050400            add ax,0x4
000007BC  EBD4              jmp short 0x792
000007BE  5B                pop bx
000007BF  83C706            add di,byte +0x6
000007C2  53                push bx
000007C3  8BC3              mov ax,bx
000007C5  03062C01          add ax,[0x12c]
000007C9  03062C01          add ax,[0x12c]
000007CD  8B16AA00          mov dx,[0xaa]
000007D1  33F6              xor si,si
000007D3  83C602            add si,byte +0x2
000007D6  83FE20            cmp si,byte +0x20
000007D9  7424              jz 0x7ff
000007DB  D1EA              shr dx,1
000007DD  F7C20100          test dx,0x1
000007E1  74F0              jz 0x7d3
000007E3  8BD8              mov bx,ax
000007E5  268B1F            mov bx,[es:bx]
000007E8  86FB              xchg bh,bl
000007EA  26C60154          mov byte [es:bx+di],0x54
000007EE  8B8CAA00          mov cx,[si+0xaa]
000007F2  26884901          mov [es:bx+di+0x1],cl
000007F6  26886902          mov [es:bx+di+0x2],ch
000007FA  050400            add ax,0x4
000007FD  EBD4              jmp short 0x7d3
000007FF  5B                pop bx
00000800  83C706            add di,byte +0x6
00000803  53                push bx
00000804  8BC3              mov ax,bx
00000806  03062C01          add ax,[0x12c]
0000080A  03062C01          add ax,[0x12c]
0000080E  8B16CA00          mov dx,[0xca]
00000812  33F6              xor si,si
00000814  83C602            add si,byte +0x2
00000817  83FE20            cmp si,byte +0x20
0000081A  7424              jz 0x840
0000081C  D1EA              shr dx,1
0000081E  F7C20100          test dx,0x1
00000822  74F0              jz 0x814
00000824  8BD8              mov bx,ax
00000826  268B1F            mov bx,[es:bx]
00000829  86FB              xchg bh,bl
0000082B  26C60158          mov byte [es:bx+di],0x58
0000082F  8B8CCA00          mov cx,[si+0xca]
00000833  26884901          mov [es:bx+di+0x1],cl
00000837  26886902          mov [es:bx+di+0x2],ch
0000083B  050400            add ax,0x4
0000083E  EBD4              jmp short 0x814
00000840  5B                pop bx
00000841  83C706            add di,byte +0x6
00000844  53                push bx
00000845  8BC3              mov ax,bx
00000847  03062C01          add ax,[0x12c]
0000084B  03062C01          add ax,[0x12c]
0000084F  8B16EA00          mov dx,[0xea]
00000853  33F6              xor si,si
00000855  83C602            add si,byte +0x2
00000858  83FE20            cmp si,byte +0x20
0000085B  7424              jz 0x881
0000085D  D1EA              shr dx,1
0000085F  F7C20100          test dx,0x1
00000863  74F0              jz 0x855
00000865  8BD8              mov bx,ax
00000867  268B1F            mov bx,[es:bx]
0000086A  86FB              xchg bh,bl
0000086C  26C6014E          mov byte [es:bx+di],0x4e
00000870  8B8CEA00          mov cx,[si+0xea]
00000874  26884901          mov [es:bx+di+0x1],cl
00000878  26886902          mov [es:bx+di+0x2],ch
0000087C  050400            add ax,0x4
0000087F  EBD4              jmp short 0x855
00000881  5B                pop bx
00000882  83C706            add di,byte +0x6
00000885  53                push bx
00000886  8BC3              mov ax,bx
00000888  03062C01          add ax,[0x12c]
0000088C  03062C01          add ax,[0x12c]
00000890  8B160A01          mov dx,[0x10a]
00000894  33F6              xor si,si
00000896  83C602            add si,byte +0x2
00000899  83FE20            cmp si,byte +0x20
0000089C  7424              jz 0x8c2
0000089E  D1EA              shr dx,1
000008A0  F7C20100          test dx,0x1
000008A4  74F0              jz 0x896
000008A6  8BD8              mov bx,ax
000008A8  268B1F            mov bx,[es:bx]
000008AB  86FB              xchg bh,bl
000008AD  26C60147          mov byte [es:bx+di],0x47
000008B1  8B8C0A01          mov cx,[si+0x10a]
000008B5  26884901          mov [es:bx+di+0x1],cl
000008B9  26886902          mov [es:bx+di+0x2],ch
000008BD  050400            add ax,0x4
000008C0  EBD4              jmp short 0x896
000008C2  5B                pop bx
000008C3  B82400            mov ax,0x24
000008C6  E8B307            call 0x107c
000008C9  C3                ret
000008CA  F7062C010100      test word [0x12c],0x1
000008D0  751B              jnz 0x8ed
000008D2  83062E0101        add word [0x12e],byte +0x1
000008D7  833E2E0106        cmp word [0x12e],byte +0x6
000008DC  7522              jnz 0x900
000008DE  C7062C010100      mov word [0x12c],0x1
000008E4  C7062E010500      mov word [0x12e],0x5
000008EA  EB14              jmp short 0x900
000008EC  90                nop
000008ED  832E2E0101        sub word [0x12e],byte +0x1
000008F2  730C              jnc 0x900
000008F4  C7062C010000      mov word [0x12c],0x0
000008FA  C7062E010000      mov word [0x12e],0x0
00000900  E841FD            call 0x644
00000903  C3                ret
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
0000091C  26AD              es lodsw
0000091E  86C4              xchg al,ah
00000920  8BF8              mov di,ax
00000922  33C0              xor ax,ax
00000924  AA                stosb
00000925  A03D01            mov al,[0x13d]
00000928  2AC2              sub al,dl
0000092A  B402              mov ah,0x2
0000092C  B95000            mov cx,0x50
0000092F  2688A50080        mov [es:di-0x8000],ah
00000934  AA                stosb
00000935  FEC0              inc al
00000937  E2F6              loop 0x92f
00000939  4A                dec dx
0000093A  75E0              jnz 0x91c
0000093C  B80600            mov ax,0x6
0000093F  E83A07            call 0x107c
00000942  C3                ret
00000943  06                push es
00000944  53                push bx
00000945  B80106            mov ax,0x601
00000948  B90000            mov cx,0x0
0000094B  BA4F1D            mov dx,0x1d4f
0000094E  B702              mov bh,0x2
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
00000971  2688A50080        mov [es:di-0x8000],ah
00000976  AA                stosb
00000977  FEC0              inc al
00000979  E2F6              loop 0x971
0000097B  FE063D01          inc byte [0x13d]
0000097F  B80600            mov ax,0x6
00000982  E8F706            call 0x107c
00000985  C3                ret
00000986  06                push es
00000987  53                push bx
00000988  B83700            mov ax,0x37
0000098B  CD10              int 0x10
0000098D  B80002            mov ax,0x200
00000990  8AF8              mov bh,al
00000992  BA0020            mov dx,0x2000
00000995  CD10              int 0x10
00000997  5B                pop bx
00000998  07                pop es
00000999  8BF3              mov si,bx
0000099B  BA1E00            mov dx,0x1e
0000099E  26AD              es lodsw
000009A0  86C4              xchg al,ah
000009A2  8BF8              mov di,ax
000009A4  33C0              xor ax,ax
000009A6  AA                stosb
000009A7  B06D              mov al,0x6d
000009A9  B402              mov ah,0x2
000009AB  B98400            mov cx,0x84
000009AE  2688A50080        mov [es:di-0x8000],ah
000009B3  AA                stosb
000009B4  E2F8              loop 0x9ae
000009B6  4A                dec dx
000009B7  75E5              jnz 0x99e
000009B9  8BF3              mov si,bx
000009BB  83C614            add si,byte +0x14
000009BE  BA0A00            mov dx,0xa
000009C1  26AD              es lodsw
000009C3  86C4              xchg al,ah
000009C5  8BF8              mov di,ax
000009C7  83C715            add di,byte +0x15
000009CA  B020              mov al,0x20
000009CC  B421              mov ah,0x21
000009CE  B91F00            mov cx,0x1f
000009D1  2688A50080        mov [es:di-0x8000],ah
000009D6  AA                stosb
000009D7  E2F8              loop 0x9d1
000009D9  B422              mov ah,0x22
000009DB  B91F00            mov cx,0x1f
000009DE  2688A50080        mov [es:di-0x8000],ah
000009E3  AA                stosb
000009E4  E2F8              loop 0x9de
000009E6  B420              mov ah,0x20
000009E8  B91F00            mov cx,0x1f
000009EB  2688A50080        mov [es:di-0x8000],ah
000009F0  AA                stosb
000009F1  E2F8              loop 0x9eb
000009F3  4A                dec dx
000009F4  75CB              jnz 0x9c1
000009F6  C3                ret
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
00000A0F  26AD              es lodsw
00000A11  86C4              xchg al,ah
00000A13  8BF8              mov di,ax
00000A15  33C0              xor ax,ax
00000A17  AA                stosb
00000A18  B420              mov ah,0x20
00000A1A  B020              mov al,0x20
00000A1C  B95000            mov cx,0x50
00000A1F  2688A50080        mov [es:di-0x8000],ah
00000A24  AA                stosb
00000A25  E2F8              loop 0xa1f
00000A27  83EF50            sub di,byte +0x50
00000A2A  26C685098022      mov byte [es:di-0x7ff7],0x22
00000A30  26C685468022      mov byte [es:di-0x7fba],0x22
00000A36  26C6851D8021      mov byte [es:di-0x7fe3],0x21
00000A3C  26C685328021      mov byte [es:di-0x7fce],0x21
00000A42  26C685268000      mov byte [es:di-0x7fda],0x0
00000A48  26C685298000      mov byte [es:di-0x7fd7],0x0
00000A4E  4A                dec dx
00000A4F  75BE              jnz 0xa0f
00000A51  268B4704          mov ax,[es:bx+0x4]
00000A55  86C4              xchg al,ah
00000A57  8BF8              mov di,ax
00000A59  83C702            add di,byte +0x2
00000A5C  33C0              xor ax,ax
00000A5E  A03F01            mov al,[0x13f]
00000A61  2D3C00            sub ax,0x3c
00000A64  3D0C00            cmp ax,0xc
00000A67  770B              ja 0xa74
00000A69  8D364001          lea si,[0x140]
00000A6D  03F0              add si,ax
00000A6F  B90700            mov cx,0x7
00000A72  F3A4              rep movsb
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
00000A91  2688A50080        mov [es:di-0x8000],ah
00000A96  AA                stosb
00000A97  E2F8              loop 0xa91
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
00000ACC  2688A50080        mov [es:di-0x8000],ah
00000AD1  AA                stosb
00000AD2  E2F8              loop 0xacc
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
00000AFA  2608A50080        or [es:di-0x8000],ah
00000AFF  AA                stosb
00000B00  E2F8              loop 0xafa
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
00000B29  2608A50080        or [es:di-0x8000],ah
00000B2E  AA                stosb
00000B2F  E2F8              loop 0xb29
00000B31  83EF50            sub di,byte +0x50
00000B34  26C64513C1        mov byte [es:di+0x13],0xc1
00000B39  26C64516C1        mov byte [es:di+0x16],0xc1
00000B3E  26C6453BC1        mov byte [es:di+0x3b],0xc1
00000B43  26C6453EC1        mov byte [es:di+0x3e],0xc1
00000B48  C3                ret
00000B49  53                push bx
00000B4A  50                push ax
00000B4B  56                push si
00000B4C  03D8              add bx,ax
00000B4E  03D8              add bx,ax
00000B50  268B07            mov ax,[es:bx]
00000B53  86C4              xchg al,ah
00000B55  8BF8              mov di,ax
00000B57  03FE              add di,si
00000B59  B020              mov al,0x20
00000B5B  8B0E3201          mov cx,[0x132]
00000B5F  2688B50080        mov [es:di-0x8000],dh
00000B64  AA                stosb
00000B65  E2F8              loop 0xb5f
00000B67  83C304            add bx,byte +0x4
00000B6A  268B07            mov ax,[es:bx]
00000B6D  86C4              xchg al,ah
00000B6F  8BF8              mov di,ax
00000B71  03FE              add di,si
00000B73  B020              mov al,0x20
00000B75  8B0E3201          mov cx,[0x132]
00000B79  2688B50080        mov [es:di-0x8000],dh
00000B7E  AA                stosb
00000B7F  E2F8              loop 0xb79
00000B81  83EB02            sub bx,byte +0x2
00000B84  268B07            mov ax,[es:bx]
00000B87  86C4              xchg al,ah
00000B89  8BF8              mov di,ax
00000B8B  03FE              add di,si
00000B8D  B020              mov al,0x20
00000B8F  8B0E3801          mov cx,[0x138]
00000B93  2688B50080        mov [es:di-0x8000],dh
00000B98  AA                stosb
00000B99  E2F8              loop 0xb93
00000B9B  8D365D01          lea si,[0x15d]
00000B9F  8B0E3601          mov cx,[0x136]
00000BA3  2688950080        mov [es:di-0x8000],dl
00000BA8  A4                movsb
00000BA9  E2F8              loop 0xba3
00000BAB  B020              mov al,0x20
00000BAD  8B0E3801          mov cx,[0x138]
00000BB1  2688B50080        mov [es:di-0x8000],dh
00000BB6  AA                stosb
00000BB7  E2F8              loop 0xbb1
00000BB9  5E                pop si
00000BBA  58                pop ax
00000BBB  5B                pop bx
00000BBC  C3                ret
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
00000BE6  E860FF            call 0xb49
00000BE9  03363201          add si,[0x132]
00000BED  BA2222            mov dx,0x2222
00000BF0  E856FF            call 0xb49
00000BF3  03363201          add si,[0x132]
00000BF7  BA0A0A            mov dx,0xa0a
00000BFA  E84CFF            call 0xb49
00000BFD  03363201          add si,[0x132]
00000C01  03363401          add si,[0x134]
00000C05  BA1202            mov dx,0x212
00000C08  E83EFF            call 0xb49
00000C0B  03363201          add si,[0x132]
00000C0F  BA3222            mov dx,0x2232
00000C12  E834FF            call 0xb49
00000C15  03363201          add si,[0x132]
00000C19  BA1A0A            mov dx,0xa1a
00000C1C  E82AFF            call 0xb49
00000C1F  050300            add ax,0x3
00000C22  BE0100            mov si,0x1
00000C25  BA0000            mov dx,0x0
00000C28  E81EFF            call 0xb49
00000C2B  03363201          add si,[0x132]
00000C2F  BA2020            mov dx,0x2020
00000C32  E814FF            call 0xb49
00000C35  03363201          add si,[0x132]
00000C39  BA0808            mov dx,0x808
00000C3C  E80AFF            call 0xb49
00000C3F  03363201          add si,[0x132]
00000C43  03363401          add si,[0x134]
00000C47  BA1000            mov dx,0x10
00000C4A  E8FCFE            call 0xb49
00000C4D  03363201          add si,[0x132]
00000C51  BA3020            mov dx,0x2030
00000C54  E8F2FE            call 0xb49
00000C57  03363201          add si,[0x132]
00000C5B  BA1808            mov dx,0x818
00000C5E  E8E8FE            call 0xb49
00000C61  050300            add ax,0x3
00000C64  BE0100            mov si,0x1
00000C67  BA0101            mov dx,0x101
00000C6A  E8DCFE            call 0xb49
00000C6D  03363201          add si,[0x132]
00000C71  BA2121            mov dx,0x2121
00000C74  E8D2FE            call 0xb49
00000C77  03363201          add si,[0x132]
00000C7B  BA0909            mov dx,0x909
00000C7E  E8C8FE            call 0xb49
00000C81  03363201          add si,[0x132]
00000C85  03363401          add si,[0x134]
00000C89  BA1101            mov dx,0x111
00000C8C  E8BAFE            call 0xb49
00000C8F  03363201          add si,[0x132]
00000C93  BA3121            mov dx,0x2131
00000C96  E8B0FE            call 0xb49
00000C99  03363201          add si,[0x132]
00000C9D  BA1909            mov dx,0x919
00000CA0  E8A6FE            call 0xb49
00000CA3  050300            add ax,0x3
00000CA6  BE0100            mov si,0x1
00000CA9  BA0303            mov dx,0x303
00000CAC  E89AFE            call 0xb49
00000CAF  03363201          add si,[0x132]
00000CB3  BA2323            mov dx,0x2323
00000CB6  E890FE            call 0xb49
00000CB9  03363201          add si,[0x132]
00000CBD  BA0B0B            mov dx,0xb0b
00000CC0  E886FE            call 0xb49
00000CC3  03363201          add si,[0x132]
00000CC7  03363401          add si,[0x134]
00000CCB  BA1303            mov dx,0x313
00000CCE  E878FE            call 0xb49
00000CD1  03363201          add si,[0x132]
00000CD5  BA3323            mov dx,0x2333
00000CD8  E86EFE            call 0xb49
00000CDB  03363201          add si,[0x132]
00000CDF  BA1B0B            mov dx,0xb1b
00000CE2  E864FE            call 0xb49
00000CE5  050300            add ax,0x3
00000CE8  BE0100            mov si,0x1
00000CEB  BA0602            mov dx,0x206
00000CEE  E858FE            call 0xb49
00000CF1  03363201          add si,[0x132]
00000CF5  BA2622            mov dx,0x2226
00000CF8  E84EFE            call 0xb49
00000CFB  03363201          add si,[0x132]
00000CFF  BA0E0A            mov dx,0xa0e
00000D02  E844FE            call 0xb49
00000D05  03363201          add si,[0x132]
00000D09  03363401          add si,[0x134]
00000D0D  BA1602            mov dx,0x216
00000D10  E836FE            call 0xb49
00000D13  03363201          add si,[0x132]
00000D17  BA3622            mov dx,0x2236
00000D1A  E82CFE            call 0xb49
00000D1D  03363201          add si,[0x132]
00000D21  BA1E0A            mov dx,0xa1e
00000D24  E822FE            call 0xb49
00000D27  050300            add ax,0x3
00000D2A  BE0100            mov si,0x1
00000D2D  BA0400            mov dx,0x4
00000D30  E816FE            call 0xb49
00000D33  03363201          add si,[0x132]
00000D37  BA2420            mov dx,0x2024
00000D3A  E80CFE            call 0xb49
00000D3D  03363201          add si,[0x132]
00000D41  BA0C08            mov dx,0x80c
00000D44  E802FE            call 0xb49
00000D47  03363201          add si,[0x132]
00000D4B  03363401          add si,[0x134]
00000D4F  BA1400            mov dx,0x14
00000D52  E8F4FD            call 0xb49
00000D55  03363201          add si,[0x132]
00000D59  BA3420            mov dx,0x2034
00000D5C  E8EAFD            call 0xb49
00000D5F  03363201          add si,[0x132]
00000D63  BA1C08            mov dx,0x81c
00000D66  E8E0FD            call 0xb49
00000D69  050300            add ax,0x3
00000D6C  BE0100            mov si,0x1
00000D6F  BA0501            mov dx,0x105
00000D72  E8D4FD            call 0xb49
00000D75  03363201          add si,[0x132]
00000D79  BA2521            mov dx,0x2125
00000D7C  E8CAFD            call 0xb49
00000D7F  03363201          add si,[0x132]
00000D83  BA0D09            mov dx,0x90d
00000D86  E8C0FD            call 0xb49
00000D89  03363201          add si,[0x132]
00000D8D  03363401          add si,[0x134]
00000D91  BA1501            mov dx,0x115
00000D94  E8B2FD            call 0xb49
00000D97  03363201          add si,[0x132]
00000D9B  BA3521            mov dx,0x2135
00000D9E  E8A8FD            call 0xb49
00000DA1  03363201          add si,[0x132]
00000DA5  BA1D09            mov dx,0x91d
00000DA8  E89EFD            call 0xb49
00000DAB  050300            add ax,0x3
00000DAE  BE0100            mov si,0x1
00000DB1  BA0703            mov dx,0x307
00000DB4  E892FD            call 0xb49
00000DB7  03363201          add si,[0x132]
00000DBB  BA2723            mov dx,0x2327
00000DBE  E888FD            call 0xb49
00000DC1  03363201          add si,[0x132]
00000DC5  BA0F0B            mov dx,0xb0f
00000DC8  E87EFD            call 0xb49
00000DCB  03363201          add si,[0x132]
00000DCF  03363401          add si,[0x134]
00000DD3  BA1703            mov dx,0x317
00000DD6  E870FD            call 0xb49
00000DD9  03363201          add si,[0x132]
00000DDD  BA3723            mov dx,0x2337
00000DE0  E866FD            call 0xb49
00000DE3  03363201          add si,[0x132]
00000DE7  BA1F0B            mov dx,0xb1f
00000DEA  E85CFD            call 0xb49
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
00000E14  AC                lodsb
00000E15  AA                stosb
00000E16  AA                stosb
00000E17  E2FB              loop 0xe14
00000E19  8BCB              mov cx,bx
00000E1B  5B                pop bx
00000E1C  3BCB              cmp cx,bx
00000E1E  7508              jnz 0xe28
00000E20  53                push bx
00000E21  83C302            add bx,byte +0x2
00000E24  B1C0              mov cl,0xc0
00000E26  EBD9              jmp short 0xe01
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
00000E50  AC                lodsb
00000E51  AA                stosb
00000E52  AA                stosb
00000E53  E2FB              loop 0xe50
00000E55  83C302            add bx,byte +0x2
00000E58  53                push bx
00000E59  B150              mov cl,0x50
00000E5B  268B07            mov ax,[es:bx]
00000E5E  86C4              xchg al,ah
00000E60  8BF8              mov di,ax
00000E62  26880D            mov [es:di],cl
00000E65  83C701            add di,byte +0x1
00000E68  57                push di
00000E69  8D369501          lea si,[0x195]
00000E6D  B90D00            mov cx,0xd
00000E70  F3A4              rep movsb
00000E72  5F                pop di
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
00000E8E  7508              jnz 0xe98
00000E90  53                push bx
00000E91  83C302            add bx,byte +0x2
00000E94  B140              mov cl,0x40
00000E96  EBC3              jmp short 0xe5b
00000E98  C3                ret
00000E99  8BC1              mov ax,cx
00000E9B  B91400            mov cx,0x14
00000E9E  E2FE              loop 0xe9e
00000EA0  8BC8              mov cx,ax
00000EA2  C3                ret
00000EA3  BA4203            mov dx,0x342
00000EA6  8AC3              mov al,bl
00000EA8  EE                out dx,al
00000EA9  E8EDFF            call 0xe99
00000EAC  BA4003            mov dx,0x340
00000EAF  EC                in al,dx
00000EB0  24E8              and al,0xe8
00000EB2  3AC7              cmp al,bh
00000EB4  C3                ret
00000EB5  EE                out dx,al
00000EB6  86C4              xchg al,ah
00000EB8  EE                out dx,al
00000EB9  C3                ret
00000EBA  B000              mov al,0x0
00000EBC  EE                out dx,al
00000EBD  EC                in al,dx
00000EBE  C3                ret
00000EBF  BA0100            mov dx,0x1
00000EC2  B400              mov ah,0x0
00000EC4  CD16              int 0x16
00000EC6  3C1B              cmp al,0x1b
00000EC8  740A              jz 0xed4
00000ECA  F6063E010F        test byte [0x13e],0xf
00000ECF  7406              jz 0xed7
00000ED1  EB69              jmp short 0xf3c
00000ED3  90                nop
00000ED4  E950F7            jmp 0x627
00000ED7  3C20              cmp al,0x20
00000ED9  7413              jz 0xeee
00000EDB  F7062A010100      test word [0x12a],0x1
00000EE1  7408              jz 0xeeb
00000EE3  3C12              cmp al,0x12
00000EE5  7414              jz 0xefb
00000EE7  3C13              cmp al,0x13
00000EE9  7439              jz 0xf24
00000EEB  33D2              xor dx,dx
00000EED  C3                ret
00000EEE  C6063E0101        mov byte [0x13e],0x1
00000EF3  33C0              xor ax,ax
00000EF5  E88401            call 0x107c
00000EF8  0BD2              or dx,dx
00000EFA  C3                ret
00000EFB  33C0              xor ax,ax
00000EFD  A32A01            mov [0x12a],ax
00000F00  A30A00            mov [0xa],ax
00000F03  A32A00            mov [0x2a],ax
00000F06  A34A00            mov [0x4a],ax
00000F09  A36A00            mov [0x6a],ax
00000F0C  A38A00            mov [0x8a],ax
00000F0F  A3AA00            mov [0xaa],ax
00000F12  A3CA00            mov [0xca],ax
00000F15  A3EA00            mov [0xea],ax
00000F18  A30A01            mov [0x10a],ax
00000F1B  B80600            mov ax,0x6
00000F1E  E85B01            call 0x107c
00000F21  0BD2              or dx,dx
00000F23  C3                ret
00000F24  80363C0101        xor byte [0x13c],0x1
00000F29  7408              jz 0xf33
00000F2B  33C0              xor ax,ax
00000F2D  E84C01            call 0x107c
00000F30  33D2              xor dx,dx
00000F32  C3                ret
00000F33  B82400            mov ax,0x24
00000F36  E84301            call 0x107c
00000F39  33D2              xor dx,dx
00000F3B  C3                ret
00000F3C  3C0D              cmp al,0xd
00000F3E  740B              jz 0xf4b
00000F40  3C01              cmp al,0x1
00000F42  7415              jz 0xf59
00000F44  3C13              cmp al,0x13
00000F46  7424              jz 0xf6c
00000F48  33D2              xor dx,dx
00000F4A  C3                ret
00000F4B  C6063E0100        mov byte [0x13e],0x0
00000F50  B80600            mov ax,0x6
00000F53  E82601            call 0x107c
00000F56  0BD2              or dx,dx
00000F58  C3                ret
00000F59  FE063E01          inc byte [0x13e]
00000F5D  803E3E0103        cmp byte [0x13e],0x3
00000F62  7605              jna 0xf69
00000F64  C6063E0101        mov byte [0x13e],0x1
00000F69  0BD2              or dx,dx
00000F6B  C3                ret
00000F6C  803E3E0102        cmp byte [0x13e],0x2
00000F71  750F              jnz 0xf82
00000F73  A03F01            mov al,[0x13f]
00000F76  3474              xor al,0x74
00000F78  A23F01            mov [0x13f],al
00000F7B  B41E              mov ah,0x1e
00000F7D  CD40              int 0x40
00000F7F  0BD2              or dx,dx
00000F81  C3                ret
00000F82  803E3E0103        cmp byte [0x13e],0x3
00000F87  75BF              jnz 0xf48
00000F89  8336300107        xor word [0x130],byte +0x7
00000F8E  8336320118        xor word [0x132],byte +0x18
00000F93  8336340104        xor word [0x134],byte +0x4
00000F98  8336360106        xor word [0x136],byte +0x6
00000F9D  8336380101        xor word [0x138],byte +0x1
00000FA2  81363A01CC00      xor word [0x13a],0xcc
00000FA8  0BD2              or dx,dx
00000FAA  C3                ret
00000FAB  803E3E0101        cmp byte [0x13e],0x1
00000FB0  741A              jz 0xfcc
00000FB2  803E3E0102        cmp byte [0x13e],0x2
00000FB7  7417              jz 0xfd0
00000FB9  803E3E0103        cmp byte [0x13e],0x3
00000FBE  7414              jz 0xfd4
00000FC0  F7062A010100      test word [0x12a],0x1
00000FC6  7510              jnz 0xfd8
00000FC8  E839F9            call 0x904
00000FCB  C3                ret
00000FCC  E8B7F9            call 0x986
00000FCF  C3                ret
00000FD0  E824FA            call 0x9f7
00000FD3  C3                ret
00000FD4  E8E6FB            call 0xbbd
00000FD7  C3                ret
00000FD8  E869F6            call 0x644
00000FDB  C3                ret
00000FDC  803E3E0100        cmp byte [0x13e],0x0
00000FE1  750F              jnz 0xff2
00000FE3  F7062A010100      test word [0x12a],0x1
00000FE9  7504              jnz 0xfef
00000FEB  E855F9            call 0x943
00000FEE  C3                ret
00000FEF  E8D8F8            call 0x8ca
00000FF2  C3                ret
00000FF3  B400              mov ah,0x0
00000FF5  CD40              int 0x40
00000FF7  9C                pushf
00000FF8  B401              mov ah,0x1
00000FFA  CD16              int 0x16
00000FFC  7409              jz 0x1007
00000FFE  E8BEFE            call 0xebf
00001001  7404              jz 0x1007
00001003  9D                popf
00001004  EB04              jmp short 0x100a
00001006  90                nop
00001007  9D                popf
00001008  730E              jnc 0x1018
0000100A  B404              mov ah,0x4
0000100C  CD40              int 0x40
0000100E  8CC0              mov ax,es
00001010  0BC3              or ax,bx
00001012  74DF              jz 0xff3
00001014  E894FF            call 0xfab
00001017  C3                ret
00001018  E88900            call 0x10a4
0000101B  750D              jnz 0x102a
0000101D  B404              mov ah,0x4
0000101F  CD40              int 0x40
00001021  8CC0              mov ax,es
00001023  0BC3              or ax,bx
00001025  74CC              jz 0xff3
00001027  E8B2FF            call 0xfdc
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
00001048  60                pusha
00001049  32E4              xor ah,ah
0000104B  CD1A              int 0x1a
0000104D  BE0100            mov si,0x1
00001050  F70660020100      test word [0x260],0x1
00001056  7512              jnz 0x106a
00001058  A15E02            mov ax,[0x25e]
0000105B  2BC2              sub ax,dx
0000105D  7619              jna 0x1078
0000105F  A15A02            mov ax,[0x25a]
00001062  2BC2              sub ax,dx
00001064  7712              ja 0x1078
00001066  0BF6              or si,si
00001068  61                popa
00001069  C3                ret
0000106A  A15E02            mov ax,[0x25e]
0000106D  2BC2              sub ax,dx
0000106F  77F5              ja 0x1066
00001071  A15A02            mov ax,[0x25a]
00001074  2BC2              sub ax,dx
00001076  76EE              jna 0x1066
00001078  33F6              xor si,si
0000107A  61                popa
0000107B  C3                ret
0000107C  60                pusha
0000107D  8BD8              mov bx,ax
0000107F  0BDB              or bx,bx
00001081  7419              jz 0x109c
00001083  33C0              xor ax,ax
00001085  CD1A              int 0x1a
00001087  89166402          mov [0x264],dx
0000108B  89166802          mov [0x268],dx
0000108F  A36A02            mov [0x26a],ax
00001092  011E6802          add [0x268],bx
00001096  11066A02          adc [0x26a],ax
0000109A  61                popa
0000109B  C3                ret
0000109C  C7066A020200      mov word [0x26a],0x2
000010A2  61                popa
000010A3  C3                ret
000010A4  60                pusha
000010A5  BE0100            mov si,0x1
000010A8  F7066A020200      test word [0x26a],0x2
000010AE  751A              jnz 0x10ca
000010B0  32E4              xor ah,ah
000010B2  CD1A              int 0x1a
000010B4  F7066A020100      test word [0x26a],0x1
000010BA  7512              jnz 0x10ce
000010BC  A16802            mov ax,[0x268]
000010BF  2BC2              sub ax,dx
000010C1  7619              jna 0x10dc
000010C3  A16402            mov ax,[0x264]
000010C6  2BC2              sub ax,dx
000010C8  7712              ja 0x10dc
000010CA  0BF6              or si,si
000010CC  61                popa
000010CD  C3                ret
000010CE  A16802            mov ax,[0x268]
000010D1  2BC2              sub ax,dx
000010D3  77F5              ja 0x10ca
000010D5  A16402            mov ax,[0x264]
000010D8  2BC2              sub ax,dx
000010DA  76EE              jna 0x10ca
000010DC  33F6              xor si,si
000010DE  61                popa
000010DF  C3                ret
000010E0  BA08FF            mov dx,0xff08
000010E3  ED                in ax,dx
000010E4  A38202            mov [0x282],ax
000010E7  C3                ret
000010E8  BA08FF            mov dx,0xff08
000010EB  A18202            mov ax,[0x282]
000010EE  EF                out dx,ax
000010EF  C3                ret
000010F0  BA08FF            mov dx,0xff08
000010F3  A18202            mov ax,[0x282]
000010F6  0DD400            or ax,0xd4
000010F9  EF                out dx,ax
000010FA  C3                ret
000010FB  BA1EFF            mov dx,0xff1e
000010FE  ED                in ax,dx
000010FF  A38802            mov [0x288],ax
00001102  BA1EFF            mov dx,0xff1e
00001105  B81800            mov ax,0x18
00001108  EF                out dx,ax
00001109  C3                ret
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
0000112A  7305              jnc 0x1131
0000112C  8887E701          mov [bx+0x1e7],al
00001130  43                inc bx
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
0000114E  730C              jnc 0x115c
00001150  BA6AFF            mov dx,0xff6a
00001153  8A87AF01          mov al,[bx+0x1af]
00001157  EE                out dx,al
00001158  FF06E501          inc word [0x1e5]
0000115C  BA02FF            mov dx,0xff02
0000115F  B80080            mov ax,0x8000
00001162  EF                out dx,ax
00001163  1F                pop ds
00001164  61                popa
00001165  CF                iret
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
0000125A  06                push es
0000125B  50                push ax
0000125C  53                push bx
0000125D  33C0              xor ax,ax
0000125F  8EC0              mov es,ax
00001261  BB0E00            mov bx,0xe
00001264  D1E3              shl bx,1
00001266  D1E3              shl bx,1
00001268  A17A02            mov ax,[0x27a]
0000126B  268907            mov [es:bx],ax
0000126E  A17C02            mov ax,[0x27c]
00001271  26894702          mov [es:bx+0x2],ax
00001275  5B                pop bx
00001276  58                pop ax
00001277  07                pop es
00001278  BA1CFF            mov dx,0xff1c
0000127B  A18602            mov ax,[0x286]
0000127E  EF                out dx,ax
0000127F  C3                ret
00001280  60                pusha
00001281  1E                push ds
00001282  B83401            mov ax,0x134
00001285  8ED8              mov ds,ax
00001287  C606570201        mov byte [0x257],0x1
0000128C  E88D00            call 0x131c
0000128F  BA02FF            mov dx,0xff02
00001292  B80080            mov ax,0x8000
00001295  EF                out dx,ax
00001296  BA0103            mov dx,0x301
00001299  B80038            mov ax,0x3800
0000129C  E816FC            call 0xeb5
0000129F  1F                pop ds
000012A0  61                popa
000012A1  CF                iret
000012A2  06                push es
000012A3  50                push ax
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
000012F7  BA0103            mov dx,0x301
000012FA  B000              mov al,0x0
000012FC  E8BBFB            call 0xeba
000012FF  A804              test al,0x4
00001301  7418              jz 0x131b
00001303  8B1EE501          mov bx,[0x1e5]
00001307  81FB3600          cmp bx,0x36
0000130B  730E              jnc 0x131b
0000130D  8A87AF01          mov al,[bx+0x1af]
00001311  BA0303            mov dx,0x303
00001314  EE                out dx,al
00001315  FF06E501          inc word [0x1e5]
00001319  EBDC              jmp short 0x12f7
0000131B  C3                ret
0000131C  BA0103            mov dx,0x301
0000131F  B000              mov al,0x0
00001321  E896FB            call 0xeba
00001324  A801              test al,0x1
00001326  7419              jz 0x1341
00001328  BA0303            mov dx,0x303
0000132B  EC                in al,dx
0000132C  8B1E5502          mov bx,[0x255]
00001330  81FB3600          cmp bx,0x36
00001334  7305              jnc 0x133b
00001336  88871F02          mov [bx+0x21f],al
0000133A  43                inc bx
0000133B  891E5502          mov [0x255],bx
0000133F  EBDB              jmp short 0x131c
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
