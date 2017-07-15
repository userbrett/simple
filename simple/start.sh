#/bin/sh
#
# start.sh
# Start the minimal Lustre VM environment.
#
# Copyright(C) 2016 Brett Lee <brett@brettlee.com>, All Rights Reserved
# ##

#for node in iml mgs mds oss1 oss2 cli; do
for node in iml mgs mds oss1 oss2; do
  echo Starting VM ${node}, then sleeping for 20 seconds
  virsh start ee-$node || exit 1
  sleep 20
done

echo
echo Running VMs:
virsh list

echo
echo Please follow the instructions in AC.README.poststart
echo

exit
