# Create the notebook.
resource "google_notebooks_instance" "user_notebook" {
  provider = google
  location = "us-central1-a"
  name = "notebook-${var.name}-user"
  machine_type = "n2d-standard-4"

  vm_image {
    project      = "deeplearning-platform-release"
    image_family = "common-cpu"
  }

  instance_owners = ["admin@yaquino.altostrat.com"]
#   service_account = "my-service-account"

#   install_gpu_driver = true
  boot_disk_type = "PD_SSD"
  boot_disk_size_gb = 100

  no_public_ip = true
  no_proxy_access = false

  network = google_compute_network.vpc.id
  subnet = google_compute_subnetwork.default.id

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot = true
    enable_vtpm = true
  }
}

# resource "google_notebooks_instance" "sa_notebook" {
#   provider = google
#   location = "us-central1-a"
#   name = "notebook-${var.name}-svcacct"
#   machine_type = "n2d-standard-4"

#   vm_image {
#     project      = "deeplearning-platform-release"
#     image_family = "common-cpu"
#   }

# #   instance_owners = ["admin@yaquino.altostrat.com"]
# #   service_account = "my-service-account"

# #   install_gpu_driver = true
#   boot_disk_type = "PD_SSD"
#   boot_disk_size_gb = 100

#   no_public_ip = true
#   no_proxy_access = false

#   network = google_compute_network.vpc.id
#   subnet = google_compute_subnetwork.default.id

#   shielded_instance_config {
#     enable_integrity_monitoring = true
#     enable_secure_boot = true
#     enable_vtpm = true
#   }
# }