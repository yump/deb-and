#!/bin/bash

# nasty hack to handle running as the argument to chroot
. /etc/profile

for i in /etc/rc5.d/S*; 
do 
	"$i" "$1"
done

exit 0

