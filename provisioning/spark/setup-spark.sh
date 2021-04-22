#!/bin/bash
SPARK_VERSION=spark-3.1.1
HADOOP_VERSION=hadoop3.2
SPARK_ARCHIVE=${SPARK_VERSION}-bin-${HADOOP_VERSION}.tar.gz
SPARK_MIRROR_DOWNLOAD=https://ftp.cixug.es/apache/spark/${SPARK_VERSION}/${SPARK_VERSION}-bin-${HADOOP_VERSION}.tgz
SPARK_RES_DIR=/vagrant/resources/spark
SPARK_CONF_DIR=/usr/local/spark/conf

function installLocalSpark {
	echo "install spark from local file"
	FILE=/vagrant/resources/${SPARK_ARCHIVE}
	tar -xzf $FILE -C /usr/local
}

function installRemoteSpark {
	echo "install spark from remote file"
	curl -o /vagrant/resources/${SPARK_ARCHIVE} -O -L ${SPARK_MIRROR_DOWNLOAD}
	tar -xzf /vagrant/resources/${SPARK_ARCHIVE} -C /usr/local
}

function setupSpark {
	echo "setup spark"
	touch ${SPARK_CONF_DIR}/slaves
}

function setupEnvVars {
	echo "Creating spark environment variables"
	echo export SPARK_HOME=/usr/local/spark >> /etc/profile.d/spark.sh
	echo export PATH=\${SPARK_HOME}/bin:\${PATH} >> /etc/profile.d/spark.sh
}

function installSpark {
	

	if [ ! -f /vagrant/resources/${SPARK_ARCHIVE} ]; 
	then
		echo "Spark not downloaded!"
		installRemoteSpark
	else	
		echo "Spark already downloaded!"
		installLocalSpark
	fi
	ln -s /usr/local/${SPARK_VERSION}-bin-${HADOOP_VERSION} /usr/local/spark
}

echo "\n----- Setup Spark ------\n"
installSpark
setupSpark
setupEnvVars