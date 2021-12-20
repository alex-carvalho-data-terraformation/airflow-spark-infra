######################################################
# DATABASE SERVICE
######################################################

resource "docker_volume" "postgres_vol" {
  name = "postgres-vol"
}

######################################################
# HADOOP SERVICES
######################################################

resource "docker_volume" "namenode_vol" {
  name = "namenode-vol"
}

resource "docker_volume" "datanode_vol" {
  name = "datanode-vol"
}

######################################################
# SPARK SERVICES
######################################################

resource "docker_volume" "spark_master_apps_vol" {
  name = "spark-master-apps-vol"
}

resource "docker_volume" "spark_master_data_vol" {
  name = "spark-master-data-vol"
}

resource "docker_volume" "spark_worker_apps_vol" {
  name = "spark-worker-apps-vol"
}

resource "docker_volume" "spark_worker_data_vol" {
  name = "spark-worker-data-vol"
}

######################################################
# AIRFLOW
######################################################

resource "docker_volume" "airflow_vol" {
  name = "airflow-vol"
}