[bits 16]
[org 0x8000]

stage2_start:
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

[bits 32]
start_protected_mode:
    
    
hang32:
    jmp hang32
