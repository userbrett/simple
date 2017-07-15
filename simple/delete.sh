#/bin/sh
#
# delete.sh
# Delete the minimal Lustre VM environment.
#
# sIMpLe
# Copyright(C) 2016 Brett Lee <brett@brettlee.com>, All Rights Reserved
# ##

echo
echo =================================================================
ls -l ee.*.img ee.*.dsk 2>/dev/null
echo =================================================================
echo
echo !!! Sleeping for 10 seconds, and then DELETING these files...
echo
echo "Press CTRL-C to exit"
sleep 10

rm -fv ee.*.img ee.*.dsk

echo
echo Removing bridges...
ifconfig br_lustre down
ifconfig br_mgs_mds down
ifconfig br_oss1_oss2 down
brctl delbr br_lustre
brctl delbr br_mgs_mds
brctl delbr br_oss1_oss2

exit
