
variable "gcp_project_id" {
  description = "GCP project ID ('my-project-123') where resources will be created"
  type        = string
}

variable "location" {
  description = "Project Location"
  type        = string
  default     = "US"
}

variable "region" {
  description = "GCP region for resources"
  type        = string
  default     = "us-central1"
}

variable "gcs_bucket_name" {
  description = "Unique name for the GCS bucket (required)"
  type        = string
}

variable "bq_dataset_name" {
  description = "BigQuery dataset name (required)"
  type        = string
}

variable "gcs_storage_class" {
    description = "Storage class for the bucket"
    type        = string
    default     = "STANDARD"
}