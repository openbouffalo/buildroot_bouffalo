#!/bin/sh

# SPDX-License-Identifier: GPL-2.0-only
#
# init.sh - set up R/W overlay rootfs
#
# Author: Chien Wong <qwang@bouffalolab.com>
#
# Copyright (C) Bouffalo Lab 2016-2023
#

mount -t jffs2 /dev/mtdblock6 /overlay
mkdir /overlay/upper /overlay/work 2>/dev/null
mount -t overlay -o lowerdir=/,upperdir=/overlay/upper,workdir=/overlay/work overlay /mnt
mkdir /mnt/old_root 2>/dev/null
pivot_root /mnt /mnt/old_root

exec /sbin/init
