#!/bin/bash

FILE=$1
TPATH=/boot/efi/arch

if [ -e $TPATH/$FILE ]; then 
    rm $TPATH/$FILE
fi
cp /boot/$FILE  /boot/efi/arch/

echo ":: efi/arch $FILE update completed"
