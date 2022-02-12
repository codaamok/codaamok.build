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
        [String[]]$Path
    ) 

    $ProcessScript = New-Item -Path $BuildRoot\build\$Script:ModuleName\Process.ps1 -ItemType "File" -Force
    $Files = @(Get-ChildItem $Path -Filter *.ps1)

    foreach ($File in $Files) {
        Get-Content -Path $File.FullName | Add-Content -Path $ProcessScript

        # Add new line only if the current file isn't the last one (minus 1 because array indexes from 0)
        if ($Files.IndexOf($File) -ne ($Files.Count - 1)) {
            Write-Output "" | Add-Content -Path $ProcessScript
        }
    }
}