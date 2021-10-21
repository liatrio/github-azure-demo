resource "random_password" "sql_admin_pasword" {
  length = 16
}

resource "azurerm_sql_server" "sql_server" {
  name                = "realworld-demo-${var.environment}-${local.branch}"
  resource_group_name = data.azurerm_resource_group.github_workshop.name
  location            = data.azurerm_resource_group.github_workshop.location
  version             = "12.0"

  administrator_login          = "realworld-admin"
  administrator_login_password = random_password.sql_admin_pasword.result

  tags = local.tags
}

resource "azurerm_sql_database" "sql_database" {
  name                             = "realworld"
  resource_group_name              = data.azurerm_resource_group.github_workshop.name
  location                         = data.azurerm_resource_group.github_workshop.location
  server_name                      = azurerm_sql_server.sql_server.name
  edition                          = var.sql_edition
  requested_service_objective_name = var.sql_requested_service_objective_name
  max_size_bytes                   = var.sql_max_size_bytes

  tags = local.tags
}
