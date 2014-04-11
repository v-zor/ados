#!/bin/sh

make clean;
lex scanner.l
##bison -y parser.y
yacc -d parser.y
make;
cat test.s | ./tpicasm
