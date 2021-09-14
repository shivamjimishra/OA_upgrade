#! /bin/sh

###############################################################################
## FILENAME:    oaupgrade.sh
## VERSION:     01.00.0000
## DESCRIPTION: Top level upgrade script for OA Agent
##              installation on UNIX platforms
##              Script can be used for
##
##             Upgradation of OA Agent One package on a node
##
## LANGUAGE:    sh
##
# Copyright 1988 - 2020 Micro Focus or one of its affiliates.
###############################################################################

OA_INSTALL_SCRIPT_DIR='/tmp/oainstall/oainstall_12'
OA_INSTALL_SCRIPT_NAME='oainstall.sh'
chmod -R 755 '/tmp/oainstall/oainstall_12'
# Standard error codes
#OA_ERROR_PREREQUISITE_CHECK_FAILURE=1
OA_UPGRADE_VALUE="Started the HP Operations agent product successfully"
# Export the standard error codes
export OA_ERROR_PREREQUISITE_CHECK_FAILURE

#####################################################
#                        MAIN                       #
#####################################################

# Call the platform specific script that will execute for us
DATE1="`date +%m`_`date +%d`_`date +%y`"
#osExecScript=`${OA_INSTALL_SCRIPT_DIR}/oainstall.sh -i -a` >> /tmp/OAUpgradelog_$DATE1.txt
osExecScript=`${OA_INSTALL_SCRIPT_DIR}/oainstall.sh -i -a -minprecheck` >> /tmp/OAUpgradelog_$DATE1.txt
echo "OA Upgrade installation is in process........."
sleep 60
command7=`tail -q /var/opt/OV/log/oainstall.log | grep -i -E "Started the HP Operations agent product successfully"`
if [[  "$command7"  ==  *"$OA_UPGRADE_VALUE"*  ]];then

    echo "OA agent upgrade is sucessfull!!!"
else

  echo "OA agent upgrade is Un-sucessfull!!! kindly check the logs"
  echo "Log location '/var/opt/OV/log/oainstall.log'"
  exit 7
fi

if [ $(echo $?) != 0 ];then

       echo "ERROR:  OA Upgrade agent is failed"
else
       echo "SUCCESS:  OA Upgrade agent is Success"
fi	




##################################
# To Check the version of the OA #
##################################
#Omi_server = ""
echo "Post installtion Validation is in process......"
currentver=`/opt/OV/bin/opcagt -version`
echo "$currentver" >> /tmp/OAUpgradelog_$DATE1.txt
requiredver="12.0.0"
 if [ ${currentver%%.*} -ge ${requiredver%%.*} ]; then

		echo "OA Agent is Greater than or equal to 12"
		/opt/OV/bin/ovconfchg -ns sec.core.ssl -clear COMM_PROTOCOL
		command20=`/opt/OV/bin/ovconfget | grep COMM_PROTOCOL |wc -l`
		echo "COMM_PROTOCOL :$command20" >> /tmp/OAUpgradelog_$DATE1.txt
		/opt/OV/bin/opcmsg a=a o=o msg_t="MFIT 12.12 OA Upgrade passed Test Message" s=normal
 else
        echo "Less than 11...Agent installtion is failed "
		/opt/OV/bin/opcmsg a=a o=o msg_t="MFIT FAILED OA upgrade  Test Message" s=normal
        exit 3
 fi

