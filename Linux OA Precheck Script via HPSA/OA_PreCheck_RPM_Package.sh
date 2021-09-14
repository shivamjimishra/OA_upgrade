#! /bin/sh
#############################
#To Check the RPM packages ##
#############################
#author:sonu.jain-v@microfocus.com

if [ $(rpm -qa|grep -c libstdc++33-32bit-3.3.3-7.8.1.x86_64.rpm) -gt 0 ]; then
    echo "present :libstdc++33-32bit-3.3.3-7.8.1.x86_64.rpm"
else
    echo none
    echo "not present :libstdc++33-32bit-3.3.3-7.8.1.x86_64.rpm"
    echo "trying to install!!!......."
    #rpm -ivh libstdc++33-32bit-3.3.3-7.8.1.x86_64.rpm
    #yum -y install libstdc++33-32bit-3.3.3-7.8.1.x86_64.rpm

fi

if [ $(rpm -qa|grep -c libstdc++.so.5.rpm) -gt 0 ]; then
    echo "present:libstdc++.so.5.rpm"
else
    echo none
    echo "not present :libstdc++.so.5"
    echo "trying to install!!!......."
    #rpm -ivh libstdc++.so.5.rpm
    #yum -y install libstdc++.so.5.rpm
   

fi

if [ $(rpm -qa|grep -c libncurses.so.5.rpm) -gt 0 ]; then
    echo "present:libncurses.so.5"
else
    echo none
    echo "not present :libncurses.so.5"
    echo "trying to install!!!......."
    #rpm -ivh libncurses.so.5.rpm
    #yum -y install libncurses.so.5.rpm
fi