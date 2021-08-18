function Install-BuildModules {
    <#
    .SYNOPSIS
        Setup
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
        [String[]]$Module = @("PlatyPS","ChangelogManagement","InvokeBuild")
    )

    Install-Module -Name $Module -Scope CurrentUser
}
