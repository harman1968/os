[bits 16]
[org 0x0000]

start:
    cli

    ; Enable A20 line (Fast A20 method)
        in al, 0x92
        or al, 0x02
        out 0x92, al

    ; setup gdt
        call gdt_start
        lgdt [gdt_descriptor]
    
    ; change last bit of cr0 to 1
        mov eax, cr0
        or eax, 1
        mov cr0, eax
        jmp CODE_SEGMENT : start_protected_mode

    %include "src/gdt.asm"

    times 510 - ($ - $$) db 0

; Include routines
%include "src/print_string.asm"
%include "src/gdt.asm"

; ------- 32-bit Protected Mode Code -------
[bits 32]
start_protected_mode:
    ; Set data segment registers
    mov ax, DATA_SEGMENT
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    ; Set up stack
    mov esp, 0x7C00

    ; Write 'P' on screen (0x0F = white on black)
    mov word [0xB8000], 0x0F50

hang:
    jmp hang
