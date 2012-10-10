/*
 * Copyright 2012 Russell Haley
 *
 * This file is part of Deb-And.
 * 
 * Deb-And is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * Deb-And is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with Deb-And.  If not, see <http://www.gnu.org/licenses/>.
 */


#include "./android_filesystem_config.h"
#include <stdlib.h>
#include <stdio.h>

int main ()
{
	int i;
	int GIDArrayLen = sizeof(android_ids) / sizeof(struct android_id_info);
	
	printf("#!/bin/sh\n\n");

	for (i=0; i < GIDArrayLen; ++i){

		if ( android_ids[i].aid >= 3000 && android_ids[i].aid < 4000
		     || android_ids[i].aid == AID_SDCARD_RW
		     || android_ids[i].aid == AID_MEDIA_RW
		   ){
			printf("addgroup --gid %u %s\n", 
					android_ids[i].aid, 
					android_ids[i].name);
		}

	}
}
