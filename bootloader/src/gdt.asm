gdt_start:
    null_descriptor:
        dd 0
        dd 0
        ; dd - double word - 4 byte
        ; in total we set 8 bytes to get entry in gdt
        ; can also use dq - 8 byte single go
    code_descriptor:
        ; limit and base
        ; there is an sequnece using which we intilize this
        ; first 16 bit for limit
        dw 0xffff
        ; next 24 bit bit for base
        dw 0    ; 16 bit
        db 0    ; 8 bit
        ; next 8 bit for access setting
        ; (4 bit for 1-bit present, 2-bit privillage, 1-bit type - 4 bit for type flag)
        db 10011010
        ; next 8 bit divide into two part
        ; (4 bit for other flag - 4 bit for limit)
        db 11001111
        ; last 8 bit base
        db 0
    data_descriptor:
        ; same as code descriptor
        dw 0xffff
        dw 0
        db 0
        ; in this type flag are different
        db 10010010
        db 11001111
        db 0
    gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1      ; size
    dd gdt_start                    ; start

CODE_SEGMENT equ code_descriptor - gdt_start
DATA_SEGMENT equ data_descriptor - gdt_start