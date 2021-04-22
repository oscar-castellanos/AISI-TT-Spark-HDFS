#!/bin/bash

# Objetivo instalar hadoop con permisos del usuario hadoop
# Todos tienen que hacerlo, masters y workers

# Variables
HADOOP_VERSION=hadoop-3.2.2
BASE_FOLDER=/home/hadoop/

sudo wget http://apache.cs.utah.edu/hadoop/common/${HADOOP_VERSION}/${HADOOP_VERSION}.tar.gz
sudo tar -xzf ${HADOOP_VERSION}.tar.gz && sudo /bin/rm ${HADOOP_VERSION}.tar.gz
sudo mkdir ${BASE_FOLDER}hadoop
sudo mv ${HADOOP_VERSION} ${BASE_FOLDER}hadoop
sudo chown -R hadoop:hadoop ${BASE_FOLDER}hadoop
sudo ln -s ${BASE_FOLDER}hadoop/bin/* /bin
sudo ln -s ${BASE_FOLDER}hadoop/sbin/* /sbin
