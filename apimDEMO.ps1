# Setup
pwsh
cd /Users/sma/git/k8s-app-conf/deploy/apim/canary

# Debug
$DebugPreference="Continue"
$ErrorActionPreference = 'Stop'
Set-StrictMode -Version 3

# Context
$apimContext = New-AzApiManagementContext -ResourceGroupName "VIPPS-AT2-rg" -ServiceName "VIPPSAT2api04"

# Deploy canary swagger api to apim with pwsh
Import-AzApiManagementApi -Context $apimContext -SpecificationFormat "Swagger" -SpecificationPath "/Users/sma/git/k8s-app-conf/deploy/apim/canary/swagger.json" -Path "canary" -ApiId "canary" 

# Deploy canary api policy
Set-AzApiManagementPolicy -Context $apimContext -ApiId "canary" -PolicyFilePath "/Users/sma/git/k8s-app-conf/deploy/apim/canary/canary.policy.xml" 

# Deploy canary product with pwsh
New-AzApiManagementProduct -Context $apimContext -ProductId "canary" -Title "Canary" -Description "Infrastructure test API" -SubscriptionRequired $True -State "published"

# Add canary api to canary product
Add-AzApiManagementApiToProduct -Context $apimContext -ProductId "canary" -ApiId "canary"

# Optional: Deploy isCanaryDown property with pwsh.
New-AzApiManagementProperty -Context $apimContext -PropertyId "isCanaryDown" -Name "isCanaryDown" -Value "true"
