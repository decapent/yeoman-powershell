
# Source all PowerShell scripts in order to export module member functions
Get-ChildItem -Path $PSScriptRoot\*.ps1 | Foreach-Object {
    . $_.FullName 
}

# Dummy
Export-ModuleMember -Function Get-Dummy