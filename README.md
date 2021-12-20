# <img src="img/sample.png" height="30" style="vertical-align: middle;"> <img src="img/terraform.png" alt="Terraform" height="30" style="vertical-align: middle;"> <img src="img/docker.png" alt="docker" height="30" style="vertical-align: middle;"> <img src="img/postgresql.png" alt="PostgreSQL" height="30" style="vertical-align: middle;"> <img src="img/hdfs.png" alt="hdfs" height="30" style="vertical-align: middle;"> <img src="img/hive.png" alt="Apache Hive" height="30" style="vertical-align: middle;"> <img src="img/hue.png" alt="hue" height="30" style="vertical-align: middle;"> <img src="img/spark.svg" alt="Apache Spark" height="30" style="vertical-align: middle;"> <img src="img/airflow.png" alt="Apache Airflow" height="30" style="vertical-align: middle;">  
# terraform infrastructure as a code | alex carvalho #

## What is this folder for? ##

### Quick summary

This project is intendend to demonstrate an infrastructure as a code project, using
Terraform and Docker.

[Environment description](ENVIRONMENT.md)

### Version 1.0.0

## How do I get set up? ##

### 1. Summary of set up

All invironment is built using Terraform.  

Basically it's necessary to initialize the Terraform environment.  

The infrastructure is splited into 2 parts:

- [build](BUILD.md)
- [execution](EXEC.md)

#### 1.1. build

The build part trigger the construction of objects that consume a lot of time, like the `docker images`.  
It also create objects that are desired to persist between executions, like `docker volumes`.  

[build instructions](BUILD.md)

#### 1.2. execution

It's intended to be very fast, less then 3 min.   
Here are created and `docker containers` and `docker networks` and destroyed after use.  

[execution instructions](EXEC.md)

### 2. Dependencies

- <img src="img/docker.png" alt="docker" height="20" style="vertical-align: middle;"> docker
- <img src="img/terraform.png" alt="Terraform" height="30" style="vertical-align: middle;"> terraform

## Who do I talk to? ##

### Repo owner 

alex.carvalho.data@gmail.com
