function Update-BuildFiles {
    <#
    .SYNOPSIS
        Setup
        Copy the build files (script + GitHub Actiosn workflow) from the module's install directory to the specified directory
    .DESCRIPTION
        Copy the build files (script + GitHub Actiosn workflow) from the module's install directory to the specified directory
    .EXAMPLE
        PS C:\> <example usage>
        Explanation of what the example does
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [String]$DestinationPath
    )

    $Module = Get-Module "codaamok.build"

    # Check for files within the ModuleBase directory aswell the Files subfolder in case this command is being used during development of codaamok.build itself
    @(
        [PSCustomObject]@{
            File = "{0}\invoke.build.ps1" -f $Module.ModuleBase
            DestinationPath = $DestinationPath
        },
        [PSCustomObject]@{
            File = "{0}\Files\invoke.build.ps1" -f $Module.ModuleBase
            DestinationPath = $DestinationPath
        },
        [PSCustomObject]@{
            File = "{0}\deploy-powershellgallery.yml" -f $Module.ModuleBase
            DestinationPath = "{0}\.github\workflows" -f $DestinationPath
        },
        [PSCustomObject]@{
            File = "{0}\Files\deploy-powershellgallery.yml" -f $Module.ModuleBase
            DestinationPath = "{0}\.github\workflows" -f $DestinationPath
        }
    ) | ForEach-Object {
        if (Test-Path $_.File) {
            New-Item -Path $_.DestinationPath -ItemType "Directory" -Force
            Copy-Item -Path $_.File -Destination $_.DestinationPath -Confirm
        }
    }
}