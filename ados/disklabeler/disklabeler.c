/*
 Copyright (C) Johan Ceuppens 2013-2014

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

#include "disklabeler.h"

static void write_bootsector55AA()
{
	/* write 0x55 @ byte 511 and write 0xAA in byte 512 */	
		
}

static void load_bootsector55AA(void)
{
	/* load to 0x7c00:0x0000 or 0x0000:0x7c00 */
	/* you can jump to label.s code in this binary and write it together
		with the mbrcode.c with a boot record into RAM 
	*/	
}

void write_bootsector(void)
{
	write_bootsector55AA();

}		

void load_bootsector(void)
{
	load_bootsector55AA();

}

#if 0
int main()
{
}
#endif
