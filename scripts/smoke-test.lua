vim.opt.runtimepath:append(vim.fn.getcwd())
vim.cmd("runtime plugin/notraycast.lua")

assert(
  vim.fn.exists(":NotRaycastHistory") == 2,
  ":NotRaycastHistory was not registered"
)

local database = vim.fn.tempname() .. ".sqlite"
local schema = [[
  CREATE TABLE moz_places (
    title TEXT,
    url TEXT,
    hidden INTEGER,
    visit_count INTEGER,
    frecency INTEGER,
    last_visit_date INTEGER
  );
  INSERT INTO moz_places VALUES (
    'Example page', 'https://example.com', 0, 1, 100, 1
  );
]]

vim.fn.system({ "sqlite3", database, schema })
assert(vim.v.shell_error == 0, "could not create the test history database")

vim.g.notraycast_firefox_history_file = database
local notraycast = require("notraycast")
local history = notraycast.load_history()

assert(#history == 1, "expected one history entry")
assert(history[1].label == "Example page", "unexpected history label")
assert(history[1].url == "https://example.com", "unexpected history URL")

vim.fn.system({ "sqlite3", database, "DELETE FROM moz_places;" })
assert(#notraycast.load_history() == 0, "empty history should return an empty list")

vim.g.notraycast_firefox_history_file = nil
vim.fn.delete(database)

print("notraycast.vim smoke test passed")
