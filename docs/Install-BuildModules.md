---
external help file: codaamok.build-help.xml
Module Name: codaamok.build
online version:
schema: 2.0.0
---

# Install-BuildModules

## SYNOPSIS
Setup
Install, or update, and import build-dependent modules

## SYNTAX

```
Install-BuildModules [[-Module] <String[]>] [<CommonParameters>]
```

## DESCRIPTION
Install, or update, and import build-dependent modules

## EXAMPLES

### EXAMPLE 1
```
Install-BuildModules
```

Installs the default build modules "PlatyPS","ChangelogManagement","InvokeBuild" if they're not installed, updates them for the first run if they are installed, and finally imports them.

## PARAMETERS

### -Module
{{ Fill Module Description }}

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: @("PlatyPS","ChangelogManagement","InvokeBuild")
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
