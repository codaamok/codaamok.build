## [Unreleased]
### Fixed
- `Update-BuildFiles` did not copy `gitignore` with the leading period

## [2.0.11] - 2022-02-12
### Added
- Updated `.gitignore` to include `.DS_Store`

### Fixed
- Module manifests can not have files in `FileList` (leading?) with periods, so changed `.gitignore` to `gitignore` and updated `Update-BuildFiles` to insert the period when copying
- Now `Update-BuildFiles` and `invoke.build.ps1` include hidden files for the `FileList` property

## [2.0.9] - 2022-02-12
### Fixed
- Fixed typo in `CONTRIBUTING.md`

## [2.0.5] - 2022-02-12
### Fixed
- Updated workflow to use the new `src` directory
- Corrected reference to new `src` directory in workflow yaml

### Changed
- Instead of storing module source code in a folder at the root of a project repository named the same as the module, build scripts and functions now expect source code to be in a named folder `src` instead. Still at the root of a project repository.
- Function `New-ModuleDirStructure` now also creates `tests` directory. Also updated the function to create folder containing module source code in `src` instead of the module name

## [1.10.2] - 2022-02-10
### Changed
- No longer reference `gitversion` as `gitversion.exe` in `invoke.build.ps1` for better x-platform compatibility

## [1.10.0] - 2022-01-26
### Added
- Added Types Folder to `Export-RootModule` and `New-ModuleDirStructure`

## [1.9.3] - 2021-11-21
### Added
- Improved templating for custom pre/post build/release tasks

### Fixed
- Typo in build.yml referencing GH_PROJECTNAME env var
- Typo in build.yml referencing GH_PROJECTNAME env var

## [1.9.0] - 2021-11-21
### Changed
- Added parameters to custom.build.ps1

## [1.8.1] - 2021-11-21
### Added
- Added custom pre and post build tasks to `invoke.build.ps1` and also included `custom.build.ps1` which drives project-specific custom pre and post build actions

### Fixed
- Fixed GitHub Actions workflow `build.yml` to reference correct build.ps1 now that there are multiple (custom.build.ps1 + invoke.build.ps1)

## [1.7.3] - 2021-11-21
### Changed
- Some improvements to `Update-BuildFiles` so I no longer need to hard code new typical project files

## [1.7.1] - 2021-11-20
### Fixed
- Fixed build script to copy *format.ps1xml files

## [1.7.0] - 2021-11-19
### Changed
- Reverted change in invoke.build.ps1 which updated changelog and then copied it as it introduced an issue of making it tricky to add release notes for current version to module manifest during build

## [1.6.7] - 2021-11-18
### Fixed
- Use `Test-ModuleManifest` against the correct manifest in the `UpdateProjectRepo` build task

## [1.6.6] - 2021-11-10
### Fixed
- Updated invoke.build.ps1

## [1.6.3] - 2021-11-10
### Fixed
- Build task InstallDependencies was not running before attempting to import codaamok.build

## [1.6.0] - 2021-11-10
### Added
- Added .gitignore file to the FileList

## [1.5.5] - 2021-11-10
### Added
- Build script now bails if `gitversion.exe` is not present on system
- Local builds now use pre-release tags, i.e. when `-Version` is not passed to the built script
- Added `CONTRIBUTING.md` to this project

### Changed
- Always assume FileList is empty in manifest, just in case "FileList" is mentioned in the release notes, otherwise the regex replace could have got screwed up
- Change build tasks to update change log and then copy it to the `build` directory, and removed the copying of the change log in the task build task
- Renamed build task `Changelog` to `CopyChangeLog`
- Prefix GitHub release and Git tags with `v` in the pipeline

### Fixed
- Broken reference to CHANGELOG.md in the pipeline in build task `UpdateChangeLog`
- Removed backticks from release notes in manifest, was preventing Update-ModuleManifest from working during build

## [1.3.0] - 2021-11-10
### Added
- Added `CONTRIBUTING.md` and `GitVersion.yml` to the `FileList`

## [1.2.1] - 2021-11-09
### Changed
- Use [GitVersion](https://gitversion.net) to determine version numbers instead of `Get-BuildVersionNumber`

### Fixed
- `build.yml` did not correctly commit at the end of the pipeline

## [1.1.0] - 2021-09-18
### Changed
- Removed requirement to use emoji :shipit: in commit message for pipeline to start - was pointless if I wanted to allow ad-hoc use of the pipeline via workflow dispatch

### Fixed
- Export-UnreleasedNotes threw exception when trying to print (an array of) release notes to the verbose output stream
- Export-UnreleasedNotes constantly wrote 'None' to the release notes and did not use the change log data

## [1.0.0] - 2021-09-18
### Added
- Initial release

[Unreleased]: https://github.com/codaamok/codaamok.build/compare/2.0.11..HEAD
[2.0.11]: https://github.com/codaamok/codaamok.build/compare/2.0.9..2.0.11
[2.0.9]: https://github.com/codaamok/codaamok.build/compare/2.0.5..2.0.9
[2.0.5]: https://github.com/codaamok/codaamok.build/compare/1.10.2..2.0.5
[1.10.2]: https://github.com/codaamok/codaamok.build/compare/1.10.0..1.10.2
[1.10.0]: https://github.com/codaamok/codaamok.build/compare/1.9.3..1.10.0
[1.9.3]: https://github.com/codaamok/codaamok.build/compare/1.9.0..1.9.3
[1.9.0]: https://github.com/codaamok/codaamok.build/compare/1.8.1..1.9.0
[1.8.1]: https://github.com/codaamok/codaamok.build/compare/1.7.3..1.8.1
[1.7.3]: https://github.com/codaamok/codaamok.build/compare/1.7.1..1.7.3
[1.7.1]: https://github.com/codaamok/codaamok.build/compare/1.7.0..1.7.1
[1.7.0]: https://github.com/codaamok/codaamok.build/compare/1.6.7..1.7.0
[1.6.7]: https://github.com/codaamok/codaamok.build/compare/1.6.6..1.6.7
[1.6.6]: https://github.com/codaamok/codaamok.build/compare/1.6.3..1.6.6
[1.6.3]: https://github.com/codaamok/codaamok.build/compare/1.6.0..1.6.3
[1.6.0]: https://github.com/codaamok/codaamok.build/compare/1.5.5..1.6.0
[1.5.5]: https://github.com/codaamok/codaamok.build/compare/1.3.0..1.5.5
[1.3.0]: https://github.com/codaamok/codaamok.build/compare/1.2.1..1.3.0
[1.2.1]: https://github.com/codaamok/codaamok.build/compare/1.1.0..1.2.1
[1.1.0]: https://github.com/codaamok/codaamok.build/compare/1.0.0..1.1.0
[1.0.0]: https://github.com/codaamok/codaamok.build/tree/1.0.0