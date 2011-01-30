#!/usr/bin/env bash
PATH=/usr/bin:/bin

# run this script from the directory the script is in
TOOLDIR=$(pwd)

[ -x $TOOLDIR/create_firmware.sh ] || {
	echo "Run this script from the directory this script is in"
	exit 1
}

# bail on errors
set -e 

TMPROOT=$(mktemp -d)

cleanup() {
	[ -d $TMPROOT ] && rm -rf $TMPROOT
}

trap cleanup exit


# locations of system dir, data dir, and root dir
SYSDIR=/spare/nfsroots/firmware/flytouch2/system
DATADIR=/spare/nfsroots/firmware/flytouch2/data
ROOTDIR=$HOME/src/mydroid/out/target/product/flytouch2/root

# delete calibration file if it exists
calfile=${DATADIR}/data/touchscreen.test/files/pointercal
sudo test -f $calfile && sudo rm $calfile

# uncomment partition mount commands in init.rc (by default, testing goes over nfs
# which doesn't need the mounts)
# make backup of rootdir in /tmp

tar -C $ROOTDIR -cf - .| tar -C $TMPROOT -xpf -
sed -i -e 's/#mount/mount/' ${TMPROOT}/init.rc 

echo -n "Creating ramdisk.img ... "
# create ramdisk
cd $TMPROOT
{
cat $TOOLDIR/ramdisk_uheader
find . | cpio --create  | gzip 
} > $TOOLDIR/ramdisk.img

echo "OK"

echo -n "Creating recovery_rd.img ... "
cp -r $TOOLDIR/recovery/* $TMPROOT/
cp $SYSDIR/build.prop $TMPROOT/default.prop
mkdir $TMPROOT/tmp
mkdir $TMPROOT/etc
#du -a $TMPROOT/
#cat $TMPROOT/init.rc

# create recovery image
cd $TMPROOT
{
cat $TOOLDIR/ramdisk_uheader
find . | cpio --create  | gzip 
} > $TOOLDIR/recovery_rd.img

echo -n "Creating system.img ... "
# create system.img. XXX: Currently assumes an already setup system dir as explained in
# install.txt, not the system dir freshly built by the system. Will fix Real Soon Now.
# create mkyaffs2image for your OS if the one in this dir doesn't work.
# See: http://sites.google.com/site/naobsd/android-tablet/hsg-x5a
$TOOLDIR/mkyaffs2image $SYSDIR $TOOLDIR/system.img
echo "OK"
