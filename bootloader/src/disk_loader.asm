disk_loader:

        mov ax, 0x8000        ; Set segment where data will be loaded
        mov es, ax
        xor bx, bx            ; Offset = 0

        mov ah, 0x02          ; BIOS function: Read Sector(s)
        mov al, 1             ; Read 1 sector
        mov ch, 0             ; Cylinder = 0
        mov cl, 2             ; Sector = 2 (first after bootloader)
        mov dh, 0             ; Head = 0
        mov dl, 0x80          ; drive (hard disk)

        int 0x13              ; Disk interrupt

        jc disk_error         ; Jump if carry flag set (i.e., error)
        jmp disk_success      ; Otherwise, jump to success

        ; Disk error handler
            disk_error:
                mov si, err_msg
                call print_string
                jmp hang

        ; Disk success handler
            disk_success:
                mov si, succ_msg
                call print_string
                jmp 0x000:0x8000

    err_msg   db "Disk read failed!", 13, 10, 0
    succ_msg  db "Disk read successful.", 13, 10, 0

    ret
