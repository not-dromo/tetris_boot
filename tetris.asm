ORG 0X7C00

start:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00



    jmp $



begin_draw dd 0
sq_width dd 40
sq_height dd 70
DRAW_START dd 0xA0000
COLOR_RED equ 0x04

times 510-($-$$) db 0

dw 0xAA55
