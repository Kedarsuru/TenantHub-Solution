project_id = "tenanthub-prod"

region = "us-central1"

cloudsql_instance_name = "shared-postgres-instance"

tenants = {
  acme-corp = {
    db_name = "acme_corp_db"
    db_user = "acme_corp_user"
  }
}
