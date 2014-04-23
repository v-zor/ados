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

#ifndef _VUBX_CHARACTERS_H_
#define _VUBX_CHARACTERS_H_
#include "types.h"

/* number of char wide and high */
extern uint32 VIDEO_MODE_CHARW;
extern uint32 VIDEO_MODE_CHARH;
/* a char wide and high */
extern uint32 CHARW;
extern uint32 CHARH;
/* a char wide and high for blitting */
extern uint32 CHARW16;
extern uint32 CHARH16;

void print_character(char c);

#endif
