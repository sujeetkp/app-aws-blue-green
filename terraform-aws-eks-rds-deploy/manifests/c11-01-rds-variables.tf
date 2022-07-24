
variable "rds_engine" {
  type = string
  description = "RDS Database Engine"
}

variable "rds_engine_version" {
  type = string
  description = "RDS Database Engine Version"
}

variable "rds_instance_class" {
  type = string
  description = "RDS Database Instance Class"
}

variable "rds_db_name" {
  type = string
  description = "Name of the Database"
}

variable "rds_db_username" {
  type = string
  description = "RDS DB Username to login"
}

variable "rds_db_port" {
  type = number
  description = "RDS DB Port"
}

variable "rds_db_password" {
  type = string
  description = "RDS DB Password"
}
