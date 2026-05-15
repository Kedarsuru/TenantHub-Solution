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

resource "google_service_account" "tenant_gsa" {
  account_id   = "acme-corp-gsa"
  display_name = "GSA for acme-corp tenant"
}

resource "google_secret_manager_secret_iam_member" "secret_accessor" {
  secret_id = google_secret_manager_secret.tenant_secret.id
  role      = "roles/secretmanager.secretAccessor"

  member = "serviceAccount:${google_service_account.tenant_gsa.email}"
}

resource "google_service_account_iam_member" "workload_identity_binding" {
  service_account_id = google_service_account.tenant_gsa.name

  role = "roles/iam.workloadIdentityUser"

  member = "serviceAccount:PROJECT_ID.svc.id.goog[acme-corp/acme-corp-sa]"
}
