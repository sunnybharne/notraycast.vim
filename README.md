# notraycast.vim

[![CI](https://github.com/sunnybharne/notraycast.vim/actions/workflows/ci.yml/badge.svg)](https://github.com/sunnybharne/notraycast.vim/actions/workflows/ci.yml)
[![GitHub Pages](https://github.com/sunnybharne/notraycast.vim/actions/workflows/pages.yml/badge.svg)](https://github.com/sunnybharne/notraycast.vim/actions/workflows/pages.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Search Firefox history from Neovim with Telescope.

## Current release

Version `0.2.0` provides one command:

```vim
:NotRaycastHistory
```

Type to fuzzy-search page titles and URLs. Press Enter to open the selected URL.

## Requirements

- macOS
- Neovim 0.10 or newer
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) and
  [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
- `sqlite3`
- Firefox must be closed while reading its history database

## Installation

With [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "sunnybharne/notraycast.vim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  cmd = "NotRaycastHistory",
}
```

For local development:

```lua
{
  dir = "/Users/sunnybharne/code/notraycast.vim",
  name = "notraycast.vim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  cmd = "NotRaycastHistory",
}
```

Optional keymap:

```lua
vim.keymap.set("n", "<leader>fi", "<cmd>NotRaycastHistory<cr>", {
  desc = "Search Firefox history",
})
```

History stays on your machine. The plugin reads Firefox's local database and
passes titles and URLs directly to Telescope.

If you use more than one Firefox profile, select one explicitly before loading
the plugin:

```lua
vim.g.notraycast_firefox_history_file = "~/path/to/places.sqlite"
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
