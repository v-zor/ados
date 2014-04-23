ASM=nasm
AS=as

# NOTE pass -m64 to gcc command for 64 bit binary

CC=gcc
LD=ld
LIBS = 
OBJECTS = dev.o

SOBJECTS = 

all: $(SOBJECTS) $(OBJECTS)

clean:
	rm *.o kernel.dev.bin 

kernel: 
	$(LD) *.o -o kernel.dev.bin --oformat=binary ### -Ttext=0x100000 

.s.o:
	$(ASM) $<

.c.o:
	$(CC) -masm=intel -Wall -ansi -c $<
