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
 	bl _led_s
 	b .
 	