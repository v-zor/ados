/*
# Copyright (C) Johan Ceuppens 2013-2014
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include "types.h" 
#include "globals_memory.h"

void *
kmalloc(void *dst, void *src, size_t n)
{
	if (n != 0) {
		unsigned char *s = src;
		unsigned char *d = dst;
		do
			*d++ = (unsigned char)(*s++);
		while (--n != 0);
	}
	return (dst);
}
