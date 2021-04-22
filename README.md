# AISI-TT-Spark-HDFS
Repositorio para el trabajo tutelado de AISI, basado en Spark + HDFS

## Fase 1: Generar con Packer una box basada en centos7.

Tras esta fase se generará una vagrant box con:

 - Un usuario y grupo hadoop: `provisioning/hadoopUser/creteHadoopUser.sh`
 - Java preinstalado: `provisioning/java/setup-java.sh`
 - Hadoop preinstalado: `provisioning/hadoop/setup-hadoop.sh`
 - Spark preinstalado: `provisioning/spark/setup-spark.sh`

## Fase 2: Generar con Vagrant un manager y dos workers.

Tras esta fase se generará un Vagrantfile capaz de desplegar las tres máquinas virtuales con los recursos correctos.

## Fase 3: Aprovisionamiento con Ansible

Tras esta fase se modificar el Vagrantfile para configurar correctamente los tres nodos.