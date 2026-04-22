# GCP IAM & CI/CD Bootstrap with Terraform

This project provides a robust foundation for managing Google Cloud Platform (GCP) Identity and Access Management (IAM) using Terraform. It is designed to implement best practices for security, including Workload Identity Federation (WIF) for GitHub Actions, eliminating the need for static JSON service account keys.

## Features

- **Human Administrator Access**: Configures granular permissions for human admins (Editor and Project IAM Admin roles).
- **Automation Service Account**: Creates a dedicated `project-admin-sa` Service Account for CI/CD and automation tasks.
- **Service Account Impersonation**: Sets up secure impersonation for human users, allowing them to act as the Service Account without downloading keys.
- **Workload Identity Federation (Optional)**: Provides a template to securely link GitHub Actions with GCP via OIDC.
- **Billing & Standard User Roles**: Includes predefined configurations for billing management and read-only viewer access.

## Project Structure

- `iam_admin.tf`: Defines human admin access and the primary automation Service Account.
- `iam_billing.tf`: Manages billing-specific permissions at the project level.
- `iam_standard.tf`: Sets up standard viewer access for non-admin users.
- `iam_cicd.tf.template`: A template for setting up Workload Identity Federation for GitHub.
- `variables.tf`: Centralized variable definitions.
- `cicd_github_action.yaml`: A sample GitHub Actions workflow for GCP deployment.

## Prerequisites

1.  **Google Cloud Project**: You must have an existing GCP Project ID.
2.  **Terraform**: Version 1.0 or higher installed locally.
3.  **GCP Credentials**: Authenticated via `gcloud auth application-default login`.

## Getting Started

### 1. Configure Variables
Create a `terraform.tfvars` file (this file is ignored by git) and provide your project-specific values:

```hcl
project             = "your-project-id"
region              = "europe-north2"
zone                = "europe-north2-b"
admin_email         = "admin@example.com"
standard_user_email = "user@example.com"
github_repository   = "your-username/your-repo"
```

### 2. Initialize and Apply
Run the following commands to set up the base IAM infrastructure:

```bash
terraform init
terraform apply
```

## GitHub CI/CD Integration (Optional)

If you want to enable secure GitHub Actions integration:

1.  **Enable the Configuration**: Rename `iam_cicd.tf.template` to `iam_cicd.tf`.
2.  **Configure Repository**: Ensure `github_repository` in `terraform.tfvars` matches your GitHub repo (e.g., `octocat/hello-world`).
3.  **Apply Changes**: Run `terraform apply` again. This will create a Workload Identity Pool and Provider.
4.  **GitHub Workflow**: Use the `cicd_github_action.yaml` as a reference for your GitHub Actions workflow. You will need to use the `workload_identity_provider` output from Terraform in your GitHub Action configuration.

## Security Notes

- **No JSON Keys**: This project adheres to the `iam.disableServiceAccountKeyCreation` constraint. Always use Workload Identity Federation or Service Account Impersonation.
- **Principle of Least Privilege**: While this project uses the `Editor` role for simplicity in bootstrapping, it is recommended to narrow down permissions as your project matures.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
