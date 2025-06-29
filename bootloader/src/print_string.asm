print_string:

        push ax
        push si

        .print_char_loop:
            mov al, [si]
            cmp al, 0
            je .done_label
            mov ah, 0x0E
            int 0x10
            inc si
            jmp .print_char_loop

        .done_label:
            pop si
            pop ax
    
    ret