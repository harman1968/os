# Makefile for bootloader build on Windows (PowerShell + NASM)
# Folders: src/ for code, build/ for output

ASM = nasm
ASMFLAGS = -f bin

SRC_FILE = src/main.asm
OUT_DIR = build

BOOTLOADER = $(OUT_DIR)/bootloader.bin
STAGE2    = $(OUT_DIR)/stage2.bin
DISK      = $(OUT_DIR)/disk.img

all: $(DISK)

# Step 1: Assemble bootloader to build/bootloader.bin
$(BOOTLOADER): $(SRC_FILE)
	$(ASM) $(ASMFLAGS) $(SRC_FILE) -o $(BOOTLOADER)

# Step 2: Create 512-byte empty stage2.bin
$(STAGE2):
	powershell -Command "$$zeros = [byte[]]::new(512); [System.IO.File]::WriteAllBytes('$(STAGE2)', $$zeros)"

# Step 3: Combine bootloader + stage2 into disk.img
$(DISK): $(BOOTLOADER) $(STAGE2)
	powershell -Command \
		"$$boot = [System.IO.File]::ReadAllBytes('$(BOOTLOADER)');" \
		"$$stage2 = [System.IO.File]::ReadAllBytes('$(STAGE2)');" \
		"[System.IO.File]::WriteAllBytes('$(DISK)', $$boot + $$stage2)"

# Clean all outputs from build/
clean:
	del /Q $(OUT_DIR)\*.bin $(OUT_DIR)\*.img 2> NUL
