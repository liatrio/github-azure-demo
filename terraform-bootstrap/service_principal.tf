data "azurerm_subscription" "primary" {
}

resource "azuread_service_principal" "github_action" {
    # TODO
}

resource "azurerm_role_definition" "github_action_terraform_role" {
  name        = "GithubActionTerraformRole"
  scope       = data.azurerm_subscription.primary.id
  description = "Role needed for github actions to have access to creating resources"

  permissions {
    actions     = [
        "Microsoft.Web/serverfarms/Read", 
        "Microsoft.Web/serverfarms/Write", 
        "Microsoft.Web/serverfarms/Delete",
        "Microsoft.Web/hostingEnvironments/Read",
        "Microsoft.Web/hostingEnvironments/Write",
        "Microsoft.Web/hostingEnvironments/Delete",
        "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/read",
        "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/write",
        "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/delete",
        "Microsoft.SqlVirtualMachine/register/action",
        "Microsoft.SqlVirtualMachine/unregister/action"
        "Microsoft.Sql/servers/firewallRules/read",
        "Microsoft.Sql/servers/firewallRules/write",
        "Microsoft.Sql/servers/firewallRules/delete",
        "Microsoft.SqlVirtualMachine/sqlVirtualMachines/read",
        "Microsoft.SqlVirtualMachine/sqlVirtualMachines/write",
        "Microsoft.SqlVirtualMachine/sqlVirtualMachines/delete",
    ]
  }

  assignable_scopes = [
    data.azurerm_subscription.primary.id, 
  ]
}

resource "azurerm_role_assignment" "github_action_terraform_role_assignment" {
  scope              = data.azurerm_subscription.primary.id
  role_definition_id = azurerm_role_definition.github_action_terraform_role.id
  principal_id       = data.azurerm_client_config.github_action.object_id
  depends_on         = [azurerm_client_config.github_action]
}

