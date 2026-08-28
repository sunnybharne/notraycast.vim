local M = {}

local history_query = [[
  SELECT COALESCE(NULLIF(title, ''), url) AS label, url
  FROM moz_places
  WHERE hidden = 0
    AND visit_count > 0
    AND (url LIKE 'https://%' OR url LIKE 'http://%')
  ORDER BY frecency DESC, last_visit_date DESC
  LIMIT 2000;
]]

local function notify(message)
  vim.notify(message, vim.log.levels.ERROR, { title = "notraycast.vim" })
end

local function firefox_history_file()
  local configured_file = vim.g.notraycast_firefox_history_file

  if configured_file and configured_file ~= "" then
    return vim.fn.expand(configured_file)
  end

  local pattern = "~/Library/Application Support/Firefox/Profiles/*/places.sqlite"
  local files = vim.fn.glob(pattern, false, true)

  table.sort(files, function(left, right)
    return vim.fn.getftime(left) > vim.fn.getftime(right)
  end)

  return files[1]
end

function M.load_history()
  local history_file = firefox_history_file()

  if not history_file then
    error("Firefox history was not found", 0)
  end

  if vim.fn.executable("sqlite3") == 0 then
    error("sqlite3 is required", 0)
  end

  local output = vim.fn.system({
    "sqlite3",
    "-readonly",
    "-json",
    history_file,
    history_query,
  })

  if vim.v.shell_error ~= 0 then
    if output:lower():find("locked", 1, true) then
      error("Firefox history is busy; close Firefox and retry", 0)
    end

    error("Firefox history could not be read", 0)
  end

  if output:match("^%s*$") then
    return {}
  end

  return vim.fn.json_decode(output)
end

function M.history()
  local ok, items = pcall(M.load_history)

  if not ok then
    notify(items)
    return
  end

  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local sorter = require("telescope.config").values.generic_sorter

  pickers.new({}, {
    prompt_title = "Firefox history",
    finder = finders.new_table({
      results = items,
      entry_maker = function(item)
        return {
          value = item,
          display = item.label .. "  " .. item.url,
          ordinal = item.label .. " " .. item.url,
        }
      end,
    }),
    sorter = sorter({}),
    attach_mappings = function(prompt_buffer)
      actions.select_default:replace(function()
        local selected = action_state.get_selected_entry()
        actions.close(prompt_buffer)

        if selected then
          vim.ui.open(selected.value.url)
        end
      end)

      return true
    end,
  }):find()
end

return M
