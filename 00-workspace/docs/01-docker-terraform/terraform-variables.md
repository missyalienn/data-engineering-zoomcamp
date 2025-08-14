# Variables Overview  
- Terraform Variables & Project IDs  
- What is a Variable Block?  
- What is a Resource Block?  
- Setting up variables.tf + Tutorial Video  

## Terraform Variables & Project ID Basics  
- Terraform variables make your configurations flexible by letting you customize values—like project IDs or resource names—without changing the code every time.  
- These variables are defined in a `variables.tf` file as placeholders you fill in when deploying resources.

## Variable Block  
- Defines an input variable with arguments like `description`, `type`, and `default`.  
- If a `default` is set, Terraform uses it unless you provide another value.  
- Best practice: Use defaults for common settings like region (`"us-central1"`), location (`"US"`), or storage class (`"STANDARD"`).  
- Avoid defaults for project- or resource-specific names to prevent accidental reuse.

```hcl
variable "gcs_bucket_name" {
  description = "Unique name for GCS bucket (required)"
  type        = string
  default     = "nyc_taxi_test_bucket"}
```
- For now, we include defaults for project-specific values `gcs_bucket_name` for simplicity, but later will switch to using `terraform.tfvars` or CLI/env var overrides.


## Resource Blocks  
- A resource block defines a specific cloud or infrastructure object you want to create or manage, like a storage bucket or dataset.
```python
resource "google_bigquery_dataset" "nyc_taxi_dataset" {
  dataset_id = var.bq_dataset_name
  location   = var.location
}
```
- **google_bigquery_dataset**:  Official GCP resource type — tells Terraform what kind of resource to create.
- **nyc_taxi_dataset**: The resource label used by Terraform (also called local name or Terraform resource label).
- **dataset_id**  The actual name you want the BigQuery dataset to have in GCP.
- **location:** The geographic location where dataset will be created (e.g., "US").

# Setting Up Terraform Variables  
🎥 [Video](https://www.youtube.com/watch?v=PBi0hHjLftk&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb&index=14)

## Create variables.tf File  
- Create the variables.tf file.  
- Read about variables here: https://developer.hashicorp.com/terraform/language/values/variables  
- Define variables for:  
  - gcp_project_id  
  - location  
  - region  
  - gcs_bucket_name  
  - gcs_storage_class  
  - bq_dataset_name  

## Update Resource Blocks With Variables  
- Go back to main.tf and update the storage bucket resource block with the new variables.  
- Create a resource block for BigQuery dataset using variables we just defined.  
- Run terraform plan and terraform apply to provision the resources (cloud storage bucket and BigQuery dataset).  
- Run terraform destroy to tear it all down when done.  

## Optional: Terraform file() Function  
- The tutorial covers using the file() function to load service account credentials as a variable.  
- We skip this because we authenticate using the gcloud CLI application default login.  
- Look up the file() function in Terraform docs to understand its use cases.
