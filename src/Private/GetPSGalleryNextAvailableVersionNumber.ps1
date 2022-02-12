function GetPSGalleryNextAvailableVersionNumber {
    param (
        [Parameter(Mandatory)]
        [String]$ModuleName,

        [Parameter(Mandatory)]
        [Version]$VersionToBuild
    )

    Write-Verbose "Qualifying the version number to build with is available in the PowerShell Gallery" -Verbose

    for ($i = $VersionToBuild.Build; $i -le 100; $i++) {
        if ($i -eq 100) {
            throw "You have 100 unlisted packages under the same build number? Sort your life out."
        }

        try {
            $PSGalleryModuleInfo = Find-Module -Name $ModuleName -RequiredVersion $VersionToBuild -ErrorAction "Stop"
            if ($PSGalleryModuleInfo) {
                Write-Verbose "Found module in the gallery with the same verison number, adding one to the Build number and will query the gallery again"

                $VersionToBuild = [System.Version]::New(
                    $VersionToBuild.Major,
                    $VersionToBuild.Minor,
                    $VersionToBuild.Build + $i
                )
            }
            else {
                throw "Unusually, there was no object returned or excpetion throw from Find-Module while sussing out unlisted packages"
            }
        }
        catch {
            if ($_.Exception.Message -match "No match was found for the specified search criteria") {
                Write-Verbose "Found the next available version number to build with" -Verbose
                break
            }
            else {
                throw $_
            }
        }
    }

    return $VersionToBuild
}