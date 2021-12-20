######################################################
# HIVE
######################################################

resource "docker_image" "hive_metastore" {
  name         = "hive-metastore:1.0.0"
  keep_locally = true
}

resource "docker_image" "hive_server" {
  name         = "hive-server:1.0.0"
  keep_locally = true
}

resource "docker_image" "hive_webhcat" {
  name         = "hive-webhcat:1.0.0"
  keep_locally = true
}

resource "docker_image" "hue" {
  name         = "hue:1.0.0"
  keep_locally = true
}