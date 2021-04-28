# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "aff-ocr-aisi2021/centos7"
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"

  config.vm.provider "virtualbox" do |vb|
	vb.memory = "1024"
  end
  
  # Configure hostmanager plugin
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.manage_guest = true
  config.hostmanager.ignore_private_ip = false
  
  # Master Node
  config.vm.define "master", primary: true do |master|
    master.vm.host_name = 'master.local'
    master.vm.network :private_network, ip: "192.168.100.100"
    master.vm.network "forwarded_port", guest: 8080, host: 8080	#head
    master.vm.network "forwarded_port", guest: 50070, host: 50070	#head
    master.vm.network "forwarded_port", guest: 8088, host: 18088	#body
    master.vm.network "forwarded_port", guest: 19888, host: 19888	#body
    master.vm.provision "shell", path: "provisioning/hadoopUser/master.sh"
    master.vm.provision "shell", path: "provisioning/hadoopUser/authHadoopPasswordless.sh"
    master.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "provisioning/ansible/playbook.yml"
      ansible.limit = "all"
      ansible.inventory_path = "ansible.inventory"
      #ansible.install_mode = "pip3"
    end
  end
  
  # Worker 1
  config.vm.define "worker1" do |worker1|
    worker1.vm.host_name = 'worker1.local'
    worker1.vm.network :private_network, ip: "192.168.100.101"
    worker1.vm.provision "shell", path: "provisioning/hadoopUser/authHadoopPasswordless.sh"
  end
  
  # Worker 2
  config.vm.define "worker2" do |worker2|
    worker2.vm.host_name = 'worker2.local'
    worker2.vm.network :private_network, ip: "192.168.100.102"
	  worker2.vm.provision "shell", path: "provisioning/hadoopUser/authHadoopPasswordless.sh"
  end
  
end
