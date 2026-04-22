output "project_id" {
  value = var.project
}

output "admin_service_account_email" {
  description = "The email of the created admin service account"
  value       = google_service_account.project_admin_sa.email
}

output "admin_user" {
  value = var.admin_email
}

output "instructions" {
  value = <<-EOT
    1. Human Admin (${var.admin_email}) has 'Editor', 'Project IAM Admin' and 'Billing Project Manager' roles.
    2. Standard User (${var.standard_user_email}) has 'Viewer' role.
    3. Service Account '${google_service_account.project_admin_sa.email}'
       has 'Editor' and 'Project IAM Admin' roles.
    4. To use a Service Account, use impersonation instead of JSON Keys (they are less secure and may be disabled).
    5. To use the Service Account via CLI (after terraform apply):
       gcloud config set auth/impersonate_service_account ${google_service_account.project_admin_sa.email}

       After this, all your 'gcloud' and 'terraform' commands will run
       as if you were that Service Account, with its permissions.

       Check:
       gcloud config list
       curl -H "Authorization: Bearer $(gcloud auth print-access-token)" https://www.googleapis.com/oauth2/v3/userinfo

       Leave impersonation mode:
       gcloud config unset auth/impersonate_service_account
    EOT
}
