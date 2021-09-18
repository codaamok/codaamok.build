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

    foreach ($FunctionType in "Private","Public") {
        '#region {0} functions' -f $FunctionType | Add-Content -Path $RootModule

        $Files = @(Get-ChildItem $DevModulePath\$FunctionType -Filter *.ps1 -Recurse)

        foreach ($File in $Files) {
            Get-Content -Path $File.FullName | Add-Content -Path $RootModule

            # Add new line only if the current file isn't the last one (minus 1 because array indexes from 0)
            if ($Files.IndexOf($File) -ne ($Files.Count - 1)) {
                Write-Output "" | Add-Content -Path $RootModule
            }
        }

        '#endregion' -f $FunctionType | Add-Content -Path $RootModule
        Write-Output "" | Add-Content -Path $RootModule
    }
}