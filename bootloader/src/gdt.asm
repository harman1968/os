[bits 16]

setup_gdt_and_enter_pm:
    ; Enable A20
    in al, 0x92
    or al, 0x02
    out 0x92, al

    ; Load GDT
    lgdt [gdt_descriptor]

    ; Set PE bit in CR0
    mov eax, cr0
    or eax, 1
    mov cr0, eax

    ; Far jump to 32-bit code
    jmp far [protected_mode_jump]

gdt_start:
    dq 0  ; Null descriptor

    ; Code segment
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 0x9A
    db 0xCF
    db 0x00

    ; Data segment
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 0x92
    db 0xCF
    db 0x00
gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

CODE_SEGMENT equ 0x08
DATA_SEGMENT equ 0x10

protected_mode_jump:
    dw start_protected_mode
    dw CODE_SEGMENT

%include "src/protected32.asm"
