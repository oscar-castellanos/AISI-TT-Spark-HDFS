#!/bin/bash

# Objetivo instalar hadoop con permisos del usuario hadoop
# Todos tienen que hacerlo, masters y workers

# Variables
HADOOP_VERSION=hadoop-3.2.2
BASE_FOLDER=/home/hadoop/

sudo cd ${BASE_FOLDER}
sudo wget http://apache.cs.utah.edu/hadoop/common/${HADOOP_VERSION}/${HADOOP_VERSION}.tar.gz -O ${BASE_FOLDER}hadoop.tar.gz
sudo tar -xzf hadoop.tar.gz && sudo /bin/rm hadoop.tar.gz
sudo mv hadoop* hadoop
sudo chown -R hadoop:hadoop hadoop/
sudo ln -s hadoop/bin/* /bin
sudo ln -s hadoop/sbin/* /sbin
