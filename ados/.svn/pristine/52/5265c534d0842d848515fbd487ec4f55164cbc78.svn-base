/*
 Copyright (C) Johan Ceuppens 2013

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

#include "error.h"
#include "types.h"
#include "elflnd.h"

static int parse_elf32(uint32 oper, uint32 opnd1, uint32 opnd2)
{
	switch(oper) {
		case 0x00000000:{
			return PRGERR;
		}
		default:{
			return PRGERR;
			break;
		}
	}

	return 0;	
}

static int parse_elf64(uint64 op)
{
	return PRGERR;	
}
