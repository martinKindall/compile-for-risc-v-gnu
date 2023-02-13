# Led driver. Writes a value to the
# led port of the FPGA. Up to 5 leds can be controlled.

# Leds are the first device 
# (remember riscv addresses to the byte)
.equ IO_LEDS, 4

.section .text

.globl digitalwrite

digitalwrite:
    sb      a0, IO_LEDS(gp)
    ret
