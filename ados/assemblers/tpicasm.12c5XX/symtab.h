/*
* tpicasm PIC 12C5XX compiler-scanner-parser-assembler
*
* Copyright (C)	erana 2011
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 2 of the License, or
* (at your option) any later version.

* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.

* You should have received a copy of the GNU General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
#ifndef _SYMTAB_H_
#define _SYMTAB_H_

enum { INTEGER = 1, CHAR = 2, } TYPE;
#define SYMBOLSN 4096
typedef struct symtabkey { int type; int Integer; char Char; char* name; } Symtabkey;
typedef struct symtab { int offset; Symtabkey symbols[SYMBOLSN]; } Symtab;

extern int counter1, counter2;

int make_symtab(Symtab *symtab);
Symtabkey *add_pair(Symtab *symtab, Symtabkey *symtabkey);
Symtabkey search_pair(Symtab *symtab, char *name);
void print_symtab(Symtab *symtab);

//public vars
extern Symtab symboltable;

#endif
