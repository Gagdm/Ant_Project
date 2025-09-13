;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.0 #9615 (Linux)
;--------------------------------------------------------
	.module stm8s_flash
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _FLASH_Unlock
	.globl _FLASH_Lock
	.globl _FLASH_DeInit
	.globl _FLASH_ITConfig
	.globl _FLASH_EraseByte
	.globl _FLASH_ProgramByte
	.globl _FLASH_ReadByte
	.globl _FLASH_ProgramWord
	.globl _FLASH_ProgramOptionByte
	.globl _FLASH_EraseOptionByte
	.globl _FLASH_ReadOptionByte
	.globl _FLASH_SetLowPowerMode
	.globl _FLASH_SetProgrammingTime
	.globl _FLASH_GetLowPowerMode
	.globl _FLASH_GetProgrammingTime
	.globl _FLASH_GetBootSize
	.globl _FLASH_GetFlagStatus
	.globl _FLASH_WaitForLastOperation
	.globl _FLASH_EraseBlock
	.globl _FLASH_ProgramBlock
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
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 87: void FLASH_Unlock(FLASH_MemType_TypeDef FLASH_MemType)
;	-----------------------------------------
;	 function FLASH_Unlock
;	-----------------------------------------
_FLASH_Unlock:
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 93: if(FLASH_MemType == FLASH_MEMTYPE_PROG)
	ld	a, (0x03, sp)
	cp	a, #0xfd
	jrne	00102$
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 95: FLASH->PUKR = FLASH_RASS_KEY1;
	mov	0x5062+0, #0x56
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 96: FLASH->PUKR = FLASH_RASS_KEY2;
	mov	0x5062+0, #0xae
	ret
00102$:
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 101: FLASH->DUKR = FLASH_RASS_KEY2; /* Warning: keys are reversed on data memory !!! */
	mov	0x5064+0, #0xae
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 102: FLASH->DUKR = FLASH_RASS_KEY1;
	mov	0x5064+0, #0x56
	ret
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 112: void FLASH_Lock(FLASH_MemType_TypeDef FLASH_MemType)
;	-----------------------------------------
;	 function FLASH_Lock
;	-----------------------------------------
_FLASH_Lock:
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 118: FLASH->IAPSR &= (uint8_t)FLASH_MemType;
	ldw	x, #0x505f
	ld	a, (x)
	and	a, (0x03, sp)
	ldw	x, #0x505f
	ld	(x), a
	ret
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 126: void FLASH_DeInit(void)
;	-----------------------------------------
;	 function FLASH_DeInit
;	-----------------------------------------
_FLASH_DeInit:
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 128: FLASH->CR1 = FLASH_CR1_RESET_VALUE;
	mov	0x505a+0, #0x00
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 129: FLASH->CR2 = FLASH_CR2_RESET_VALUE;
	mov	0x505b+0, #0x00
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 130: FLASH->NCR2 = FLASH_NCR2_RESET_VALUE;
	mov	0x505c+0, #0xff
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 131: FLASH->IAPSR &= (uint8_t)(~FLASH_IAPSR_DUL);
	ldw	x, #0x505f
	ld	a, (x)
	and	a, #0xf7
	ld	(x), a
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 132: FLASH->IAPSR &= (uint8_t)(~FLASH_IAPSR_PUL);
	ldw	x, #0x505f
	ld	a, (x)
	and	a, #0xfd
	ld	(x), a
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 133: (void) FLASH->IAPSR; /* Reading of this register causes the clearing of status flags */
	ldw	x, #0x505f
	ld	a, (x)
	ret
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 142: void FLASH_ITConfig(FunctionalState NewState)
;	-----------------------------------------
;	 function FLASH_ITConfig
;	-----------------------------------------
_FLASH_ITConfig:
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 147: if(NewState != DISABLE)
	tnz	(0x03, sp)
	jreq	00102$
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 149: FLASH->CR1 |= FLASH_CR1_IE; /* Enables the interrupt sources */
	ldw	x, #0x505a
	ld	a, (x)
	or	a, #0x02
	ld	(x), a
	ret
00102$:
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 153: FLASH->CR1 &= (uint8_t)(~FLASH_CR1_IE); /* Disables the interrupt sources */
	ldw	x, #0x505a
	ld	a, (x)
	and	a, #0xfd
	ld	(x), a
	ret
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 164: void FLASH_EraseByte(uint32_t Address)
;	-----------------------------------------
;	 function FLASH_EraseByte
;	-----------------------------------------
_FLASH_EraseByte:
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 170: *(uint8_t*) Address = FLASH_CLEAR_BYTE; 
	ldw	x, (0x05, sp)
	clr	(x)
	ret
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 181: void FLASH_ProgramByte(uint32_t Address, uint8_t Data)
;	-----------------------------------------
;	 function FLASH_ProgramByte
;	-----------------------------------------
_FLASH_ProgramByte:
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 185: *(uint8_t*) Address = Data;
	ldw	x, (0x05, sp)
	ld	a, (0x07, sp)
	ld	(x), a
	ret
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 195: uint8_t FLASH_ReadByte(uint32_t Address)
;	-----------------------------------------
;	 function FLASH_ReadByte
;	-----------------------------------------
_FLASH_ReadByte:
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 201: return(*(uint8_t *) Address); 
	ldw	x, (0x05, sp)
	ld	a, (x)
	ret
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 212: void FLASH_ProgramWord(uint32_t Address, uint32_t Data)
;	-----------------------------------------
;	 function FLASH_ProgramWord
;	-----------------------------------------
_FLASH_ProgramWord:
	sub	sp, #4
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 218: FLASH->CR2 |= FLASH_CR2_WPRG;
	ldw	x, #0x505b
	ld	a, (x)
	or	a, #0x40
	ld	(x), a
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 219: FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NWPRG);
	ldw	x, #0x505c
	ld	a, (x)
	and	a, #0xbf
	ld	(x), a
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 222: *((uint8_t*)Address)       = *((uint8_t*)(&Data));
	ldw	y, (0x09, sp)
	ldw	(0x03, sp), y
	ldw	x, sp
	addw	x, #11
	ldw	(0x01, sp), x
	ldw	x, (0x01, sp)
	ld	a, (x)
	ldw	x, (0x03, sp)
	ld	(x), a
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 224: *(((uint8_t*)Address) + 1) = *((uint8_t*)(&Data)+1); 
	ldw	x, (0x03, sp)
	incw	x
	ldw	y, (0x01, sp)
	ld	a, (0x1, y)
	ld	(x), a
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 226: *(((uint8_t*)Address) + 2) = *((uint8_t*)(&Data)+2); 
	ldw	x, (0x03, sp)
	incw	x
	incw	x
	ldw	y, (0x01, sp)
	ld	a, (0x2, y)
	ld	(x), a
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 228: *(((uint8_t*)Address) + 3) = *((uint8_t*)(&Data)+3); 
	ldw	x, (0x03, sp)
	addw	x, #0x0003
	ldw	y, (0x01, sp)
	ld	a, (0x3, y)
	ld	(x), a
	addw	sp, #4
	ret
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 237: void FLASH_ProgramOptionByte(uint16_t Address, uint8_t Data)
;	-----------------------------------------
;	 function FLASH_ProgramOptionByte
;	-----------------------------------------
_FLASH_ProgramOptionByte:
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 243: FLASH->CR2 |= FLASH_CR2_OPT;
	bset	0x505b, #7
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 244: FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NOPT);
	ldw	x, #0x505c
	ld	a, (x)
	and	a, #0x7f
	ld	(x), a
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 250: *((uint8_t*)Address) = Data;
	ldw	x, (0x03, sp)
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 247: if(Address == 0x4800)
	pushw	x
	ldw	x, (0x05, sp)
	cpw	x, #0x4800
	popw	x
	jrne	00102$
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 250: *((uint8_t*)Address) = Data;
	ld	a, (0x05, sp)
	ld	(x), a
	jra	00103$
00102$:
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 255: *((uint8_t*)Address) = Data;
	ld	a, (0x05, sp)
	ld	(x), a
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 256: *((uint8_t*)((uint16_t)(Address + 1))) = (uint8_t)(~Data);
	ldw	x, (0x03, sp)
	incw	x
	ld	a, (0x05, sp)
	cpl	a
	ld	(x), a
00103$:
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 258: FLASH_WaitForLastOperation(FLASH_MEMTYPE_PROG);
	push	#0xfd
	call	_FLASH_WaitForLastOperation
	pop	a
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 261: FLASH->CR2 &= (uint8_t)(~FLASH_CR2_OPT);
	bres	0x505b, #7
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 262: FLASH->NCR2 |= FLASH_NCR2_NOPT;
	bset	0x505c, #7
	ret
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 270: void FLASH_EraseOptionByte(uint16_t Address)
;	-----------------------------------------
;	 function FLASH_EraseOptionByte
;	-----------------------------------------
_FLASH_EraseOptionByte:
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 276: FLASH->CR2 |= FLASH_CR2_OPT;
	bset	0x505b, #7
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 277: FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NOPT);
	ldw	x, #0x505c
	ld	a, (x)
	and	a, #0x7f
	ld	(x), a
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 283: *((uint8_t*)Address) = FLASH_CLEAR_BYTE;
	ldw	x, (0x03, sp)
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 280: if(Address == 0x4800)
	pushw	x
	ldw	x, (0x05, sp)
	cpw	x, #0x4800
	popw	x
	jrne	00102$
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 283: *((uint8_t*)Address) = FLASH_CLEAR_BYTE;
	clr	(x)
	jra	00103$
00102$:
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 288: *((uint8_t*)Address) = FLASH_CLEAR_BYTE;
	clr	(x)
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 289: *((uint8_t*)((uint16_t)(Address + (uint16_t)1 ))) = FLASH_SET_BYTE;
	ldw	x, (0x03, sp)
	incw	x
	ld	a, #0xff
	ld	(x), a
00103$:
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 291: FLASH_WaitForLastOperation(FLASH_MEMTYPE_PROG);
	push	#0xfd
	call	_FLASH_WaitForLastOperation
	pop	a
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 294: FLASH->CR2 &= (uint8_t)(~FLASH_CR2_OPT);
	bres	0x505b, #7
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 295: FLASH->NCR2 |= FLASH_NCR2_NOPT;
	bset	0x505c, #7
	ret
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 303: uint16_t FLASH_ReadOptionByte(uint16_t Address)
;	-----------------------------------------
;	 function FLASH_ReadOptionByte
;	-----------------------------------------
_FLASH_ReadOptionByte:
	sub	sp, #5
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 311: value_optbyte = *((uint8_t*)Address); /* Read option byte */
	ldw	x, (0x08, sp)
	ld	a, (x)
	ld	(0x02, sp), a
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 312: value_optbyte_complement = *(((uint8_t*)Address) + 1); /* Read option byte complement */
	ld	a, (0x1, x)
	ld	(0x01, sp), a
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 317: res_value =	 value_optbyte;
	clrw	x
	ld	a, (0x02, sp)
	ld	xl, a
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 315: if(Address == 0x4800)	 
	pushw	x
	ldw	x, (0x0a, sp)
	cpw	x, #0x4800
	popw	x
	jreq	00106$
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 317: res_value =	 value_optbyte;
	jra	00105$
00105$:
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 321: if(value_optbyte == (uint8_t)(~value_optbyte_complement))
	ld	a, (0x01, sp)
	cpl	a
	ld	(0x05, sp), a
	ld	a, (0x02, sp)
	cp	a, (0x05, sp)
	jrne	00102$
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 323: res_value = (uint16_t)((uint16_t)value_optbyte << 8);
	clr	a
	rlwa	x
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 324: res_value = res_value | (uint16_t)value_optbyte_complement;
	ld	a, (0x01, sp)
	clr	(0x03, sp)
	pushw	x
	or	a, (2, sp)
	popw	x
	rlwa	x
	or	a, (0x03, sp)
	ld	xh, a
	jra	00106$
00102$:
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 328: res_value = FLASH_OPTIONBYTE_ERROR;
	ldw	x, #0x5555
00106$:
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 331: return(res_value);
	addw	sp, #5
	ret
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 340: void FLASH_SetLowPowerMode(FLASH_LPMode_TypeDef FLASH_LPMode)
;	-----------------------------------------
;	 function FLASH_SetLowPowerMode
;	-----------------------------------------
_FLASH_SetLowPowerMode:
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 346: FLASH->CR1 &= (uint8_t)(~(FLASH_CR1_HALT | FLASH_CR1_AHALT)); 
	ldw	x, #0x505a
	ld	a, (x)
	and	a, #0xf3
	ld	(x), a
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 349: FLASH->CR1 |= (uint8_t)FLASH_LPMode; 
	ldw	x, #0x505a
	ld	a, (x)
	or	a, (0x03, sp)
	ldw	x, #0x505a
	ld	(x), a
	ret
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 358: void FLASH_SetProgrammingTime(FLASH_ProgramTime_TypeDef FLASH_ProgTime)
;	-----------------------------------------
;	 function FLASH_SetProgrammingTime
;	-----------------------------------------
_FLASH_SetProgrammingTime:
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 363: FLASH->CR1 &= (uint8_t)(~FLASH_CR1_FIX);
	bres	0x505a, #0
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 364: FLASH->CR1 |= (uint8_t)FLASH_ProgTime;
	ldw	x, #0x505a
	ld	a, (x)
	or	a, (0x03, sp)
	ldw	x, #0x505a
	ld	(x), a
	ret
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 372: FLASH_LPMode_TypeDef FLASH_GetLowPowerMode(void)
;	-----------------------------------------
;	 function FLASH_GetLowPowerMode
;	-----------------------------------------
_FLASH_GetLowPowerMode:
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 374: return((FLASH_LPMode_TypeDef)(FLASH->CR1 & (uint8_t)(FLASH_CR1_HALT | FLASH_CR1_AHALT)));
	ldw	x, #0x505a
	ld	a, (x)
	and	a, #0x0c
	ret
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 382: FLASH_ProgramTime_TypeDef FLASH_GetProgrammingTime(void)
;	-----------------------------------------
;	 function FLASH_GetProgrammingTime
;	-----------------------------------------
_FLASH_GetProgrammingTime:
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 384: return((FLASH_ProgramTime_TypeDef)(FLASH->CR1 & FLASH_CR1_FIX));
	ldw	x, #0x505a
	ld	a, (x)
	and	a, #0x01
	ret
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 392: uint32_t FLASH_GetBootSize(void)
;	-----------------------------------------
;	 function FLASH_GetBootSize
;	-----------------------------------------
_FLASH_GetBootSize:
	sub	sp, #4
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 397: temp = (uint32_t)((uint32_t)FLASH->FPR * (uint32_t)512);
	ldw	x, #0x505d
	ld	a, (x)
	clrw	x
	ld	xl, a
	clrw	y
	ld	a, #0x09
00109$:
	sllw	x
	rlcw	y
	dec	a
	jrne	00109$
	ldw	(0x01, sp), y
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 400: if(FLASH->FPR == 0xFF)
	ldw	y, #0x505d
	ld	a, (y)
	cp	a, #0xff
	jrne	00102$
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 402: temp += 512;
	addw	x, #0x0200
	ld	a, (0x02, sp)
	adc	a, #0x00
	ld	yl, a
	ld	a, (0x01, sp)
	adc	a, #0x00
	ld	yh, a
	ldw	(0x01, sp), y
00102$:
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 406: return(temp);
	ldw	y, (0x01, sp)
	addw	sp, #4
	ret
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 417: FlagStatus FLASH_GetFlagStatus(FLASH_Flag_TypeDef FLASH_FLAG)
;	-----------------------------------------
;	 function FLASH_GetFlagStatus
;	-----------------------------------------
_FLASH_GetFlagStatus:
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 424: if((FLASH->IAPSR & (uint8_t)FLASH_FLAG) != (uint8_t)RESET)
	ldw	x, #0x505f
	ld	a, (x)
	and	a, (0x03, sp)
	tnz	a
	jreq	00102$
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 426: status = SET; /* FLASH_FLAG is set */
	ld	a, #0x01
	ret
00102$:
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 430: status = RESET; /* FLASH_FLAG is reset*/
	clr	a
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 434: return status;
	ret
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 549: IN_RAM(FLASH_Status_TypeDef FLASH_WaitForLastOperation(FLASH_MemType_TypeDef FLASH_MemType)) 
;	-----------------------------------------
;	 function FLASH_WaitForLastOperation
;	-----------------------------------------
_FLASH_WaitForLastOperation:
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 551: uint8_t flagstatus = 0x00;
	clr	a
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 576: while((flagstatus == 0x00) && (timeout != 0x00))
	ldw	x, #0xffff
00102$:
	tnz	a
	jrne	00104$
	tnzw	x
	jreq	00104$
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 578: flagstatus = (uint8_t)(FLASH->IAPSR & (FLASH_IAPSR_EOP | FLASH_IAPSR_WR_PG_DIS));
	ldw	y, #0x505f
	ld	a, (y)
	and	a, #0x05
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 579: timeout--;
	decw	x
	jra	00102$
00104$:
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 583: if(timeout == 0x00 )
	tnzw	x
	jreq	00128$
	ret
00128$:
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 585: flagstatus = FLASH_STATUS_TIMEOUT;
	ld	a, #0x02
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 588: return((FLASH_Status_TypeDef)flagstatus);
	ret
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 598: IN_RAM(void FLASH_EraseBlock(uint16_t BlockNum, FLASH_MemType_TypeDef FLASH_MemType))
;	-----------------------------------------
;	 function FLASH_EraseBlock
;	-----------------------------------------
_FLASH_EraseBlock:
	sub	sp, #6
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 611: if(FLASH_MemType == FLASH_MEMTYPE_PROG)
	ld	a, (0x0b, sp)
	cp	a, #0xfd
	jrne	00102$
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 614: startaddress = FLASH_PROG_START_PHYSICAL_ADDRESS;
	ldw	x, #0x8000
	ldw	(0x05, sp), x
	clrw	x
	ldw	(0x03, sp), x
	jra	00103$
00102$:
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 619: startaddress = FLASH_DATA_START_PHYSICAL_ADDRESS;
	ldw	x, #0x4000
	ldw	(0x05, sp), x
	clrw	x
	ldw	(0x03, sp), x
00103$:
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 627: pwFlash = (uint32_t *)(MemoryAddressCast)(startaddress + ((uint32_t)BlockNum * FLASH_BLOCK_SIZE));
	ldw	y, (0x09, sp)
	clrw	x
	ld	a, #0x06
00113$:
	sllw	y
	rlcw	x
	dec	a
	jrne	00113$
	addw	y, (0x05, sp)
	ld	a, xl
	adc	a, (0x04, sp)
	rlwa	x
	adc	a, (0x03, sp)
	ldw	(0x01, sp), y
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 631: FLASH->CR2 |= FLASH_CR2_ERASE;
	ldw	x, #0x505b
	ld	a, (x)
	or	a, #0x20
	ld	(x), a
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 632: FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NERASE);
	ldw	x, #0x505c
	ld	a, (x)
	and	a, #0xdf
	ld	(x), a
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 636: *pwFlash = (uint32_t)0;
	ldw	x, (0x01, sp)
	clr	(0x3, x)
	clr	(0x2, x)
	clr	(0x1, x)
	clr	(x)
	addw	sp, #6
	ret
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 655: IN_RAM(void FLASH_ProgramBlock(uint16_t BlockNum, FLASH_MemType_TypeDef FLASH_MemType, 
;	-----------------------------------------
;	 function FLASH_ProgramBlock
;	-----------------------------------------
_FLASH_ProgramBlock:
	sub	sp, #14
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 664: if(FLASH_MemType == FLASH_MEMTYPE_PROG)
	ld	a, (0x13, sp)
	cp	a, #0xfd
	jrne	00102$
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 667: startaddress = FLASH_PROG_START_PHYSICAL_ADDRESS;
	ldw	x, #0x8000
	ldw	(0x0d, sp), x
	clr	a
	clr	(0x0b, sp)
	jra	00103$
00102$:
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 672: startaddress = FLASH_DATA_START_PHYSICAL_ADDRESS;
	ldw	x, #0x4000
	ldw	(0x0d, sp), x
	clr	a
	clr	(0x0b, sp)
00103$:
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 676: startaddress = startaddress + ((uint32_t)BlockNum * FLASH_BLOCK_SIZE);
	ldw	y, (0x11, sp)
	clrw	x
	push	a
	ld	a, #0x06
00128$:
	sllw	y
	rlcw	x
	dec	a
	jrne	00128$
	ldw	(0x08, sp), x
	pop	a
	addw	y, (0x0d, sp)
	adc	a, (0x08, sp)
	ld	xl, a
	ld	a, (0x0b, sp)
	adc	a, (0x07, sp)
	ld	xh, a
	ldw	(0x03, sp), y
	ldw	(0x01, sp), x
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 679: if(FLASH_ProgMode == FLASH_PROGRAMMODE_STANDARD)
	tnz	(0x14, sp)
	jrne	00105$
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 682: FLASH->CR2 |= FLASH_CR2_PRG;
	bset	0x505b, #0
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 683: FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NPRG);
	ldw	x, #0x505c
	ld	a, (x)
	and	a, #0xfe
	ld	(x), a
	jra	00114$
00105$:
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 688: FLASH->CR2 |= FLASH_CR2_FPRG;
	ldw	x, #0x505b
	ld	a, (x)
	or	a, #0x10
	ld	(x), a
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 689: FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NFPRG);
	ldw	x, #0x505c
	ld	a, (x)
	and	a, #0xef
	ld	(x), a
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 693: for(Count = 0; Count < FLASH_BLOCK_SIZE; Count++)
00114$:
	clrw	x
	ldw	(0x05, sp), x
00108$:
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 695: *((uint8_t*) (MemoryAddressCast)startaddress + Count) = ((uint8_t)(Buffer[Count]));
	ldw	x, (0x03, sp)
	addw	x, (0x05, sp)
	ldw	y, (0x15, sp)
	addw	y, (0x05, sp)
	ld	a, (y)
	ld	(x), a
;	../Libraries/STM8S_StdPeriph_Driver/src/stm8s_flash.c: 693: for(Count = 0; Count < FLASH_BLOCK_SIZE; Count++)
	ldw	x, (0x05, sp)
	incw	x
	ldw	(0x05, sp), x
	ldw	x, (0x05, sp)
	cpw	x, #0x0040
	jrc	00108$
	addw	sp, #14
	ret
	.area CODE
	.area INITIALIZER
	.area CABS (ABS)
