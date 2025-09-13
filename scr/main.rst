                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 3.6.0 #9615 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module main
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _main
                                     12 	.globl _delay_ms
                                     13 	.globl _GPIO_WriteReverse
                                     14 	.globl _GPIO_Init
                                     15 	.globl _CLK_SYSCLKConfig
                                     16 ;--------------------------------------------------------
                                     17 ; ram data
                                     18 ;--------------------------------------------------------
                                     19 	.area DATA
                                     20 ;--------------------------------------------------------
                                     21 ; ram data
                                     22 ;--------------------------------------------------------
                                     23 	.area INITIALIZED
                                     24 ;--------------------------------------------------------
                                     25 ; Stack segment in internal ram 
                                     26 ;--------------------------------------------------------
                                     27 	.area	SSEG
      000001                         28 __start__stack:
      000001                         29 	.ds	1
                                     30 
                                     31 ;--------------------------------------------------------
                                     32 ; absolute external ram data
                                     33 ;--------------------------------------------------------
                                     34 	.area DABS (ABS)
                                     35 ;--------------------------------------------------------
                                     36 ; interrupt vector 
                                     37 ;--------------------------------------------------------
                                     38 	.area HOME
      008000                         39 __interrupt_vect:
      008000 82 00 80 83             40 	int s_GSINIT ;reset
      008004 82 00 00 00             41 	int 0x0000 ;trap
      008008 82 00 00 00             42 	int 0x0000 ;int0
      00800C 82 00 00 00             43 	int 0x0000 ;int1
      008010 82 00 00 00             44 	int 0x0000 ;int2
      008014 82 00 00 00             45 	int 0x0000 ;int3
      008018 82 00 00 00             46 	int 0x0000 ;int4
      00801C 82 00 00 00             47 	int 0x0000 ;int5
      008020 82 00 00 00             48 	int 0x0000 ;int6
      008024 82 00 00 00             49 	int 0x0000 ;int7
      008028 82 00 00 00             50 	int 0x0000 ;int8
      00802C 82 00 00 00             51 	int 0x0000 ;int9
      008030 82 00 00 00             52 	int 0x0000 ;int10
      008034 82 00 00 00             53 	int 0x0000 ;int11
      008038 82 00 00 00             54 	int 0x0000 ;int12
      00803C 82 00 00 00             55 	int 0x0000 ;int13
      008040 82 00 00 00             56 	int 0x0000 ;int14
      008044 82 00 00 00             57 	int 0x0000 ;int15
      008048 82 00 00 00             58 	int 0x0000 ;int16
      00804C 82 00 00 00             59 	int 0x0000 ;int17
      008050 82 00 00 00             60 	int 0x0000 ;int18
      008054 82 00 00 00             61 	int 0x0000 ;int19
      008058 82 00 00 00             62 	int 0x0000 ;int20
      00805C 82 00 00 00             63 	int 0x0000 ;int21
      008060 82 00 00 00             64 	int 0x0000 ;int22
      008064 82 00 00 00             65 	int 0x0000 ;int23
      008068 82 00 00 00             66 	int 0x0000 ;int24
      00806C 82 00 00 00             67 	int 0x0000 ;int25
      008070 82 00 00 00             68 	int 0x0000 ;int26
      008074 82 00 00 00             69 	int 0x0000 ;int27
      008078 82 00 00 00             70 	int 0x0000 ;int28
      00807C 82 00 00 00             71 	int 0x0000 ;int29
                                     72 ;--------------------------------------------------------
                                     73 ; global & static initialisations
                                     74 ;--------------------------------------------------------
                                     75 	.area HOME
                                     76 	.area GSINIT
                                     77 	.area GSFINAL
                                     78 	.area GSINIT
      008083                         79 __sdcc_gs_init_startup:
      008083                         80 __sdcc_init_data:
                                     81 ; stm8_genXINIT() start
      008083 AE 00 00         [ 2]   82 	ldw x, #l_DATA
      008086 27 07            [ 1]   83 	jreq	00002$
      008088                         84 00001$:
      008088 72 4F 00 00      [ 1]   85 	clr (s_DATA - 1, x)
      00808C 5A               [ 2]   86 	decw x
      00808D 26 F9            [ 1]   87 	jrne	00001$
      00808F                         88 00002$:
      00808F AE 00 00         [ 2]   89 	ldw	x, #l_INITIALIZER
      008092 27 09            [ 1]   90 	jreq	00004$
      008094                         91 00003$:
      008094 D6 86 5B         [ 1]   92 	ld	a, (s_INITIALIZER - 1, x)
      008097 D7 00 00         [ 1]   93 	ld	(s_INITIALIZED - 1, x), a
      00809A 5A               [ 2]   94 	decw	x
      00809B 26 F7            [ 1]   95 	jrne	00003$
      00809D                         96 00004$:
                                     97 ; stm8_genXINIT() end
                                     98 	.area GSFINAL
      00809D CC 80 80         [ 2]   99 	jp	__sdcc_program_startup
                                    100 ;--------------------------------------------------------
                                    101 ; Home
                                    102 ;--------------------------------------------------------
                                    103 	.area HOME
                                    104 	.area HOME
      008080                        105 __sdcc_program_startup:
      008080 CC 80 A0         [ 2]  106 	jp	_main
                                    107 ;	return from main will return to caller
                                    108 ;--------------------------------------------------------
                                    109 ; code
                                    110 ;--------------------------------------------------------
                                    111 	.area CODE
                                    112 ;	main.c: 9: int main(void)
                                    113 ;	-----------------------------------------
                                    114 ;	 function main
                                    115 ;	-----------------------------------------
      0080A0                        116 _main:
                                    117 ;	main.c: 11: CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
      0080A0 4B 80            [ 1]  118 	push	#0x80
      0080A2 CD 84 02         [ 4]  119 	call	_CLK_SYSCLKConfig
      0080A5 84               [ 1]  120 	pop	a
                                    121 ;	main.c: 12: CLK_SYSCLKConfig(CLK_PRESCALER_HSIDIV1);
      0080A6 4B 00            [ 1]  122 	push	#0x00
      0080A8 CD 84 02         [ 4]  123 	call	_CLK_SYSCLKConfig
      0080AB 84               [ 1]  124 	pop	a
                                    125 ;	main.c: 14: GPIO_Init(TEST_LED_PORT, TEST_LED_PIN, GPIO_MODE_OUT_PP_LOW_FAST);
      0080AC 4B E0            [ 1]  126 	push	#0xe0
      0080AE 4B 20            [ 1]  127 	push	#0x20
      0080B0 4B 05            [ 1]  128 	push	#0x05
      0080B2 4B 50            [ 1]  129 	push	#0x50
      0080B4 CD 80 EF         [ 4]  130 	call	_GPIO_Init
      0080B7 5B 04            [ 2]  131 	addw	sp, #4
                                    132 ;	main.c: 16: while (1)
      0080B9                        133 00102$:
                                    134 ;	main.c: 18: GPIO_WriteReverse(TEST_LED_PORT, TEST_LED_PIN);
      0080B9 4B 20            [ 1]  135 	push	#0x20
      0080BB 4B 05            [ 1]  136 	push	#0x05
      0080BD 4B 50            [ 1]  137 	push	#0x50
      0080BF CD 81 82         [ 4]  138 	call	_GPIO_WriteReverse
      0080C2 5B 03            [ 2]  139 	addw	sp, #3
                                    140 ;	main.c: 19: delay_ms(5000);
      0080C4 4B 88            [ 1]  141 	push	#0x88
      0080C6 4B 13            [ 1]  142 	push	#0x13
      0080C8 5F               [ 1]  143 	clrw	x
      0080C9 89               [ 2]  144 	pushw	x
      0080CA CD 85 A6         [ 4]  145 	call	_delay_ms
      0080CD 5B 04            [ 2]  146 	addw	sp, #4
      0080CF 20 E8            [ 2]  147 	jra	00102$
      0080D1 81               [ 4]  148 	ret
                                    149 	.area CODE
                                    150 	.area INITIALIZER
                                    151 	.area CABS (ABS)
