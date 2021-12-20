######################################################
# DATABASE SERVICE
######################################################

resource "docker_image" "postgres" {
  name         = "postgres-hive:1.0.0"
  keep_locally = true
}

resource "docker_image" "adminer" {
  name         = "wodby/adminer:latest"
  keep_locally = true
}