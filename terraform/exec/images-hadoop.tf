######################################################
# HADOOP SERVICES (HDFS)
######################################################

resource "docker_image" "hadoop_namenode" {
  name         = "hadoop-namenode:1.0.0"
  keep_locally = true
}

resource "docker_image" "hadoop_datanode" {
  name         = "hadoop-datanode:1.0.0"
  keep_locally = true
}
