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
Import-AzApiManagementApi -Context $apimContext -SpecificationFormat "Swagger" -SpecificationPath "/Users/sma/git/msbuild/files/2.20-swagger-canary.json" -Path "canary" -ApiId "canary" 

# Get canary api
Get-AzApiManagementApi -Context $apimContext -ApiId "canary"

# Deploy canary api policy
Set-AzApiManagementPolicy -Context $apimContext -ApiId "canary" -PolicyFilePath "/Users/sma/git/msbuild/files/2.30-api-canary.policy.xml" 

# Deploy canary product with pwsh
New-AzApiManagementProduct -Context $apimContext -ProductId "canary" -Title "Canary" -Description "Infrastructure test API" -SubscriptionRequired $True -State "published"

# Add canary api to canary product
Add-AzApiManagementApiToProduct -Context $apimContext -ProductId "canary" -ApiId "canary"

# Deploy AKSBackendUrl property with pwsh.
New-AzApiManagementProperty -Context $apimContext -PropertyId "AKSBackendUrl" -Name "AKSBackendUrl" -Value "http://uat.aks-test.local"


