# <img src="img/CHANGE_ME.png" alt="CHANGE_ME" width="30" style="vertical-align: middle;"> | CHANGE_ME | alex carvalho #

## What is this folder for? ##

### Quick summary

This folder is intended to follow the exercises present in section 3 of the course.

[Environment description](ENVIRONMENT.md)

### Version 1.0.0

## How do I get set up? ##

### Summary of set up

All invironment is built using Terraform.  
Basically it's necessary to initialize the Terraform environment

### Dependencies

- docker
- terraform

### Configuration

1. Go to terraform config dir (from this README folder)
```bash
cd ./env/terraform/
```

2. Initialize Terraform
```bash
terraform init
```

### Deployment instructions

```bash
terraform apply
```

### How to run tests

1. Check if terraform resources are running

```bash
terraform state list
```

*Expected output similar to:*

```bash
docker_container.adminer
docker_container.airflow
docker_container.hadoop_datanode
docker_container.hadoop_namenode
docker_container.hive_metastore
docker_container.hive_server
docker_container.hive_webhcat
docker_container.hue
docker_container.livy
docker_container.postgres
docker_container.spark_master
docker_container.spark_worker
docker_image.adminer
docker_image.airflow
docker_image.hadoop_base
docker_image.hadoop_datanode
docker_image.hadoop_namenode
docker_image.hive_base
docker_image.hive_metastore
docker_image.hive_server
docker_image.hive_webhcat
docker_image.hue
docker_image.livy
docker_image.postgres
docker_image.spark_base
docker_image.spark_master
docker_image.spark_worker
docker_network.airflow_network
docker_volume.datanode_vol
docker_volume.namenode_vol
docker_volume.postgres_vol
docker_volume.spark_master_apps_vol
docker_volume.spark_master_data_vol
docker_volume.spark_worker_apps_vol
docker_volume.spark_worker_data_val
```

2. Check if docker containers are running

```bash
docker container ls
```

..while loading  
*Expected output similar to:*

```bash
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS                            PORTS                                                                         NAMES
b14a10351e8f   c73024e4ecfb   "./entrypoint.sh ./s…"   6 seconds ago   Up 5 seconds (health: starting)   0.0.0.0:8080->8080/tcp, 10000-10002/tcp                                       airflow
7459a29c1dac   c813a711c8f5   "./entrypoint"           2 minutes ago   Up 2 minutes (healthy)            0.0.0.0:32758->8998/tcp                                                       livy
8cfd7161271a   660a6050ff03   "./entrypoint.sh ./s…"   2 minutes ago   Up 2 minutes (healthy)            10000-10002/tcp, 0.0.0.0:32764->8081/tcp                                      spark-worker
1eb2c631e2b7   2ee255a55d9c   "./entrypoint.sh ./s…"   2 minutes ago   Up 2 minutes (healthy)            6066/tcp, 10000-10002/tcp, 0.0.0.0:32765->7077/tcp, 0.0.0.0:32766->8082/tcp   spark-master
3495e5111bbc   b263c6f2868c   "./entrypoint.sh ./s…"   5 minutes ago   Up 5 minutes (healthy)            10000-10002/tcp, 50111/tcp                                                    hive-webhcat
c24c6f7ad12e   dfcfde7cc54b   "./entrypoint.sh ./s…"   5 minutes ago   Up 5 minutes (healthy)            0.0.0.0:32762->8888/tcp                                                       hue
4d5a107754d4   729dc85b05c5   "./entrypoint.sh ./s…"   5 minutes ago   Up 5 minutes (healthy)            10001/tcp, 0.0.0.0:32760->10000/tcp, 0.0.0.0:32759->10002/tcp                 hive-server
09fdd22dc6e6   f271f05a5fda   "./entrypoint.sh ./s…"   5 minutes ago   Up 5 minutes (healthy)            10000-10002/tcp, 0.0.0.0:32761->9083/tcp                                      hive-metastore
84e35c1a17ed   b5afcede233c   "./entrypoint.sh ./s…"   5 minutes ago   Up 5 minutes (healthy)            9864/tcp                                                                      datanode
5a122812c402   19feb22d0a3c   "./entrypoint.sh ./s…"   5 minutes ago   Up 5 minutes (healthy)            0.0.0.0:32763->9870/tcp                                                       namenode
4d238338366e   5caaff0dbf9f   "/entrypoint.sh php …"   6 minutes ago   Up 6 minutes (healthy)            0.0.0.0:32767->9000/tcp                                                       adminer
695c747b59f2   c83faa634e4b   "docker-entrypoint.s…"   6 minutes ago   Up 6 minutes (healthy)            0.0.0.0:32769->5432/tcp                                                       postgres

```

..when ready  
*Expected output similar to:*

```bash
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS                    PORTS                                                                         NAMES
b14a10351e8f   c73024e4ecfb   "./entrypoint.sh ./s…"   50 seconds ago   Up 48 seconds (healthy)   0.0.0.0:8080->8080/tcp, 10000-10002/tcp                                       airflow
7459a29c1dac   c813a711c8f5   "./entrypoint"           3 minutes ago    Up 3 minutes (healthy)    0.0.0.0:32758->8998/tcp                                                       livy
8cfd7161271a   660a6050ff03   "./entrypoint.sh ./s…"   3 minutes ago    Up 3 minutes (healthy)    10000-10002/tcp, 0.0.0.0:32764->8081/tcp                                      spark-worker
1eb2c631e2b7   2ee255a55d9c   "./entrypoint.sh ./s…"   3 minutes ago    Up 3 minutes (healthy)    6066/tcp, 10000-10002/tcp, 0.0.0.0:32765->7077/tcp, 0.0.0.0:32766->8082/tcp   spark-master
3495e5111bbc   b263c6f2868c   "./entrypoint.sh ./s…"   6 minutes ago    Up 6 minutes (healthy)    10000-10002/tcp, 50111/tcp                                                    hive-webhcat
c24c6f7ad12e   dfcfde7cc54b   "./entrypoint.sh ./s…"   6 minutes ago    Up 6 minutes (healthy)    0.0.0.0:32762->8888/tcp                                                       hue
4d5a107754d4   729dc85b05c5   "./entrypoint.sh ./s…"   6 minutes ago    Up 6 minutes (healthy)    10001/tcp, 0.0.0.0:32760->10000/tcp, 0.0.0.0:32759->10002/tcp                 hive-server
09fdd22dc6e6   f271f05a5fda   "./entrypoint.sh ./s…"   6 minutes ago    Up 6 minutes (healthy)    10000-10002/tcp, 0.0.0.0:32761->9083/tcp                                      hive-metastore
84e35c1a17ed   b5afcede233c   "./entrypoint.sh ./s…"   6 minutes ago    Up 6 minutes (healthy)    9864/tcp                                                                      datanode
5a122812c402   19feb22d0a3c   "./entrypoint.sh ./s…"   6 minutes ago    Up 6 minutes (healthy)    0.0.0.0:32763->9870/tcp                                                       namenode
4d238338366e   5caaff0dbf9f   "/entrypoint.sh php …"   7 minutes ago    Up 7 minutes (healthy)    0.0.0.0:32767->9000/tcp                                                       adminer
695c747b59f2   c83faa634e4b   "docker-entrypoint.s…"   7 minutes ago    Up 7 minutes (healthy)    0.0.0.0:32769->5432/tcp                                                       postgres
```

3. adminer

http://localhost:32767/

4. Hadoop hdfs NameNode

http://localhost:32763/

5. hue

http://localhost:32762/

6. spark master

http://localhost:32766/

7. spark worker

http://localhost:32764/

8. livy

http://localhost:32758/

9. airflow

http://localhost:8080/

|          |         |
|----------|---------|
| Username | airflow |
| Password | airflow |

### Undeploy instructions

#### Stop and remove docker containers and network

```bash
terraform destroy
```
docker image rm openjdk:8-jdk-slim-buster
#### Remove docker images

```bash
docker image rm postgres-hive:latest postgres-hive:1.0.0 postgres:11.4-alpine
docker image rm hadoop-datanode:1.0.0 hadoop-datanode:latest
docker image rm hadoop-namenode:1.0.0 hadoop-namenode:latest
docker image rm hadoop-base:1.0.0 hadoop-base:latest openjdk:8-jdk-slim-buster
docker image rm hive-base:1.0.0 hive-base:latest
docker image rm hive-server:1.0.0 hive-server:latest
docker image rm hive-webhcat:1.0.0 hive-webhcat:latest
docker image rm hive-metastore:1.0.0 hive-metastore:latest
docker image rm wodby/adminer:latest
docker image rm hue:1.0.0 hue:latest gethue/hue:4.10.0
docker image rm livy:1.0.0 livy:latest cloudiator/livy-server:latest
docker image rm spark-worker:1.0.0 spark-worker:latest
docker image rm spark-master:1.0.0 spark-master:latest
docker image rm spark-base:1.0.0 spark-base:latest
docker image rm airflow:1.0.0 airflow:latest
```

## Exercises info

Many exercises in this lesson consist in creating a new airflow task in a DAG.

### Test a Task

*Syntax:*  
`airflow tasks test [DAG Id] [Task Id] [Date in past]`

*Example:*  
```bash
airflow tasks test forex_data_pipeline create_hive_forex_table 2021-01-01
```
