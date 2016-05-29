/*********************************************************************************
  *FileName		:	start.S
  *Author		:  	PateLin
  *Version		:  	V1.0.1
  *Date			:	2016.05.29
  *Description	:	X210 naked machine start code.
  *Others		:  
  *History		: 	V1.0.0 start and control led light 
  *					V1.0.0 add close the watch dog
**********************************************************************************/
.equ WDTCON	,0XE2700000	@the watch dog control register address

.global _start
 _start:
 	@close the watch dog
 	ldr r0, =WDTCON
 	ldr r1, =0x00000000
 	str r1, [r0]

 	bl _led_s
 	b .
 	