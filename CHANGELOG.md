## [Unreleased]

## [1.1.0] - 2021-09-18
### Changed
- Removed requirement to use emoji :shipit: in commit message for pipeline to start - was pointless if I wanted to allow ad-hoc use of the pipeline via workflow dispatch

### Fixed
- Export-UnreleasedNotes threw excpetion when trying to print (an array of) release notes to the verbose output stream
- Export-UnreleasedNotes constantly wrote 'None' to the release notes and did not use the change log data

## [1.0.0] - 2021-09-18
### Added
- Initial release

[Unreleased]: https://github.com/codaamok/codaamok.build/compare/1.1.0..HEAD
[1.1.0]: https://github.com/codaamok/codaamok.build/compare/1.0.0..1.1.0
[1.0.0]: https://github.com/codaamok/codaamok.build/tree/1.0.0