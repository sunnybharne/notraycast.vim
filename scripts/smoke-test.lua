vim.opt.runtimepath:append(vim.fn.getcwd())
vim.cmd("runtime plugin/notraycast.lua")

assert(
  vim.fn.exists(":NotRaycastHello") == 2,
  ":NotRaycastHello was not registered"
)

local notification
vim.notify = function(message, level, options)
  notification = {
    message = message,
    level = level,
    options = options,
  }
end

vim.cmd("NotRaycastHello")

assert(notification, ":NotRaycastHello did not send a notification")
assert(notification.message == "Hello, world!", "unexpected notification text")
assert(notification.options.title == "notraycast.vim", "unexpected title")

print("notraycast.vim smoke test passed")
