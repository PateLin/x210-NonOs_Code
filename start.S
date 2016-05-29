/*********************************************************************************
  *FileName		:	start.S
  *Author		:  	PateLin
  *Version		:  	V1.0.2
  *Date			:	2016.05.29
  *Description	:	X210 naked machine start code.
  *Others		:  
  *History		: 	V1.0.0 start and control led light 
  *					V1.0.1 add close the watch dog
  *					V1.0.2 add set the SVC stack
**********************************************************************************/
.equ WDTCON		,0XE2700000	@the watch dog control register address
.equ STRACK_ADD	,0xD0037D80	@the address of the SVC strack in IRAM
.global _start
 _start:
 	@close the watch dog
 	ldr r0, =WDTCON
 	ldr r1, =0x00000000
 	str r1, [r0]

 	@set the SVC stack
 	ldr sp, =STRACK_ADD

 	bl _led_s
 	b .
