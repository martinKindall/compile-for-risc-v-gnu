.section .text

.globl delay

delay:
    addi    t0, x0, 1
loop:
    beq     t0, a0, finish
    addi    t0, t0, 1
    j       loop

finish:
    ret
