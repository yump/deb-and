/* This here be under the GPL version 3 */

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
