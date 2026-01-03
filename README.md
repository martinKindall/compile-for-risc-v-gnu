# Compiling code for the RISC-V
## (Updated 2026-01)
Tested on Ubuntu 24.04.1 (WSL2)

Kernel 6.6.87.2-microsoft-standard-WSL2

## Requirements 

- RISC-V Toolchain (32 or 64 bits, in this example I will use the 32 version)
  - This [is the repository](https://github.com/riscv-collab/riscv-gnu-toolchain/commits/2026.01.01/) I used to install the toolchain, precisely tag 2026.01.01.
  - Basically clone the repo, checkout the tag and install the Prerequisites for Ubuntu.
  - Then configure the installation for baremetal Risc-V, 32 bits RV32I
    ```shell
    sudo mkdir /opt/riscv
    sudo chown -R <your_ubuntu_username> /opt/riscv/
    sudo chgrp -R <your_ubuntu_username> /opt/riscv/

    ./configure --prefix=/opt/riscv --with-arch=rv32i --with-abi=ilp32
    make
    ```
  - The installation might take up around 1 hour. Verify it went successful by:
    ```shell
    cd /opt/riscv/bin
    ./riscv32-unknown-elf-gcc --version
    ```
  - Add the riscv toolchain to PATH by adding this to the .bashrc:
    ```shell
    export PATH=$PATH:/opt/riscv/bin
    ```

## Assembler example

```bash
riscv32-unknown-elf-as exampleAsm.S -o exampleAsm.o
riscv32-unknown-elf-ld -o exampleAsm.elf -T asm.ld -m elf32lriscv -nostdlib --no-relax
```

## C example (compiling and linking)

```bash
riscv32-unknown-elf-gcc -c example.c -o example.o
riscv32-unknown-elf-gcc example.o -o example.elf -nostdlib -lgcc -T loader.ld
```

Trying to use multiplication or other advanced math operations with the rv32I arch? No problem, by linking with
the flag ```-lgcc``` the compiler will use software multiplication by using __libgcc__.

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
