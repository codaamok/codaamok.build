function Get-BuildCommands {
    <#
    .SYNOPSIS
        Auxiliary
        Short description
    .DESCRIPTION
        Long description
    .EXAMPLE
        PS C:\> <example usage>
        Explanation of what the example does
    .INPUTS
        Inputs (if any)
    .OUTPUTS
        Output (if any)
    .NOTES
        General notes
    #>
    param (
    )

    $Commands = @{}

    Get-Command -Module "codaamok.build" | ForEach-Object {
        $Help = Get-Help -Name $_.Name
        $Synopsis = $Help.Synopsis

        if ([String]::IsNullOrWhiteSpace($Synopsis[0])) { 
            $Commands["N/A"] += @($_.Name)
        } 
        else {
            $Commands[($Synopsis -split '\n')[0]] += @($_.Name)
        }
    }

    foreach ($Key in $Commands.Keys) {
        Write-Host $Key -ForegroundColor Blue
        foreach ($Value in $Commands[$Key]) {
            Write-Host ("- {0}" -f $Value) -ForegroundColor Green
        }
        Write-Host ""
    }
}