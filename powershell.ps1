   # Connect to Azure
   Connect-AzAccount -TenantId e823de87-1173-410f-a37d-96c4083bb170

   # Define variables
   $appName = "spn-gh-oidc-conn-build"
   $orgName = "rengamurugesan"
   $repoName = "azureterraform"
   $environmentName = "connectivity-build"
   $subscriptionId = "e0930014-caa6-45da-a0d6-5d02bb6e89ff"
   

   # Create Azure AD Application
   if (-not (Get-AzADApplication -DisplayName $appName -ErrorAction SilentlyContinue)) {
       Write-Host "Creating Azure AD Application: $appName"
       $app = New-AzADApplication -DisplayName $appName
   } else {
       Write-Host "Azure AD Application '$appName' already exists."
       exit
   }
   
   

   # Create Service Principal
    if (-not (Get-AzADServicePrincipal -DisplayName $appName -ErrorAction SilentlyContinue)) {
         Write-Host "Creating Service Principal for Application: $appName"
         $sp = New-AzADServicePrincipal -ApplicationId $app.AppId
    } else {
         Write-Host "Service Principal for '$appName' already exists."
         exit
    }
   
   

   # Assign Contributor Role to SPN
   $roleDefinition = Get-AzRoleDefinition -Name "Contributor"
    if (-not $roleDefinition) {
         Write-Error "Role definition 'Contributor' not found."
         exit
    }
   $scope = "/subscriptions/$subscriptionId"
    if (-not (Get-AzRoleAssignment -ObjectId $sp.Id -RoleDefinitionName "Contributor" -Scope $scope -ErrorAction SilentlyContinue)) {
         Write-Host "Assigning 'Contributor' role to Service Principal: $($sp.DisplayName)"
         New-AzRoleAssignment -ObjectId $sp.Id -RoleDefinitionId $roleDefinition.Id -Scope $scope
    } else {
         Write-Host "Service Principal '$($sp.DisplayName)' already has 'Contributor' role assigned."
         exit
    }
   
   # Create Federated Credential
  # $federatedCredential = New-AzADFederatedCredential -ApplicationObjectId $app.ObjectId -Name "GitHubActionCredential" -Issuer "https://token.actions.githubusercontent.com" -Subject "repo:$orgName/$repoName:environment:$environmentName" -Audience "api://AzureADTokenExchange"
    
         # Create Federated Credential
      Write-Host "Creating Federated Credential for Application: $appName"
    

    $federatedCredential = New-AzADAppFederatedCredential -ApplicationObjectId $app.id  -Name "$appName" -Issuer "https://token.actions.githubusercontent.com" -Subject "repo:$($orgName)/$($repoName):environment:$environmentName"  -Audience "api://AzureADTokenExchange"                              
           
       
        
  
   # Output values
   Write-Host "Application (client) ID: $($app.AppId)"
   Write-Host "Tenant ID: $(Get-AzContext).Tenant.Id"
   Write-Host "Service Principal ID: $($sp.Id)"
   Write-Host "Federated Credential ID: $($federatedCredential.Id)"
   write-host "Federated Credential Name: $($federatedCredential.Name)"
   