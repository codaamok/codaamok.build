---
external help file: codaamok.build-help.xml
Module Name: codaamok.build
online version:
schema: 2.0.0
---

# New-BuildEnvironmentVariable

## SYNOPSIS
Build
Set build and platform specific environment variables.

## SYNTAX

```
New-BuildEnvironmentVariable [-Variable] <Hashtable> [-Platform] <String[]> [<CommonParameters>]
```

## DESCRIPTION
Set build and platform specific environment variables.

## EXAMPLES

### EXAMPLE 1
```
New-BuildEnvironmentVariable -Variables @{ VersionToBuild = "1.2.3" } -Platform "GitHubActions"
```

Writes to GitHub Action's environment variable file to create environment variable "VersionToBuild" with value of "1.2.3".

## PARAMETERS

### -Variable
{{ Fill Variable Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Platform
{{ Fill Platform Description }}

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
