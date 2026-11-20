ORG 0X7C00

start:
    xor ax, ax                  ; ax becomes 0
    mov ds, ax                  ; ds becomes 0 
    mov es, ax                  ; es becomes 0
    mov ss, ax                  ; ss becomes 0
    mov sp, 0x7C00              ; defines the stack pointer to 0x7C00 (address where the BIOS loads the code)

    mov al, 0x13                ; stores video mode value in al
                                ; video mode gives you color and it's 320x200 resolution
    int 0x10                    ; calls BIOS to read al

    call draw_square


    jmp $                       ; eternal loop: jumps to the address it already is ($ stores the current address)



draw_square:
    
    mov edi, DRAW_START         ; moves to edi the byte valeu of the first pixel in the screen
    mov eax, [sq_y]             ; moves the start height value to eax
    mov ebx, 320                ; stores the amount of horizontal pixels in the screen to ebx
    mul ebx                     ; the mul instruction multiplies and stores in eax (eax is implicit)
                                ; meaning: mul ebx --> eax = eax*ebx
                                ; so these last 3 lines are how we move down [sq_y] pixels
    add edi, eax                ; now we add the result to the first pixel
    add edi, [sq_x]             ; and then we add the x distance

    jmp .put_pixel              ; and we goto put pixel



.move_down:
    add edi, 320                ; adds the width of the screen to edi so it moves 1 pixel down
    sub edi, [sq_width]         ; so it goes back to the beginning of the square
.put_pixel:
    mov byte [edi], COLOR_RED   ; colors the current byte we are in the screen (i.e. in edi) as red
    inc edi                     ; moves to the next pixel
    inc ecx                     ; width
    cmp ecx, [sq_width]         ; checks if it reached the end of the width
    jl .put_pixel               ; if it didn't then go back to the begginning to add another pixel

    mov ecx, $0                 ; if it did than we clear ecx --> (xor ecx, ecx) is another option

    inc edx                     ; add one to height
    cmp edx, [sq_height]        ; checks if it reached the end of the height
    jl .move_down               ; if it didn't than goto .move_down
.done:
    ret                         ; if it did the code ends
;---------------------------------------------------------------------------------------------------------------;

; defining variables ;
begin_draw dd 0                 ; dd is for 4 bytes (db 1 byte, dw 2 bytes)

sq_x dd 100

sq_y dd 50

sq_width dd 40

sq_height dd 70

DRAW_START equ 0xA0000          ; start location of buffer that has every single pixel of the screen (64.000 pixels)

COLOR_RED equ 0x04              ; equ is fixed, meaning it cannot change throughout the code



times 510-($-$$) db 0           ; fills all the bytes (except the last 2) with 0

dw 0xAA55                       ; writes the bios signature in the last 2 bytes of the 512