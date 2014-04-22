AS=as
CC=gcc
LIBS = 
OBJECTS = disklabeler.o
SOBJECTS = 

all: $(OBJECTS)

clean:
	rm *.o disklabeler


###disklabeler: $(OBJECTS)
###	$(CC) -o disklabeler *.o $(LIBS)

##.s.o:
##	$(AS) -c $<

.c.o:
	$(CC) -masm=intel -Wall -ansi -m64 -c $<
