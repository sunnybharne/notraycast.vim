local M = {}

function M.hello()
  vim.notify("Hello, world!", vim.log.levels.INFO, {
    title = "notraycast.vim",
  })
end

return M
