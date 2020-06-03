output "ARM_CLIENT_ID" {
  value = azuread_service_principal.github_action_service_principal.application_id
}

output "ARM_CLIENT_SECRET" {
  value = random_password.azuread_sp_password.result
}

output "ARM_SUBSCRIPTION_ID" {
  value = data.azurerm_subscription.primary.subscription_id
}

output "ARM_TENANT_ID" {
  value = data.azurerm_subscription.primary.tenant_id
}