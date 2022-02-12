function Invoke-BuildClean {
    <#
    .SYNOPSIS
        Build
        Empty the contents of the build and release directories. If not exist, create them.
    .DESCRIPTION
        Empty the contents of the build and release directories. If not exist, create them.
    .EXAMPLE
        PS C:\> <example usage>
        Explanation of what the example does
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [String[]]$Path
    )

    foreach ($item in $Path) {
        if (Test-Path $item) {
            Remove-Item -Path $item\* -Exclude ".gitkeep" -Recurse -Force
        }
        else {
            $null = New-Item -Path $item -ItemType "Directory" -Force
        }
    }
}