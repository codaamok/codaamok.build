function New-ModuleDirStructure {
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
        [Parameter(Mandatory)]
        [String]$Path,
        [Parameter(Mandatory)]
        [String]$ModuleName,
        [Parameter()]
        [String]$Author = "Adam Cook (@codaamok)",
        [Parameter(Mandatory)]
        [String]$Description,
        [Parameter()]
        [String[]]$Tags,
        [Parameter()]
        [String]$ProjectUri,
        [Parameter()]
        [Switch]$CreateFormatFile,
        [Parameter()]
        [Version]$PowerShellVersion = 5.1
    )

    # Create the module and private function directories
    @(
        "$Path\$ModuleName",
        "$Path\.github\workflows"
        "$Path\$ModuleName\ScriptsToProcess",
        "$Path\$ModuleName\Files",
        "$Path\$ModuleName\Private",
        "$Path\$ModuleName\Public",
        "$Path\$ModuleName\en-US"
    ) | ForEach-Object {
        New-Item -Path $_ -ItemType Directory -Force
        New-Item -Path $_\.gitkeep -ItemType File -Force
    }

    #Create the module and related files
    $GitIgnorePath = Join-Path -Path $Path -ChildPath ".gitignore"
    $ModuleScript = "{0}.psm1" -f $ModuleName
    $ModuleScriptPath = Join-Path -Path $Path -ChildPath $ModuleScript
    $ModuleManifest = "{0}.psd1" -f $ModuleName
    $ModuleManifestPath = Join-Path -Path $Path -ChildPath $ModuleManifest
    New-Item $ModuleManifestPath -ItemType File -Force
    @(
        '$Public  = @( Get-ChildItem -Path $PSScriptRoot\Public -Recurse -Filter "*.ps1" )'
        '$Private = @( Get-ChildItem -Path $PSScriptRoot\Private -Recurse -Filter "*.ps1" )'
        'foreach ($import in @($Public + $Private)) {'
        '    try {'
        '        . $import.fullname'
        '    }'
        '    catch {'
        '        Write-Error -Message "Failed to import function $($import.fullname): $_"'
        '    }'
        '}'
        'Export-ModuleMember -Function $Public.Basename'
    ) | Set-Content -Path $ModuleManifestPath -Force
    @(
        'build/*'
        'release/*'
        '!*.gitkeep'
    ) | Set-Content -Path $GitIgnorePath

    $ModuleHelp = "about_{0}.help.txt" -f $ModuleName
    $ModuleHelpPath - "{0}\{1}\en-US\{2}" -f $Path, $ModuleName, $ModuleHelp
    New-Item $ModuleHelpPath -ItemType File -Force

    $NewModuleManifestSplat = @{
        Path                = Join-Path -Path $Path -ChildPath $ModuleName | Join-Path -ChildPath $ModuleManifest
        RootModule          = $ModuleScript
        Description         = $Description
        PowerShellVersion   = $PowerShellVersion
        Author              = $Author
        FunctionsToExport   = '*'
    }

    if ($CreateFormatFile) { 
        $ModuleFormat = "{0}.Format.ps1xml" -f $ModuleName
        $ModuleFormatPath = "{0}\{1}\{2}" -f $Path, $ModuleName, $ModuleFormat
        New-Item $ModuleFormatPath -ItemType File -Force
        $NewModuleManifestSplat["FormatsToProcess"] = $ModuleFormat
    }

    if ($ProjectUri) {
        $NewModuleManifestSplat["ProjectUri"] = $ProjectUri
    }

    New-ModuleManifest @NewModuleManifestSplat

    # Copy the public/exported functions into the public folder, private functions into private folder

}