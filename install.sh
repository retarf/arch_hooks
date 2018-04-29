#!/bin/bash

EFIARCH=/boot/efi/arch
UPDATES=/boot/updates
HOOKS_DIR=/etc/pacman.d/hooks
USH=update.sh
ULSH=update_linux.sh
ULLSH=update_linux_lts.sh
UPDATE_FILES=($USH $ULSH $ULLSH)
ULH=update_linux.hook
ULLH=update_linux_lts.hook
HOOKS=($ULH $ULLH)
DIRECTORIES=($UPDATES $HOOKS_DIR)


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
            echo ":: $DIR created"
        else
            echo ":: $DIR exist"
        fi;
    done
    return 0

}

copy_update_files () {

    for FILE in ${UPDATE_FILES[@]}
    do
        if [ -e $FILE ]; then
            cp $FILE $UPDATES
            chmod 744 "$UPDATES/$FILE"
            echo ":: File $FILE was copied to $UPDATES"
        else
            echo ":: File $FILE doesn't exist.";
            return 1
        fi;
    done

    for i in ${HOOKS[@]}
    do
        cp $i $HOOKS_DIR
        echo ":: File $i was copied to $HOOKS_DIR"
    done


    return 0
}

if [ "$(id -u)" != "0" ]; then
    echo ":: You have to be root"
else
    make_directories 
    copy_update_files
fi
