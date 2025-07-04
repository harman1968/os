ASM = nasm
ASMFLAGS = -f bin

SRC_DIR = src
OUT_DIR = build

BOOTLOADER = $(OUT_DIR)/bootloader.bin
STAGE2    = $(OUT_DIR)/stage2.bin
DISK      = $(OUT_DIR)/disk.img

all: $(DISK)

$(BOOTLOADER): $(SRC_DIR)/main.asm
	$(ASM) $(ASMFLAGS) $< -o $@

$(STAGE2): $(SRC_DIR)/stage2.asm
	$(ASM) $(ASMFLAGS) $< -o $@

$(DISK): $(BOOTLOADER) $(STAGE2)
	powershell -Command "Get-Content $(BOOTLOADER), $(STAGE2) -Encoding Byte -ReadCount 0 | Set-Content $(DISK) -Encoding Byte"

clean:
	del /q $(OUT_DIR)\*.bin $(OUT_DIR)\*.img
