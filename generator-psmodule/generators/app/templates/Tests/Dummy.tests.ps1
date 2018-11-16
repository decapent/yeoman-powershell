Describe ": Given the Dummy tools" {
    BeforeAll {
        # Positioning ourselves at the script level
        Push-Location $PSScriptRoot

        # Source Dummy tools function
        . $(Resolve-Path "..\Sources\Dummy.ps1")

        # Copying Test data to Test Drive        
        $testData = Resolve-Path ".\Test Data\Dummy"
        Get-ChildItem $testData -Recurse | Copy-Item -Destination $TestDrive
        Set-Location $TestDrive
    }

    AfterAll {
        Pop-Location
    }

    Context "-> When doing great things with the dummy module" {
        BeforeAll {
            # Setting tests context
            $invalidDummyPath = ".\kappa\wontresolve"
            $validDummyPath = $TestDrive
        }

        It "Throws if something bad happens" {
            { Get-Dummy -DummyPath $invalidDummyPath } | Should -Throw
        }
        
        It "Produces great results" {
            $results = Get-Dummy -DummyPath $validDummyPath

            $result | Should -Not -Be $null
            $result.Count | Should -Be 5
        }
    }
}