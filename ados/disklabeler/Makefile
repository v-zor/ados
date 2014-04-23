ASM=nasm

# NOTE pass -m64 to gcc command for 64 bit binary

CC=gcc
LD=ld
LIBS = 
OBJECTS = disklabeler.o \
	mbrcode.o

SOBJECTS = label.o 

all: $(SOBJECTS) $(OBJECTS) disklabeler

clean:
	rm *.o label disklabeler disklabeler.bin


disklabeler: 
	$(LD) *.o -o disklabeler.bin --oformat=binary -Ttext=0x000000 

.s.o:
	$(ASM) $<

.c.o:
	$(CC) -masm=intel -Wall -ansi -c $<
