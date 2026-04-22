# Project-level Billing Management
# Note: Full billing administration usually happens at the Billing Account level.
# roles/billing.projectManager allows managing billing for this specific project.

resource "google_project_iam_member" "billing_manager" {
  project = var.project
  role    = "roles/billing.projectManager"
  member  = "user:${var.admin_email}"
}
