AS=as
CC=gcc
LIBS = 
OBJECTS = disklabeler.o
SOBJECTS = 

all: disklabeler 

clean:
	rm *.o disklabeler


disklabeler: $(OBJECTS)
	$(CC) -o disklabeler *.o $(LIBS)

.s.o:
	$(AS) -c $<

.c.o:
	$(CC) -c $<
