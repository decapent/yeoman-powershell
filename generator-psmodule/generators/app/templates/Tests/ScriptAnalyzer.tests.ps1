Describe ': Given the PowerShell Scripts Analyzer' -Tags @("Linter") {
    BeforeAll {
        Push-Location $PSScriptRoot
        $scriptsToAnalyze = Get-ChildItem "..\Sources\" -Recurse
        $rules = Get-ScriptAnalyzerRule
    }

    AfterAll {
        Pop-Location
    }
       
    Context '-> When analyzing with the standard rules' {
        foreach($script in $scriptsToAnalyze) {
            $rules | ForEach-Object {
                It "$($script.Name) passes the PSScriptAnalyzerRule $($_)" {
                    (Invoke-ScriptAnalyzer -Path $script.FullName -IncludeRule $_.RuleName).Count | Should -Be 0
                }
            }
        }
    }
}