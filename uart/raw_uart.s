.global uart
uart:
	
rst_uart:
	ldr r0, =rst_set
	mov r1, #1
	lsl r1, r1, #22
	str r1, [r0]

derst_uart:
	ldr r0, =rst_clr
	mov r1, #1
	lsl r1, r1, #22
	str r1, [r0]

check_rst_uart:
	ldr r0, =rst_base
	mov r1, #1
	lsl r1, r1, #22
	ldr r2, [r0, #0x8]
	and r1, r2
	beq check_rst_uart

enable_clk_peri_ctrl:
	ldr r0, =clk_base
	mov r1, #1
	lsl r1, r1, #11
	add r1, #128
	str r1, [r0, #0x48]

enable_uart0:
	ldr r0, =uart0_base
	mov r1, #3
	lsl r1, r1, #8
	add r1, #1
	str r1, [r0, #0x30]

	set_baud_rate:
		mov r1, #6
		str r1, [r0, #0x24]
		mov r1, #33
		str r1, [r0, #0x28]
	
	set_wlen:
		mov r1, #7
		lsl r1, r1, #4
		str r1, [r0, #0x02c]

	enable_uart_gpio:
		ldr r0, =iobank0_base
		mov r1, #2
		str r1, [r0, #0x4]
		str r1, [r0, #0xc]


com_loop:
	bl uart0_in
	bl uart0_out
	b com_loop

uart0_in:
	ldr r0, =uart0_base
	mov r1, #1
	lsl r1, r1, #4
	ldr r2, [r0, #0x18]
	and r1, r2
	bne uart0_in
	ldr r3, [r0]
	bx lr

uart0_out:
	mov r1, #1
	lsl r1, r1, #5
	ldr r2, [r0, #0x18]
	and r1, r2
	bne uart0_out
	str r3, [r0]
	bx lr



.equ rst_base, 0x4000c000
.equ rst_set, 0x4000e000
.equ rst_clr, 0x4000f000

.equ clk_base, 0x40008000
.equ uart0_base, 0x40034000
.equ iobank0_base, 0x40014000