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
      vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    end
  end
  
    #  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

    #config.vm.provision "preparation_vm", type: "shell" do |s|
    #    s.privileged = true
    #    s.path = "./provision/01_prepare_vm.sh"
   # end

    #config.vm.provision "prepare_user", type: "shell" do |s|
     #   s.privileged = false
     #   s.path = "./provision/02_prepare_user.sh"
    #end

    # config.vm.synced_folder "PATH", "/media/ansible"
  
end
