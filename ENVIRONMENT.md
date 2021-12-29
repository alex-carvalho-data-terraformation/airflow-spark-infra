# Environment #

## Quick summary  

<img src="img/terraform.png" alt="Terraform" height="30" style="vertical-align: middle;"> Terraform infrastructure containing: 

### network

- 1 network called airflow-network

### containers <img src="img/docker.png" alt="docker" height="30" style="vertical-align: middle;">

- 1 <img src="img/postgresql.png" alt="PostgreSQL" height="20" style="vertical-align: middle;"> [PostgreSQL](#postgres)
- 1 [adminer](#adminer) (Web UI for PostgreSQL)
- 1 <img src="img/hdfs.png" alt="hdfs" height="20" style="vertical-align: middle;"> [hadoop hdfs NameNode](#hadoop-hdfs-namenode)
- 1 <img src="img/hdfs.png" alt="hdfs" height="20" style="vertical-align: middle;"> [hadoop hdfs DataNode](#hadoop-hdfs-datanode)
- 1 <img src="img/hive.png" alt="Apache Hive" height="20" style="vertical-align: middle;"> [hive metastore](#hive-metastore)
- 1 <img src="img/hive.png" alt="Apache Hive" height="20" style="vertical-align: middle;"> [hive server](#hive-server)
- 1 [webhcat](#webhcat-rest-api-for-hive) (REST API for Hive)
- 1 <img src="img/hue.png" alt="hue" height="20" style="vertical-align: middle;"> [hue](#hue)
- 1 <img src="img/spark.svg" alt="Apache Spark" height="20" style="vertical-align: middle;"> [spark master](#spark-master)
- 1 <img src="img/spark.svg" alt="Apache Spark" height="20" style="vertical-align: middle;"> [spark worker](#spark-worker)
- 1 [livy](#livy-rest-api-for-spark) (REST API for spark)
- 1 <img src="img/airflow.png" alt="Apache Airflow" height="20" style="vertical-align: middle;"> [airflow](#airflow)


# container descriptions #

## postgres 

<img src="img/postgresql.png" alt="PostgreSQL" height="60" style="vertical-align: middle;">

### software

- PostgreSQL db 11.4
- alpine linux

### exposed ports (host:container)

- 32769:5432 

### container specific info

#### databases
| database name | user    | password |
|---------------|---------|----------|
| airflow_db    | airflow | airflow  |
| metastore     | hive    | hive     |


## adminer

### software

- adminer:latest
  - version 4.8.1 (in 10/12/2021)

### exposed ports (host:container)

- 32767:9000 

### container specific info

#### URL
http://localhost:32767/

|              |            |
|--------------|------------|
| **System**   | PostgreSQL |
| **Server**   | postgres   |
| **Username** | airflow    |
| **Password** | airflow    |
| **Database** | airflow_db |


## hadoop hdfs NameNode

<img src="img/hdfs.png" alt="hdfs" height="60" style="vertical-align: middle;">

### software

- Hadoop 3.1.1
- openjdk 8

### exposed ports (host:container)

- 32763:9870 

## hadoop hdfs DataNode

<img src="img/hdfs.png" alt="hdfs" height="60" style="vertical-align: middle;">

### software

- Hadoop 3.1.1
- openjdk 8


## hive metastore

<img src="img/hive.png" alt="Apache Hive" height="60" style="vertical-align: middle;">

### software

- Hive 3.1.2
- Hadoop 3.1.1
- openjdk 8

### exposed ports (host:container)

- 32763:9083

### container specific info

#### URL

http://localhost:32763/


## hive server

<img src="img/hive.png" alt="Apache Hive" height="60" style="vertical-align: middle;">

### software

- Hive 3.1.2
- Hadoop 3.1.1
- openjdk 8

### exposed ports (host:container)

- 32763:9083


## webhcat (REST API for Hive)

## hue

<img src="img/hue.png" alt="hue" height="60" style="vertical-align: middle;">

### software

- Hive 4.10.0

### exposed ports (host:container)

- 32762:8888

### container specific info

#### URL

http://localhost:32762/


## spark master

<img src="img/spark.svg" alt="Apache Spark" height="60" style="vertical-align: middle;">

### software

- Spark 2.4.5
- Scala 2.12.4
- sbt 1.2.8
- Hive 3.1.2
- Hadoop 3.1.1
- openjdk 8

### exposed ports (host:container)

- 32766:8082
- 32765:7077

### container specific info

#### URL

http://localhost:32766/


## spark worker

<img src="img/spark.svg" alt="Apache Spark" height="60" style="vertical-align: middle;">

### software

- Spark 2.4.5
- Scala 2.12.4
- sbt 1.2.8
- Hive 3.1.2
- Hadoop 3.1.1
- openjdk 8

### exposed ports (host:container)

- 32764:8081

### container specific info

#### URL

http://localhost:32764/


## livy (REST API for spark)

### software

- livy server latest (docker image poorly documented)

### exposed ports (host:container)

- 32758:8998

### container specific info

#### URL

http://localhost:32758/ui


## airflow

<img src="img/airflow.png" alt="Apache Airflow" height="60" style="vertical-align: middle;">

### software

- airflow 2.1.4
  - providers
    - apache-hdfs 2.1.0
    - apache-hive 2.0.2
    - apache-spark 2.0.1
    - slack 4.0.1
    - http 2.0.1
- python 3
- pip 20.2.4
- Spark 2.4.5
- Scala 2.12.4
- sbt 1.2.8
- Hive 3.1.2
- Hadoop 3.1.1
- openjdk 8

### exposed ports (host:container)

- 8080:8080

### container specific info

#### URL

http://localhost:8080/

|              |         |
|--------------|---------|
| **Username** | airflow |
| **Password** | airflow |
