# 1. Human Admin Access
# Note: Using roles/editor instead of roles/owner for external users 
# to comply with GCP Organization policies (ORG_MUST_INVITE_EXTERNAL_OWNERS).
resource "google_project_iam_member" "human_admin" {
  project = var.project
  role    = "roles/editor"
  member  = "user:${var.admin_email}"
}

# Grant IAM management rights to the human admin
resource "google_project_iam_member" "human_iam_admin" {
  project = var.project
  role    = "roles/resourcemanager.projectIamAdmin"
  member  = "user:${var.admin_email}"
}

# 2. Service Account for programmatic access
resource "google_service_account" "project_admin_sa" {
  account_id   = "project-admin-sa"
  display_name = "Project Administrator Service Account"
  description  = "SA with Editor and IAM Admin permissions for automation/CLI"
}

# Assign Editor role to the Service Account
resource "google_project_iam_member" "sa_editor_binding" {
  project = var.project
  role    = "roles/editor"
  member  = "serviceAccount:${google_service_account.project_admin_sa.email}"
}

# Assign IAM Admin role to the Service Account (to manage permissions)
resource "google_project_iam_member" "sa_iam_admin_binding" {
  project = var.project
  role    = "roles/resourcemanager.projectIamAdmin"
  member  = "serviceAccount:${google_service_account.project_admin_sa.email}"
}

# 3. Allow Human Admin to IMPERSONATE this Service Account
# This is the modern replacement for JSON keys when keys are disabled.
resource "google_service_account_iam_member" "admin_impersonates_sa" {
  service_account_id = google_service_account.project_admin_sa.name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "user:${var.admin_email}"
}
