#/bin/sh
#
# destroy.sh
# Destroy the Lustre VM environment.
#
# Copyright(C) 2016 Brett Lee <brett@brettlee.com>, All Rights Reserved
# ##

#for node in iml mgs mds oss1 oss2 cli; do
for node in iml mgs mds oss1 oss2; do
  echo Sleeping for 5 seconds, and then UNDEFINING VM ${node}...
  echo "CTRL-C to exit"
  sleep 5
  virsh destroy ee-$node
  sleep 2
  virsh undefine ee-$node || exit 1
done

echo
echo VMs:
virsh list --all

exit
