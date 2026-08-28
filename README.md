# notraycast.vim

[![CI](https://github.com/sunnybharne/notraycast.vim/actions/workflows/ci.yml/badge.svg)](https://github.com/sunnybharne/notraycast.vim/actions/workflows/ci.yml)
[![GitHub Pages](https://github.com/sunnybharne/notraycast.vim/actions/workflows/pages.yml/badge.svg)](https://github.com/sunnybharne/notraycast.vim/actions/workflows/pages.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Search the web from Neovim with Telescope and DuckDuckGo.

## Current release

Version `0.3.0` provides one command:

```vim
:NotRaycastSearch
```

Type a web query and press Enter. Telescope shows the top DuckDuckGo links;
press Enter again to open one.

## Requirements

- Neovim 0.10 or newer
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) and
  [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
- `curl`

## Installation

With [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "sunnybharne/notraycast.vim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  cmd = "NotRaycastSearch",
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
  cmd = "NotRaycastSearch",
}
```

Optional keymap:

```lua
vim.keymap.set("n", "<leader>fi", "<cmd>NotRaycastSearch<cr>", {
  desc = "Search the web",
})
```

Queries are sent to DuckDuckGo's Lite search page. The plugin extracts result
titles and links; it does not need an API key.

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
