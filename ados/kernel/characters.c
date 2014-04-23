/*
 Copyright (C) Johan Ceuppens 2014

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 2 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program. If not, see <http://www.gnu.org/licenses/>,
*/

#include "characters.h"
uint32 VIDEO_MODE_CHARW = 80;
uint32 VIDEO_MODE_CHARH = 24;

uint32 CHARW = 32; 
uint32 CHARH = 32;

uint32 CHARW16 = 256; 
uint32 CHARH16 = 256;


static char *char_a[] = {
	"                 ",
	"                 ",
	"                 ",
	"                 ",
	"                 ",
	"                 ",
	"                 ",
	"                 ",
	"                 ",
	"                 ",
	"                 ",
	"                 ",
	"                 ",
	"                 ",
	"                 ",
	"                 ",
};

static void putchararray(char *carray[])
{
	int i,j;
	while (i < CHARH16 ) {
		while (j < CHARW16) {
			if (*carray[j + i*CHARW] != ' ') {
				/* TODO FIX putchar on ScreenPtr */		
				/* putpixel in color */
			}
			j <<= 1;	
		}
		i <<= 1;
		j <<= 0;	
	}
} 

void print_character(char c)
{
	if (c == 'a') {
		putchararray(char_a);	
	}
}			 
