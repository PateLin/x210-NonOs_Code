/*********************************************************************************
  *FileName		:	start.S
  *Author		:  	PateLin
  *Version		:  	V1.0.4
  *Date			:	2016.05.29
  *Description	:	X210 naked machine start code.
  *Others		:  
  *History		: 	V1.0.0 start and control led light 
  *					V1.0.1 add close the watch dog
  *					V1.0.2 add set the SVC stack
  *					V1.0.3 call the C main function
  *					V1.0.4 to test open or close the icache
**********************************************************************************/
.equ WDTCON		,0XE2700000	@the watch dog control register address
.equ STRACK_ADD	,0xD0037D80	@the address of the SVC strack in IRAM

.global _start
 _start:
 	@close the watch dog
 	ldr r0, =WDTCON
 	ldr r1, =0x00000000
 	str r1, [r0]

 	@switch the icache
 	mrc p15,0,r0,c1,c0,0;			@ read the c1 of the cp15 to r0
	@bic r0, r0, #(1<<12)			@ to reset the bit12 to shut the icache
	orr r0, r0, #(1<<12)			@ to set the bit12 to turn on the icache
	mcr p15,0,r0,c1,c0,0;

 	@set the SVC stack
 	ldr sp, =STRACK_ADD

 	@bl _led_s
 	bl main
 	b .
