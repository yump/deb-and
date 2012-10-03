#!/system/xbin/ash

mountpoint="/data/debian/debian"
image="/data/debian/debian.img"

## start the debian chroot -- must be root

if ! [ "$(whoami)" = "root" ]; then
	echo "Sorry, must be run as root"
	exit 1
fi

if ! [ -d "$mountpoint" ]; then
	echo "creating $mountpoint"
	mkdir "$mountpoint" || exit 2
fi

if ! mountpoint -q "$mountpoint"; then
	echo "loop mounting $image on $mountpoint"
	mount -t ext4 -o loop,noatime "$image" "$mountpoint" || exit 3
fi

if ! mountpoint -q "${mountpoint}/proc"; then
	echo "mounting /proc"
	mount -t proc proc "${mountpoint}/proc" || exit 4
fi

if ! mountpoint -q "${mountpoint}/sys"; then
	echo "mounting /sys"
	busybox mount --rbind /sys "${mountpoint}/sys" || exit 5
fi

if ! mountpoint -q "${mountpoint}/dev"; then
	echo "mounting /dev"
	busybox mount --rbind /dev "${mountpoint}/dev" || exit 6
fi

if ! mountpoint -q "${mountpoint}/mnt/sdcard"; then
	echo "mounting sdcard"
	busybox mount --rbind /sdcard "${mountpoint}/mnt/sdcard" || exit 7
fi


if [ "$1" = "enter" ]; then
	echo "chrooting in"
	HOME="/root" chroot "$mountpoint" /bin/bash -l
elif [ "$1" = "start" ]; then
	echo "starting chroot services"
	chroot "$mountpoint" /usr/local/bin/chroot-control.bash start
elif [ "$1" = "stop" ]; then                                             
        echo "stopping chroot services"                                   
        chroot "$mountpoint" /usr/local/bin/chroot-control.bash stop
elif [ "$1" = "restart" ]; then                                             
        echo "restarting chroot services"                                   
        chroot "$mountpoint" /usr/local/bin/chroot-control.bash restart
fi

