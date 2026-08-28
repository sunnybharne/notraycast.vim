if vim.g.loaded_notraycast then
  return
end

vim.g.loaded_notraycast = true

vim.api.nvim_create_user_command("NotRaycastHistory", function()
  require("notraycast").history()
end, {
  desc = "Search Firefox history with Telescope",
})
