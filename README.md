# codaamok.build
My PowerShell pipeline build module

## Folders

### Files

Store all additional files to include as part of the module manifest property `FileList`.

### ScriptsToProcess

Store all scripts to process as the module manifest property `ScriptsToProcess`. Any .ps1 script files defined within this directory will be merged into a single Process.ps1 during build.

## To Do

- Write blog post on how to develop modules using this helper module
- Add comment based help
- Flesh out `New-ProjectDirStructure`
  - Include vscode tasks.json and launch.json
- Auto-updater in GitHub Actions workflow for build script and workflow yaml
  - Fail the workflow if there are newer files in the module compared to the repo, and force user to create an ignore file or update the files?
- Make fewer assumptions about GitHub Actions being the build platform
  - Perhaps define module name and author using vscode workspace env vars
  - Handle the GitHub project automatic links 
  - Assumption made on always using GitHub Actions in `Update-BuildFiles`