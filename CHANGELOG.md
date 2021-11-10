## [Unreleased]

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
- Export-UnreleasedNotes threw excpetion when trying to print (an array of) release notes to the verbose output stream
- Export-UnreleasedNotes constantly wrote 'None' to the release notes and did not use the change log data

## [1.0.0] - 2021-09-18
### Added
- Initial release

[Unreleased]: https://github.com/codaamok/codaamok.build/compare/1.6.0..HEAD
[1.6.0]: https://github.com/codaamok/codaamok.build/compare/1.5.5..1.6.0
[1.5.5]: https://github.com/codaamok/codaamok.build/compare/1.3.0..1.5.5
[1.3.0]: https://github.com/codaamok/codaamok.build/compare/1.2.1..1.3.0
[1.2.1]: https://github.com/codaamok/codaamok.build/compare/1.1.0..1.2.1
[1.1.0]: https://github.com/codaamok/codaamok.build/compare/1.0.0..1.1.0
[1.0.0]: https://github.com/codaamok/codaamok.build/tree/1.0.0