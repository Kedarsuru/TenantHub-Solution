resource "random_password" "db_password" {
  length  = 20
  special = true
}

resource "google_sql_database" "tenant_database" {
  name     = var.db_name
  instance = var.cloudsql_instance_name
}

resource "google_sql_user" "tenant_user" {
  name     = var.db_user
  instance = var.cloudsql_instance_name
  password = random_password.db_password.result
}
