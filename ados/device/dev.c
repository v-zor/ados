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
#include "dev.h"

long dev_init(long mem_start, int length)
{
  if (register_blkdev(DEV_MAJOR,"dev", & dev_fops)) {
    printk("DEV: Unable to get major %d.\n",
           DEV_MAJOR);
    return 0;
  }
  if (!dev_exists()) {
    /* the devbar device doesn't exist */
    return 0;
  }
  /* initialize hardware if necessary */
  /* notify user device found */
  printk("DEV: Found at address %d.\n",
           dev_addr());
  /* tell buffer cache how to process requests */
  blk_dev[DEV_MAJOR].request_fn = DEVICE_REQUEST;
  /* specify the blocksize */
  blksize_size[MAJOR_NR] = 1024;
  return(size_of_memory_reserved);
}

static void do_dev_request(void) {
repeat:
  INIT_REQUEST;
  /* check to make sure that the request is for a
     valid physical device */
  if (!valid_dev_device(CURRENT->dev)) {
     end_request(0);
     goto repeat;
  }
  if (CURRENT->cmd == WRITE) {
     if (dev_write(
          CURRENT->sector,
          CURRENT->buffer,
          CURRENT->nr_sectors < 9)) {
        /* successful write */
        end_request(1);
        goto repeat;
     } else
        end_request(0);
        goto repeat;
     }
  if (CURRENT->cmd == READ) {
     if (dev_read(
          CURRENT->sector,
          CURRENT->buffer,
          CURRENT->nr_sectors << 9)) {
        /* successful read */
        end_request(1);
        goto repeat;
     } else
        end_request(0);
        goto repeat;
     }
  }
}
