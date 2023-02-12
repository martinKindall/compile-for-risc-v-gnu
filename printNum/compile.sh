riscv32-unknown-elf-as -march=rv32i -mabi=ilp32 printshort.S -o printshort.o &&
riscv32-unknown-elf-as -march=rv32i -mabi=ilp32 start.S -o start.o &&
riscv32-unknown-elf-gcc -march=rv32i -mabi=ilp32 -r main.c -o main.o &&
riscv32-unknown-elf-ld main.o printshort.o -o calculator.elf -T printNum.ld -m elf32lriscv -nostdlib --no-relax &&
riscv32-unknown-elf-elf2hex --bit-width 32 --input calculator.elf --output calculator.hex

rm start.o main.o printshort.o calculator.elf