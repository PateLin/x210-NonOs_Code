
#####################################
#	This Makefile is for Compile 	#
#	the X210 base computer Code!	#
#####################################

#The local compile tool for X210
CC = arm-none-linux-gnueabi-gcc
LD = arm-none-linux-gnueabi-ld
OC = arm-none-linux-gnueabi-objcopy
OD = arm-none-linux-gnueabi-objdump

RM 		= rm -rf
MKDIR 	= mkdir

DIR_OBJS= ./objs
DIR_EXES= ./exes
DIRS 	= $(DIR_OBJS) $(DIR_EXES)

SRCS = $(wildcard *.c *.S)

OBJS := $(SRCS:.c=.o)
OBJS := $(OBJS:.S=.o)
OBJS := $(addprefix $(DIR_OBJS)/,$(OBJS))

BOOT = $(DIR_EXES)/boot
BIN = $(BOOT).bin
ELF = $(BOOT).elf
DIS = $(ELF).dis

all:$(DIRS) $(BIN)

$(DIRS):
	$(MKDIR) $@

$(BIN):$(OBJS)
	$(LD) -Ttext 0x0 -o $(ELF) $^
	$(OC) -O binary $(ELF) $@
	$(OD) -D $(ELF) > $(DIS)

$(DIR_OBJS)/%.o:%.c
	$(CC) -nostdlib -o $@ $< -c

$(DIR_OBJS)/%.o:%.S
	$(CC) -o $@ $< -c

.PHONY:clean
clean:
	$(RM) *.o *.elf *.bin *.dis $(DIRS)
