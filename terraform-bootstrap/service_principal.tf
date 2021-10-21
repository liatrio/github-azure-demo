data "azurerm_subscription" "primary" {
}

resource "azuread_service_principal" "github_action_service_principal" {
  application_id               = azuread_application.github_action_demo.application_id
  app_role_assignment_required = false
}

resource "azuread_service_principal_password" "github_action_service_principal_password" {
  service_principal_id = azuread_service_principal.github_action_service_principal.id
}

resource "azuread_application" "github_action_demo" {
  display_name = "github-action-demo"
}

resource "azurerm_role_definition" "github_action_terraform_role" {
  name        = "github-action-terraform-role"
  scope       = data.azurerm_subscription.primary.id
  description = "Role needed for github actions to have access to creating resources"

  permissions {
    actions = [
      "Microsoft.Web/serverfarms/read",
      "Microsoft.Web/serverfarms/write",
      "Microsoft.Web/serverfarms/delete",
      "Microsoft.Sql/servers/databases/read",
      "Microsoft.Sql/servers/databases/write",
      "Microsoft.Sql/servers/databases/delete",
      "Microsoft.Sql/servers/firewallRules/read",
      "Microsoft.Sql/servers/firewallRules/write",
      "Microsoft.Sql/servers/firewallRules/delete",
      "Microsoft.Resources/subscriptions/resourcegroups/read",
      "Microsoft.Sql/servers/read",
      "Microsoft.Sql/servers/write",
      "Microsoft.Sql/servers/delete",
      "Microsoft.Sql/servers/connectionPolicies/write",
      "Microsoft.Sql/servers/connectionPolicies/read",
      "Microsoft.Sql/servers/extendedAuditingSettings/read",
      "Microsoft.Sql/servers/extendedAuditingSettings/write",
      "Microsoft.Sql/servers/databases/azureAsyncOperation/read",
      "Microsoft.Sql/servers/databases/securityAlertPolicies/write",
      "Microsoft.Sql/servers/databases/extendedAuditingSettings/read",
      "Microsoft.Sql/servers/databases/extendedAuditingSettings/write",
      "Microsoft.Web/sites/read",
      "Microsoft.Web/sites/write",
      "Microsoft.Web/sites/delete",
      "Microsoft.Web/sites/config/read",
      "Microsoft.Web/sites/config/write",
      "Microsoft.Web/sites/config/list/action",
      "Microsoft.Web/sites/sourcecontrols/read",
      "Microsoft.Web/sites/sourcecontrols/write",
      "Microsoft.Web/sites/publishxml/action",
    ]
  }

  assignable_scopes = [
    data.azurerm_subscription.primary.id,
  ]
}

resource "azurerm_role_assignment" "github_action_terraform_role_assignment" {
  scope              = data.azurerm_subscription.primary.id
  role_definition_id = azurerm_role_definition.github_action_terraform_role.id
  principal_id       = azuread_service_principal.github_action_service_principal.object_id
}
