#!/usr/bin/env bash

JAVA_VERSION=java-1.8.0-openjdk

function installJava {
	echo "Installing Java"
	sudo yum -y install ${JAVA_VERSION}
	sudo mv /usr/lib/jvm/${JAVA_VERSION}* /usr/lib/jvm/${JAVA_VERSION}
	sudo rm /etc/alternatives/java
	sudo ln -s /usr/lib/jvm/${JAVA_VERSION}/jre/bin/java /etc/alternatives/java
}

function setupEnvVars {
	echo "Creating java environment variables"
	echo "export JAVA_HOME=/usr/lib/jvm/${JAVA_VERSION}/jre" | sudo tee -a /etc/profile.d/java.sh
	echo "export PATH=\${JAVA_HOME}/bin:\${PATH}" | sudo tee -a /etc/profile.d/java.sh
}

echo "\n----- Setup Java ------\n"
installJava
setupEnvVars
