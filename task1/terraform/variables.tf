variable "project_id" {}
variable "region" {}
variable "cloudsql_instance_name" {}

variable "tenants" {
  type = map(object({
    db_name = string
    db_user = string
  }))
}
