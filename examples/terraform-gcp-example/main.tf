# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY A CLOUD INSTANCE RUNNING UBUNTU
# See test/terraform_gcp_example_test.go for how to write automated tests for this code.
# ---------------------------------------------------------------------------------------------------------------------

resource "google_compute_instance" "example" {
  name         = "${var.instance_name}"
  machine_type = "${var.machine_type}"
  zone         = "${var.zone}"

  boot_disk {
    initialize_params {
      image = "${data.google_compute_image.ubuntu.self_link}"
    }
  }

  network_interface {
    network = "default"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# LOOK UP THE LATEST UBUNTU 16.04 LTS AMI
# ---------------------------------------------------------------------------------------------------------------------

data "google_compute_image" "ubuntu" {
  family  = "ubuntu-1604-lts"
  project = "ubuntu-os-cloud"
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE A GOOGLE STORAGE BUCKET
# ---------------------------------------------------------------------------------------------------------------------

resource "google_storage_bucket" "example_bucket" {
  name     = "${var.bucket_name}"
  location = "${var.bucket_location}"
}
