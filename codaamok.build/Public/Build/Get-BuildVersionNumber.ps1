function Get-BuildVersionNumber {
    <#
    .SYNOPSIS
        Build
        Qualify the next version number to build with
    .DESCRIPTION
        Qualify the next version number to build with
    .EXAMPLE
        PS C:\> Get-BuildVersionNumber -ModuleName "PSShlink" -ManifestData $ManifestData -ChangeLogData $ChangeLogData        
    #>
    param (
        [Parameter(Mandatory)]
        [String]$ModuleName,

        [Parameter(Mandatory, ParameterSetName='DetermineNextVersion')]
        [Hashtable]$ManifestData,

        [Parameter(Mandatory, ParameterSetName='DetermineNextVersion')]
        [PSCustomObject]$ChangeLogData,

        [Parameter(Mandatory, ParameterSetName='HardCodeNextVersion')]
        [Version]$VersionToBuild,

        [Parameter(ParameterSetName='DetermineNextVersion')]
        [Switch]$NewRelease
    )

    # Get PowerShell Gallery current verison number (if published) 
    try {
        $PSGalleryModuleInfo = Find-Module -Name $ModuleName -ErrorAction "Stop"
    }
    catch {
        if ($_.Exception.Message -notmatch "No match was found for the specified search criteria") {
            throw $_
        }
        else {
            $PSGalleryModuleInfo = [PSCustomObject]@{
                "Name"    = $ModuleName
                "Version" = "0.0"
            }
        }
    }

    Write-Verbose ("PowerShell Gallery verison: {0}" -f $PSGalleryModuleInfo.Version) -Verbose

    if (-not $VersionToBuild) {
        if ($NewRelease.IsPresent) {
            # Try and piece together an understanding from the module manifest, PowerShell Gallery, and the change log as to what the next version number should be automatically

            # If the last released version in the change log and latest version available in the PowerShell gallery don't match, throw an exception - get them level!
            if ($null -ne $ChangeLogData.Released[0].Version -And $ChangeLogData.Released[0].Version -ne $PSGalleryModuleInfo.Version) {
                throw "The latest released version in the changelog does not match the latest released version in the PowerShell gallery"
            }
            # If module isn't yet published in the PowerShell gallery, and there's no Released section in the change log, set initial version as per the manifest
            elseif ($PSGalleryModuleInfo.Version -eq "0.0" -And $ChangeLogData.Released.Count -eq 0) {
                $VersionToBuild = [System.Version]$ManifestData.ModuleVersion
            }
            # If module isn't yet published in the PowerShell gallery, and there is a Released section in the change log, update version
            elseif ($PSGalleryModuleInfo.Version -eq "0.0" -And $ChangeLogData.Released.Count -ge 1) {
                $CurrentVersion = [System.Version]$ChangeLogData.Released[0].Version
                $VersionToBuild = [System.Version]::New(
                    $CurrentVersion.Major,
                    $CurrentVersion.Minor + 1,
                    $CurrentVersion.Build
                )
            }
            # If the last Released verison in the change log and currently latest verison in the PowerShell gallery are in harmony, update version
            elseif ($ChangeLogData.Released[0].Version -eq $PSGalleryModuleInfo.Version) {
                $CurrentVersion = [System.Version]$PSGalleryModuleInfo.Version
                $VersionToBuild = [System.Version]::New(
                    $CurrentVersion.Major,
                    $CurrentVersion.Minor + 1,
                    $CurrentVersion.Build
                )
            }
            else {
                Write-Output ("Latest release version from change log: {0}" -f $ChangeLogData.Released[0].Version)
                Write-Output ("Latest release version from PowerShell gallery: {0}" -f $PSGalleryModuleInfo.Version)
                throw "Can not determine next version number"
            }
        
            $VersionToBuild = GetPSGalleryNextAvailableVersionNumber -ModuleName $ModuleName -VersionToBuild $VersionToBuild
        }
        else {
            $VersionToBuild = [System.Version]::New(
                ([System.Version]$ManifestData.ModuleVersion).Major, 
                ([System.Version]$ManifestData.ModuleVersion).Minor, 
                ([System.Version]$ManifestData.ModuleVersion).Build + 1
            )
        }
    }
    else {
        Write-Verbose "Version to build with is hard coded" -Verbose
        if ($PSGalleryModuleInfo.Version -ne "0.0") {
            Write-Verbose "Module is published to the PowerShell Gallery" -Verbose
            $VersionToBuild = GetPSGalleryNextAvailableVersionNumber -ModuleName $ModuleName -VersionToBuild $VersionToBuild
        }
        else {
            Write-Verbose "Module not published to the PowerShell Gallery, will build with the given version number" -Verbose
        }
    }

    Write-Verbose ("Version to build: '{0}'" -f $VersionToBuild) -Verbose

    return $VersionToBuild
}