# AISI-TT-Spark-HDFS
Repositorio para el trabajo tutelado de AISI, basado en Spark + HDFS

## Fase 1: Generar con Packer una box basada en centos7

``` sh
packer build centosSpark.json
```

Tras esta fase se generará una vagrant box con:

 - Un usuario y grupo hadoop: `provisioning/hadoopUser/creteHadoopUser.sh`
 - Java preinstalado: `provisioning/java/setup-java.sh`
 - Hadoop preinstalado: `provisioning/hadoop/setup-hadoop.sh`
 - Spark preinstalado: `provisioning/spark/setup-spark.sh`

 Finalmente añade la box para su uso con vagrant.

``` sh
 vagrant box add --name aff-ocr-aisi2021/centos7 output-vagrant/package.box
```

## Fase 2: Generar un proyecto Vagrant para desplegar el cluster virtual

Tras esta fase se generará un Vagrantfile capaz de desplegar las tres máquinas virtuales, un manager y dos workers, con los recursos correctos.

 - Tanto el usuario `vagrant` como el usuario `hadoop` del nodo maestro serán capaces de establecer una sessión ssh passwordless en los nodos workers: `provisioning/hadoopUser/master.sh` y `provisioning/hadoopUser/authHadoopPasswordless.sh`.

## Fase 3: Aprovisionamiento con Ansible

Tras esta fase se modificar el Vagrantfile para configurar correctamente los tres nodos.