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

#include "mbrcode.h"

void write_floppy_mbr(void)
{

}

void write_hd_mbr(void)
{

/***
	fprintf(stdout, "%x", 0x80);
	fprintf(stdout, "%x", getheads());
	fprintf(stdout, "%x", getcyls());
	fprintf(stdout, "%x", gettypes());
	fprintf(stdout, "%x", endheads());
	fprintf(stdout, "%x", endcyls());
	fprintf(stdout, "%x", getsector());
	fprintf(stdout, "%x", getsectorn());
***/

	struct mbr_table_entry *mte;
	mte = kmalloc(4096);

	getbootflag();
	getheads();
	getcyls();
	gettype(); 
	getendheads();
	getendcyls();
	getstartsector();
	getnsectors();

		
}

/* boot flag 0x80 bootable, 0x00 unbootable */
uint16 getbootflag(void)
{
	return 0x08;
}
/* get starting head number */
uint16 getheads(void)
{
	return 0;
}
/* get ending head number */
uint16 getendheads(void)
{
	return 1048576; 
}
/* get starting cylinder number */
uint32 getcyls(void)
{
	return 0;
}
/* get starting cylinder number */
uint32 getendcyls(void)
{
	return 1048576; 
}

/* get filesystem type */
uint16 gettype(void)
{
	return 0xff;
}

/* get start sector */
uint64 getstartsector(void)
{
	return 0;
}

/* get number of sectors */
uint64 getnsectors(void)
{
	return 1024;
}


