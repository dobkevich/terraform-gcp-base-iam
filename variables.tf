variable "project" {
  description = "The GCP Project ID"
  type        = string
}

variable "region" {
  description = "Default region"
  type        = string
  default     = "europe-north2"
}

variable "zone" {
  description = "Default zone"
  type        = string
  default     = "europe-north2-b"
}

variable "admin_email" {
  description = "Email of the human administrator"
  type        = string
}

variable "standard_user_email" {
  description = "Email of a standard viewer user"
  type        = string
}

variable "github_repository" {
  description = "The GitHub repository in 'owner/repo' format"
  type        = string
  default     = "your-org/your-repo"
}
