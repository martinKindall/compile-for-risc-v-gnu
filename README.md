# Compiling code for the RISC-V

## Requirements

- RISC-V Toolchain (32 or 64 bits, in this example I will use the 32 version)
- Here's a [guide how to easily build](https://github.com/johnwinans/riscv-toolchain-install-guide) the 32-bits version with the ISA of your choice

## Assembler example

```bash
riscv32-unknown-elf-as exampleAsm.S -o exampleAsm.o
riscv32-unknown-elf-ld -o exampleAsm.elf -T asm.ld -m elf32lriscv -nostdlib --no-relax
```

## C example

```bash
riscv32-unknown-elf-gcc -r exampleC.c -o exampleC.o
riscv32-unknown-elf-ld -o exampleC.elf -T c_prog.ld -m elf32lriscv -nostdlib --no-relax
```

Trying to use multiplication or other advanced math operations with the rv32I arch? No problem, you just
have to declare the path to the correct libgcc library on the __loader__ step.

__Watch out!__, the path may change depending of how did you setup the multilib, just beware of choosing the libgcc.a corresponding to the rv32I.

```bash
riscv32-unknown-elf-ld -o exampleC2.elf -T bram.ld -m elf32lriscv -nostdlib --no-relax /(RVTOOLCHAIN_GCC_LIB_DIR)/libgcc.a
```

# (Optional) Generating .HEX dump (for FPGA)

## Alternative 1: use standard tools

```bash
riscv32-unknown-elf-objcopy -O binary exampleProg.elf exampleProg.bin
hexdump -e '"%08x\n"' exampleProg.bin > exampleProg.hex
```

## Alternative 2: use elf2hex

- A guide to install [the elf2hex tool](https://github.com/martinKindall/elf2hex)

```bash
riscv32-unknown-elf-elf2hex --bit-width 32 --input exampleProg.elf --output exampleProg.hex
```
