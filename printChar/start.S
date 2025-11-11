# Base address of memory-mapped IO,
# Loaded into gp at startup
.equ IO_BASE, 0x400000

.section .text

.globl start

start:
	li   gp, IO_BASE
	li   sp, 0x2000   # allocate space for stack
	call main

finish:
    j finish
    
	ebreak
