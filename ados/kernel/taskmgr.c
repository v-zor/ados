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

#include "taskmgr.h"

int task_add(TaskMgr *tmgr, Task *t)
{

	if (tmgr->current >= tmgr->max)
		return PRGERR;

	tmgr->queue += tmgr->current; 
	tmgr->queue = t;
	tmgr->queue -= tmgr->current; 
	return 0;
}
