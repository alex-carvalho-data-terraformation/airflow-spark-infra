######################################################
# SPARK SERVICES
######################################################

resource "docker_image" "spark_master" {
  name         = "spark-master:2.0.0"
  keep_locally = true
}

resource "docker_image" "spark_worker" {
  name         = "spark-worker:2.0.0"
  keep_locally = true
}

resource "docker_image" "livy" {
  name         = "livy:1.0.0"
  keep_locally = true
}
