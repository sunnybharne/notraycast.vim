# notraycast.vim development rules

## Product direction

- Build a keyboard-first search tool for Neovim using Telescope.
- Firefox history search is the first experiment, not the final product shape.
- Use Telescope for searching and selection. Do not build a separate UI.

## Code style

- Prefer the smallest working implementation.
- Keep the Lua direct, readable, and easy to change.
- Use short functions with plain names.
- Add abstractions, options, dependencies, and compatibility layers only when a current feature needs them.
- Add one useful behavior at a time and test the real workflow.
- Do not add code or documentation merely to make the project look sophisticated.

## Project upkeep

- Keep the README, changelog, release notes, roadmap, and website aligned with shipped behavior.
- Never collect, upload, or transmit browser history. Read it locally only.
