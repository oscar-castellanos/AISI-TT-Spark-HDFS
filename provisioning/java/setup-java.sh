#!/usr/bin/env bash

JAVA_VERSION=java-1.8.0-openjdk

function installJava {
	echo "Installing Java"
	yum -y install ${JAVA_VERSION}
	mv /usr/lib/jvm/${JAVA_VERSION}* /usr/lib/jvm/${JAVA_VERSION}
	rm /etc/alternatives/java
	ln -s /usr/lib/jvm/${JAVA_VERSION}/jre/bin/java /etc/alternatives/java
}

function setupEnvVars {
	echo "Creating java environment variables"
	echo export JAVA_HOME=/usr/lib/jvm/${JAVA_VERSION}/jre >> /etc/profile.d/java.sh
	echo export PATH=\${JAVA_HOME}/bin:\${PATH} >> /etc/profile.d/java.sh
}

echo "\n----- Setup Java ------\n"
installJava
setupEnvVars
