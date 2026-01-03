# --- Toolchain Definitions ---
AS = riscv32-unknown-elf-as -march=rv32i -mabi=ilp32
GCC = riscv32-unknown-elf-gcc -march=rv32i -mabi=ilp32
OBJCOPY = riscv32-unknown-elf-objcopy
HEXDUMP = hexdump

#libgcc will be used implicitly because our core is rv32i

# --- Source Files ---
C_SRCS = main.c outchar.c
S_SRCS = printshort.S start.S

# --- Object Files ---
OBJS = $(C_SRCS:.c=.o) $(S_SRCS:.S=.o)

# All object files to be linked.
LINK_OBJS = $(OBJS)

# --- Targets ---

# Default target
all: print_char.hex program_data.hex

program_data.hex: program_data.bin
	@echo "==> Creating Data HEX file..."
	$(HEXDUMP) -v -e '"%08x\n"' $< > $@
	@echo "==> Build complete: program_data.hex"

program_data.bin: print_char.elf
	@echo "==> Creating data binary..."
	# This combines .data, .rodata, and .bss (preserves same order of loader.ld)
	$(OBJCOPY) -O binary -j .data -j .rodata -j .bss $< $@
	@echo "==> Build complete: program_data.bin"

print_char.hex: print_char.bin
	@echo "==> Creating HEX file..."
	$(HEXDUMP) -v -e '"%08x\n"' $< > $@
	@echo "==> Build complete: print_char.hex"

print_char.bin: print_char.elf
	@echo "==> Creating bin file..."
	# Use objcopy to create the bin file, and *only* include the .text
	# section. This ignores .bss, .data, and all other sections.
	$(OBJCOPY) -O binary --only-section=.text $< $@
	@echo "==> Build complete: print_char.bin"

print_char.elf: $(OBJS)
	@echo "==> Linking ELF file..."
	$(GCC) $(LINK_OBJS) -o $@ -nostdlib -lgcc -T loader.ld

# Pattern rule for compiling .c files to .o files
%.o: %.c
	@echo "==> Compiling C: $<"
	# "-c" is the standard flag to "compile only, do not link".
	$(GCC) -c $< -o $@

# Pattern rule for assembling .S files to .o files
%.o: %.S
	@echo "==> Assembling: $<"
	$(AS) $< -o $@


.PHONY: clean all
clean:
	@echo "==> Cleaning up built files..."
	rm -f $(OBJS) print_char.elf print_char.hex print_char.bin program_data.bin program_data.hex
