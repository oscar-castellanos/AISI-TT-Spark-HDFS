##PARA TODOS

# Copy ssh public key from vagrant
USER_DIR=/home/vagrant/.ssh

if [ ! -f /vagrant/id_rsa.pub ]; then
	echo "SSH public key does not exist"
	exit -1
fi

sed -i "/master.local/d" .ssh/authorized_keys >& /dev/null
cat /vagrant/id_rsa.pub >> $USER_DIR/authorized_keys
chown vagrant:vagrant $USER_DIR/authorized_keys
chmod 0600 $USER_DIR/authorized_keys >& /dev/null

# Copy ssh public key from HADOOP
USER_DIR=/home/hadoop/.ssh

if [ ! -f /vagrant/id_rsa.hadoop.pub ]; then
	echo "SSH public key does not exist"
	exit -1
fi

sed -i "/master.local/d" .ssh/authorized_keys >& /dev/null
cat /vagrant/id_rsa.hadoop.pub >> $USER_DIR/authorized_keys
chown hadoop:hadoop $USER_DIR/authorized_keys
chmod 0600 $USER_DIR/authorized_keys >& /dev/null