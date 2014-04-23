#!/bin/sh

# some quick code to make a bootable CDROM

if [ ! -f ../kernel/kernel.bin ] ; then 
	echo "You need to build the kernel in the kernel directory !"
	exit
fi

if [ ! -f grub.cfg ] ; then 
	echo "You need grub.cfg in this directory (see for example /etc/grub.cfg) !"
	exit
fi

if ! which grub-mkrescue >/dev/null; then 
	echo "You need grub-mkrescue installed !"
	exit
fi

mkdir -p isodir
mkdir -p isodir/boot
cp ../kernel/kernel.bin isodir/boot/kernel.bin
mkdir -p isodir/boot/grub
cp grub.cfg isodir/boot/grub/grub.cfg
grub-mkrescue -o ados.iso isodir
