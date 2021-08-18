function Get-BuildVersionNumber {
    <#
    .SYNOPSIS
        Build
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
        [Parameter()]
        [Version]$VersionToBuild
    )

    if (-not $VersionToBuild) {

    }
    else {
        # TODO Validate the version number is OK to use
        return $VersionToBuild
    }
}