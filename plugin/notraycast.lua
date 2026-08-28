if vim.g.loaded_notraycast then
  return
end

vim.g.loaded_notraycast = true

vim.api.nvim_create_user_command("NotRaycastSearch", function()
  require("notraycast").web()
end, {
  desc = "Search the web with DuckDuckGo and Telescope",
})
