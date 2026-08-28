vim.opt.runtimepath:append(vim.fn.getcwd())
vim.cmd("runtime plugin/notraycast.lua")

assert(
  vim.fn.exists(":NotRaycastSearch") == 2,
  ":NotRaycastSearch was not registered"
)

local html = [[
  <a rel="nofollow"
     href="//duckduckgo.com/l/?uddg=https%3A%2F%2Fexample.com%2Fyellow%2Dduck&amp;rut=test"
     class='result-link'>Yellow &amp; Duck</a>
  <a rel="nofollow"
     href="//duckduckgo.com/l/?uddg=javascript%3Aalert%281%29&amp;rut=test"
     class='result-link'>Unsafe result</a>
]]

local notraycast = require("notraycast")
local results = notraycast.parse_results(html)

assert(#results == 1, "expected one search result")
assert(results[1].title == "Yellow & Duck", "unexpected result title")
assert(results[1].url == "https://example.com/yellow-duck", "unexpected result URL")
assert(#notraycast.parse_results("") == 0, "empty HTML should return no results")

vim.fn.system({ "true" })
local system = vim.fn.system
vim.fn.system = function()
  return '<form id="challenge-form">verification required</form>'
end

local ok, message = pcall(notraycast.search, "yellow duck")
vim.fn.system = system

assert(not ok, "verification page should fail")
assert(message:find("human verification", 1, true), "unexpected verification error")

print("notraycast.vim smoke test passed")
