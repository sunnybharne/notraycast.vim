# Release notes

## v0.2.0 — Firefox history search

Released on August 28, 2026.

Run `:NotRaycastHistory` to open a Telescope picker containing local Firefox
history. Search page titles or URLs, then press Enter to open a result.

The implementation is intentionally small: it locates the newest Firefox
profile, asks `sqlite3` for the top 2,000 history entries, and gives those
entries to Telescope. History is never uploaded or transmitted.

Firefox currently needs to be closed while the history database is read.

## v0.1.0 — Hello, world!

Released on August 28, 2026.

This first release establishes the smallest working foundation for
notraycast.vim. Install the plugin and run `:NotRaycastHello` to display a
Neovim notification.

### Included

- A conventional Neovim runtime plugin layout.
- A public `require("notraycast").hello()` Lua function.
- The `:NotRaycastHello` user command.
- Automated smoke testing.
- Contributor documentation, roadmap, changelog, and project website.

### Next

Future features will be selected and shaped incrementally. See the
[roadmap](ROADMAP.md) and GitHub project board for the current direction.
