#!/system/xbin/ash

mountpoint="/data/debian/debian"

if ! [ "$(whoami)" = "root" ]; then
	echo "Sorry, must be run as root"
	exit 1
fi

echo "nameserver $(getprop net.dns1)" > "${mountpoint}/etc/resolv.conf"
echo "nameserver $(getprop net.dns2)" >> "${mountpoint}/etc/resolv.conf"
