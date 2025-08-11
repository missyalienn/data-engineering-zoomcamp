# 🌎 Terraform with GCP: Setup & Basics

📺 [Video](https://www.youtube.com/watch?v=Y2ux7gq3Z0o&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb&index=12)

> ⚠️ **Note: Security Risks of Using Service Account Keys**  
> - The tutorial shows how to authenticate by creating a service account and downloading a key.  
> - This method is **NOT recommended by Google** due to the inherent security risks of long-lived JSON keys.   
> - See Appendix and docs for more info. 
>
> ✅ Luckily, there are several better, safer ways to authenticate!
> - I chose Google Cloud CLI Application Default Credentials approach -  which lets you authenticate using your Google user account.
> - See [Google Cloud Auth Methods Decision Tree](https://cloud.google.com/docs/authentication#auth-decision-tree)
> 

## Authenticate Using Google Cloud CLI (Recommended)

- Google recommends authenticating with **Google Cloud CLI** esp for local dev. [Application Default Credentials (ADC)](https://cloud.google.com/docs/authentication/provide-credentials-adc)
- First, install the **Google Cloud SDK** to interact with GCP from the terminal.
- Make sure your Google user account has the necessary permissions for the project, such as: Storage Admin, BigQuery Admin, Compute Admin
- Run this command to authenticate (it will open a Google sign-in page): ```gcloud auth application-default login``` 

#### 👍 Nice! Now we'll configure Terraform and use it to plan, provision, and destroy some cloud resources on GCP. 

## Set up Terraform & Configure Google Provider 
*Make sure you have downloaded Terraform and installed the VSCode Terraform extension first*

- Create a `main.tf` file 
- Configure the Google provider in `main.tf` using the docs:[Terraform Docs - Google Cloud Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
- Click **'Use this provider'** and copy the code snippet provided by Terraform
``` python
provider "google" {
  project     = "my-project-id"
  region      = "us-central1"
  }
```
## Configure Google Cloud Storage Bucket 
- Add a **Google Cloud Storage bucket** resource to `main.tf`.
- Use docs as a reference: [Terraform docs: Storage Bucket Example Lifecycle Settings](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket#lifecycle_rule)
- Update the **local name** (`auto-expire`) to your project ID — e.g., `nyc-taxi-data-eng`.
- The **`name`** field must be globally unique. Using your project ID often works since it’s already unique.
- The `lifecycle_rule` block below deletes objects after 3 days (`age = 3`). Remove it if you don’t want automatic deletion.
- The second `lifecycle_rule` block aborts incomplete uploads after 1 day (`age = 1`).
- After editing, run this `terraform fmt` command to format the file 

**Example** 
 ``` python
resource "google_storage_bucket" "auto-expire" {
  name          = "auto-expiring-bucket"
  location      = "US"
  force_destroy = true
  lifecycle_rule {
    condition { age = 3 }
    action { type = "Delete" }
  }
  lifecycle_rule {
    condition { age = 1 }
    action { type = "AbortIncompleteMultipartUpload" }
  }
}
```
## Run terraform plan
- **Purpose:** Simulates what Terraform will do and shows the intended changes **before** they are made.
- **Why it matters:** Always read the `terraform plan` output carefully to catch typos, misconfigurations, or unintended actions. 
- If something in the plan looks suspicious (e.g., resources being destroyed when you only expected updates), stop and fix before proceeding.

## Run terraform apply
- **Purpose:** Provisions or updates infrastructure resources defined in your .tf configuration files.
- Runs an implicit `terraform plan` first. Shows you the proposed changes and prompts for confirmation. 
- You must type `yes` (in lowercase) to proceed.
- Boom, that's it. Terraform provisions the resources and creates/updates the terraform state file. 
- You can check in Google Cloud Console to see that the bucket was successfully created. 

#### Terraform State File 
- **What it is:** A JSON file that stores the current state of your infrastructure as Terraform knows it.
  - Tracks which real-world resources map to your Terraform config.
  - Needed for Terraform to perform incremental updates instead of recreating everything.
  - **Important:** Do **not** manually edit this file.
   
## Run terraform destroy
- Purpose: Removes all infrastructure resources managed by your current Terraform configuration.  
- Use to shut down resources when no longer needed. Helps avoid unnecessary cloud costs.  
- Run `terraform destroy` and Terraform will show you an overview of the resources that will be destroyed.  
- You must confirm by typing `yes`. All cloud resources tracked in the current state file will be destroyed.  
- Once destroyed, Terraform creates a backup of the state file named `terraform.tfstate.backup`.  

### ✅ And... that's it. 


We've successfully used Terraform with GCP to provision and destroy cloud resources.

---
## Docs
- [Google Cloud -  Authentication for Terraform](https://cloud.google.com/docs/terraform/authentication)
- [Terraform - Authentication for Google Cloud](https://cloud.google.com/docs/terraform/authentication)
- [Terraform - Google Cloud Provider ](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
- [Terraform - Google Cloud Storage Bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket)  
- [Terraform - GCP Get Started Guide](https://learn.hashicorp.com/collections/terraform/gcp-get-started)  
- [Google Cloud Developers Docs](https://cloud.google.com/developers)  
- [GCP Service Account Overview](https://cloud.google.com/iam/docs/service-account-overview)


## Appendix  
### ⚠️ Service Account Key Risks  
- Downloading keys is almost never necessary—safer alternatives exist. Read the docs!   
- JSON keys are long-lived credentials granting ongoing access until revoked.  
- Attackers scan GitHub for exposed keys, which can quickly lead to costly cloud bills or data loss.  
- If a key leaks to GitHub, consider it compromised and **revoke it IMMEDIATELY**.
--- 

#### Creating Service Account + Key
> *For Reference only — not best practice* 
- Navigate to **IAM & Admin > Service Accounts** to create a service account (e.g., `terraform-runner`). 
- Assign the required roles for the project  `Storage Admin`, `BigQuery Admin`, `Compute Admin`.  
- Generate a key for authentication.  
- Do **not** store keys inside your project repo. Store it in a local directory.  
- Add `.json` files to `.gitignore` as a safeguard.  
-  Never commit or expose JSON key files publicly.  
