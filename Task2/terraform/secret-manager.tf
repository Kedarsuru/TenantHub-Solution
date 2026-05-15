resource "google_secret_manager_secret" "tenant_secret" {
  secret_id = "tenant-acme-corp-credentials"

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "tenant_secret_version" {
  secret = google_secret_manager_secret.tenant_secret.id

  secret_data = jsonencode({
    username = "acme_corp_user"
    password = "super-secret-password"
    database = "acme_corp_db"
  })
}
