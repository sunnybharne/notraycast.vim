vim.opt.runtimepath:append(vim.fn.getcwd())
vim.cmd("runtime plugin/notraycast.lua")

local notraycast = require("notraycast")
local query
local opened_url

notraycast.search = function(value)
  query = value
  return {
    { title = "Yellow Duck", url = "https://example.com/yellow-duck" },
  }
end

vim.ui.open = function(url)
  opened_url = url
end

vim.cmd("NotRaycastSearch")
assert(vim.wait(1000, function()
  return vim.bo.filetype == "TelescopePrompt"
end), "query picker did not open")

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local state = require("telescope.state")
local query_buffer = vim.api.nvim_get_current_buf()

state.set_global_key("current_line", "yellow duck")
actions.select_default(query_buffer)

assert(vim.wait(1000, function()
  return query ~= nil
end), "query was not submitted")
assert(query == "yellow duck", "unexpected query")

assert(vim.wait(1000, function()
  return vim.bo.filetype == "TelescopePrompt"
    and vim.api.nvim_get_current_buf() ~= query_buffer
    and action_state.get_selected_entry() ~= nil
end), "results picker did not open")

actions.select_default(vim.api.nvim_get_current_buf())

assert(vim.wait(1000, function()
  return opened_url ~= nil
end), "selected result was not opened")
assert(opened_url == "https://example.com/yellow-duck", "unexpected opened URL")

print("notraycast.vim UI test passed")
