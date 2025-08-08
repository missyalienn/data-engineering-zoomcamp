# 🌎 Terraforming GCP: Setup & Basics

📺 [Video](https://www.youtube.com/watch?v=Y2ux7gq3Z0o&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb&index=12)

## Setting up a service account on GCP
- Navigate to **IAM & Admin > Service Accounts**.
- Create a service account (e.g., `terraform-runner`).
- Assign roles:
  - `Storage Admin`
  - `BigQuery Admin`
  - `Compute Admin` 
- This service account gives Terraform permission to create/destroy GCP resources.

## 🔐 IMPORTANT: Managing Keys
- Create a key for the service account.
- 🚫 **DO NOT** save key files `(.json)` inside your project repo—period.
- 🚫 **DO NOT** share or commit this file ever. 
- 🔒 Store the key securely (e.g., in a `/keys` directory). Consider upgrading to Vault later.
- Attackers/Bots **hunt github for exposed keys** to spin up $$$ resources and rack up bills in minutes.
- If it somehow gets on github, consider it comprised and REVOKE it asap.  

> ⚠️ Seriously - DO NOT be careless about security and credentials. You will regret it. 


## Creating `main.tf` file
- Install the **Terraform extension** in VS Code 
- Create a `main.tf` file and configure the **Google provider**.
- Use `terraform fmt` to auto-format your file.
- Populate with:
  - Provider config
  - Project ID
  - Region/Zone

## Setting up credentials and providers
- Set the environment variable to authenticate:
  ```bash
  export GOOGLE_CREDENTIALS="/full/path/to/your/creds.json"
- Alternatively, use gcloud auth application-default login.

## Running terraform plan
- Simulates what Terraform will do and shows you the intended changes
- Always READ terraform plan carefully - catch typos, config errors that can lead to unintended outcomes. 

## Running terraform apply
- This applys/deploys the infrastructure to GCP.
- Prompts for confirmation. - You must confirm with a YES to apply (aka deploy). 
- Creates a `terraform.tfstate` file to track resource state.

## Running terraform destroy
- Safely tears down all resources defined in the state file.
- Remember to destroy resources after creating. DO NOT leave resources running. 

## Summary

### GCP + Keys 
- ✅ Set up a GCP service account with scoped, least-privilege permissions.
- 🔐 Never commit or expose your service account JSON keys publicly.
- 🚫 Don’t store key files (.json) inside your project repo—period.
- 🧼 Use a `.gitignore` to exclude all .json files as a safety net.

### Terraform (Deploy)
- 📁 Use `main.tf` with provider and resource definitions.
- 🛠 Use `terraform plan` to preview and `terraform apply` to deploy.
- 💣 Use `terraform destroy` to remove resources cleanly.








