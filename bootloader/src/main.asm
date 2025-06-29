[bits 16]
[org 0x7C00]  ; BIOS loads bootloader to this address

main:
        cli
        ; Segment Setup
            xor ax, ax
            mov ds, ax
            mov es, ax
        ; Stack Setup
            mov ax, 0x8000
            mov ss, ax
            mov sp, 0xFFFF
        sti

        ; Print startup message
            mov si, msg
            call print_string

        ; call disk loader
            call disk_loader

    hang:
        jmp hang

; Files that are included
    %include "src/print_string.asm"
    %include "src/disk_loader.asm"

; Messages
    msg       db "Stack and segment both are setup.", 13, 10, 0

times 510 - ($ - $$) db 0
dw 0xAA55