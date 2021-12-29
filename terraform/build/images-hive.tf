######################################################
# HIVE
######################################################

resource "docker_image" "hive_base" {
  name         = "hive-base:1.0.0"
  depends_on   = [docker_image.hadoop_base]
  keep_locally = true

  build {
    path = "../../docker/image/hive-base/"
    tag  = ["hive-base:latest"]

    label = {
      author : "Marc Lamberti"
    }
  }
}

resource "docker_image" "hive_metastore" {
  name         = "hive-metastore:1.0.0"
  depends_on   = [docker_image.hive_base]
  keep_locally = true

  build {
    path = "../../docker/image/hive-metastore/"
    tag  = ["hive-metastore:latest"]

    label = {
      author : "Marc Lamberti"
    }
  }
}

resource "docker_image" "hive_server" {
  name         = "hive-server:1.0.0"
  depends_on   = [docker_image.hive_base]
  keep_locally = true

  build {
    path = "../../docker/image/hive-server/"
    tag  = ["hive-server:latest"]

    label = {
      author : "Marc Lamberti"
    }
  }
}

resource "docker_image" "hive_webhcat" {
  name         = "hive-webhcat:1.0.0"
  depends_on   = [docker_image.hive_base]
  keep_locally = true

  build {
    path = "../../docker/image/hive-webhcat/"
    tag  = ["hive-webhcat:latest"]

    label = {
      author : "Marc Lamberti"
    }
  }
}

resource "docker_image" "hue" {
  name         = "hue:1.0.0"
  keep_locally = true

  build {
    path = "../../docker/image/hue/"
    tag  = ["hue:latest"]

    label = {
      author : "Marc Lamberti"
    }
  }
}