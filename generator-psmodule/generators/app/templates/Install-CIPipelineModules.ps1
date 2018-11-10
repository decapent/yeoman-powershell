# This script installs dependencies required by the Module
# and intended to be used by a CI pipeline. 
Install-PackageProvider -Name NuGet -Force -Scope CurrentUser
Install-Module -Name PSScriptAnalyzer -Force -Scope CurrentUser
Install-Module -Name Pester -Force -Scope CurrentUser