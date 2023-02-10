# Generating .HEX file from RISC-V Assembler code

## Requirements

- RISC-V Toolchain (32 or 64 bits, in this example I will use the 32 version)
- Here's a [guide how to easily build]() the 32-bits version with the ISA of your choice

```bash
riscv32-unknown-elf-as exampleProg.S -o exampleProg.o
riscv32-unknown-elf-ld -o exampleProg.elf -T bram.ld -m elf32lriscv -nostdlib --no-relax
riscv32-unknown-elf-elf2hex --bit-width 32 --input exampleProg.elf --output exampleProg.hex
```

Trying to use multiplication or other advanced math operations with the rv32I arch? No problem, you just
have to declare the path to the correct libgcc library on the __loader__ step.

__Watch out!__, the path may change depending of how did you setup the multilib, just beware of choosing the libgcc.a corresponding to the rv32I.

```bash
riscv32-unknown-elf-ld -o exampleProg2.elf -T bram.ld -m elf32lriscv -nostdlib --no-relax /(RVTOOLCHAIN_GCC_LIB_DIR)/libgcc.a
```
