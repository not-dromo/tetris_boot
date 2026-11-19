ORG 0X7C00

start:
    xor ax, ax                  ; ax becomes 0
    mov ds, ax                  ; ds becomes 0 
    mov es, ax                  ; es becomes 0
    mov ss, ax                  ; ss becomes 0
    mov sp, 0x7C00              ; defines the stack pointer to 0x7C00 (address where the BIOS loads the code)

    mov al, 0x13                ; stores video mode value in al
    int 0x10                    ; calls BIOS to read al

    mov edi, DRAW_START         ; moves to edi the byte valeu of the first pixel in the screen
    mov byte [edi], COLOR_RED   ; colors that byte in red


    jmp $                       ; eternal loop: jumps to the address it already is ($ stores the current address)


; defining variables
begin_draw dd 0                 ; dd is for 4 bytes (db 1 byte, dw 2 bytes)
sq_width dd 40
sq_height dd 70
DRAW_START equ 0xA0000
COLOR_RED equ 0x04              ; equ is fixed, meaning it cannot change throughout the code

times 510-($-$$) db 0           ; fills all the bytes (except the last 2) with 0

dw 0xAA55                       ; writes the bios signature in the last 2 bytes of the 512