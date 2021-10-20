provider "azurerm" {
  version = "2.10.0"
  features {}
}

locals {
  tags = {
    application = "github-workshop"
    managed_by  = "terraform"
    source      = "https://github.com/liatrio/aspnetcore-realworld-example-app/tree/master/terraform-backend-storage"
  }
}
