# Environment #

## Quick summary  

Terraform infrastructure containing: 

### network

- 1 network called airflow-network

### containers

- 1 postgres
- 1 adminer (Web UI for postgres)
- 1 hadoop hdfs NameNode
- 1 hadoop hdfs DataNode
- 1 hive metastore
- 1 hive server
- 1 webhcat (REST API for Hive)
- 1 hue
- 1 spark master
- 1 spark worker
- 1 livy (REST API for spark)
- 1 airflow


# container descriptions #

## postgres

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

### software

- Hadoop 3.1.1
- openjdk 8

### exposed ports (host:container)

- 32763:9870 

## hadoop hdfs DataNode

### software

- Hadoop 3.1.1
- openjdk 8


## hive metastore

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

### software

- Hive 3.1.2
- Hadoop 3.1.1
- openjdk 8

### exposed ports (host:container)

- 32763:9083


## webhcat (REST API for Hive)

## hue

### software

- Hive 4.10.0

### exposed ports (host:container)

- 32762:8888

### container specific info

#### URL

http://localhost:32762/


## spark master

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

http://localhost:32758/


## airflow

### software

- airflow 2.1.4
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
