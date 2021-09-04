#Requires -Module "codaamok.build", "ChangelogManagement", "PlatyPS"
[CmdletBinding()]
param (
    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [String]$ModuleName = $env:GH_PROJECTNAME,

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [String]$Author = $env:GH_USERNAME,

    [Parameter()]
    [Bool]$UpdateDocs = $false,

    [Parameter()]
    [Bool]$NewRelease = $false
)

# Synopsis: Initiate the entire build process
task . Clean, 
    GetPSGalleryVersionNumber, 
    CopyChangeLog, 
    GetChangelog, 
    GetReleaseNotes,
    GetManifestVersionNumber, 
    GetVersionToBuild, 
    UpdateChangeLog, 
    GetFunctionsToExport, 
    CreateRootModule,
    CopyFormatFiles, 
    CopyLicense, 
    CreateProcessScript, 
    CopyAboutHelp, 
    CopyModuleManifest, 
    UpdateModuleManifest, 
    CreateReleaseAsset,
    UpdateDocs

# Synopsis: Empty the contents of the build and release directories. If not exist, create them.
task Clean {
    Invoke-BuildClean -Path @(
        "{0}\build\{1}" -f $BuildRoot, $ModuleName
        "{0}\release" -f $BuildRoot
    )
}

# Synopsis: Get change log, copy it to the build directory, and create releasenotes.txt
task Changelog {
    Copy-Item -Path $BuildRoot\CHANGELOG.md -Destination $BuildRoot\build\$ModuleName\CHANGELOG.md
    $ChangeLog = Get-ChangeLogData -Path $BuildRoot\CHANGELOG.md
    Write-Output ("Last released version: {0}" -f $ChangeLog.Released[0].Version)
    Export-UnreleasedNotes -Path $BuildRoot\release\releasenotes.txt -ChangeLogData $ChangeLog -NewRelease $NewRelease
}

# Synopsis: Get current version number of module in the manifest file
task GetManifestVersionNumber {
    $ModuleManifest = Import-PowerShellDataFile -Path $BuildRoot\$ModuleName\$ModuleName.psd1
}

# Synopsis: Determine version number to build with
task GetVersionToBuild {
    Get-BuildVersionNumber 
}

# Synopsis: Update CHANGELOG.md if building a new release (-NewRelease switch parameter)
task UpdateChangeLog -If ($NewRelease.IsPresent) {
    $LinkPattern   = @{
        FirstRelease  = "https://github.com/{0}/{1}/tree/{{CUR}}" -f $Script:Author, $Script:ModuleName
        NormalRelease = "https://github.com/{0}/{1}/compare/{{PREV}}..{{CUR}}" -f $Script:Author, $Script:ModuleName
        Unreleased    = "https://github.com/{0}/{1}/compare/{{CUR}}..HEAD" -f $Script:Author, $Script:ModuleName
    }

    Update-Changelog -Path $BuildRoot\build\$Script:ModuleName\CHANGELOG.md -ReleaseVersion $Script:VersionToBuild -LinkMode Automatic -LinkPattern $LinkPattern
}

# Synopsis: Gather all exported functions to populate manifest with
task GetFunctionsToExport {
    $Files = @(Get-ChildItem $BuildRoot\$Script:ModuleName\Public -Filter *.ps1)

    $Script:FunctionsToExport = foreach ($File in $Files) {
        try {
            $tokens = $errors = @()
            $Ast = [System.Management.Automation.Language.Parser]::ParseFile(
                $File.FullName,
                [ref]$tokens,
                [ref]$errors
            )

            if ($errors[0].ErrorId -eq 'FileReadError') {
                throw [InvalidOperationException]::new($errors[0].Message)
            }

            Write-Output $Ast.EndBlock.Statements.Name
        }
        catch {
            Write-Error -Exception $_.Exception -Category "OperationStopped"
        }
    }
}

# Synopsis: Creates a single .psm1 file of all private and public functions of the to-be-built module
task CreateRootModule {
    $RootModule = New-Item -Path $BuildRoot\build\$Script:ModuleName\$Script:ModuleName.psm1 -ItemType "File" -Force

    foreach ($FunctionType in "Private","Public") {
        '#region {0} functions' -f $FunctionType | Add-Content -Path $RootModule

        $Files = @(Get-ChildItem $BuildRoot\$Script:ModuleName\$FunctionType -Filter *.ps1)

        foreach ($File in $Files) {
            Get-Content -Path $File.FullName | Add-Content -Path $RootModule

            # Add new line only if the current file isn't the last one (minus 1 because array indexes from 0)
            if ($Files.IndexOf($File) -ne ($Files.Count - 1)) {
                Write-Output "" | Add-Content -Path $RootModule
            }
        }

        '#endregion' -f $FunctionType | Add-Content -Path $RootModule
        Write-Output "" | Add-Content -Path $RootModule
    }
}

# Synopsis: Create a single Process.ps1 script file for all script files under ScriptsToProcess\* (if any)
task CreateProcessScript {
    $ScriptsToProcessFolder = "{0}\{1}\ScriptsToProcess" -f $BuildRoot, $Script:ModuleName

    if (Test-Path $ScriptsToProcessFolder) {
        $Script:ProcessFile = New-Item -Path $BuildRoot\build\$Script:ModuleName\Process.ps1 -ItemType "File" -Force
        $Files = @(Get-ChildItem $ScriptsToProcessFolder -Filter *.ps1)
    }

    foreach ($File in $Files) {
        Get-Content -Path $File.FullName | Add-Content -Path $Script:ProcessFile

        # Add new line only if the current file isn't the last one (minus 1 because array indexes from 0)
        if ($Files.IndexOf($File) -ne ($Files.Count - 1)) {
            Write-Output "" | Add-Content -Path $Script:ProcessFile
        }
    }
}

# Synopsis: Copy format files (if any)
task CopyFormatFiles {
    $Script:FormatFiles = Get-ChildItem $BuildRoot\$Script:ModuleName -Filter "*format.ps1xml" | Copy-Item -Destination $BuildRoot\build\$Script:ModuleName
}

# Synopsis: Copy LICENSE file (must exist)
task CopyLicense {
    Copy-Item -Path $BuildRoot\LICENSE -Destination $BuildRoot\build\$Script:ModuleName\LICENSE
}

# Synopsis: Copy "About" help files (must exist)
task CopyAboutHelp {
    Copy-Item -Path $BuildRoot\$Script:ModuleName\en-US -Destination $BuildRoot\build\$Script:ModuleName -Recurse
}

# Synopsis: Copy module manifest files (must exist)
task CopyModuleManifest {
    $Script:ManifestFile = Copy-Item -Path $BuildRoot\$Script:ModuleName\$Script:ModuleName.psd1 -Destination $BuildRoot\build\$Script:ModuleName\$Script:ModuleName.psd1 -PassThru
}

# Synopsis: Update the manifest in build directory. If successful, replace manifest in the module directory
task UpdateModuleManifest {  
    $UpdateModuleManifestSplat = @{
        Path = $Script:ManifestFile
    }

    $UpdateModuleManifestSplat["ModuleVersion"] = $Script:VersionToBuild

    $UpdateModuleManifestSplat["ReleaseNotes"] = $Script:ReleaseNotes

    if ($Script:FormatFiles) {
        $UpdateModuleManifestSplat["FormatsToProcess"] = $Script:FormatFiles.Name
    }

    if ($Script:ProcessFile) {
        # Use this instead of Updatet-ModuleManifest due to https://github.com/PowerShell/PowerShellGet/issues/196
        (Get-Content -Path $Script:ManifestFile.FullName) -replace '(#? ?ScriptsToProcess.+)', ('ScriptsToProcess = "{0}"' -f $Script:ProcessFile.Name) | Set-Content -Path $ManifestFile
    }

    if ($Script:FunctionsToExport) {
        $UpdateModuleManifestSplat["FunctionsToExport"] = $Script:FunctionsToExport
    }
    
    Update-ModuleManifest @UpdateModuleManifestSplat

    # Arguably a moot point as Update-MooduleManifest obviously does some testing to ensure a valid manifest is there first before updating it
    # However with the regex replace for ScriptsToProcess, I want to be sure
    $null = Test-ModuleManifest -Path $Script:ManifestFile
}

# Synopsis: Create release asset (archived module)
task CreateReleaseAsset {
    $ReleaseAsset = "{0}_{1}.zip" -f $Script:ModuleName, $Script:VersionToBuild
    Compress-Archive -Path $BuildRoot\build\$Script:ModuleName\* -DestinationPath $BuildRoot\release\$ReleaseAsset -Force
}

# Synopsis: Update documentation (-NewRelease or -UpdateDocs switch parameter)
task UpdateDocs -If ($NewRelease.IsPresent -Or $UpdateDocs.IsPresent) {
    Import-Module -Name $BuildRoot\build\$Script:ModuleName -Force
    New-MarkdownHelp -Module $Script:ModuleName -OutputFolder $BuildRoot\docs -Force
}