terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.23.0"
    }
  }
}

provider "docker" {}

######################################################
# NETWORK
######################################################
# Change name of default network otherwise URI invalid for HIVE
# because of the _ contained by default network (according to Marc Lamberti)

resource "docker_network" "airflow_network" {
  name = "airflow-network"
}

######################################################
# DATABASE SERVICE
######################################################

resource "docker_container" "postgres" {
  name           = "postgres"
  image          = docker_image.postgres.image_id
  restart        = "always"
  remove_volumes = false

  networks_advanced {
    name = docker_network.airflow_network.name
  }
  ports {
    external = 32769
    internal = 5432
  }

  volumes {
    volume_name    = "postgres-vol"
    container_path = "/var/lib/postgresql/data"
  }

  env = [
    "POSTGRES_USER=airflow",
    "POSTGRES_PASSWORD=airflow",
    "POSTGRES_DB=airflow_db"
  ]

  log_driver = "json-file"
  log_opts = {
    max-file = "5"
    max-size = "10m"
  }

  healthcheck {
    test     = ["CMD", "pg_isready", "-q", "-d", "airflow_db", "-U", "airflow"]
    timeout  = "45s"
    interval = "10s"
    retries  = 10
  }
}

resource "docker_container" "adminer" {
  name    = "adminer"
  image   = docker_image.adminer.image_id
  restart = "always"

  networks_advanced {
    name = docker_network.airflow_network.name
  }

  ports {
    external = 32767
    internal = 9000
  }

  env = [
    "ADMINER_DEFAULT_DB_DRIVER=pgsql",
    "ADMINER_DEFAULT_DB_HOST=postgres",
    "ADMINER_DEFAULT_DB_NAME=airflow_db"
  ]

  log_driver = "json-file"
  log_opts = {
    max-file = "5"
    max-size = "10m"
  }

  healthcheck {
    test     = ["CMD", "nc", "-z", "adminer", "9000"]
    timeout  = "45s"
    interval = "10s"
    retries  = 10
  }
}

######################################################
# HADOOP SERVICES
######################################################

resource "docker_container" "hadoop_namenode" {
  name           = "namenode"
  image          = docker_image.hadoop_namenode.image_id
  restart        = "always"
  remove_volumes = false

  networks_advanced {
    name = docker_network.airflow_network.name
  }

  ports {
    external = "32763"
    internal = "9870"
  }

  volumes {
    volume_name    = "namenode-vol"
    container_path = "/hadoop/dfs/name"
  }

  env = [
    "CLUSTER_NAME=hadoop_cluster"
  ]

  log_driver = "json-file"
  log_opts = {
    max-file = "5"
    max-size = "10m"
  }

  healthcheck {
    test     = ["CMD", "nc", "-z", "namenode", "9870"]
    timeout  = "45s"
    interval = "10s"
    retries  = 10
  }
}

resource "docker_container" "hadoop_datanode" {
  name           = "datanode"
  image          = docker_image.hadoop_datanode.image_id
  restart        = "always"
  remove_volumes = false

  depends_on = [docker_container.hadoop_namenode]

  networks_advanced {
    name = docker_network.airflow_network.name
  }

  volumes {
    volume_name    = "datanode-vol"
    container_path = "/hadoop/dfs/data"
  }

  env = [
    "SERVICE_PRECONDITION=namenode:9870"
  ]

  log_driver = "json-file"
  log_opts = {
    max-file = "5"
    max-size = "10m"
  }

  healthcheck {
    test     = ["CMD", "nc", "-z", "datanode", "9864"]
    timeout  = "45s"
    interval = "10s"
    retries  = 10
  }
}

######################################################
# HIVE
######################################################

resource "docker_container" "hive_metastore" {
  name    = "hive-metastore"
  image   = docker_image.hive_metastore.image_id
  restart = "always"

  depends_on = [
    docker_container.hadoop_namenode,
    docker_container.hadoop_datanode,
    docker_container.postgres
  ]

  networks_advanced {
    name = docker_network.airflow_network.name
  }

  ports {
    external = "32761"
    internal = "9083"
  }

  env = ["SERVICE_PRECONDITION=namenode:9870 datanode:9864 postgres:5432"]

  log_driver = "json-file"
  log_opts = {
    max-file = "5"
    max-size = "10m"
  }

  healthcheck {
    test     = ["CMD", "nc", "-z", "hive-metastore", "9083"]
    timeout  = "45s"
    interval = "10s"
    retries  = 10
  }
}

resource "docker_container" "hive_server" {
  name    = "hive-server"
  image   = docker_image.hive_server.image_id
  restart = "always"

  depends_on = [docker_container.hive_metastore]

  networks_advanced {
    name = docker_network.airflow_network.name
  }

  ports {
    external = "32760"
    internal = "10000"
  }

  ports {
    external = "32759"
    internal = "10002"
  }

  env = ["SERVICE_PRECONDITION=hive-metastore:9083"]

  log_driver = "json-file"
  log_opts = {
    max-file = "5"
    max-size = "10m"
  }

  healthcheck {
    test     = ["CMD", "nc", "-z", "hive-server", "10002"]
    timeout  = "45s"
    interval = "10s"
    retries  = 10
  }
}

resource "docker_container" "hive_webhcat" {
  name    = "hive-webhcat"
  image   = docker_image.hive_webhcat.image_id
  restart = "always"

  depends_on = [docker_container.hive_server]

  networks_advanced {
    name = docker_network.airflow_network.name
  }

  env = ["SERVICE_PRECONDITION=hive-server:10000"]

  log_driver = "json-file"
  log_opts = {
    max-file = "5"
    max-size = "10m"
  }

  healthcheck {
    test         = ["CMD", "nc", "-z", "hive-webhcat", "50111"]
    timeout      = "45s"
    interval     = "10s"
    retries      = 10
    start_period = "1m0s"
  }
}

resource "docker_container" "hue" {
  name    = "hue"
  image   = docker_image.hue.image_id
  restart = "always"

  depends_on = [
    docker_container.hive_server,
    docker_container.postgres
  ]

  networks_advanced {
    name = docker_network.airflow_network.name
  }

  ports {
    external = "32762"
    internal = "8888"
  }

  env = ["SERVICE_PRECONDITION=hive-server:10000 postgres:5432"]

  log_driver = "json-file"
  log_opts = {
    max-file = "5"
    max-size = "10m"
  }

  healthcheck {
    test         = ["CMD", "nc", "-z", "hue", "8888"]
    timeout      = "45s"
    interval     = "10s"
    retries      = 10
    start_period = "1m0s"
  }
}

resource "docker_container" "spark_master" {
  name           = "spark-master"
  image          = docker_image.spark_master.image_id
  restart        = "always"
  remove_volumes = false

  networks_advanced {
    name = docker_network.airflow_network.name
  }

  ports {
    external = "32766"
    internal = "8082"
  }

  ports {
    external = "32765"
    internal = "7077"
  }

  volumes {
    volume_name    = "spark-master-apps-vol"
    container_path = "/opt/spark-apps"
  }

  volumes {
    volume_name    = "spark-master-data-vol"
    container_path = "/opt/spark-data"
  }

  log_driver = "json-file"
  log_opts = {
    max-file = "5"
    max-size = "10m"
  }

  healthcheck {
    test     = ["CMD", "nc", "-z", "spark-master", "8082"]
    timeout  = "45s"
    interval = "10s"
    retries  = 10
  }
}

resource "docker_container" "spark_worker" {
  name           = "spark-worker"
  image          = docker_image.spark_worker.image_id
  restart        = "always"
  remove_volumes = false

  depends_on = [docker_container.spark_master]

  networks_advanced {
    name = docker_network.airflow_network.name
  }

  ports {
    external = "32764"
    internal = "8081"
  }

  volumes {
    volume_name    = "spark-worker-apps-vol"
    container_path = "/opt/spark-apps"
  }

  volumes {
    volume_name    = "spark-worker-data-vol"
    container_path = "/opt/spark-data"
  }

  log_driver = "json-file"
  log_opts = {
    max-file = "5"
    max-size = "10m"
  }

  healthcheck {
    test     = ["CMD", "nc", "-z", "spark-worker", "8081"]
    timeout  = "45s"
    interval = "10s"
    retries  = 10
  }
}

resource "docker_container" "livy" {
  name    = "livy"
  image   = docker_image.livy.image_id
  restart = "always"

  depends_on = [docker_container.spark_worker]

  networks_advanced {
    name = docker_network.airflow_network.name
  }

  ports {
    external = "32758"
    internal = "8998"
  }

  env = [
    "SPARK_MASTER_ENDPOINT=spark-master",
    "SPARK_MASTER_PORT=7077",
    "DEPLOY_MODE=client"
  ]

  log_driver = "json-file"
  log_opts = {
    max-file = "5"
    max-size = "10m"
  }

  healthcheck {
    test     = ["CMD", "nc", "-z", "livy", "8998"]
    timeout  = "45s"
    interval = "10s"
    retries  = 10
  }
}

######################################################
# AIRFLOW
######################################################

resource "docker_container" "airflow" {
  name           = "airflow"
  image          = docker_image.airflow.image_id
  restart        = "always"
  remove_volumes = false

  networks_advanced {
    name = docker_network.airflow_network.name
  }

  ports {
    external = "8080"
    internal = "8080"
  }

  volumes {
    host_path      = "${path.cwd}/../../mnt/airflow/dags/"
    container_path = "/opt/airflow/dags/"
  }

  volumes {
    host_path      = "${path.cwd}/../../mnt/airflow/airflow.cfg"
    container_path = "/opt/airflow/airflow.cfg"
  }

  volumes {
    volume_name    = "airflow-vol"
    container_path = "/opt/airflow/db"
  }

  healthcheck {
    test     = ["CMD", "nc", "-z", "airflow", "8080"]
    timeout  = "45s"
    interval = "10s"
    retries  = 10
  }
}
