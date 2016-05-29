
#####################################
#	This Makefile is for Compile 	#
#	the X210 base computer Code!	#
#####################################

#The local compile tool for X210
CC = arm-none-linux-gnueabi-gcc
LD = arm-none-linux-gnueabi-ld
OC = arm-none-linux-gnueabi-objcopy
OD = arm-none-linux-gnueabi-objdump

X210.bin:start.o main.o led.o
	$(LD) -Ttext 0x0 -o start.elf $^
	$(OC) -O binary start.elf start.bin
	$(OD) -D start.elf >start.elf.dis

%.o : %.s
	$(CC) -o $@ $< -c

%.o : %.c
	#$(CC) -o $@ $< -c
	$(CC) -nostdlib -o $@ $< -c

clean:
	rm *.o *.elf *.bin *.dis -f
