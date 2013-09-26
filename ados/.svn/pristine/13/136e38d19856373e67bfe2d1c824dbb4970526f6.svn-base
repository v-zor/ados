%{
/*
 tpicasm PIC 16C505 compiler-scanner-parser-assembler

 Copyright (C) erana 2011

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 2 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
#include <math.h>
#include "y.tab.h"
extern int yylval;
%}

DIGIT	[0-9]
ID	[0-9]+
ID2	[a-z]*[a-z0-9]*
ID3	[A-Z]*[a-z0-9]*

%%
"("			{ printf("LEFTPARENS"); return LEFTPARENS; }
")"			{ printf("RIGHTPARENS"); return RIGHTPARENS; }
","			{ printf("COMMA"); return COMMA; }
"+"			{printf("PLUS"); return PLUS; }
"-"			{printf("MINUS"); return MINUS; }
"*"			{printf("MULTIPLY"); return MULTIPLY; }
"/"			{printf("DIVIDE"); return DIVIDE; }

if			{ printf ("IF"); return IF; }
then			{ printf ("THEN"); return THEN; }
else			{ printf ("ELSE"); return ELSE; }

do			{ printf ("DO"); return DO; }


ADDWF			{ printf("ADDWF"); return ADDWF; }
ANDWF			{ printf("ANDWF"); return ANDWF; }
CLRF			{ printf("CLRF"); return CLRF; }
CLRW			{ printf("CLRW"); return CLRW; }
COMF			{ printf("COMF"); return COMF; }
DECF			{ printf("DECF"); return DECF; }
DECFSZ			{ printf("DECFSZ"); return DECFSZ; }
INCF			{ printf("INCF"); return INCF; }
INCFSZ			{ printf("INCFSZ"); return INCFSZ; }
IORWF			{ printf("IORWF"); return IORWF; }
MOVF			{ printf("MOVF"); return MOVF; }
MOVWF			{ printf("MOVWF"); return MOVWF; }
NOP			{ printf("NOP"); return NOP; }
RLF			{ printf("RLF"); return RLF; }
RRF			{ printf("RBF"); return RRF; }
SUBWF			{ printf("SUBWF"); return SUBWF; }
SWAPF			{ printf("SWAPF"); return SWAPF; }
XORWF			{ printf("XORWF"); return XORWF; }
BCF			{ printf("BCF"); return BCF; }
BSF			{ printf("BSF"); return BSF; }
BTFSC			{ printf("BTFSC"); return BTFSC; }
BTFSS			{ printf("BTFSS"); return BTFSS; }
ANDLW			{ printf("ANDLW"); return ANDLW; }
CALL			{ printf("CALL"); return CALL; }
CLRWDTR			{ printf("CLRWDT"); return CLRWDT; }
GOTO			{ printf("GOTO"); return GOTO; }
IORLW			{ printf("IORLW"); return IORLW; }
MOVLW			{ printf("MOVLW"); return MOVLW; }
OPTION			{ printf("OPTION"); return OPTION; }
RETLW			{ printf("RETLW"); return RETLW; }
SLEEP			{ printf("SLEEP"); return SLEEP; }
TRIS			{ printf("TRIS"); return TRIS; }
XORLW			{ printf("XORLW"); return XORLW; }

DIGIT  			{ printf ("digit=%s\n", yytext); return NAME; }
ID  			{ printf ("id=%s\n", yytext); return NAME; }
ID2  			{ printf ("id2=%s\n", yytext); return NAME; }
ID3  			{ printf ("id3=%s\n", yytext); return NAME; }

[ \t|\n]+		{ printf ("newline\n"); }

.		{ printf( " Unrecognised char: %s\n", yytext); }
%%
