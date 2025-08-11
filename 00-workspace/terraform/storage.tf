#Defines Google Cloud Storage Resources. Add storage resource blocks here. 

resource "google_storage_bucket" "nyc-taxi-bucket" { 
  name          = "nyc-taxi-data-eng-bucket" 
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