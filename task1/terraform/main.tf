module "tenant_databases" {
  source = "./modules/tenant-db"

  for_each = var.tenants

  tenant_name            = each.key
  db_name                = each.value.db_name
  db_user                = each.value.db_user
  cloudsql_instance_name = var.cloudsql_instance_name
}
