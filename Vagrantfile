# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.hostname = "dev-test.ru"
  config.vm.box = "ubuntu/bionic64"

  config.vm.network "forwarded_port", guest: 80, host: 8083
  config.vm.network "forwarded_port", guest: 90, host: 9090
  config.vm.network "forwarded_port", guest: 27017, host: 28017
  config.vm.network "private_network", ip: "192.168.10.10"

  config.vm.synced_folder ".", "/home/testCar/projects"

 # config.ssh.private_key_path = "~/.ssh/id_rsa"
#  config.ssh.forward_agent = true

# config.ssh.private_key_path = "~/.ssh/id_rsa"

  config.vm.provider "virtualbox" do |vb|
        vb.gui = false
        vb.memory = 4056
  end
end
