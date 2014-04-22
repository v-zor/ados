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

#ifndef _VUBX_MBRCODE_H_
#define _VUBX_MBRCODE_H_

/* int should be 32 bits wide */
struct mbr_table_entry {
	short int bootflag, starthead, descriptor, endhead;
	int startcyl, endcyl;
	long int startsector, nsectors;

}; 

void write_floppy_mbr(void);
void write_hd_mbr(void);
int getbootflag(void);
int getheads(void);
int getendheads(void);
int getcyls(void);
int getendcyls(void);
int gettype(void);
int getstartsector(void);
int getnsectors(void);

#endif
