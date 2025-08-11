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


resource "google_storage_bucket" "nyc-taxi-bucket" { #local name of the bucket 
  name          = "nyc-taxi-data-eng-terra-bucket" #provide unique name for the bucket - can use projectid
  location      = "US"
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 3 #age in days
    }
    action {
      type = "Delete"
    }
  }

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}