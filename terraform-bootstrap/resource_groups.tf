resource "azurerm_resource_group" "github_workshop" {
  name     = "github-workshop"
  location = var.location
}

resource "azurerm_resource_group" "github_workshop_ado_prod" {
  name     = "github-workshop-ado-prod"
  location = var.location
}

resource "azurerm_resource_group" "github_workshop_prod" {
  name     = "github-workshop-prod"
  location = var.location
}

resource "azurerm_resource_group" "github_workshop_preview" {
  name     = "github-workshop-preview"
  location = var.location
}
