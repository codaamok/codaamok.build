function Get-PublicFunctions {
    <#
    .SYNOPSIS
        Build
        Get a list of functions - as functions to export - defined in script files within the Public directory
    .DESCRIPTION
        Get a list of functions - as functions to export - defined in script files within the Public directory
    .EXAMPLE
        PS C:\> <example usage>
        Explanation of what the example does
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [String[]]$Path
    )

    $Files = @(Get-ChildItem $Path -Filter *.ps1 -Recurse)

    foreach ($File in $Files) {
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
}