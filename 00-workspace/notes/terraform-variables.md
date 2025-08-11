
## Terraform Variables File 
# TO DO: 
 - create variables.tf and declare all inputs your resources will use.  
 - the tutorial puts all the resource blocks in main.tf but its getting way too long to scroll 
 - so we'll break up the resources into separate files for storage, big query, compute to keep things clean

## Overview of Terraform Config

- main.tf — keep your terraform {} and provider {} blocks (or split later)
- variables.tf — declare inputs
- storage.tf - create bucket resources using variables 
- bigquery.tf create bigquery resoruces using variables 
- compute.tf - we haven't done anything with this yet but will udpate it when time comes 


### Variables.tf 
- Create variables.tf file 
- Read up on variables in the docs: https://developer.hashicorp.com/terraform/language/values/variables
  

- Make variables for: 
  - location
  - project 
  - big query dataset name 
  - google cloud storage bucket name 
  - gcs storage class 

- Each variable should have values for "description" and "default"
- Read the docs and look at Terraforms examples to understand 


### Configure variables in main.tf 
- Go back to main.tf and update hardcoded values with variables we just defined 
- Run terraform plan and apply to provision the resources (should be a big query dataset)
- Run terraform destroy to tear it all down. 
- That's it. 

### Terraform file function 
- The tutorial then goes through using terraform file function to set a variable for credentials (service account key creds)
- We are not doing that bc we authenticate using gcloud cli application default login. 
- Look up the terraform file function in the docs to get a better understanding of its use cases 



# Variables Template


# Project ID
variable "project_id" {
  description = "The GCP project ID where resources will be created."
  type        = string
}

# Region
variable "region" {
  description = "The GCP region for resources."
  type        = string
  default     = "us-central1"
}

# Zone (optional if your resources are region-based)
variable "zone" {
  description = "The GCP zone for resources."
  type        = string
  default     = "us-central1-a"
}

# Environment name (dev, staging, prod, etc.)
variable "environment" {
  description = "Deployment environment name."
  type        = string
  default     = "dev"
}

# Labels (tags) for resources
variable "labels" {
  description = "A map of labels to apply to resources."
  type        = map(string)
  default = {
    managed_by  = "terraform"
    environment = "dev"
  }
}