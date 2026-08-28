# notraycast.vim

[![CI](https://github.com/sunnybharne/notraycast.vim/actions/workflows/ci.yml/badge.svg)](https://github.com/sunnybharne/notraycast.vim/actions/workflows/ci.yml)
[![GitHub Pages](https://github.com/sunnybharne/notraycast.vim/actions/workflows/pages.yml/badge.svg)](https://github.com/sunnybharne/notraycast.vim/actions/workflows/pages.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

An experimental Neovim plugin that will grow into a quick, keyboard-first
command surface. It is deliberately starting small so each capability can be
designed and tested in public.

## Current release

Version `0.1.0` provides one command:

```vim
:NotRaycastHello
```

It displays `Hello, world!` as a Neovim notification.

## Requirements

- Neovim 0.7 or newer

## Installation

With [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "sunnybharne/notraycast.vim",
  cmd = "NotRaycastHello",
}
```

For local development:

```lua
{
  dir = "/Users/sunnybharne/code/notraycast.vim",
  name = "notraycast.vim",
  cmd = "NotRaycastHello",
}
```

## Documentation

- [Project website](https://sunnybharne.github.io/notraycast.vim/)
- [Roadmap](ROADMAP.md)
- [Changelog](CHANGELOG.md)
- [Release notes](RELEASE_NOTES.md)
- [Contributing](CONTRIBUTING.md)

## Development

Run the smoke test from the repository root:

```sh
nvim --headless -u NONE -l scripts/smoke-test.lua
```

## License

[MIT](LICENSE) © Sunny Bharne
