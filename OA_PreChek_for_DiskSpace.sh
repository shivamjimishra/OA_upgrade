#! /bin/sh
###########################################
##To Check the space for given directory###
###########################################
#author:sonu.jain-v@microfocus.com
Dir4='/opt/OV/bin/'
Dir5='/var/opt/OV/'
echo $Dir4
# check if the available space is smaller than 100MB (100000kB)
# get the available space left on the device
size=$(df -k $Dir4 | tail -1 | awk '{print $4}')
echo "size is :$size" Kb
if [ $size -gt 100000 ];
then
  echo "space is avilable in given directory $Dir4"
else
  echo "No Enough space in $Dir4"
  exit 7
fi

# check if the available space is greater than 350MB (350000kB)
# get the available space left on the device
echo $Dir5
size1=$(df -k $Dir5 | tail -1 | awk '{print $4}')
echo "size1 is :$size1" Kb
if [ $size1 -gt 350000 ];
then
  echo "space is avilable in given directory $Dir5"
else
  echo "No Enough space in $Dir5"
  exit 7
fi