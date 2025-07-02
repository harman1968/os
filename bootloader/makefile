ASM = nasm
ASMFLAGS = -f bin

SRC_DIR = src
OUT_DIR = build

BOOTLOADER = $(OUT_DIR)/bootloader.bin
STAGE2    = $(OUT_DIR)/stage2.bin
DISK      = $(OUT_DIR)/disk.img

all: $(DISK)

# Compile stage 1
$(BOOTLOADER): $(SRC_DIR)/main.asm
	$(ASM) $(ASMFLAGS) $(SRC_DIR)/main.asm -o $(BOOTLOADER)

# Compile stage 2
$(STAGE2): $(SRC_DIR)/stage2.asm
	$(ASM) $(ASMFLAGS) $(SRC_DIR)/stage2.asm -o $(STAGE2)

# Combine bootloader + stage2 into disk.img (PowerShell-friendly)
$(DISK): $(BOOTLOADER) $(STAGE2)
	powershell -Command "Get-Content $(BOOTLOADER), $(STAGE2) -Encoding Byte -ReadCount 0 | Set-Content $(DISK) -Encoding Byte"

# Clean build artifacts
clean:
	del /q $(OUT_DIR)\*.bin 2>nul || exit 0
