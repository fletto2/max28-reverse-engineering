; ============================================================================
; flashdump.asm  -  LT300 / Link MAX28 flash-dumper boot ROM   (rev 2)
; ----------------------------------------------------------------------------
; Replacement boot ROM (27C512, 64 KiB) for the 80C188EB SBC. On reset it brings
; up the chip-selects as the stock firmware does, configures the Zilog Z8530 SCC
; for async TX, and streams the two Intel 28F001 flash chips (CPU physical
; 0x80000-0xBFFFF, 256 KiB) out the serial port as Motorola S-records.
; READ-ONLY w.r.t. the flash (28F001 powers up in read-array mode).
;
; STRUCTURE (mirrors the stock ROM, because at reset only the top ~1 KiB of ROM
; is mapped until UCS is programmed):
;     - reset vector @file 0xFFF0  -> JMP FFE0:0000 (file 0xFE00)
;     - init stub    @file 0xFE00  -> program chip-selects, then JMP F000:0000
;     - main body    @file 0x0000  -> SCC init + dump (CS=0xF000, now mapped)
; With org 0 the main body's labels equal their file offsets = IP offsets under
; CS=0xF000, so no address fixups are needed.
;
; ASSEMBLE: nasm -f bin flashdump.asm -o flashdump.bin   (must be 65536 bytes)
; USE: burn to 27C512, socket in place of stock ROM (KEEP THE ORIGINAL). Capture
;      AUX SERIAL on a PC; then  srec_cat capture.s19 -o flash.bin -binary
;      (add  -offset -0x80000  for a 0-based 256 KiB image).
;
; VERIFIED VALUES (council + Z8530 datasheet): WR4=0x44(x16,1stop,noparity),
;   WR3=0xC1(Rx8+en), WR5=0x68(Tx8+en), WR11=0x00(clk=RTxC), WR14=0x00, WR9=0xC0.
;   SCC @0x300-0x303: 0x301/0x303=control, 0x300/0x302=data; AUX channel unknown
;   so init+TX on BOTH.  Chip-select OUT stream copied verbatim from stock init.
; *** ONE UNKNOWN = BAUD: SCC is externally clocked (RTxC) from a timer off the
;   49.423 MHz crystal; target 9600 8N1. A 0x55 calibration preamble is sent first
;   so the host baud can be locked / scoped. Only value not proven first-try. ***
; ============================================================================

bits 16
cpu 186
org 0                       ; main body at file 0 runs as CS=0xF000, IP=file off

; NOTE on 'out dx,al' (NOT 'out dx,ax'): the stock firmware programs these 16-bit
; PCB chip-select registers with exactly 'mov ax,VAL / out dx,al' and the machine
; boots - which only works if a byte OUT to an on-chip PCB register latches the
; full 16-bit AX (a low-byte-only write would leave UCS=0x01 and the ROM wouldn't
; map). So this is correct and intentional; do NOT "fix" it to out dx,ax.
%macro PCB 2                ; write 16-bit %2 to PCB reg %1 (byte OUT latches AX)
        mov dx,%1
        mov ax,%2
        out dx,al
%endmacro

; ============================================================================
; MAIN BODY  - file 0x0000, entered far as F000:0000 after the stub.
; ============================================================================
main:
        xor ax,ax
        mov ss,ax
        mov sp,0xFFFE               ; SS:SP = 0000:FFFE (low DRAM; refresh is up)
        push cs
        pop ds                      ; DS = CS = 0xF000 (for string reads)

        mov dx,0x0343               ; video heartbeat - screen shows we are alive
        mov al,0x44
        out dx,al

        call scc_reset              ; Z8530 async 8N1 TX on both channels
        mov dx,0x0301
        call scc_chan
        mov dx,0x0303
        call scc_chan

        mov cx,200                  ; calibration preamble: 200 x 'U' (0x55)
.pre:
        mov bl,0x55
        call send_bl
        loop .pre
        call send_crlf

        mov si,str_s0               ; S0 header "S0030000FC"
        call send_str
        call send_crlf

        ; ---- dump 0x80000-0xBFFFF as S2 records, 16 data bytes each ----
        mov bp,0x0008               ; BP = addr[23:16] = 0x08..0x0B ; ES = BP<<12
.block:
        mov ax,bp
        mov cl,12
        shl ax,cl
        mov es,ax                   ; ES = 0x8000/0x9000/0xA000/0xB000
        mov dx,0x0343               ; per-block heartbeat
        mov ax,bp
        out dx,al
        xor si,si
.rec:
        xor bh,bh                   ; record checksum
        mov bl,'S'
        call send_bl
        mov bl,'2'
        call send_bl
        mov al,0x14                 ; count = 3 addr + 16 data + 1 csum
        call put_hex
        mov ax,bp                   ; addr[23:16]
        call put_hex
        mov ax,si                   ; addr[15:8]
        mov al,ah
        call put_hex
        mov ax,si                   ; addr[7:0]
        call put_hex
        mov cx,16
.data:
        mov al,[es:si]
        inc si
        call put_hex
        loop .data
        mov al,bh                   ; csum = ones-complement of running sum
        not al
        call put_hex
        call send_crlf
        cmp si,0                    ; wrapped past 0xFFFF -> block complete
        jne .rec
        inc bp
        cmp bp,0x000C
        jb .block

        mov si,str_s8               ; S8 termination
        call send_str
        call send_crlf

        mov dx,0x0343               ; done: solid video, halt
        mov al,0xFF
        out dx,al
.halt:
        hlt
        jmp .halt

; ----------------------------------------------------------------------------
scc_reset:                          ; force HW reset of the whole SCC (WR9=0xC0)
        mov dx,0x0301
        mov al,9
        out dx,al
        mov al,0xC0
        out dx,al
        mov cx,2000                 ; settle delay
.sd:
        loop .sd
        ret

scc_chan:                           ; DX = channel CONTROL port; async 8N1 TX
        mov al,4
        out dx,al
        mov al,0x44                 ; WR4: x16, 1 stop, no parity
        out dx,al
        mov al,3
        out dx,al
        mov al,0xC1                 ; WR3: Rx 8-bit + Rx enable
        out dx,al
        mov al,5
        out dx,al
        mov al,0x68                 ; WR5: Tx 8-bit + Tx enable
        out dx,al
        mov al,11
        out dx,al
        mov al,0x00                 ; WR11: Rx/Tx clock = RTxC pin
        out dx,al
        mov al,14
        out dx,al
        mov al,0x00                 ; WR14: BRG off, no loopback
        out dx,al
        ret

send_bl:                            ; transmit BL out BOTH channels (polled).
                                    ; DI = ~64K-spin timeout so a dead RTxC clock
                                    ; can't hang the dump forever (the video
                                    ; heartbeat then keeps advancing, making a
                                    ; serial-clock fault visible instead of a freeze).
        mov di,0
.wa:
        mov dx,0x0301               ; ch A control -> RR0
        in al,dx
        test al,0x04                ; RR0 D2 = Tx Buffer Empty
        jnz .asend
        dec di
        jnz .wa
        jmp .b                      ; ch A timed out -> skip
.asend:
        mov al,bl
        mov dx,0x0300               ; ch A data
        out dx,al
.b:
        mov di,0
.wb:
        mov dx,0x0303               ; ch B control -> RR0
        in al,dx
        test al,0x04
        jnz .bsend
        dec di
        jnz .wb
        ret                         ; ch B timed out -> done
.bsend:
        mov al,bl
        mov dx,0x0302               ; ch B data
        out dx,al
        ret

send_crlf:
        mov bl,13
        call send_bl
        mov bl,10
        call send_bl
        ret

send_str:                           ; DS:SI -> NUL-terminated string (DS=CS=0xF000)
.sl:
        mov bl,[si]
        inc si
        or bl,bl
        jz .done
        call send_bl
        jmp .sl
.done:
        ret

put_hex:                            ; AL=byte -> 2 hex on both ch; BH += byte
        add bh,al
        mov ah,al
        shr al,1
        shr al,1
        shr al,1
        shr al,1                    ; AL = high nibble
        call nib_send
        mov al,ah
        and al,0x0F                 ; AL = low nibble
nib_send:                           ; (fall-through) AL nibble -> ascii -> send
        cmp al,10
        jb .dec
        add al,7
.dec:
        add al,0x30
        mov bl,al
        jmp send_bl                 ; tail-call

str_s0:  db 'S0030000FC',0
str_s8:  db 'S804000000FB',0

; ============================================================================
; INIT STUB  - file 0xFE00 (FFE0:0000). Runs from the reset-mapped top of ROM.
; Programs the chip-selects/refresh/timers, then far-jumps to the main body.
; ============================================================================
        times (0xFE00 - ($-$$)) db 0xFF
init_stub:
        cli
        cld
        PCB 0xFFA4,0xE001           ; UCS START (expands ROM mapping)
        PCB 0xFFA6,0x000E           ; UCS STOP
        PCB 0xFFA0,0x0000           ; LCS START (DRAM @0)
        PCB 0xFFA2,0x800A           ; LCS STOP
        PCB 0xFF80,0x8001           ; GCS0 START (flash @0x80000)
        PCB 0xFF82,0xA00A           ; GCS0 STOP
        PCB 0xFF84,0xA001           ; GCS1 START (flash @0xA0000)
        PCB 0xFF86,0xC00A           ; GCS1 STOP
        PCB 0xFF88,0xC002           ; GCS2 START
        PCB 0xFF8A,0xD00A           ; GCS2 STOP
        PCB 0xFF8C,0xD005           ; GCS3 START
        PCB 0xFF8E,0xE00A           ; GCS3 STOP
        PCB 0xFF90,0x0340           ; GCS I/O window (video 0x340)
        PCB 0xFF92,0x0389
        PCB 0xFF94,0x0300           ; GCS I/O window (SCC 0x300)
        PCB 0xFF96,0x0349
        PCB 0xFFB0,0x0000           ; refresh control (DRAM refresh)
        PCB 0xFFB2,0x008C
        PCB 0xFFB4,0x8000
        PCB 0xFF64,0x0001           ; timer block (baud clock source)
        mov dx,0xFF74
        out dx,al
        PCB 0xFF58,0x0035
        PCB 0xFF54,0x003F
        PCB 0xFF5C,0x0000
        PCB 0xFF5E,0x00C0
        jmp 0xF000:0x0000           ; -> main body (now mapped)

; ============================================================================
; reset vector + 64 KiB pad
; ============================================================================
        times (0xFFF0 - ($-$$)) db 0xFF
        jmp 0xFFE0:0x0000           ; power-on reset -> init_stub (EA 00 00 E0 FF)
        times (0x10000 - ($-$$)) db 0xFF
