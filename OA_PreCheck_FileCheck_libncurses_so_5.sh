#! /bin/sh
#author:sonu.jain-v@microfocus.com
##Check libncurses.so.5 present or not
ldconfig -p | grep libncurses
if [ $(echo $?) -ne 0 ];
    then
    echo "ERROR: No file libncurses.so.5."
    echo "ERROR: File Check failed for libncurses.so.5."
    exit 2
else 
   echo "file present." 
	exit 0   
fi