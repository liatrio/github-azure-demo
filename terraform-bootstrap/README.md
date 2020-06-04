# Environment Bootstrap Terraform

Terraform plan to bootstrap Azure resources. It creates storage for Terraform state for the [Application Terraform](../terraform/README.md) and resource groups for _prod_ and _preview_ environments.

Resources
  - Resource Group: `github-workshop` - Contains storage for Terraform state
  - Resource Group: `github-workshop-prod` - Production environment for realworld app
  - Resource Group: `github-workshop-preview` - Preview environment for realworld app
  - Storage Account: `githubworkshop`
  - Storage Container: `tfstate` - Remote storage to Terraform backend

## Setup

To bootstrap the environment you must be logged into the Azure account with the CLI

```
az login
```

Run Terraform plan

```
terraform apply
```

## Storage access key

To use the storage with the Terraform azurerm backend you need the access key which you cat get from the Terraform state.

```
terraform show -json | jq '.values.root_module.resources[] | select( .type == "azurerm_storage_account" and .name == "storage_account") .values.primary_access_key'
```

See the [Application Terraform](../terraform/README.md) for an example using the access key.

## Import exiting resources

```
terraform import azurerm_resource_group.github_workshop `az group show --name github-workshop | jq -r .id`
terraform import azurerm_resource_group.github_workshop_preview `az group show --name github-workshop-preview | jq -r .id`
terraform import azurerm_resource_group.github_workshop_prod `az group show --name github-workshop-prod | jq -r .id`
terraform import azurerm_storage_account.storage_account `az storage account show --name githubworkshop | jq -r .id`
terraform import azurerm_storage_container.storage_container https://githubworkshop.blob.core.windows.net/tfstate
```

## Azure Service Principal for Terraform

In order for the Github Actions to run Terraform on Azure, they will need 5 Github secrets configured for the repostiory which you can retrieve by running the following command.

```
terraform output -json | jq 'with_entries(.value |= .value)'
```

https://github.com/liatrio/github-azure-demo/settings/secrets

For `ARM_CLIENT_ID, ARM_CLIENT_SECRET, ARM_SUBSCRIPTION_ID, ARM_TENANT_ID`, update each value into its own secret.

For `AZURE_CREDENTIALS`, copy the entire JSON into the secret value.
