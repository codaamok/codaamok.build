function Export-RootModule {
    <#
    .SYNOPSIS
        Build
        Get all of the function definition content for the module and create a single .psm1 with said content
    .DESCRIPTION
        Get all of the function definition content for the module and create a single .psm1 with said content
    .EXAMPLE
        PS C:\> <example usage>
        Explanation of what the example does
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [String[]]$DevModulePath,

        [Parameter(Mandatory)]
        [String[]]$RootModule
    )

    $null = New-Item -Path $RootModule -ItemType "File" -Force

    switch ('Classes','Enums','Private','Public') {
        'Classes' {
            $Files = @(Get-ChildItem $DevModulePath\$_ -Filter *.ps1 -Recurse)

            if ($Files) {
                '#region {0}' -f $_ | Add-Content -Path $RootModule

                $ClassCode = foreach ($File in $Files) {
                    Get-Content -Path $File.FullName | ForEach-Object {
                        $LastLineWasUsingStatement = $false
                        if ($_ -match '^using .+') {
                            $_ | Add-Content -Path $RootModule
                            $LastLineWasUsingStatement = $true
                        }
                        elseif (-not $LastLineWasUsingStatement -And -not [String]::IsNullOrWhiteSpace($_)) {
                            $_
                        }
                    } 

                    # Add new line only if the current file isn't the last one (minus 1 because array indexes from 0)
                    if ($Files.IndexOf($File) -ne ($Files.Count - 1)) {
                        ''
                    }
                }

                '',$ClassCode,('#endregion' -f $_),'' | Add-Content -Path $RootModule
            }
        }
        default {
            $Files = @(Get-ChildItem $DevModulePath\$_ -Filter *.ps1 -Recurse)

            if ($Files) {
                '#region {0}' -f $_ | Add-Content -Path $RootModule
        
                foreach ($File in $Files) {
                    Get-Content -Path $File.FullName | Add-Content -Path $RootModule
        
                    # Add new line only if the current file isn't the last one (minus 1 because array indexes from 0)
                    if ($Files.IndexOf($File) -ne ($Files.Count - 1)) {
                        Write-Output "" | Add-Content -Path $RootModule
                    }
                }
        
                ('#endregion' -f $_),'' | Add-Content -Path $RootModule
            }
        }
    }
}
