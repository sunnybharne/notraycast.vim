# Changelog

All notable changes to notraycast.vim are documented here.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and the project uses [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.3.0] - 2026-08-28

### Added

- `:NotRaycastSearch`, a two-step Telescope web-search flow.
- Keyless DuckDuckGo Lite searches using `curl`.
- Top result titles and links with Enter-to-open behavior.

### Removed

- Firefox history access and its `sqlite3` dependency.
- `:NotRaycastHistory`.

## [0.2.0] - 2026-08-28

### Added

- `:NotRaycastHistory`, a Telescope picker for local Firefox history.
- Fuzzy searching across page titles and URLs.
- Opening the selected result in the default browser.
- Project rules that favor simple, direct code and local-only history access.

### Removed

- The initial `:NotRaycastHello` placeholder command.

## [0.1.0] - 2026-08-28

### Added

- Initial Neovim plugin scaffold.
- `:NotRaycastHello` command.
- Hello-world notification through the public Lua module.
- Smoke-test coverage and GitHub Actions CI.
- Project documentation and GitHub Pages website.

[Unreleased]: https://github.com/sunnybharne/notraycast.vim/compare/v0.3.0...HEAD
[0.3.0]: https://github.com/sunnybharne/notraycast.vim/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/sunnybharne/notraycast.vim/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/sunnybharne/notraycast.vim/releases/tag/v0.1.0
