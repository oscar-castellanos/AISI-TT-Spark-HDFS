# AISI-TT-Spark-HDFS
Repositorio para el trabajo tutelado de AISI, basado en Spark + HDFS.

## Fase 0: Instalación de los pre-requisitos

Para este proyecto es necesario tener instalado:

- [VirtualBox](https://www.virtualbox.org/wiki/Downloads) versión >= 6.1.X con las Guest Additions.
- [Vagrant](https://www.vagrantup.com/docs/installation). Hemos usado la versión 2.2.14.
- [Packer](https://learn.hashicorp.com/tutorials/packer/getting-started-install). Hemos usado la versión 1.7.0.

Además, se han usado los plugins de vagrant  `vagrant-vbguest` y `vagrant-hostmanager`. Puedes instalarlos con:

``` sh
vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-hostmanager
```

## Fase 1: Generar con Packer y Ansible una box basada en centos7

``` sh
packer build centosSpark.json
```

Tras esta fase se generará una vagrant box con:

 - El servicio `firewalld` parado y deshabilitado: `provisioning/ansiblePacker/tasks/generalConfig.yml`
 - Un usuario y grupo hadoop: `provisioning/ansiblePacker/tasks/generalConfig.yml`
 - Java preinstalado: `provisioning/ansiblePacker/tasks/javaConfig.yml`
 - Hadoop preinstalado: `provisioning/ansiblePacker/tasks/hadoopConfig.yml`
 - Spark preinstalado: `provisioning/ansiblePacker/tasks/sparkConfig.yml`

 Finalmente añade la box para su uso con vagrant.

``` sh
vagrant box add --name aff-ocr-aisi2021/centos7 output-vagrant/package.box
```

## Fase 2: Generar un proyecto Vagrant para desplegar el cluster virtual

Tras esta fase se generará un Vagrantfile capaz de desplegar las tres máquinas virtuales, un manager (haciendo de NameNode y ResourceManager) y dos workers (haciendo de DataNodes y NodeManagers), con los recursos correctos.

 - Tanto el usuario `vagrant` como el usuario `hadoop` del nodo maestro serán capaces de establecer una sesión ssh passwordless en los nodos workers: `provisioning/hadoopUser/master.sh` y `provisioning/hadoopUser/authHadoopPasswordless.sh`.

``` sh
vagrant up
```

## Fase 3: Aprovisionamiento con Ansible

Tras esta fase se modificar el Vagrantfile para configurar correctamente los tres nodos.

 - Hadoop estará funcionando con HDFS y YARN: `provisioning/ansible`.
 - Spark esta funcionando sobre YARN: `provisioning/ansible`.

``` sh
vagrant provision --provision-with Ansible_Spark_Provisioner
```

## Fase 4: Pruebas de que esto esta funcionando

### Comprueba el estado de HDFS

- Usando el comando `hdfs dfsadmin`.

``` sh
vagrant ssh 
sudo su hadoop
hdfs dfsadmin -report
```

- Desde la interfaz web, accediendo a `http://master.local:9870`.

### Comprueba el estado de Yarn

- Usando el comando `yarn node`.

``` sh
vagrant ssh 
sudo su hadoop
yarn node -list
```

- Desde la interfaz web, accediendo a `http://master.local:8088`.

### Ejecuta una tarea de prueba en el cluster con Yarn 

#### Subiremos un archivo al sistema de ficheros HDFS.

``` sh
vagrant ssh 
sudo su hadoop
cd 
hdfs dfs -mkdir -p /user/hadoop
hdfs dfs -mkdir books
wget -O alice.txt https://www.gutenberg.org/files/11/11-0.txt
hdfs dfs -put alice.txt books
```

#### Ejecutaremos un ejemplo sobre dicho archivo

Mientras la tarea se ejecuta recargando la interfaz web podemos ver el progreso en su estado.

``` sh
yarn jar ~/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.2.2.jar wordcount "books/alice.txt" output
```

#### Comprobaremos los resultados

``` sh
hdfs dfs -ls output
hdfs dfs -cat output/part-r-00000 | less
```

### Ejecuta un par de tareas de prueba en el cluster con Spark

``` sh
vagrant ssh 
sudo su hadoop
spark-submit --deploy-mode client --class org.apache.spark.examples.SparkPi /usr/local/spark/examples/jars/spark-examples_2.12-3.1.1.jar 10
spark-submit --deploy-mode client --class org.apache.spark.examples.JavaWordCount /usr/local/spark/examples/jars/spark-examples_2.12-3.1.1.jar alice.txt
```
 - Puedes comprobar los resultados desde la interfaz web de Yarn, accediendo a Desde la interfaz web, accediendo a `http://master.local:8088`.


## Referencias principales

 - https://www.linode.com/docs/guides/how-to-install-and-set-up-hadoop-cluster/
 - https://www.linode.com/docs/databases/hadoop/install-configure-run-spark-on-top-of-hadoop-yarn-cluster/

### Referencias de resolución de problemas o bugs

 - [Packer no encuentra vars/main.yml](https://github.com/hashicorp/packer/issues/3316)
 - [Mover/renombrar archivos con Ansible](https://stackoverflow.com/questions/24162996/how-to-move-rename-a-file-using-an-ansible-task-on-a-remote-system)
 - [`start-yarn.sh` no funciona correctamente con ansible](https://stackoverflow.com/questions/66295332/hadoops-resourcemanager-fails-to-start-when-started-through-ansible)
 - [Incompatible clusterIDs error](https://sparkbyexamples.com/hadoop/incompatible-clusterids/)
