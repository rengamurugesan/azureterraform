   # Connect to Azure
   Connect-AzAccount -TenantId e823de87-1173-410f-a37d-96c4083bb170

   # Define variables
   $appName = "SPN-GH-AZ-OIDC-connectivity"
   $orgName = "rengamurugesan"
   $repoName = "azureterraform"
   $environmentName = "connectivity"
   $subscriptionId = "e0930014-caa6-45da-a0d6-5d02bb6e89ff"
   $resourceGroupName = "YourResourceGroupName"

   # Create Azure AD Application
   $app = New-AzADApplication -DisplayName $appName

   # Create Service Principal
   $sp = New-AzADServicePrincipal -ApplicationId $app.AppId

   # Assign Contributor Role to SPN
   $roleDefinition = Get-AzRoleDefinition -Name "Contributor"
   $scope = "/subscriptions/$subscriptionId/resourceGroups/$resourceGroupName"
   New-AzRoleAssignment -ObjectId $sp.Id -RoleDefinitionId $roleDefinition.Id -Scope $scope

   # Create Federated Credential
   $federatedCredential = New-AzADFederatedCredential -ApplicationObjectId $app.ObjectId -Name "GitHubActionCredential" -Issuer "https://token.actions.githubusercontent.com" -Subject "repo:$orgName/$repoName:environment:$environmentName" -Audience "api://AzureADTokenExchange"

   # Output values
   Write-Host "Application (client) ID: $($app.AppId)"
   Write-Host "Tenant ID: $(Get-AzContext).Tenant.Id"
   Write-Host "Service Principal ID: $($sp.Id)"
   Write-Host "Federated Credential ID: $($federatedCredential.Id)"