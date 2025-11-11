# --- Toolchain Definitions ---
AS = riscv32-unknown-elf-as -march=rv32i -mabi=ilp32
GCC = riscv32-unknown-elf-gcc -march=rv32i -mabi=ilp32 -c
LD = riscv32-unknown-elf-ld
OBJCOPY = riscv32-unknown-elf-objcopy
HEXDUMP = hexdump

# --- Paths ---
# You may need to adjust this path to your system
PATH_TO_LIBGCC = ~/informatica/risc-v/install/rv32i/lib/gcc/riscv32-unknown-elf/11.1.0
LIBGCC_A = $(PATH_TO_LIBGCC)/libgcc.a

# --- Source Files ---
C_SRCS = main.c outchar.c
S_SRCS = printshort.S start.S

# --- Object Files ---
OBJS = $(C_SRCS:.c=.o) $(S_SRCS:.S=.o)

# All object files to be linked.
LINK_OBJS = $(OBJS)

# --- Targets ---

# Default target
all: print_char.hex

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
	$(LD) $(LINK_OBJS) -o $@ -T loader.ld -m elf32lriscv -nostdlib --no-relax $(LIBGCC_A)

# Pattern rule for compiling .c files to .o files
%.o: %.c
	@echo "==> Compiling C: $<"
	# Note: Changed from "-r" to "-c".
	# "-c" is the standard flag to "compile only, do not link".
	$(GCC) $< -o $@

# Pattern rule for assembling .S files to .o files
%.o: %.S
	@echo "==> Assembling: $<"
	$(AS) $< -o $@


.PHONY: clean all
clean:
	@echo "==> Cleaning up built files..."
	rm -f $(OBJS) print_char.elf print_char.hex print_char.bin
