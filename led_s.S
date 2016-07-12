/*********************************************************************************
  *FileName	:	led_s.S
  *Author		:  	PateLin
  *Version	:  	V1.0.0
  *Date		:	2016.05.29
  *Description	:	Control the LED of X210,the step as: 
  *					1.blink all of the led 3 tiems
  *					2.light the led as flow water
  *					3.light the led reverse of step 2 as flow water
  *					4.light the led as push stacked
  *					5.light the led as deliver from godown
  *Others		:  
  *History		: 
**********************************************************************************/

.equ GPJ0CON	,0xE0200240		@the address of GPJ0 Control register
.equ GPJ0DAT	,0xE0200244		@the address of GPJ0 Data register
.equ GPD0CON	,0xE02000A0		@the address of GPD0 Control register
.equ GPD0DAT	,0xE02000A4		@the address of GPD0 Data register

.equ BLINK_TIMES,3				@the led blink tiems

.global _led_s
 _led_s:
 	/*
 	@Set the led light of the X210.
 	@According to the X210 Core board schematic diagram V1.2 (x210cv3.pdf)
 	@and X210 Base board schematic diagram V3.0 (x210bv3.pdf)
 	@set the register and them value.
 	*/
 	@step 1 :set the gpio control register
 	ldr r0, =GPJ0CON		@set the GPJ0CON register address
 	ldr r1, =0x66111666		@set the 3th,4th,5th pin of the GPJ0CON register as output
 	str r1, [r0]
 	ldr r0, =GPD0CON		@set the GPD0CON register address
 	ldr r1, =0x00006616		@set the 1st pin of the GPD0CON register as output
 	str r1, [r0]		
 	@step 1 :set the gpio data register
 	ldr r0, =GPJ0DAT		@set the GPJ0DAT register address
 	ldr r1, =GPD0DAT		@set the GPD0DAT register address

	ldr r2, =BLINK_TIMES	@set the led blink times
 blink:	@blink the led
 	ldr r3, =0x00000000
 	str r3, [r0]
 	str r3, [r1]
 	bl _delay
	ldr r3, =0x00000038
 	str r3, [r0]
	ldr r3, =0x00000002
 	str r4, [r1]
 	bl _delay
 	subs r2, r2, #1
 	bne blink

 flow:	@set the led flow as water
 	ldr r3, =((0<<3)|(1<<4)|(1<<5))
 	str r3, [r0]
	bl _delay
 	ldr r3, =((1<<3)|(0<<4)|(1<<5))
 	str r3, [r0]
	bl _delay
 	ldr r3, =((1<<3)|(1<<4)|(0<<5))
 	str r3, [r0]
 	bl _delay
 	ldr r3, =((1<<3)|(1<<4)|(1<<5))
 	str r3, [r0]
 	ldr r3, =(0<<1)
 	str r3, [r1]
 	bl _delay

reflow:	@reverse the led flow as water
 	ldr r3, =(1<<1)
 	str r3, [r1]
 	ldr r3, =((1<<3)|(1<<4)|(0<<5))
 	str r3, [r0]
 	bl _delay
 	ldr r3, =((1<<3)|(0<<4)|(1<<5))
 	str r3, [r0]
 	bl _delay
 	ldr r3, =((0<<3)|(1<<4)|(1<<5))
 	str r3, [r0]
 	bl _delay

 push:	@light the led as push stacked
 	@ldr r3, =((0<<3)|(1<<4)|(1<<5))
 	@str r3, [r0]
	@bl _delay
 	ldr r3, =((1<<3)|(0<<4)|(1<<5))
 	str r3, [r0]
	bl _delay
 	ldr r3, =((1<<3)|(1<<4)|(0<<5))
 	str r3, [r0]
 	bl _delay
 	ldr r3, =((1<<3)|(1<<4)|(1<<5))
 	str r3, [r0]
 	ldr r3, =(0<<1)
 	str r3, [r1]
 	bl _delay
 	ldr r3, =((0<<3)|(1<<4)|(1<<5))
 	str r3, [r0]
	bl _delay
 	ldr r3, =((1<<3)|(0<<4)|(1<<5))
 	str r3, [r0]
	bl _delay
 	ldr r3, =((1<<3)|(1<<4)|(0<<5))
 	str r3, [r0]
 	bl _delay
 	ldr r3, =((0<<3)|(1<<4)|(0<<5))
 	str r3, [r0]
	bl _delay
 	ldr r3, =((1<<3)|(0<<4)|(0<<5))
 	str r3, [r0]
	bl _delay
 	ldr r3, =((0<<3)|(0<<4)|(0<<5))
 	str r3, [r0]
 	bl _delay

pull:	@light the led as deliver from godown
	ldr r3, =((1<<3)|(0<<4)|(0<<5))
 	str r3, [r0]
 	bl _delay
	ldr r3, =((0<<3)|(1<<4)|(0<<5))
 	str r3, [r0]
 	bl _delay
	ldr r3, =((1<<3)|(1<<4)|(0<<5))
 	str r3, [r0]
 	bl _delay
	ldr r3, =((1<<3)|(0<<4)|(1<<5))
 	str r3, [r0]
 	bl _delay
	ldr r3, =((0<<3)|(1<<4)|(1<<5))
 	str r3, [r0]
 	bl _delay
	ldr r3, =((1<<3)|(1<<4)|(1<<5))
 	str r3, [r0]
 	bl _delay
 	ldr r3, =(1<<1)
 	str r3, [r1]
 	ldr r3, =((1<<3)|(1<<4)|(0<<5))
 	str r3, [r0]
 	bl _delay
 	ldr r3, =((1<<3)|(0<<4)|(1<<5))
 	str r3, [r0]
 	bl _delay
 	ldr r3, =((0<<3)|(1<<4)|(1<<5))
 	str r3, [r0]
 	bl _delay
 	ldr r3, =((1<<3)|(1<<4)|(1<<5))
 	str r3, [r0]
 	bl _delay

 	@redo all of control
 	b _led_s

 _delay:	@delay
 	ldr r5, =9000000
 loop:
 	subs r5, r5, #1
 	bne loop
 	mov pc, lr