AS='riscv32-unknown-elf-as -march=rv32i -mabi=ilp32'
GCC='riscv32-unknown-elf-gcc -march=rv32i -mabi=ilp32'
LD=riscv32-unknown-elf-ld
ELF2HEX=riscv32-unknown-elf-elf2hex

# depends on your toolchain installation
PATH_TO_LIBGCC=~/informatica/risc-v/install/rv32i/lib/gcc/riscv32-unknown-elf/11.1.0

$AS printshort.S -o printshort.o &&
$AS start.S -o start.o &&
$AS delay.S -o delay.o &&
$GCC -r main.c -o main.o &&
$LD main.o printshort.o digitalwrite.o delay.o -o calculator.elf -T printNum.ld -m elf32lriscv -nostdlib --no-relax $PATH_TO_LIBGCC/libgcc.a &&
$ELF2HEX --bit-width 32 --input calculator.elf --output calculator.hex

rm start.o main.o printshort.o calculator.elf delay.o
