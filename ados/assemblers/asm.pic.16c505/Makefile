LIBS = -lfl
OBJECTS = lex.yy.o\
	y.tab.o\

all: tpicasm 

clean:
	rm *.o tpicasm lex.yy.* y.tab.*


tpicasm: $(OBJECTS)
	cc -o tpicasm *.o $(LIBS)
