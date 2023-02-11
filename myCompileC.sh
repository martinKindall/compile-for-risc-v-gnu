myPATH=./exC2
riscv32-unknown-elf-gcc -march=rv32i -mabi=ilp32 -r $myPATH/example.c -o example.o &&
riscv32-unknown-elf-ld -o $myPATH/example.elf -T loader.ld -m elf32lriscv -nostdlib --no-relax &&
riscv32-unknown-elf-elf2hex --bit-width 32 --input $myPATH/example.elf --output $myPATH/example.hex
rm example.o $myPATH/example.elf 