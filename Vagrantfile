# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "generic/centos7"
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"

  config.vm.provider "virtualbox" do |vb|
	vb.memory = "1024"

  # Configure hostmanager plugin
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.manage_guest = true
  config.hostmanager.ignore_private_ip = false
  
  # Master Node
  config.vm.define "master-node", primary: true do |master-node|
    master-node.vm.host_name = 'master-node.local'
    master-node.vm.network :private_network, ip: "192.168.100.100"
	  master-node.vm.network "forwarded_port", guest: 8080, host: 8080	#head
    master-node.vm.network "forwarded_port", guest: 50070, host: 50070	#head
	  master-node.vm.network "forwarded_port", guest: 8088, host: 18088	#body
    master-node.vm.network "forwarded_port", guest: 19888, host: 19888	#body
    master-node.vm.provision "shell", path: ""
  end
  
  # Worker 1
  config.vm.define "worker1" do |worker1|
    worker1.vm.host_name = 'worker1.local'
    worker1.vm.network :private_network, ip: "192.168.100.101"
    worker1.vm.provision "shell", path: ""
  end
  
  # Worker 2
  config.vm.define "worker2" do |worker2|
    worker2.vm.host_name = 'worker2.local'
    worker2.vm.network :private_network, ip: "192.168.100.102"
    worker2.vm.provision "shell", path: ""
  end
  
end
