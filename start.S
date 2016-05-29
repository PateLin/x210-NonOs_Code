/*********************************************************************************
  *FileName		:	start.S
  *Author		:  	PateLin
  *Version		:  	V1.0.0
  *Date			:	2016.05.29
  *Description	:	X210 base computer start code.
  *Others		:  
  *History		: 
**********************************************************************************/

.global _start
 _start:
 	/*
 	@Set the led light of the X210.
 	@According to the X210 Core board schematic diagram V1.2 (x210cv3.pdf)
 	@and X210 Base board schematic diagram V3.0 (x210bv3.pdf)
 	@set the register and them value.
 	*/
 	@step 1
 	ldr r0, =0xE0200240	@set the GPJ0CON register address
 	ldr r1, =0x66111666	@set the 3th,4th,5th pin of the GPJ0CON register as output
 	str r1, [r0]
 	ldr r0, =0xE02000A0	@set the GPD0CON register address
 	ldr r1, =0x00006616	@set the 1st pin of the GPD0CON register as output
 	str r1, [r0]		
 	@step 2
 	ldr r0, =0xE0200244	@set the GPJ0DAT register address
 	ldr r1, =0xE02000A4	@set the GPD0DAT register address
 	ldr r3, =0x00000000 @set the step 1 pin output 0 to light the led
 	str r3, [r0]
 	str r3, [r1]

 	b .
 	