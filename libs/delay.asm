;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.0 #9615 (Linux)
;--------------------------------------------------------
	.module delay
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _delay_ms
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	../Libraries/STM8S_StdPeriph_Driver/src/delay.c: 5: void delay_ms(uint32_t ms) {
;	-----------------------------------------
;	 function delay_ms
;	-----------------------------------------
_delay_ms:
	sub	sp, #4
;	../Libraries/STM8S_StdPeriph_Driver/src/delay.c: 6: sim();
	sim
;	../Libraries/STM8S_StdPeriph_Driver/src/delay.c: 7: ms *= DELAY_MS_COUNTER;
	ldw	x, (0x09, sp)
	pushw	x
	ldw	x, (0x09, sp)
	pushw	x
	push	#0x58
	push	#0x02
	clrw	x
	pushw	x
	call	__mullong
	addw	sp, #8
	ldw	(0x09, sp), x
	ldw	(0x07, sp), y
;	../Libraries/STM8S_StdPeriph_Driver/src/delay.c: 9: while (ms != 0)
	ldw	y, (0x09, sp)
	ldw	(0x03, sp), y
	ldw	x, (0x07, sp)
00101$:
	ldw	y, (0x03, sp)
	jrne	00115$
	tnzw	x
	jreq	00103$
00115$:
;	../Libraries/STM8S_StdPeriph_Driver/src/delay.c: 11: ms--;
	ldw	y, (0x03, sp)
	subw	y, #0x0001
	ldw	(0x03, sp), y
	ld	a, xl
	sbc	a, #0x00
	rlwa	x
	sbc	a, #0x00
	ld	xh, a
	jra	00101$
00103$:
;	../Libraries/STM8S_StdPeriph_Driver/src/delay.c: 13: rim();
	rim
	addw	sp, #4
	ret
	.area CODE
	.area INITIALIZER
	.area CABS (ABS)
