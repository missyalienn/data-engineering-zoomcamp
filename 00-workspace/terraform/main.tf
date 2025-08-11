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

resource "google_storage_bucket" "nyc-taxi-bucket" { 
  name          = var.gcs_bucket_name
  location      = var.location
  storage_class = var.gcs_storage_class
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}

resource "google_bigquery_dataset" "nyc_taxi_dataset" {
  dataset_id = var.bq_dataset_name
  location   = var.location
}