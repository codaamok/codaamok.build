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
        "$Path\.github\workflows",
        "$Path\src",
        "$Path\src\ScriptsToProcess",
        "$Path\src\Files",
        "$Path\src\Private",
        "$Path\src\Public",
        "$Path\src\Classes",
        "$Path\src\Enums",
        "$Path\src\en-US",
        "$Path\tests",
        "$Path\build",
        "$Path\release",
        "$Path\docs"
    ) | ForEach-Object {
        New-Item -Path $_ -ItemType Directory -Force
        New-Item -Path $_\.gitkeep -ItemType File -Force
    }

    #Create the module and related files
    $GitIgnorePath = "{0}\.gitignore" -f $Path
    $ModuleScript = "{0}.psm1" -f $ModuleName
    $ModuleScriptPath = "{0}\src\{1}" -f $Path, $ModuleScript
    $ModuleManifest = "{0}.psd1" -f $ModuleName
    $ModuleManifestPath = "{0}\src\{1}" -f $Path, $ModuleManifest
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
    ) | Set-Content -Path $ModuleScriptPath -Force
    @(
        'build/*'
        'release/*'
        '!*.gitkeep'
    ) | Set-Content -Path $GitIgnorePath

    $ModuleHelpPath = "{0}\src\en-US\about_{1}.help.txt" -f $Path, $ModuleName
    New-Item $ModuleHelpPath -ItemType File -Force

    $NewModuleManifestSplat = @{
        Path                = $ModuleManifestPath
        RootModule          = $ModuleScript
        Description         = $Description
        PowerShellVersion   = $PowerShellVersion
        Author              = $Author
        FunctionsToExport   = '*'
    }

    if ($CreateFormatFile) { 
        $ModuleFormat = "{0}.Format.ps1xml" -f $ModuleName
        $ModuleFormatPath = "{0}\src\{1}" -f $Path, $ModuleFormat
        New-Item $ModuleFormatPath -ItemType File -Force
        $NewModuleManifestSplat["FormatsToProcess"] = $ModuleFormat
    }

    if ($ProjectUri) {
        $NewModuleManifestSplat["ProjectUri"] = $ProjectUri
    }

    New-ModuleManifest @NewModuleManifestSplat
}