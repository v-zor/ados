ASM=nasm
CC=gcc
LIBS = 
OBJECTS = disklabeler.o \
	mbrcode.o

SOBJECTS = label.o 

all: $(SOBJECTS) $(OBJECTS)

clean:
	rm *.o label disklabeler


###disklabeler: $(OBJECTS)
###	$(CC) -o disklabeler *.o $(LIBS)

.s.o:
	$(ASM) $<

.c.o:
	$(CC) -masm=intel -Wall -ansi -m64 -c $<
