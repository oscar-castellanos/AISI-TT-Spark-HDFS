#!/bin/bash
SPARK_VERSION=spark-3.1.1
HADOOP_VERSION=hadoop3.2
SPARK_ARCHIVE=${SPARK_VERSION}-bin-${HADOOP_VERSION}.tar.gz
SPARK_MIRROR_DOWNLOAD=https://ftp.cixug.es/apache/spark/${SPARK_VERSION}/${SPARK_VERSION}-bin-${HADOOP_VERSION}.tgz
SPARK_RES_DIR=/vagrant/resources/spark
SPARK_DOWNLOAD_FILE=/var/${SPARK_ARCHIVE}
SPARK_INSTALL_DIR=/usr/local/spark
SPARK_CONF_DIR=${SPARK_INSTALL_DIR}/conf

function installLocalSpark {
	echo "install spark from local file"
	FILE=/vagrant/resources/${SPARK_ARCHIVE}
	sudo tar -xzf $FILE -C /usr/local
}

function installRemoteSpark {
	echo "install spark from remote file"
	sudo wget ${SPARK_MIRROR_DOWNLOAD} -O ${SPARK_DOWNLOAD_FILE}
	sudo tar -xzf ${SPARK_DOWNLOAD_FILE} -C /usr/local
	sudo rm ${SPARK_DOWNLOAD_FILE}
}

function setupSpark {
	echo "setup spark"
	sudo touch ${SPARK_CONF_DIR}/slaves
}

function setupEnvVars {
	echo "Creating spark environment variables"
	echo "export SPARK_HOME=/usr/local/spark" | sudo tee -a /etc/profile.d/spark.sh
	echo "export PATH=\${SPARK_HOME}/bin:\${PATH}" | sudo tee -a /etc/profile.d/spark.sh
}

function installSpark {

	if [ ! -f ${SPARK_DOWNLOAD_FILE} ]; 
	then
		echo "Spark not downloaded!"
		installRemoteSpark
	else	
		echo "Spark already downloaded!"
		installLocalSpark
	fi
	sudo ln -s /usr/local/${SPARK_VERSION}-bin-${HADOOP_VERSION} ${SPARK_INSTALL_DIR}
}

echo "\n----- Setup Spark ------\n"
installSpark
setupSpark
setupEnvVars