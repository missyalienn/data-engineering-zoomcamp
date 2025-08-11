terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.47.0"
    }
  }
}

provider "google" {
  project     = "nyc-taxi-data-eng"
  region      = "us-central1"
}