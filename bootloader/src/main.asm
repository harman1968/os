[bits 16]
[org 0x7c00]

start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ax, 0x8000
    mov ss, ax
    mov sp, 0x8100

    ; Print "OK"
    mov si, msg_ok
    call print_string

    ; Setup GDT + switch to protected mode
    call setup_gdt_and_enter_pm

    ; msg
    msg_ok db 'OK', 0

    ; Includes
    %include "src/print_string.asm"
    %include "src/gdt.asm"

hang:
    jmp hang

times 510 - ($ - $$) db 0
dw 0xAA55
