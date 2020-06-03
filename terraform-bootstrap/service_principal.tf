data "azurerm_subscription" "primary" {
}

resource "azuread_service_principal" "github_action_service_principal" {
  application_id = azuread_application.github_action_demo.application_id
}

resource "azuread_service_principal_password" "github_action_service_principal_password" {
  service_principal_id = azuread_service_principal.github_action_service_principal.id
  value                = random_password.azuread_sp_password.result
  end_date_relative    = "240h"
}

resource "random_password" "azuread_sp_password" {
  length  = 10
  special = false
}

resource "azuread_application" "github_action_demo" {
  name = "github-action-demo"
}

resource "azurerm_role_definition" "github_action_terraform_role" {
  name        = "github-action-terraform-role"
  scope       = data.azurerm_subscription.primary.id
  description = "Role needed for github actions to have access to creating resources"

  permissions {
    actions     = [
        "Microsoft.Web/serverfarms/Read", 
        "Microsoft.Web/serverfarms/Write", 
        "Microsoft.Web/serverfarms/Delete",
#        "Microsoft.Web/hostingEnvironments/Read",
#        "Microsoft.Web/hostingEnvironments/Write",
#        "Microsoft.Web/hostingEnvironments/Delete",
#        "Microsoft.SqlVirtualMachine/register/action",
#        "Microsoft.SqlVirtualMachine/unregister/action",
#        "Microsoft.Sql/servers/firewallRules/read",
#        "Microsoft.Sql/servers/firewallRules/write",
#        "Microsoft.Sql/servers/firewallRules/delete",
#        "Microsoft.SqlVirtualMachine/sqlVirtualMachines/read",
#        "Microsoft.SqlVirtualMachine/sqlVirtualMachines/write",
#        "Microsoft.SqlVirtualMachine/sqlVirtualMachines/delete",
        "Microsoft.Resources/subscriptions/resourcegroups/read",
        "Microsoft.Sql/servers/read",
        "Microsoft.Sql/servers/write",
        "Microsoft.Sql/servers/delete",
        "Microsoft.Sql/servers/connectionPolicies/write",
        "Microsoft.Sql/servers/connectionPolicies/read",
        "Microsoft.Sql/servers/extendedAuditingSettings/read",
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
