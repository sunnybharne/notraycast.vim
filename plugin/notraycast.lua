if vim.g.loaded_notraycast then
  return
end

vim.g.loaded_notraycast = true

vim.api.nvim_create_user_command("NotRaycastHello", function()
  require("notraycast").hello()
end, {
  desc = "Show the notraycast.vim hello-world message",
})
