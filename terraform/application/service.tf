resource "azurerm_app_service_plan" "service_plan" {
  name                = "github-workshop-${var.environment}-${local.branch}"
  location            = data.azurerm_resource_group.github_workshop.location
  resource_group_name = data.azurerm_resource_group.github_workshop.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = var.service_plan_tier
    size = var.service_plan_size
  }

  tags = local.tags
}

resource "azurerm_app_service" "app_service" {
  name                = "realworld-demo-${var.environment}-${local.branch}"
  location            = data.azurerm_resource_group.github_workshop.location
  resource_group_name = data.azurerm_resource_group.github_workshop.name
  app_service_plan_id = azurerm_app_service_plan.service_plan.id
  site_config {
    dotnet_framework_version = "v4.0"
    linux_fx_version         = "DOTNETCORE|3.1"
    scm_type                 = var.service_app_scm_type
  }

  app_settings = {
    "WEBSITES_PORT"                       = "5000"
    "PORT"                                = "5000"
    "ASPNETCORE_Conduit_DatabaseProvider" = "sqlserver"
    "ASPNETCORE_Conduit_ConnectionString" = local.sql_connection_string
  }

  tags = local.tags
}
