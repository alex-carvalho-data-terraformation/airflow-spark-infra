# <img src="img/terraform.png" alt="Terraform" height="30" style="vertical-align: middle;"> <img src="img/docker.png" alt="docker" height="30" style="vertical-align: middle;"> build

The build part trigger the construction of objects that consume a lot of time, like the `docker images`.  
It also creates objects that are desired to persist between executions, like `docker volumes`.

## 1. Configuration

1. Go to terraform config dir for build (from this README folder)
   
```bash
cd terraform/build/
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
docker_volume.airflow_vol
docker_volume.datanode_vol
docker_volume.namenode_vol
docker_volume.postgres_vol
docker_volume.spark_master_apps_vol
docker_volume.spark_master_data_vol
docker_volume.spark_worker_apps_vol
docker_volume.spark_worker_data_vol
```

### <img src="img/docker.png" alt="docker" height="20" style="vertical-align: middle;"> 3.2. Check docker images

```bash
docker image ls
```

*Expected output similar to:*

```bash
REPOSITORY               TAG                 IMAGE ID       CREATED         SIZE
airflow                  1.1.0               984d0b45f049   2 days ago      3.43GB
airflow                  latest              984d0b45f049   2 days ago      3.43GB
spark-master             1.0.0               d2758248847d   4 days ago      2.09GB
spark-master             latest              d2758248847d   4 days ago      2.09GB
spark-worker             1.0.0               0592d59b0f8a   4 days ago      2.09GB
spark-worker             latest              0592d59b0f8a   4 days ago      2.09GB
spark-base               1.0.0               361e95ad0304   4 days ago      2.09GB
spark-base               latest              361e95ad0304   4 days ago      2.09GB
hue                      1.0.0               6dc44447ffe6   4 days ago      1.95GB
hue                      latest              6dc44447ffe6   4 days ago      1.95GB
hive-webhcat             1.0.0               f814cf614618   4 days ago      1.02GB
hive-webhcat             latest              f814cf614618   4 days ago      1.02GB
hive-server              1.0.0               cf951835930f   4 days ago      1.02GB
hive-server              latest              cf951835930f   4 days ago      1.02GB
hive-metastore           1.0.0               33a7e180f085   4 days ago      1.02GB
hive-metastore           latest              33a7e180f085   4 days ago      1.02GB
hive-base                1.0.0               c85d6343ff8e   4 days ago      1.02GB
hive-base                latest              c85d6343ff8e   4 days ago      1.02GB
hadoop-namenode          1.0.0               dd192aee7178   4 days ago      699MB
hadoop-namenode          latest              dd192aee7178   4 days ago      699MB
hadoop-datanode          1.0.0               48a81795f15b   4 days ago      699MB
hadoop-datanode          latest              48a81795f15b   4 days ago      699MB
hadoop-base              1.0.0               a7bd296f5db8   4 days ago      699MB
hadoop-base              latest              a7bd296f5db8   4 days ago      699MB
livy                     1.0.0               bd7e6a4f43c4   4 days ago      1.5GB
livy                     latest              bd7e6a4f43c4   4 days ago      1.5GB
postgres-hive            1.0.0               51296ced813f   4 days ago      71.9MB
postgres-hive            latest              51296ced813f   4 days ago      71.9MB
wodby/adminer            latest              5caaff0dbf9f   9 days ago      393MB
openjdk                  8-jdk-slim-buster   e365b7e52f97   2 weeks ago     288MB
hello-world              latest              feb5d9fea6a5   2 months ago    13.3kB
gethue/hue               4.10.0              dfa2f9872e8d   6 months ago    1.62GB
cloudiator/livy-server   latest              61e38fb04202   19 months ago   1.49GB
postgres                 11.4-alpine         5239fade3a90   2 years ago     71.9MB
```

### <img src="img/docker.png" alt="docker" height="20" style="vertical-align: middle;"> 3.3. Check docker volumes

```bash
docker volume ls
```

*Expected output similar to:*

```bash
DRIVER    VOLUME NAME
local     airflow-vol
local     datanode-vol
local     namenode-vol
local     postgres-vol
local     spark-master-apps-vol
local     spark-master-data-vol
local     spark-worker-apps-vol
local     spark-worker-data-vol
```

## 4. Undeploy instructions

### 4.1. Stop and remove docker containers and volumes

at `terraform/build/`  

```bash
terraform destroy
```

### 4.2. Remove docker images

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
