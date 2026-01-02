riscv32-unknown-elf-as -march=rv32i -mabi=ilp32 digitalwrite.S -o digitalwrite.o &&
riscv32-unknown-elf-as -march=rv32i -mabi=ilp32 start.S -o start.o &&
riscv32-unknown-elf-gcc -march=rv32i -mabi=ilp32 -r main.c -o main.o &&
riscv32-unknown-elf-ld main.o digitalwrite.o -o blink.elf -T blink.ld -m elf32lriscv -nostdlib --no-relax &&
hexdump -v -e '"%08x\n"' blink.elf > blink.hex

rm start.o main.o digitalwrite.o blink.elf
