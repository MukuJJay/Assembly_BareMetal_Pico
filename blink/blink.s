.global start
start:

        ldr r0, =rst_clr
        mov r1, #32 
        str r1, [r0]

rst:
    ldr r0, =rst_base
    ldr r1, [r0, #8]
    mov r2, #32
    and r1, r1, r2
    beq rst

        ldr r0, =ctrl
        mov r1, #5
        str r1, [r0]

        ldr r0, =sio_base
        mov r1, #1
        lsl r1, r1, #25
        str r1, [r0, #0x24]

led_loop:
    str r1, [r0, #0x14]
    ldr r3, =big_num
    bl delay

    str r1, [r0, #0x18]
    ldr r3, =big_num
    bl delay

    b led_loop

delay:
    sub r3, #1
    bne delay
    bx lr

data:

.equ rst_clr, 0x4000f000 //2.1.2

.equ rst_base, 0x4000c000 //2.14.3.

.equ ctrl, 0x400140cc //2.19.6.1

.equ sio_base, 0xd0000000	// SIO base 2.3.1.7

.equ big_num, 0x00f00000