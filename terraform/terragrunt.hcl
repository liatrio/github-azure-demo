locals {
  environment = get_env("ENVIRONMENT", "preview")
  branch      = get_env("BRANCH", "master")
}

remote_state {
  backend = "azurerm"
  generate = {
    path      = "terragrunt-backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    resource_group_name  = "github-workshop"
    storage_account_name = "githubworkshop"
    container_name       = "tfstate"
    key                  = "${local.environment}/${local.branch}/${path_relative_to_include()}-terraform.tfstate"
  }
}

skip = true

terraform {
  extra_arguments "common_vars" {
    commands = ["plan", "apply", "destroy"]

    arguments = [
      "-var", "environment=${local.environment}",
      "-var", "branch=${local.branch}"
    ]
  }
}
