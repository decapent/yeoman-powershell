<#
	.SYNOPSIS
        Publish the <%=moduleName%> module to the PowerShell Gallery.
    .DESCRIPTION
        The <%=moduleName%> gets published to a public nuget feed. This
        script will be most likely ran from a CI pipeline.
#>
[CmdletBinding()]
Param (
    [ValidateScript({-not([string]::IsNullOrEmpty($_))})]
    [Parameter(Mandatory=$true)]
    [string]$NuGetApiKey
)

$moduleName = "<%=moduleName%>"
Push-Location $PSScriptRoot

try {
    Write-Output "Creating module staging folder"
    $module = New-Item -Name $moduleName -Type Directory

    Write-Verbose "Copying module scripts to staging folder"
    Get-ChildItem -Recurse -Path ".\Sources" | ForEach-Object {
        Write-Verbose "Copying $($_.FullName) to $($module.FullName)"
        Copy-Item $_.FullName -Destination $module.FullName -Force
    }

    Write-Output "Publishing module to PowerShell Gallery"
    Publish-Module -Path $module.FullName -NuGetApiKey $NuGetApiKey

} finally {
    if(Test-Path $moduleName) {
        Write-Warning "Removing module staging folder"
        Remove-Item $moduleName -Force -Recurse
    }

    Pop-Location
}