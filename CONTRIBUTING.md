# Contributing

Thanks for helping shape notraycast.vim.

## Proposing a change

Open a feature request before starting a substantial change so the intended
workflow can be discussed. Small fixes can go directly to a pull request.

## Local setup

1. Clone the repository.
2. Add the checkout to Neovim's runtime path through your plugin manager.
3. Run the smoke test:

   ```sh
   nvim --headless -u NONE -l scripts/smoke-test.lua
   ```

## Pull requests

- Keep each change focused.
- Update documentation for user-visible behavior.
- Add an entry beneath `Unreleased` in `CHANGELOG.md`.
- Confirm the smoke test passes.

By participating, you agree to follow the [Code of Conduct](CODE_OF_CONDUCT.md).
