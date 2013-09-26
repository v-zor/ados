%{
/*int yylex (void);*/

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
#include "y.tab.h"
#include<stdio.h>
#include<string.h>
#include "symtab.h"
#include<stdlib.h> //exit(0); syscall
Symtab symboltable;
int counter1, counter2;
FILE *fp = (FILE *)0;

void yyerror(const char *str)
{
	
}

int yywrap()
{
	return 1;
}

void dispatch_ifclause(int cs)
{
	fprintf(fp, "MOVF %d", cs);
	fprintf(fp, "MOVWF 0x00"); // load 0x00 file reg f into W (this is the result of the if clause)
	fprintf(fp, "ANDWF 0x00, 0"); //Check it d = 0 (for destination W)
        fprintf(fp, "GOTO 0x00"); // Goto previous destination W (compactize layter on for PIC prog memory)
	 
}

void dispatch_ifandclause(int cs)
{
	fprintf(fp, "MOVWF 0x00"); // load 0x00 file reg f into W (this is the result of the if clause)
	fprintf(fp, "ANDWF 0x00, 0"); //Check it d = 0 (for destination W)
        fprintf(fp, "GOTO 0x00"); // Goto previous destination W (compactize layter on for PIC prog memory)
	 
}

main()
{

	fp = fopen ("./code.ooo", "w+");
	make_symtab(&symboltable);
	counter2 = 0;
	counter1 = 0;
	yyparse();
	fclose(fp);

}

%}

%token LEFTBRACKET RIGHTBRACKET LEFTPARENS RIGHTPARENS COMMA NAME DIGIT SEMICOLON INTTYPE CHARTYPE EQUALS OR AND NOT IF IFAND ELSE WHEN DO WHILE COMMENTOPEN COMMENTCLOSE PLUS MINUS MULTIPLY DIVIDE ADDWF ANDWF CLRF CLRW COMF DECF DECFSZ INCF INCFSZ IORWF MOVF MOVWF NOP RLF RRF SUBWF SWAPF XORWF BCF BSF BTFSC BTFSS ANDLW CALL CLRWDT GOTO IORLW MOVLW OPTION RETLW SLEEP TRIS XORLW
%left '+' '-'
%left '*'

%% 
/*FIXME: END IF ;<-*/
stms: stm stms 		{ printf("STMS1 ");}	
	| stm				{ printf("STMS3 ");} 
	| INTTYPE NAME EQUALS DIGIT SEMICOLON	{ printf("DECLARATION ");/* int n = atoi((char *)$2) % INTSYMBOLSN; intsymbols[n == 0 ? n : n-1] = atoi((char *)$4);*/
	Symtabkey key;
	key.type = INTEGER;
	key.Integer = atoi((char *)$4);
	key.Char = 0;
	key.name  = strdup((char *)$2);	
	add_pair(&symboltable, &key);
	counter2 ++;
	 } 
	| CHARTYPE NAME EQUALS DIGIT SEMICOLON	{ printf("DECLARATION ");/* int n = atoi((char *)$2) % INTSYMBOLSN; intsymbols[n == 0 ? n : n-1] = atoi((char *)$4);*/
	Symtabkey key;
	key.type = CHAR;
	key.Integer = 0;
	key.Char = atoi((char *)$4);
	key.name  = strdup((char *)$2);	
	add_pair(&symboltable, &key);
	counter2 ++;
	}
	| CHARTYPE NAME EQUALS NAME SEMICOLON	{ printf("DECLARATION ");/* int n = atoi((char *)$2) % INTSYMBOLSN; intsymbols[n == 0 ? n : n-1] = atoi((char *)$4);*/
	Symtabkey key;
	key.type = CHAR;
	key.Integer = 0; 
	key.Char = atoi((char *)$4);
	key.name  = strdup((char *)$2);	
	add_pair(&symboltable, &key);
	counter2 ++;
	}
	| COMMENTOPEN stms COMMENTCLOSE stms	{ printf("comment..."); }
	;
stm:	 ifclause				{ printf("STMSIF "); }
	| whenclause				{ printf("STMSWHEN"); } 
	| doclause				{ printf("DOSTM "); }
	| exp					{ printf("EXP ");}
	| RIGHTBRACKET				{ printf("BLOCKCLOSE"); counter1 -= (counter2 - counter1); counter2 = counter1; symboltable.offset = counter1; }	
	|/* empty */
	;

whenclause:	WHEN LEFTPARENS exp RIGHTPARENS LEFTBRACKET stms { printf("when clause"); counter1 = counter2; symboltable.offset = counter1; dispatch_ifclause(atoi((char *)$3)); }
	;

ifclause:	IF LEFTPARENS exp RIGHTPARENS LEFTBRACKET { printf("if clause"); counter1 = counter2; symboltable.offset = counter1; dispatch_ifclause(atoi((char *)$3)); }
	|	IFAND LEFTPARENS exp RIGHTPARENS LEFTBRACKET { printf("if-and clause"); counter1 = counter2; symboltable.offset = counter1; dispatch_ifandclause(atoi((char *)$3)); }
	|	IF LEFTPARENS exp RIGHTPARENS stm { printf("if clause"); dispatch_ifclause(atoi((char *)$3)); }
	|	ELSE LEFTBRACKET { printf("else clause"); counter1 = counter2; symboltable.offset = counter1; /*FIXMEdispatch_ifclause(atoi((char *)$3)); */}
	|	ELSE stm { printf("else-single clause"); /*FIXMEdispatch_ifclause(atoi((char *)$3));*/ }
	;


doclause:	WHILE LEFTPARENS stm RIGHTPARENS LEFTBRACKET stms RIGHTBRACKET	{ printf("do clause"); }
	;


exp: exp PLUS exp { $$ = $1 + $3; }
	| DIGIT { printf("digit clause"); return atoi((char *)$1); }
	| exp MINUS exp { $$ = $1 + $3; }
	| exp MULTIPLY exp { $$ = $1 * $3; }
	| exp DIVIDE exp { $$ = $1 / $3; }
	| NOT exp { $$ = atoi((char *)$2) ? 0 : 1; }
	| exp AND exp { $$ = (atoi((char *)$1) && atoi((char *)$2)); }
	| exp OR exp { $$ = (atoi((char *)$1) || atoi((char *)$2)); }
	| NAME { printf("NAME clause"); 
		Symtabkey key = search_pair(&symboltable,(char *)$1); 
		switch (key.type) {
		case 1:{
			$$ = key.Integer;//Integer
			break;
		}
		case 2:{
			$$  = key.Char;//Char
			break;
		}
		default:
			fprintf(stdout, "***error tpicasm : Undeclared identifier %s\n", (char *)$1);
			exit(0);
			//FIXME $$ = NULL;
			break;
		}
	}
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
