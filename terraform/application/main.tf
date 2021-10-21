provider "azurerm" {
  version         = "2.10.0"
  subscription_id = var.ARM_SUBSCRIPTION_ID
  client_id       = var.ARM_CLIENT_ID
  client_secret   = var.ARM_CLIENT_SECRET
  tenant_id       = var.ARM_TENANT_ID
  features {}
}

data "azurerm_resource_group" "github_workshop" {
  name = "github-workshop-${var.environment}"
}

locals {
  sql_connection_string = "Server=tcp:${azurerm_sql_server.sql_server.fully_qualified_domain_name},1433;Database=${azurerm_sql_database.sql_database.name};User ID=${azurerm_sql_server.sql_server.administrator_login};Password=${tostring(azurerm_sql_server.sql_server.administrator_login_password)};Encrypt=true;Connection Timeout=30;"
  tags = {
    application = "realworld-demo-${var.environment}-${var.branch}"
    managed_by  = "terraform"
    source      = "https://github.com/liatrio/aspnetcore-realworld-example-app/tree/master/terraform"
  }
  branch = replace(var.branch, ".", "")
}
