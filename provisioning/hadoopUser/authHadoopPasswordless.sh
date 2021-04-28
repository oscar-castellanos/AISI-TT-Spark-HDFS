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

if [ ! -f $USER_DIR/authorized_keys ]; then
    mkdir -p $USER_DIR
    touch $USER_DIR/authorized_keys
fi
sed -i "/master.local/d" $USER_DIR/authorized_keys >& /dev/null
cat /vagrant/id_rsa.hadoop.pub >> $USER_DIR/authorized_keys
chown -R hadoop:hadoop $USER_DIR
chmod 0600 $USER_DIR/authorized_keys >& /dev/null
chmod 0700 $USER_DIR >& /dev/null