#/bin/sh
#
# stop.sh
# Stop the minimal Lustre VM environment.
#
# Copyright(C) 2016 Brett Lee <brett@brettlee.com>, All Rights Reserved
# ##

#for node in iml mgs mds oss1 oss2 cli; do
for node in iml mgs mds oss1 oss2; do
  echo Stopping VM ${node}
  ssh ee-$node "shutdown -h now" || exit 1
done

echo
echo Sleeping for 10 sec...

echo
echo Running VMs:
virsh list

exit
