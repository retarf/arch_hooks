#!/bin/bash

EFIARCH=/boot/efi/arch
UPDATES=/boot/updates
UILF=update_initramfs_linux_fallback
UIL=update_initramfs_linux
UVL=update_vmlinuz_linux 


echo ":: Checking if /boot/efi/arch exist..."
if [ -d  $EFIARCH ]; then
    echo ":: Found $EFIARCH"
else
    echo ":: $EFIARCH doesn't exist"
    exit
fi;

if [ ! -d /boot/updates ]; then
    # mkdir /boot/updates;
    
    ### update_initramfs_linux_fallback ###
    if [ -e update_initramfs_linux_fallback.sh ]; then
        # cp update_initramfs_linux_fallback.sh /boot/efi/arch/
        echo ":: File update_initramfs-linux-fallback.sh was copied to /boot/updates"
    else
        echo ":: File update_initramfs_linux_fallback.sh doesn't exist.";
        exit;
    fi;

    ### update_initramfs_linux ###
    if [ -e update_initramfs_linux.sh ]; then
        # cp update_initramfs_linux.sh /boot/efi/arch/
        echo ":: File update_initramfs_linux.sh was copied to /boot/updates"
    else
        echo ":: File update_initramfs_linux.sh doesn't exist.";
        exit;
    fi;

    ### update_vmlinuz_linux ###
    if [ -e update_vmlinuz_linux.sh ]; then
        # cp update_vmlinuz_linux.sh /boot/efi/arch/
        echo ":: File update_vmlinuz_linux.sh was copied to /boot/updates"
    else
        echo ":: File update_vmlinuz_linux.sh doesn't exist.";
        exit;
    fi;

fi;
