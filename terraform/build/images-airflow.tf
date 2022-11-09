######################################################
# AIRFLOW
######################################################

resource "docker_image" "airflow" {
  name         = "airflow:1.1.0"
  depends_on   = [docker_image.spark_base]
  keep_locally = true

  build {
    path = "../../docker/image/airflow/"
    tag  = ["airflow:latest"]

    label = {
      author : "alex carvalho"
    }
  }
}