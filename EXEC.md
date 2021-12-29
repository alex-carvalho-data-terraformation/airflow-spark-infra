# <img src="img/terraform.png" alt="Terraform" height="30" style="vertical-align: middle;"> <img src="img/docker.png" alt="docker" height="30" style="vertical-align: middle;"> execution

It's intended to be very fast, less then 3 min.   
Here are created and `docker containers` and `docker networks` and destroyed after use.  

## 1. Configuration

1. Go to terraform config dir for execution (from this README folder)
   
```bash
cd terraform/exec/
```

2. Initialize Terraform

```bash
terraform init
```

## 2. Deployment instructions

Execute the build.  

```bash
terraform apply
```

## 3. How to run tests

### <img src="img/terraform.png" alt="Terraform" height="30" style="vertical-align: middle;"> 3.1. Check terraform objects

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
docker_image.hadoop_datanode
docker_image.hadoop_namenode
docker_image.hive_metastore
docker_image.hive_server
docker_image.hive_webhcat
docker_image.hue
docker_image.livy
docker_image.postgres
docker_image.spark_master
docker_image.spark_worker
docker_network.airflow_network
```

### <img src="img/docker.png" alt="docker" height="20" style="vertical-align: middle;"> 3.2. Check docker networks

```bash
docker network ls
```

*Expected output similar to:*

```bash
NETWORK ID     NAME              DRIVER    SCOPE
c81eb58de5af   airflow-network   bridge    local
```

### <img src="img/docker.png" alt="docker" height="20" style="vertical-align: middle;"> 3.3. Check docker containers

```bash
docker container ls
```

*Expected output similar to:*

```bash
CONTAINER ID   IMAGE          COMMAND                  CREATED       STATUS                 PORTS                                                                         NAMES
869be1af8241   6dc44447ffe6   "./entrypoint.sh ./s…"   4 hours ago   Up 4 hours (healthy)   0.0.0.0:32762->8888/tcp                                                       hue
dde0b610e600   f814cf614618   "./entrypoint.sh ./s…"   4 hours ago   Up 4 hours (healthy)   10000-10002/tcp, 50111/tcp                                                    hive-webhcat
a3c263c87e00   cf951835930f   "./entrypoint.sh ./s…"   4 hours ago   Up 4 hours (healthy)   10001/tcp, 0.0.0.0:32760->10000/tcp, 0.0.0.0:32759->10002/tcp                 hive-server
d8f31ce19d37   bd7e6a4f43c4   "./entrypoint"           4 hours ago   Up 4 hours (healthy)   0.0.0.0:32758->8998/tcp                                                       livy
027e1ff8197c   33a7e180f085   "./entrypoint.sh ./s…"   4 hours ago   Up 4 hours (healthy)   10000-10002/tcp, 0.0.0.0:32761->9083/tcp                                      hive-metastore
90b6756ef764   0592d59b0f8a   "./entrypoint.sh ./s…"   4 hours ago   Up 4 hours (healthy)   10000-10002/tcp, 0.0.0.0:32764->8081/tcp                                      spark-worker
097baa9beb8d   48a81795f15b   "./entrypoint.sh ./s…"   4 hours ago   Up 4 hours (healthy)   9864/tcp                                                                      datanode
51e0dc01bb7b   5caaff0dbf9f   "/entrypoint.sh php …"   4 hours ago   Up 4 hours (healthy)   0.0.0.0:32767->9000/tcp                                                       adminer
4c20d1ebfec9   d2758248847d   "./entrypoint.sh ./s…"   4 hours ago   Up 4 hours (healthy)   6066/tcp, 10000-10002/tcp, 0.0.0.0:32765->7077/tcp, 0.0.0.0:32766->8082/tcp   spark-master
0b453661da42   51296ced813f   "docker-entrypoint.s…"   4 hours ago   Up 4 hours (healthy)   0.0.0.0:32769->5432/tcp                                                       postgres
83cc1ced996f   984d0b45f049   "./entrypoint.sh ./s…"   4 hours ago   Up 4 hours (healthy)   0.0.0.0:8080->8080/tcp, 10000-10002/tcp                                       airflow
64d81544c2ac   dd192aee7178   "./entrypoint.sh ./s…"   4 hours ago   Up 4 hours (healthy)   0.0.0.0:32763->9870/tcp                                                       namenode
```

## 4. URLs

### 4.1. adminer

[<img src="img/postgresql.png" alt="PostgreSQL" height="60" style="vertical-align: middle;">](http://localhost:32767/)

http://localhost:32767/

|          |             |
|----------|-------------|
| System   | PostegreSQL |
| Server   | postgres    |
| Username | airflow     |
| Password | airflow     |
| Database | airflow_db  |

### 4.2. Hadoop hdfs NameNode

[<img src="img/hdfs.png" alt="hdfs" height="60" style="vertical-align: middle;">](http://localhost:32763/)

http://localhost:32763/

### 4.3. hue

[<img src="img/hue.png" alt="hue" height="60" style="vertical-align: middle;">](http://localhost:32762/)  

http://localhost:32762/

### 4.4. spark master

[<img src="img/spark.svg" alt="Apache Spark" height="60" style="vertical-align: middle;">](http://localhost:32766/)

http://localhost:32766/

### 4.5. spark worker

[<img src="img/spark.svg" alt="Apache Spark" height="60" style="vertical-align: middle;">](http://localhost:32764/)

http://localhost:32764/

### 4.6. livy

http://localhost:32758/

### 4.7. airflow

[<img src="img/airflow.png" alt="Apache Airflow" height="60" style="vertical-align: middle;">](http://localhost:8080/)

http://localhost:8080/

|          |         |
|----------|---------|
| Username | airflow |
| Password | airflow |


## 5. Undeploy instructions

### 5.1. Stop and remove docker containers and volumes

at `terraform/exec/`  

```bash
terraform destroy
```
