/*********************************************************************************
  *FileName	:	main.c
  *Author		:  	PateLin
  *Version	:  	V1.0.0
  *Date		:	2016.05.29
  *Description	:	the main function of C after the assembler 
  *Others		:  
  *History		: 	V1.0.0 add the main fuction and call the the fuction of led
**********************************************************************************/
#include "led.h"

void main(void)
{
	ctrl_led();
	return ;
}