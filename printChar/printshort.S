# 7-segment driver. Writes a 16 bit value to the
# segments port of the FPGA. Up to 4 segments can be controlled (16 bits).

.equ IO_SEV_SEGM, 0x402000

.section .text

.globl printshort

printshort:
    la t0, IO_SEV_SEGM     # load absolute address into t0
    sh a0, 0(t0)           # store halfword at that address
    ret
