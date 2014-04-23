ASM=nasm
AS=as

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
	print.o \
	display.o \
	screen.o \
	task.o \
	taskmgr.o \
	characters.o \
	usrlnd.o

### C++	fb.o \

SOBJECTS = 

all: $(SOBJECTS) $(OBJECTS) kernel

clean:
	rm *.o label kernel kernel.example.bin kernel.bin


kernel: 
	$(LD) *.o -o kernel.bin --oformat=binary ### -Ttext=0x000000 
	$(AS) boot.s -o boot.o
	$(CC) -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
	$(CC) -T linker.ld -o kernel.example.bin -ffreestanding -O2 -nostdlib boot.o kernel.o ### -lgcc

.s.o:
	$(ASM) $<

.c.o:
	$(CC) -masm=intel -Wall -ansi -c $<
