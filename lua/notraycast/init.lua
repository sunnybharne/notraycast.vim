local M = {}

local search_url = "https://lite.duckduckgo.com/lite/"
local user_agent = "Lynx/2.9.2 libwww-FM/2.14 SSL-MM/1.4.1"

local function notify(message)
  vim.notify(message, vim.log.levels.ERROR, { title = "notraycast.vim" })
end

local function decode_html(text)
  return text
    :gsub("<.->", "")
    :gsub("&quot;", '"')
    :gsub("&#x27;", "'")
    :gsub("&#39;", "'")
    :gsub("&lt;", "<")
    :gsub("&gt;", ">")
    :gsub("&amp;", "&")
end

function M.parse_results(html)
  local results = {}
  local pattern = '<a[^>]-href="([^"]-)"[^>]-class=\'result%-link\'[^>]*>(.-)</a>'

  for href, title in html:gmatch(pattern) do
    local target = href:match("[?&]uddg=([^&]+)")

    if target then
      local url = vim.uri_decode(target)

      if url:match("^https?://") then
        table.insert(results, {
          title = decode_html(title),
          url = url,
        })
      end
    end
  end

  return results
end

function M.search(query)
  if vim.fn.executable("curl") == 0 then
    error("curl is required", 0)
  end

  local output = vim.fn.system({
    "curl",
    "-fsSL",
    "--max-time",
    "10",
    "-A",
    user_agent,
    "--get",
    "--data-urlencode",
    "q=" .. query,
    search_url,
  })

  if vim.v.shell_error ~= 0 then
    error("DuckDuckGo search failed", 0)
  end

  if
    output:find("challenge-form", 1, true)
    or output:find("anomaly-modal", 1, true)
    or output:find("Unfortunately, bots use DuckDuckGo too", 1, true)
  then
    error("DuckDuckGo requires human verification; try again later", 0)
  end

  return M.parse_results(output)
end

local function show_results(query)
  local ok, results = pcall(M.search, query)

  if not ok then
    notify(results)
    return
  end

  if #results == 0 then
    notify("DuckDuckGo returned no results")
    return
  end

  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local sorter = require("telescope.config").values.generic_sorter

  pickers.new({}, {
    prompt_title = "Results: " .. query,
    finder = finders.new_table({
      results = results,
      entry_maker = function(result)
        return {
          value = result,
          display = result.title .. "  " .. result.url,
          ordinal = result.title .. " " .. result.url,
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

function M.web()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local sorter = require("telescope.config").values.generic_sorter

  pickers.new({}, {
    prompt_title = "Search DuckDuckGo (press Enter)",
    finder = finders.new_table({ results = {} }),
    sorter = sorter({}),
    attach_mappings = function(prompt_buffer)
      actions.select_default:replace(function()
        local query = vim.trim(action_state.get_current_line())

        if query ~= "" then
          actions.close(prompt_buffer)
          show_results(query)
        end
      end)

      return true
    end,
  }):find()
end

return M
