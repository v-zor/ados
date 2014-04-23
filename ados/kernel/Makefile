ASM=nasm

# NOTE pass -m64 to gcc command for 64 bit binary

CC=gcc
LD=ld
LIBS = 
OBJECTS = \
	elf.o \
	font.o \
	globals_memory.o \
	malloc.o \
	memcpy.o \
	memset.o \
	display.o \
	screen.o \
	task.o \
	taskmgr.o \
	usrlnd.o

### C++	fb.o \

SOBJECTS = 

all: $(SOBJECTS) $(OBJECTS) kernel

clean:
	rm *.o label kernel kernel.bin


kernel: 
	$(LD) *.o -o kernel.bin --oformat=binary -Ttext=0x100000 

.s.o:
	$(ASM) $<

.c.o:
	$(CC) -masm=intel -Wall -ansi -c $<
