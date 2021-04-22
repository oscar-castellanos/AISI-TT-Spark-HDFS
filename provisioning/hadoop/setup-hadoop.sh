#!/bin/bash

# Objetivo instalar hadoop con permisos del usuario hadoop
# Todos tienen que hacerlo, masters y workers

# Variables
HADOOP_VERSION=hadoop-3.2.2
BASE_FOLDER=/home/hadoop/

cd ${BASE_FOLDER}
wget http://apache.cs.utah.edu/hadoop/common/${HADOOP_VERSION}/${HADOOP_VERSION}.tar.gz -O ${BASE_FOLDER}hadoop.tar.gz
tar -xzf hadoop.tar.gz && rm hadoop.tar.gz
mv hadoop* hadoop
sudo ln -s hadoop/bin/* /bin
sudo ln -s hadoop/sbin/* /sbin
