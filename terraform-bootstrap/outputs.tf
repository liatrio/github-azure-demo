output "clientId" {
  value = azuread_service_principal.github_action_service_principal.application_id
}

output "clientSecret" {
  value = random_password.azuread_sp_password.result
}

output "subscriptionId" {
  value = data.azurerm_subscription.primary.subscription_id
}

output "tenantId" {
  value = data.azurerm_subscription.primary.tenant_id
}