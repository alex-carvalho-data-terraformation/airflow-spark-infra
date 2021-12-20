######################################################
# SPARK SERVICES
######################################################

resource "docker_image" "spark_base" {
  name         = "spark-base:1.0.0"
  depends_on   = [docker_image.hive_base]
  keep_locally = true

  build {
    path = "../../docker/images/spark-base/"
    tag  = ["spark-base:latest"]

    label = {
      author : "Marc Lamberti"
    }
  }
}

resource "docker_image" "spark_master" {
  name         = "spark-master:1.0.0"
  depends_on   = [docker_image.spark_base]
  keep_locally = true

  build {
    path = "../../docker/images/spark-master/"
    tag  = ["spark-master:latest"]

    label = {
      author : "Marc Lamberti"
    }
  }
}

resource "docker_image" "spark_worker" {
  name         = "spark-worker:1.0.0"
  depends_on   = [docker_image.spark_base]
  keep_locally = true

  build {
    path = "../../docker/images/spark-worker/"
    tag  = ["spark-worker:latest"]

    label = {
      author : "Marc Lamberti"
    }
  }
}

resource "docker_image" "livy" {
  name         = "livy:1.0.0"
  keep_locally = true

  build {
    path = "../../docker/images/livy/"
    tag  = ["livy:latest"]

    label = {
      author : "Marc Lamberti"
    }
  }
}
