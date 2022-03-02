function Export-ScriptsToProcess {
    <#
    .SYNOPSIS
        Build
        Create a single Process.ps1 script file for all script files under ScriptsToProcess\*
    .DESCRIPTION
        Create a single Process.ps1 script file for all script files under ScriptsToProcess\*
    .EXAMPLE
        PS C:\> <example usage>
        Explanation of what the example does
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [System.IO.FileSystemInfo[]]$File,

        [Parameter(Mandatory)]
        [String]$Path
    ) 

    $ProcessScript = New-Item -Path $Path -ItemType "File" -Force

    foreach ($_File in $File) {
        Get-Content -Path $_File.FullName | Add-Content -Path $ProcessScript

        # Add new line only if the current file isn't the last one (minus 1 because array indexes from 0)
        if ($File.IndexOf($_File) -ne ($File.Count - 1)) {
            Write-Output "" | Add-Content -Path $ProcessScript
        }
    }
}