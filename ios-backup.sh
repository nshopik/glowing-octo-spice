#!/bin/bash

#Cisco IOS enable SNMP write only to specific table
#
#snmp-server view CISCO-CONFIG-COPY ciscoConfigCopyMIB included
#snmp-server community Private view CISCO-CONFIG-COPY RW


community=Private
IP=192.0.2.1
ServerIP=192.0.2.69
FileName=$IP-`date +%F`.conf
Protocol=1 # tftp(1),ftp(2),rcp(3),scp(4),sftp(5)
CopySourceFileType=4 # networkFile(1),iosFile(2),startupConfig(3),runningConfig(4),terminal(5)
CopyDestFileType=1
CopyEntryRowStatus=4 # active (1),createAndGo(4),createAndWait(5),destroy(6)
ID=$RANDOM

snmpset -v2c -OQv -c $community $IP .1.3.6.1.4.1.9.9.96.1.1.1.1.2.$ID i $Protocol \
.1.3.6.1.4.1.9.9.96.1.1.1.1.3.$ID i $CopySourceFileType \
.1.3.6.1.4.1.9.9.96.1.1.1.1.4.$ID i $CopyDestFileType \
.1.3.6.1.4.1.9.9.96.1.1.1.1.5.$ID a "$ServerIP" \
.1.3.6.1.4.1.9.9.96.1.1.1.1.6.$ID s "$FileName" \
.1.3.6.1.4.1.9.9.96.1.1.1.1.14.$ID i $CopyEntryRowStatus

CopyState=2
while [ $CopyState = "2" ]
do
    CopyState="$(snmpwalk -OQv -v2c -c $community $IP .1.3.6.1.4.1.9.9.96.1.1.1.1.10.$ID)"
    sleep 1
done

case $CopyState in
    1) echo Wating;;
    2) echo Running;;
    3) echo Successful;;
    4) echo Failed;;
    *) echo Unknown error code;;
esac
