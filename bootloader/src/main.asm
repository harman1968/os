[bits 16]
[org 0x7C00]

start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax

    ; Setup stack
    mov ax, 0x8000
    mov ss, ax
    mov sp, 0x8100
    sti

    ; Load stage2 from disk (sector 2 to 0x8000:0000)
    call disk_loader

    jmp 0x000:0x8000

; ------------------------
; Print routine and disk loader
%include "src\print_string.asm"
%include "src\disk_loader.asm"

; ------------------------
; Boot Signature (ends at exactly 512 bytes)
times 510 - ($ - $$) db 0
dw 0xAA55
