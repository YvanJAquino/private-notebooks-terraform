# Google Cloud Provider
provider "google"  {
    alias = "default"
}

# Attributes include: access_token, project, region, and zone
data "google_client_config" "default" {
    provider = google.default
}

locals {
    project = coalesce(var.project_id, data.google_client_config.default.project)
    region  = coalesce(var.region, data.google_client_config.default.region)
}

# Recreate the provider based on defaults or user-provided variables.
provider "google" {
    project = local.project
    region  = local.region
}

terraform {
  backend "gcs" {
    bucket = "nodal-spot-341618"
    prefix = "terraform"
  }
}

# Enable the compute API
resource "google_project_service" "compute" {
    provider = google
    service  = "compute.googleapis.com"
    disable_on_destroy = false
}
# Enable the Notebooks API
resource "google_project_service" "notebooks" {
    provider = google
    service  = "notebooks.googleapis.com"
    disable_on_destroy = false
}
# Enable the Notebooks API
resource "google_project_service" "iap" {
    provider = google
    service  = "iap.googleapis.com"
    disable_on_destroy = false
}


# # Not working; says I can't use my identity with orgpolicy.googleapis.com
# resource "google_org_policy_policy" "trusted_images" {
#     name   = "projects/${local.project}/policies/compute.trustedImageProjects"
#     parent = "projects/${local.project}"
#     spec {
#         rules {
#             values {
#                 allowed_values = [
#                     "projects/deeplearning-platform-release"
#                 ]
#             }
#         }
#     }
# }