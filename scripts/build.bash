#!/bin/bash

arch="armhf"
release="wheezy"

if ! [ -d debian.mnt ]; then
	mkdir debian.mnt 
fi

if [ -f debian.img ]; then
	read -p "debian.img already exists.  Rebuild? (y/N)"
	if [ "$REPLY" = "y" -o "$REPLY" = "Y" ]; then
		echo "deleting old image..."
		rm debian.img
	else
		exit 1;
	fi
fi

echo "creating image file..."
dd if=/dev/zero bs=1 count=0 seek=2G of=debian.img || exit 2

echo "making file system..."
sudo mkfs.ext4 debian.img || exit 3

echo "mounting..."
sudo mount -o noatime ./debian.img ./debian.mnt || exit 4

echo "debootstrapping..."
sudo debootstrap \
	--arch="$arch" \
	--foreign \
	--variant=minbase \
	--verbose \
	"$release" \
	./debian.mnt \
	http://ftp.us.debian.org/debian \
	|| exit 5

echo "generating add_gids.sh"
./gid_unfucker/gid_unfucker | sudo dd of=./debian.mnt/root/add_gids.sh || exit 6

echo "copying in chroot-control.bash"
sudo cp scripts/chroot-control.bash ./debian.mnt/usr/local/bin || exit 7

echo "symlinking /etc/mtab"
sudo ln -s /proc/mounts ./debian.mnt/etc/mtab || exit 8

echo "unmounting..."
sudo umount ./debian.img || exit 9

echo "done"
