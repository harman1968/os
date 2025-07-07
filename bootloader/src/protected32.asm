[bits 32]

start_protected_mode:
    ; Load segment registers
    mov ax, DATA_SEGMENT
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    ; Setup stack
    mov esp, 0x9000

    ; Write 'P' to screen (0x0F = white on black)
    mov word [0xB8000], 0x0F50

.hang32:
    jmp .hang32
