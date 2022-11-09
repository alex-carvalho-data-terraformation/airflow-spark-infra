######################################################
# SPARK SERVICES
######################################################

resource "docker_image" "spark_base" {
  name         = "spark-base:2.0.0"
  depends_on   = [docker_image.hive_base]
  keep_locally = true

  build {
    path = "../../docker/image/spark-base/"
    tag  = ["spark-base:latest", "spark-base:2.0.0"]

    label = {
      author : "alex carvalho"
    }
  }
}

resource "docker_image" "spark_master" {
  name         = "spark-master:2.0.0"
  depends_on   = [docker_image.spark_base]
  keep_locally = true

  build {
    path = "../../docker/image/spark-master/"
    tag  = ["spark-master:latest", "spark-master:2.0.0"]

    label = {
      author : "alex carvalho"
    }
  }
}

resource "docker_image" "spark_worker" {
  name         = "spark-worker:2.0.0"
  depends_on   = [docker_image.spark_base]
  keep_locally = true

  build {
    path = "../../docker/image/spark-worker/"
    tag  = ["spark-worker:latest", "spark-worker:2.0.0"]

    label = {
      author : "alex carvalho"
    }
  }
}

resource "docker_image" "livy" {
  name         = "livy:1.0.0"
  keep_locally = true

  build {
    path = "../../docker/image/livy/"
    tag  = ["livy:latest"]

    label = {
      author : "alex carvalho"
    }
  }
}
