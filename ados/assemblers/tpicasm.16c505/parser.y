%{
/*int yylex (void);*/

/*
* tpicasm PIC 16C505 compiler-scanner-parser-assembler
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
#include "y.tab.h"
#include <stdio.h>

FILE *fp = (FILE *)0;

void yyerror(const char *str)
{
	
}

int yywrap()
{
	return 1;
}

main()
{

/*
	SymtabElt e;
	e.type = INTEGER;
	e.Integer = 123;	

	s = add_symtab(&s, &e);	
	print_symtab(&s);
*/
	fp = fopen ("./code.ooo", "w+");
	yyparse();
}

%}

%token LEFTPARENS RIGHTPARENS COMMA NAME IF THEN ELSE DO PLUS MINUS MULTIPLY DIVIDE ADDWF ANDWF CLRF CLRW COMF DECF DECFSZ INCF INCFSZ IORWF MOVF MOVWF NOP RLF RRF SUBWF SWAPF XORWF BCF BSF BTFSC BTFSS ANDLW CALL CLRWDT GOTO IORLW MOVLW OPTION RETLW SLEEP TRIS XORLW
%left '+' '-'
%left '*'

%% 
/*FIXME: END IF ;<-*/
stms: stm stms 		{ printf("STMS1 ");}	
	| stm				{ printf("STMS3 ");} 
	;
stm:	 ifclause				{ printf("STMSIF "); } 
	| doclause				{ printf("DOSTM "); }
	| exp					{ printf("EXP ");} 
	|/* empty */
	;

ifclause:	IF LEFTPARENS stm RIGHTPARENS THEN LEFTPARENS stm RIGHTPARENS	{ printf("if-then clause"); }
	|	IF LEFTPARENS stm RIGHTPARENS THEN LEFTPARENS stm RIGHTPARENS	ELSE LEFTPARENS stm RIGHTPARENS { printf("if-then-else clause"); }
	;


doclause:	DO LEFTPARENS stm RIGHTPARENS stm	{ printf("do clause"); }
	;


exp: exp PLUS exp
	| exp MINUS exp
	| exp MULTIPLY exp
	| exp DIVIDE exp
	| ADDWF NAME COMMA NAME { /*printf("%s", $1);*/ printf("ADDWF clause"); fprintf(fp, "%x%x%x", 1,8+4+$4*2+$2,$2*8+$2*4+$2*2+$2); }
	| ANDWF NAME COMMA NAME { printf("ANDWF clause"); fprintf(fp, "%x%x%x", 1,4+$4*2+$2, 8*$2+4*$2+2*$2+$2); }
	| CLRF NAME { printf("CLRF clause"); fprintf(fp, "%x%x%x", 0,0+4+2+$2,8*$2+4*$2+2*$2+$2); }
	| CLRW { printf("CLRW clause"); fprintf(fp, "%x%x%x", 0,4,0); }
	| COMF NAME COMMA NAME { printf("COMF clause"); fprintf(fp, "%x%x%x", 2,4+$4*2+$2,8*$2+4*$2+2*$2+$2); } 
	| DECF NAME COMMA NAME { printf("DECF clause"); fprintf(fp, "%x%x%x", 0, 8+4+$4*2+$2, 8*$2+4*$2+2*$2+$2); }
	| DECFSZ NAME COMMA NAME { printf("DECFSZ clause"); fprintf(fp, "%x%x%x", 2, 8+4+$4*2+$2, 8*$2+4*$2+2*$2+$2); }
	| INCF NAME COMMA NAME { printf("INCF clause"); fprintf(fp, "%x%x%x", 2, 8+$4*2+$2, 8*$2+4*$2+2*$2+$2); }
	| INCFSZ NAME COMMA NAME { printf("INCFSZ clause"); fprintf(fp, "%x%x%x", 2+1, 8+4+$4*2+$2, 8*$2+4*$2+2*$2+$2); }
	| IORWF NAME COMMA NAME { printf("IORWF clause"); fprintf(fp, "%x%x%x", 1, $4*2+$2, 8*$2+4*$2+2*$2+$2); }
	| MOVF NAME COMMA NAME { printf("MOVF clause"); fprintf(fp, "%x%x%x", 2, 2*$4+$2, 8*$2+4*$2+2*$2+$2); }
	| MOVWF NAME { printf("MOVWF clause"); fprintf(fp, "%x%x%x", 0, 2+$2, 8*$2+4*$2+2*$2+$2); }
	| NOP { printf("NOP clause"); fprintf(fp, "%x%x%x", 0,0,0); }
	| RLF NAME COMMA NAME { printf("RLF clause"); fprintf(fp, "%x%x%x", 2+1,4+2*$4+$2,8*$2+4*$2+2*$2+$2); }
	| RRF NAME COMMA NAME { printf("RRF clause"); fprintf(fp, "%x%x%x", 2+1,2*$4+$2,8*$2+4*$2+2*$2+$2); }
	| SUBWF NAME COMMA NAME { printf("SUBWF clause"); fprintf(fp, "%x%x%x", 0,8+2*$4+$2,8*$2+4*$2+2*$2+$2); }
	| SWAPF NAME COMMA NAME { printf("SWAPF clause"); fprintf(fp, "%x%x%x", 2+1,8+2*$4+$2,8*$2+4*$2+2*$2+$2); }
	| XORWF NAME COMMA NAME { printf("XORWF clause"); fprintf(fp, "%x%x%x", 1,8+2*$4+$2,8*$2+4*$2+2*$2+$2); }
	| BCF NAME COMMA NAME { printf("BCF clause"); fprintf(fp, "%x%x%x", 4,8*$4+4*$4+2*$4+$2,8*$2+4*$2+2*$2+$2); }
	| BSF NAME COMMA NAME { printf("BSF clause"); fprintf(fp, "%x%x%x", 4+1,8*$4+4*$4+2*$4+$2,8*$2+4*$2+2*$2+$2); }
	| BTFSC NAME COMMA NAME { printf("BTFSC clause"); fprintf(fp, "%x%x%x", 4+2,8*$4+4*$4+2*$4+$2,8*$2+4*$2+2*$2+$2); }
	| BTFSS NAME COMMA NAME { printf("BTFSS clause"); fprintf(fp, "%x%x%x", 4+2+1,8*$4+4*$4+2*$4+$2,8*$2+4*$2+2*$2+$2); }
	| ANDLW NAME { printf("ANDLW clause"); fprintf(fp, "%x%x%x", 8+4+2,8*$2+4*$2+2*$2+$2,8*$2+4*$2+2*$2+$2); }
	| CALL NAME { printf("CALL clause"); fprintf(fp, "%x%x%x", 8+1,8*$2+4*$2+2*$2+$2,8*$2+4*$2+2*$2+$2); }
	| CLRWDT NAME { printf("CLRWDT clause"); fprintf(fp, "%x%x%x", 0,0,4); }
	| GOTO NAME { printf("GOTO clause"); fprintf(fp, "%x%x%x", 8+2+$2, 8*$2+4*$2+2*$2+$2, 8*$2+4*$2+2*$2+$2); } 
	| IORLW NAME { printf("IORLW clause"); fprintf(fp, "%x%x%x", 8+4+1, 8*$2+4*$2+2*$2+$2, 8*$2+4*$2+2*$2+$2); } 
	| MOVLW NAME { printf("MOVLW clause"); fprintf(fp, "%x%x%x", 8+4, 8*$2+4*$2+2*$2+$2, 8*$2+4*$2+2*$2+$2); } 
	| OPTION { printf ("OPTION clause"); fprintf(fp, "%x%x%x", 0,0,2); }
	| RETLW NAME { printf("RETLW clause"); fprintf(fp, "%x%x%x", 8, 8*$2+4*$2+2*$2+$2, 8*$2+4*$2+2*$2+$2); } 
	| SLEEP { printf("SLEEP clause"); fprintf(fp, "%x%x%x", 0,0,2+1); } 
	| TRIS NAME { printf("TRIS clause"); fprintf(fp, "%x%x%x", 0,0,4*$2+2*$2+$2); } 
	| XORLW NAME { printf("XORLW clause"); fprintf(fp, "%x%x%x", 8+4+2+1, 8*$2+4*$2+2*$2+$2, 8*$2+4*$2+2*$2+$2); } 
	;
%%
