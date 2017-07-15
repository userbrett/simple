README.create.vm.txt

sIMpLe
Copyright(C) 2016 Brett Lee <brett@brettlee.com>, All Rights Reserved


======================================================================
CREATING THE TEMPLATE VM
======================================================================

Creating the template VM:

1. Perform a "minimal" OS installation.
   a. Using the KVM GUI, create new machine
      Name it "ee", and use local media.
   b. Select the ISO (e.g. 6.5-x86_64-minimal) and OS type/version.
   c. Minimal RAM/CPU, 1024/1.
   d. Enable storage - Select managed storage, ee.img.
      Create image with: dd if=/dev/zero of=ee.img bs=100M count=25
   e. Advanced options - MAC 52:54:00:00:00:00
   f. Install process - take basic video driver
      Keep clicking Next, make no changes.. Yes, discard any data.
   g. Type of installation?  Create custom layout:
        Create standard partition on all free space.
        Mount point = /
        Fill to maximal allowable size
        Force to be a primary partition
   h. Select Basic Server, and complete the installation.

2. Reboot the new VM, stopping the boot process before it boots
                      ^^^^^^^^^^^^^^^^^^^^^^^^^
   a. Edit the kernel entry, replacing "rhgb" and "quiet"
      with "edd=off selinux=0 single"
      Then, boot it to single user mode.
   b. Disable postfix - admin's can configure outgoing email:
      chkconfig postfix off
   c. vi /etc/udev/rules.d/70-persistent-net.rules
      Delete all lines after the header.
   d. vi /etc/sysconfig/network-scripts/ifcfg-eth0
      Delete the HWADDR line.
      Delete the UUID line (results in no UUID after boot).
      Change ONBOOT to "yes".
      Change NM_CONTROLLED to "no".
   e. vi /boot/grub/grub.conf
      Add to the header, after "default=0":
        serial --unit=0 --speed=115200
        terminal --timeout=5 serial console
      On the kernel entry, replace:
        "rhgb" and "quiet" with "edd=off selinux=0 text console=ttyS0,115200"
   f. Disable selinux and iptables
      vi /etc/selinux/config && s/enforcing/disabled/
      chkconfig iptables off
      chkconfig ip6tables off
   g. Shutdown the node
      shutdown -h now

3. Compress the image, saving the original
   bzip2 -k -v ee.img

