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
#include "values.h" 
#include "globals_memory.h"
#include "characters.h"
#include "print.h"

const char * 
kprint(const char *s)
{
	char *res;
	int n;	
	if (s != NIL) {
		do {
			*res++ = *s;	
			print_character(*s++);
		} while (n++ && (*res++ = *s) != '\0');
		return res-n;	
	} else {
		return NIL;
	}
}
