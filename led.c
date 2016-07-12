/*********************************************************************************
  *FileName	:	led.c
  *Author		:  	PateLin
  *Version	:  	V1.0.0
  *Date			:	2016.05.29
  *Description	:	Control the LED of X210,the step as: 
  *					1.blink all of the led 3 tiems
  *					2.light the led as flow water
  *					3.light the led reverse of step 2 as flow water
  *					4.light the led as push stacked
  *					5.light the led as deliver from godown
  *Others		:  
  *History		: 	V1.0.0 add the control of the LED function
**********************************************************************************/

#define GPJ0CON (0xE0200240)
#define GPJ0DAT (0xE0200244)
#define GPD0CON (0xE02000A0)
#define GPD0DAT (0xE02000A4)

#define rGPJ0CON (*(volatile unsigned int *)GPJ0CON)
#define rGPJ0DAT (*(volatile unsigned int *)GPJ0DAT)
#define rGPD0CON (*(volatile unsigned int *)GPD0CON)
#define rGPD0DAT (*(volatile unsigned int *)GPD0DAT)

#define DELAY_COUNT		900000

/*
static void light_swt(int number, int swt);
static void light_only(int number);
static void blink(int times);
static void flow(void);
static void reflow(void);
static void push_stack(void);
static void pull_stack(void);
static void delay();

void init_led(void)
{
	rGPJ0CON = 0x66111666;
	rGPD0CON = 0x00006616;
	return ;
}

void ctrl_led(void)
{
	blink(3);
	//flow();
	//reflow();
	//push_stack();
	//pull_stack();
	return ;
}

static void light_swt(int number, int swt)
{
	switch (number){
	case 0:
		if (0 != swt) {
			rGPJ0DAT &= ~(1<<3);	
		} else {
			rGPJ0DAT |= (1<<3);
		}
		break;
	case 1:
		if (0 != swt) {
			rGPJ0DAT &= ~(1<<4);
		} else {
			rGPJ0DAT |= (1<<4);
		}
		break;
	case 2:
		if (0 != swt) {
			rGPJ0DAT &= ~(1<<5);
		} else {
			rGPJ0DAT |= (1<<5);
		}
		break;
	case 3:
		if (0 != swt) {
			rGPD0DAT &= ~(1<<1);
		} else {
			rGPD0DAT |= (1<<1);
		}
		break;
	default:
		if (0 != swt) {
			//rGPJ0DAT &= ~(7<<5);
			//rGPD0DAT &= ~(1<<1);
			rGPJ0DAT = (0<<3|0<<4|0<<5);
			rGPD0DAT = (0<<1);
		} else {
			//rGPJ0DAT |= (7<<5);
			//rGPD0DAT |= (1<<1);
			rGPJ0DAT = (1<<3|1<<4|1<<5);
			rGPD0DAT = (1<<1);
		}
		break;
	}

	return ;
}
/*
static void light_only(int number)
{
	if (0<number || 3>number) {
		return ;
	}

	int only[4] = {0};
	only[number] = 1;
	int i = 0;
	for (i=0; i!=4; ++i) {
		light_swt(i, only[i]);
	}
	return ;
}

static void blink(int times)
{
	while (0 <= times--) {
		light_swt(4, 1);
		delay();
		light_swt(4, 0);
		delay();
	}
	return ;
}

static void flow(void)
{
	light_only(0);
	delay();
	light_only(1);
	delay();
	light_only(2);
	delay();
	light_only(3);
	delay();
	return ;
}

static void reflow(void)
{
	light_only(3);
	delay();
	light_only(2);
	delay();
	light_only(1);
	delay();
	light_only(0);
	delay();
	return ;
}

static void push_stack(void)
{
	light_swt(0,1);
	delay();
	light_swt(1,1);
	delay();
	light_swt(2,1);
	delay();
	light_swt(3,1);
	delay();
	return ;
}

static void pull_stack(void)
{
	light_swt(0,0);
	delay();
	light_swt(1,0);
	delay();
	light_swt(2,0);
	delay();
	light_swt(3,0);
	delay();
	return ;
}
*/
static void delay(void)
{
	volatile unsigned int i = DELAY_COUNT;
	while(0 != --i){
		;
	}
	return ;
}

void ctrl_led(void)
{
	rGPJ0CON = 0x66111666;
	rGPD0CON = 0x00006616;
	while (1){
		rGPJ0DAT = (0<<3|0<<4|0<<5);
		rGPD0DAT = (0<<1);
		delay();
		rGPJ0DAT = (1<<3|1<<4|1<<5);
		rGPD0DAT = (1<<1);
		delay();
	}
	return ;
}