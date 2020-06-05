resource "azurerm_storage_account" "storage_account" {
  name                     = "githubworkshop"
  resource_group_name      = azurerm_resource_group.github_workshop.name
  location                 = azurerm_resource_group.github_workshop.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = local.tags
}

resource "azurerm_storage_container" "storage_container" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"
}