function Export-UnreleasedNotes {
    <#
    .SYNOPSIS
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
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [String]$Path,

        [Parameter(Mandatory)]
        [PSCustomObject]$ChangeLogData,

        [Parameter()]
        [Bool]$NewRelease
    )

    $EmptyChangeLog = $true

    $ReleaseNotes = foreach ($Property in $ChangeLogData.Unreleased[0].Data.PSObject.Properties.Name) {
        $Data = $ChangeLogData.Unreleased[0].Data.$Property

        if ($Data) {
            $EmptyChangeLog = $false

            Write-Output ("# {0}" -f $Property)

            foreach ($item in $Data) {
                Write-Output ("- {0}" -f $item)
            }
        }
    }

    if ($EmptyChangeLog -eq $true -Or $ReleaseNotes.Count -eq 0) {
        if ($NewRelease.IsPresent) {
            throw "Can not build with empty Unreleased section in the change log"
        }
        else {
            $ReleaseNotes = "None"
        }
    }

    Write-Verbose "Release notes:" -Verbose
    $ReleaseNotes | Write-Verbose -Verbose

    Set-Content -Value $ReleaseNotes -Path $Path -Force
}