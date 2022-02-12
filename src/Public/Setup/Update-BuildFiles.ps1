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

    # FileList property could be empty if imported the non-released module manifest during development
    if ([String]::IsNullOrWhiteSpace($MOdule.FileList)) {
        $Module = [PSCustomObject]@{
            FileList = Get-ChildItem -Path "$($Module.ModuleBase)\Files" -Force | Select-Object -ExpandProperty FullName
        }
    }

    switch -Regex ($Module.FileList) {
        "build\.yml$" {
            $Destination = "{0}\.github\workflows" -f $DestinationPath
            if (-not (Test-Path $Destination)) {
                $null = New-Item -Path $Destination -ItemType "Directory" -Force
            }
            Copy-Item -Path $_ -Destination $Destination -Confirm
        }
        "^gitignore$" {
            $Destination = "{0}\.{1}" -f $DestinationPath, $_
            Copy-Item -Path $_ -Destination $DestinationPath -Confirm
        }
        default {
            Copy-Item -Path $_ -Destination $DestinationPath -Confirm
        }
    }
}