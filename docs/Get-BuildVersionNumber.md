---
external help file: codaamok.build-help.xml
Module Name: codaamok.build
online version:
schema: 2.0.0
---

# Get-BuildVersionNumber

## SYNOPSIS
Build
Qualify the next version number to build with

## SYNTAX

### DetermineNextVersion
```
Get-BuildVersionNumber -ModuleName <String> -ManifestData <Hashtable> -ChangeLogData <PSObject> [-NewRelease]
 [<CommonParameters>]
```

### HardCodeNextVersion
```
Get-BuildVersionNumber -ModuleName <String> -VersionToBuild <Version> [<CommonParameters>]
```

## DESCRIPTION
Qualify the next version number to build with

## EXAMPLES

### EXAMPLE 1
```
Get-BuildVersionNumber -ModuleName "PSShlink" -ManifestData $ManifestData -ChangeLogData $ChangeLogData
```

## PARAMETERS

### -ModuleName
{{ Fill ModuleName Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ManifestData
{{ Fill ManifestData Description }}

```yaml
Type: Hashtable
Parameter Sets: DetermineNextVersion
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ChangeLogData
{{ Fill ChangeLogData Description }}

```yaml
Type: PSObject
Parameter Sets: DetermineNextVersion
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -VersionToBuild
{{ Fill VersionToBuild Description }}

```yaml
Type: Version
Parameter Sets: HardCodeNextVersion
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NewRelease
{{ Fill NewRelease Description }}

```yaml
Type: SwitchParameter
Parameter Sets: DetermineNextVersion
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
