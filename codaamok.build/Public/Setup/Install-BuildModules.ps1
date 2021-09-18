function Install-BuildModules {
    <#
    .SYNOPSIS
        Setup
        Install, or update, and import build-dependent modules
    .DESCRIPTION
        Install, or update, and import build-dependent modules
    .EXAMPLE
        PS C:\> Install-BuildModules
        
        Installs the default build modules "PlatyPS","ChangelogManagement","InvokeBuild" if they're not installed, updates them for the first run if they are installed, and finally imports them.
    #>
    [CmdletBinding()]
    param (
        [Parameter()]
        [String[]]$Module = @("PlatyPS","ChangelogManagement","InvokeBuild")
    )

    if (-not (Get-Module $Module) -And (Get-Module $Module -ListAvailable)) {
        # If installed but not imported, try and update them - good for local development, just makes the first run a little delayed
        Update-Module $Module
    }
    elseif (-not (Get-Module $Module -ListAvailable)) {
        Install-Module $Module -Scope CurrentUser -Force
    }

    Import-Module $Module -Force
}
