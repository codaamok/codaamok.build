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
    [CmdletBindind()]
    param (
        [Parameter(Mandatory)]
        [String[]]$Path
    )

    foreach ($Path in $Paths) {
        if (Test-Path $Path) {
            Remove-Item -Path $Path\* -Exclude ".gitkeep" -Recurse -Force
        }
        else {
            $null = New-Item -Path $Path -ItemType "Directory" -Force
        }
    }
}