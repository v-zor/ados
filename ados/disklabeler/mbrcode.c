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

/*
On a floppy disk, all 512 bytes of the boot record may contain executable code.
 (Well, actually 510 bytes due to the two-byte signature.)
*/

}

void write_hd_mbr(void)
{

/*
On a hard drive, the so-called Master Boot Record (MBR) holds executable code at offset 0x0000 - 0x01bd, followed by table entries for the four primary partitions, using sixteen bytes per entry (0x01be - 0x01fd), and the two-byte signature (0x01fe - 0x01ff).
The layout of the table entries is as follows:
Offset	 Size (bytes)	 Description
0x00	 1	 Boot Indicator (0x80=bootable, 0x00=not bootable)
0x01	 1	 Starting Head Number
0x02	 2	 Starting Cylinder Number (10 bits) and Sector (6 bits)
0x04	 1	 Descriptor (Type of partition/filesystem)
0x05	 1	 Ending Head Number
0x06	 2	 Ending Cylinder and Sector numbers
0x08	 4	 Starting Sector (relative to beginning of disk)
0x0C	 4	 Number of Sectors in partition
*/
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
}

