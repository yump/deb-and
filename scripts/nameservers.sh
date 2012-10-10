#!/system/xbin/ash

# Copyright 2012 Russell Haley

# This file is part of Deb-And.
#
# Deb-And is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Deb-And is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Deb-And.  If not, see <http://www.gnu.org/licenses/>.

mountpoint="/data/debian/debian"

if ! [ "$(whoami)" = "root" ]; then
	echo "Sorry, must be run as root"
	exit 1
fi

echo "nameserver $(getprop net.dns1)" > "${mountpoint}/etc/resolv.conf"
echo "nameserver $(getprop net.dns2)" >> "${mountpoint}/etc/resolv.conf"
