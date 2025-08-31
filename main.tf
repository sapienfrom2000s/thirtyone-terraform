terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.0.1"
    }
  }
}

provider "google" {
  project = "flash-469615"
  zone    = "asia-south1-a"
  region  = "asia-south1"
}

resource "google_compute_address" "static_ip" {
  name   = "thirtyone-static-ip"
  region = "asia-south1"
}

resource "google_compute_instance" "vm" {
  provider     = google
  name         = "rio-fire"
  machine_type = "e2-medium"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.static_ip.address
    }
  }
}
