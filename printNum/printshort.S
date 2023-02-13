# 7-segment driver. Writes a 16 bit value to the
# segments port of the FPGA. Up to 4 segments can be controlled (16 bits).

.equ IO_SEV_SEGM, 8

.section .text

.globl printshort

printshort:
    sh      a0, IO_SEV_SEGM(gp)
    ret
