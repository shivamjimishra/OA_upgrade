#! /bin/sh
#author:sonu.jain-v@microfocus.com
##Check libncurses.so.5 present or not
which m4
#command1=`m4 --version`
#echo "m4 version is $command1";
if [ $(echo $?) -ne 0 ];
    then
    echo "ERROR: No file m4 utility."
    echo "ERROR: File Check failed for m4 utility."
    exit 3
else 
   echo "file present." 
   exit 0   
fi