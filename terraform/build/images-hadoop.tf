######################################################
# HADOOP SERVICES (HDFS)
######################################################

resource "docker_image" "hadoop_base" {
  name         = "hadoop-base:1.0.0"
  keep_locally = true

  build {
    path = "../../docker/images/hadoop-base/"
    tag  = ["hadoop-base:latest"]

    label = {
      author : "Marc Lamberti"
    }
  }
}

resource "docker_image" "hadoop_namenode" {
  name         = "hadoop-namenode:1.0.0"
  depends_on   = [docker_image.hadoop_base]
  keep_locally = true

  build {
    path = "../../docker/images/hadoop-namenode/"
    tag  = ["hadoop-namenode:latest"]

    label = {
      author : "Marc Lamberti"
    }
  }
}

resource "docker_image" "hadoop_datanode" {
  name         = "hadoop-datanode:1.0.0"
  depends_on   = [docker_image.hadoop_base]
  keep_locally = true

  build {
    path = "../../docker/images/hadoop-datanode/"
    tag  = ["hadoop-datanode:latest"]

    label = {
      author : "Marc Lambert"
    }
  }
}
