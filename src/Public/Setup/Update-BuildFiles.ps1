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
    if ([String]::IsNullOrWhiteSpace($Module.FileList)) {
        $Module = [PSCustomObject]@{
            FileList = Get-ChildItem -Path "$($Module.ModuleBase)\Files" -Force | Select-Object -ExpandProperty FullName
        }
    }

    $oldbuildyml = "{0}\.github\workflows\build.yml" -f $DestinationPath
    if (Test-Path $oldbuildyml) { 
        Remove-Item -Path $oldbuildyml -Confirm
    }

    switch -Regex ($Module.FileList) {
        "pipeline\.yml$" {
            $Destination = "{0}\.github\workflows" -f $DestinationPath
            $File = "{0}\pipeline.yml" -f $Destination
            if (-not (Test-Path $Destination)) {
                $null = New-Item -Path $Destination -ItemType "Directory" -Force
            }
            elseif (Test-Path $File) {
                $TargetFirstLine = Get-Content $File -TotalCount 1
                $SourceFirstLine = Get-Content $_ -TotalCount 1
                if ($TargetFirstLine -ne $SourceFirstLine) {
                    Write-Warning -Message 'Will not update pipeline.yml as it appears to be customised (indicated by reading the first line)'
                    continue
                }
            }
            Copy-Item -Path $_ -Destination $Destination -Confirm
        }
        "gitignore$" {
            $Destination = "{0}\.gitignore" -f $DestinationPath
            Copy-Item -Path $_ -Destination $Destination -Confirm
        }
        default {
            Copy-Item -Path $_ -Destination $DestinationPath -Confirm
        }
    }
}