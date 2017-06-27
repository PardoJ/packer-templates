# -*- mode: ruby -*-
# vi: set ft=ruby :
#

Vagrant.configure(2) do |config|

  config.vm.define "stretch" do |debian|

    debian.vm.box = "debian-stretch"

    debian.vm.provider "virtualbox" do |vb|
      vb.name = "stretch"
      vb.cpus = 1
      vb.memory = "1024"
      vb.gui = false
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--ioapic", "on"]
    end
  end
end
