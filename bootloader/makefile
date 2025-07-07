ASM     = nasm
ASMFLAGS = -f bin

SRC_DIR = src
OUT_DIR = build

BOOTLOADER = $(OUT_DIR)/main.bin

all: $(BOOTLOADER)

$(BOOTLOADER): $(SRC_DIR)/main.asm $(SRC_DIR)/gdt.asm $(SRC_DIR)/protected32.asm $(SRC_DIR)/print_string.asm | $(OUT_DIR)
	$(ASM) $(ASMFLAGS) $< -o $@

$(OUT_DIR):
	@if not exist $(OUT_DIR) mkdir $(OUT_DIR)

clean:
	@if exist $(OUT_DIR) rmdir /s /q $(OUT_DIR)