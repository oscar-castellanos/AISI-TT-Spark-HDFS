#!/bin/bash

# Install ansible and other stuff
yum -y install epel-release python-setuptools wget curl sshpass vim nano ansible
mkdir -p /etc/ansible
cp /vagrant/ansible.cfg /etc/ansible
cp /vagrant/ansible.inventory /etc/ansible/hosts

# Create ssh keys for vagrant user
USER_DIR=/home/vagrant/.ssh

if [ ! -f /vagrant/id_rsa.pub ]; then
	echo -e 'y\n' | sudo -u vagrant ssh-keygen -t rsa -f $USER_DIR/id_rsa -q -N ''
	chown vagrant:vagrant $USER_DIR/id_rsa*
	cp $USER_DIR/id_rsa.pub /vagrant    
fi

# Create hadoop user and group
sudo useradd -m -d /home/hadoop hadoop
echo -e ".h4d00p.\n.h4d00p.\n" | sudo passwd hadoop

# Create hadoop ssh keys
HADOOP_DIR=/home/hadoop/.ssh

if [ ! -f /vagrant/id_rsa.hadoop.pub ]; then
	echo -e 'y\n' | sudo -u hadoop ssh-keygen -t rsa -f $HADOOP_DIR/id_rsa -q -N ''
	chown hadoop:hadoop $HADOOP_DIR/id_rsa*
	cp $HADOOP_DIR/id_rsa.pub /vagrant/id_rsa.hadoop.pub   
fi
