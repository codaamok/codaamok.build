#
# Module manifest for module 'codaamok.build'
#
# Generated by: Adam Cook (@codaamok)
#
# Generated on: 11/21/2021
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'codaamok.build.psm1'

# Version number of this module.
ModuleVersion = '1.8.1'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = '4b9410c4-85b8-46b8-abc7-81b3830a52c5'

# Author of this module
Author = 'Adam Cook (@codaamok)'

# Company or vendor of this module
CompanyName = ''

# Copyright statement for this module
Copyright = '(c) Adam Cook (@codaamok). All rights reserved.'

# Description of the functionality provided by this module
Description = 'My PowerShell pipeline build module which contains a bunch of helper functions to aid with PowerShell module deployment'

# Minimum version of the PowerShell engine required by this module
PowerShellVersion = '7.0'

# Name of the PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# ClrVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = '*'

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = 'Build','Pipeline','CICD','codaamok','Helper'

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/codaamok/codaamok.build/blob/main/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/codaamok/codaamok.build'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        ReleaseNotes = '# Added
- Added custom pre and post build tasks to invoke.build.ps1 and also included custom.build.ps1 which drives project-specific custom pre and post buildactions
# Fixed
- Fixed GitHub Actions workflow build.yml to reference correct build.ps1 now that there are multiple (custom.build.ps1 + invoke.build.ps1)'

        # Prerelease string of this module
        # Prerelease = ''

        # Flag to indicate whether the module requires explicit user acceptance for install/update/save
        # RequireLicenseAcceptance = $false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

 } # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

