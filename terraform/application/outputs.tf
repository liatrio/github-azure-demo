output "resource_group_name" {
  value = data.azurerm_resource_group.github_workshop.name
}

output "sql_server_name" {
  value = azurerm_sql_server.sql_server.name
}

output "backend_app_service_ip_addresses" {
  value = split(",", azurerm_app_service.app_service.possible_outbound_ip_addresses)
}

output "azure_app_hostname" {
  value = azurerm_app_service.app_service.default_site_hostname
}