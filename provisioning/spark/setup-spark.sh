#!/bin/bash
SPARK_VERSION=spark-3.1.1
HADOOP_VERSION=hadoop2.7
SPARK_ARCHIVE=${SPARK_VERSION}-bin-${HADOOP_VERSION}.tar.gz
SPARK_MIRROR_DOWNLOAD=https://ftp.cixug.es/apache/spark/${SPARK_VERSION}/spark-3.1.1-bin-${HADOOP_VERSION}.tgz
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
	cp -f /vagrant/resources/spark/slaves ${SPARK_CONF_DIR}
}

function setupEnvVars {
	echo "creating spark environment variables"
	cp -f ${SPARK_RES_DIR}/spark.sh /etc/profile.d/spark.sh
}

function installSpark {
	installRemoteSpark
	ln -s /usr/local/${SPARK_VERSION}-bin-${HADOOP_VERSION} /usr/local/spark
}

echo "--- Setup spark ---"

if [ ! -f /vagrant/resources/${SPARK_ARCHIVE} ]; 
then
    echo "Spark not downloaded!"
	installRemoteSpark
else	
	echo "Spark already downloaded!"
	installLocalSpark
fi
ln -s /usr/local/${SPARK_VERSION}-bin-${HADOOP_VERSION} /usr/local/spark

#installSpark
#setupSpark
setupEnvVars