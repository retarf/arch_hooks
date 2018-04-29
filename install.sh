#!/bin/bash

EFIARCH=/boot/efi/arch
UPDATES=/boot/updates
HOOKS=/etc/pacman.d/hooks
UPDATE_FILE=update.sh
DIRECTORIES=($UPDATES $HOOKS)


make_directories () {

    echo ":: Checking if /boot/efi/arch exist..."
    if [ -d  $EFIARCH ]; then
        echo ":: Found $EFIARCH"
    else
        echo ":: $EFIARCH doesn't exist"
        return 1
    fi;

    for DIR in ${DIRECTORIES[@]}
    do
        echo ":: Checking if $DIR exist..."
        if [ ! -d $DIR ]; then
            mkdir $DIR
            echo "mkdir $DIR"
            echo ":: $DIR created"
        else
            echo ":: $DIR exist"
        fi;
    done
    return 0

}

copy_update_files () {

    if [ -e $UPDATE_FILE ]; then
        cp $UPDATE_FILE /boot
        echo "cp $UPDATE_FILE /boot"
        echo ":: File $UPDATE_FILE was copied to /boot"
    else
        echo ":: File $UPDATE_FILE doesn't exist.";
        return 1
    fi;

    return 0
}

make_directories
copy_update_files
