#!/bin/sh

set -x

date > /etc/vagrant_box_build_time

# Customize the message of the day
echo 'Welcome to your Vagrant-built virtual machine.' > /var/run/motd

#######################################################################
# install guest additions
#######################################################################

yes | m-a prepare

# Install the VirtualBox guest additions
mount -o loop VBoxGuestAdditions.iso /mnt
yes|bash /mnt/VBoxLinuxAdditions.run
umount /mnt

# Start the newly build driver
service vboxadd start
usermod -a -G vboxsf vagrant

#######################################################################
# setup vagrant user
#######################################################################

# Install vagrant keys
mkdir -pm 700 /home/vagrant/.ssh
curl -Lo /home/vagrant/.ssh/authorized_keys \
  'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub'
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh

#######################################################################
# setup passwordless sudo for vagrant user
#######################################################################

cat > /etc/sudoers.d/vagrant <<EOF
vagrant ALL=(ALL) NOPASSWD:ALL
EOF
chmod 0440 /etc/sudoers.d/vagrant

#######################################################################
# install ansible
#######################################################################

curl -s https://bootstrap.pypa.io/get-pip.py | python2.7

pip install ansible virtualenv

#######################################################################
# speed up tweaks
#######################################################################

# Prevent DNS resolution (speed up logins)
echo 'UseDNS no' >> /etc/ssh/sshd_config

# Disable password logins
echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config

# Reduce grub timeout to 1s to speed up booting
# but only if we are not in a chroot
[ -f /etc/default/grub ] && \
  mountpoint -q /dev/ && \
  sed -i s/GRUB_TIMEOUT=5/GRUB_TIMEOUT=1/ /etc/default/grub

[ -x /usr/sbin/update-grub ] && \
  mountpoint -q /dev/ && \
  /usr/sbin/update-grub

# Removing leftover leases and persistent rules
rm /var/lib/dhcp/*

echo "pre-up sleep 2" >> /etc/network/interfaces

#######################################################################
# cleanup
#######################################################################

rm -f VBoxGuestAdditions.iso

apt-get remove --purge build-essential module-assistant python2.7-dev libssl-dev libffi-dev
apt-get --yes autoremove
apt-get remove --purge --yes `deborphan --guess-all`

apt-get clean

rm -f /usr/sbin/policy-rc.d
