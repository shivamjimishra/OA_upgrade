#!/bin/sh

###############################################################################
## VERSION:     1.00.0000
## DESCRIPTION: To check the post upgrade check
##
## LANGUAGE:    sh
##
# Copyright 1988 - 2020 Micro Focus or one of its affiliates.
###############################################################################


##################################
# To Check the version of the OA #
##################################
Omi_server="m4t0166g.houston.softwaregrp.net"
DATE1="`date +%m`_`date +%d`_`date +%y`"
currentver=`/opt/OV/bin/opcagt -version`
echo "OA Version:$currentver"
echo "CurrentOAversion : $currentver" >> /tmp/OA_Upgrade_postchecklog_$DATE1.txt

 ###################################
 #  To Check the Status of the OA  #
 ###################################
command1=`/opt/OV/bin/ovc -status | awk '{print $NF}' | sed '/^$/d' | grep -vi "Running" | wc -l`
echo "OAstatus  : $command1" >> /tmp/OA_Upgrade_postchecklog_$DATE1.txt
/opt/OV/bin/ovc -status >> /tmp/OA_Upgrade_postchecklog_$DATE1.txt
if [ "$command1" -gt 0 ]
then
  echo "Agent Status is not Working Fine\n\n"
  echo "process kill...started"
   `/opt/OV/bin/ovc -kill`
    sleep 20
  `/opt/OV/bin/ovc -start`

else
echo "Agent Status Working Fine\n\n"
fi

#######################################
#       To Check opcagt Status        #
#######################################
/opt/OV/bin/opcagt -status >> /tmp/OA_Upgrade_postchecklog_$DATE1.txt
if `/opt/OV/bin/opcagt -status | grep -q 'Message Agent is not buffering'`; then
  echo "Agent is  not buffering"

else
  echo "Agent is buffering " 
  echo "cleanstart agent initaited"
  /opt/OV/bin/opcagt -cleanstart
fi

if `/opt/OV/bin/opcagt -status | grep -q 'Message Agent is not buffering'`; then
  echo "Agent is  not buffering"

else
  echo "Agent is buffering"
  
fi

/opt/OV/bin/opcagt -status >> /tmp/OA_Upgrade_postchecklog_$DATE1.txt
###################################################
#  To check the communcation with OMI server      #
###################################################

command10=`/opt/OV/bin/bbcutil -ping  $Omi_server | grep "status=eServiceOK" | wc -l`
echo "omiCommunication : $command10" >> /tmp/OA_Upgrade_postchecklog_$DATE1.txt
/opt/OV/bin/bbcutil -ping m4t0166g.houston.softwaregrp.net >> /tmp/OA_Upgrade_postchecklog_$DATE1.txt
#echo "command10" : $command4 \n"
if [ "$command10" -ge 1 ]
then
	echo "Communication is Working Fine\n\n"
else
	echo "Communication is not Working Fine\n\n"
fi
############################################
# Script for Certification                 #
############################################
command13=`/opt/OV/bin/ovcert -list | grep "CA_*" | wc -l`
echo "CertificateList : $command13" >> /tmp/OA_Upgrade_postchecklog_$DATE1.txt
/opt/OV/bin/ovcert -list >> /tmp/OA_Upgrade_postchecklog_$DATE1.txt
#echo "command13 : $command13 \n"
if [ "$command13" -ge 1 ]
then
echo "Certificate is OK\n\n"

#echo "post-check  Completed"
else
echo "Certificate is not OK\n\n"

fi

############################################
# Script for Certification-Check           #
############################################

command1=`/opt/OV/bin/ovcert -check | awk '{print $NF}' | sed '/^$/d' | grep -vi "OK" | wc -l`
echo "CertificationCheck : $command1" >> /tmp/OA_Upgrade_postchecklog_$DATE1.txt
/opt/OV/bin/ovcert -check >> /tmp/OA_Upgrade_postchecklog_$DATE1.txt
#echo "command1 : $command1 \n"
if [ "$command1" -gt 0 ]
then
  echo "Certificate check is successful \n\n"
else
echo "Certificate check Not successful \n\n"

fi
#################################################
# To check the Policy                           #
#################################################
command16=`/opt/OV/bin/ovpolicy -list`
echo "policylist : $command16" >> /tmp/OA_Upgrade_postchecklog_$DATE1.txt

echo "post-check is completed"
exit 0