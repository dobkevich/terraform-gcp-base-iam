# Standard User Access
# GCP users manage their own credentials via Google Account settings.

resource "google_project_iam_member" "standard_viewer" {
  project = var.project
  role    = "roles/viewer"
  member  = "user:${var.standard_user_email}"
}
