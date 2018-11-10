function global:Get-Dummy {
    [CmdletBinding()]
    Param (
        [ValidateScript({Test-Path $_})]
        [Parameter(Mandatory=$true)]
        [string]$DummyPath
    )

    Write-Verbose "[Get-Dummy]Entering function scope"

    Write-Verbose "[Get-Dummy]Simulating intense calculation"
    $results = @(1,2,3,4,5)
    Start-Sleep -Milliseconds 100

    return $results
}