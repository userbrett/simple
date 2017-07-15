#/bin/sh
#
# setup.sh
# Setup a minimal Intel EE Lustre VM environment.
#
# Copyright(C) 2016 Brett Lee <brett@brettlee.com>, All Rights Reserved
# ##

echo
echo Setting up the EE VMs...
echo

if [ ! -e /intel.lustre ]; then
  echo Creating link:  ln -s $(pwd) /intel.lustre
  ln -v -s $(pwd) /intel.lustre || exit 1
fi


echo Changing directory to /intel.lustre...
echo

cd /intel.lustre || exit 2


echo Creating the storage targets...
echo
fallocate -l 100M /intel.lustre/ee.target.mgt.dsk || exit 3
fallocate -l 5G /intel.lustre/ee.target.mdt0.dsk || exit 3
fallocate -l 5G /intel.lustre/ee.target.mdt1.dsk || exit 3
fallocate -l 5G /intel.lustre/ee.target.ost0.dsk || exit 3
fallocate -l 5G /intel.lustre/ee.target.ost1.dsk || exit 3
fallocate -l 5G /intel.lustre/ee.target.ost2.dsk || exit 3
fallocate -l 5G /intel.lustre/ee.target.ost3.dsk || exit 3


echo Creating the Lustre and HA networks...
echo

brctl addbr br_lustre || exit 4
brctl addbr br_mgs_mds || exit 4
brctl addbr br_oss1_oss2 || exit 4

ifconfig br_lustre up || exit 4
ifconfig br_mgs_mds up || exit 4
ifconfig br_oss1_oss2 up || exit 4


echo Creating the Virtual Machines...
echo

for node in iml mgs mds oss1 oss2 cli; do
  echo Creating VM: $node
  echo Copying the generic VM image...
  cp -v ee.img ee.$node.img || exit 5
  virsh define /intel.lustre/node.$node.xml || exit 5
done


echo Attaching Storage Targets to VMs...
echo

virsh attach-device --config ee-mgs target.mgt.xml || exit 6
virsh attach-device --config ee-mds target.mgt.xml || exit 6

virsh attach-device --config ee-mgs target.mdt0.xml || exit 6
virsh attach-device --config ee-mds target.mdt0.xml || exit 6

virsh attach-device --config ee-mgs target.mdt1.xml || exit 6
virsh attach-device --config ee-mds target.mdt1.xml || exit 6

virsh attach-device --config ee-oss1 target.ost0.xml || exit 6
virsh attach-device --config ee-oss2 target.ost0.xml || exit 6

virsh attach-device --config ee-oss1 target.ost1.xml || exit 6
virsh attach-device --config ee-oss2 target.ost1.xml || exit 6

virsh attach-device --config ee-oss1 target.ost2.xml || exit 6
virsh attach-device --config ee-oss2 target.ost2.xml || exit 6

virsh attach-device --config ee-oss1 target.ost3.xml || exit 6
virsh attach-device --config ee-oss2 target.ost3.xml || exit 6


echo Available VMs are...
echo

virsh list --all


echo Success
echo

exit
