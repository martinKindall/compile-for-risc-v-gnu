AS='riscv32-unknown-elf-as -march=rv32i -mabi=ilp32'
GCC='riscv32-unknown-elf-gcc -march=rv32i -mabi=ilp32'
HEXDUMP=hexdump

$AS printshort.S -o printshort.o &&
$AS start.S -o start.o &&
$AS delay.S -o delay.o &&
$GCC -r main.c -o main.o &&
$GCC main.o printshort.o digitalwrite.o delay.o -o calculator.elf -nostdlib -lgcc -T printNum.ld &&
$HEXDUMP -v -e '"%08x\n"' calculator.elf > calculator.hex

rm start.o main.o printshort.o calculator.elf delay.o
