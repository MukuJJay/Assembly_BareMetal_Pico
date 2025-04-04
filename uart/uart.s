.global start
start:

com_loop:
    bl uart0_in
    bl uart0_out
    b com_loop

uart0_in:
    ldr r1, =uart0_base
    mov r2, #16
    ldr r3, [r1, #0x18]
    and r2, r3
    bne uart0_in
    ldr r0, [r1]
    bx lr

uart0_out:
    mov r2, #32
    and r2, r3
    bne uart0_out
    mov r2, #0xff
    and r0, r0, r2
    str r0, [r1]
    bx lr


.equ uart0_base, 0x40034000