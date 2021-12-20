######################################################
# AIRFLOW
######################################################

resource "docker_image" "airflow" {
  name         = "airflow:1.1.0"
  keep_locally = true
}