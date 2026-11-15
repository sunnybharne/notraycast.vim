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

local function picker(title, finder, on_select)
  local actions = require("telescope.actions")
  local state = require("telescope.actions.state")
  require("telescope.pickers").new({}, {
    prompt_title = title,
    finder = require("telescope.finders").new_table(finder),
    sorter = require("telescope.config").values.generic_sorter({}),
    attach_mappings = function(buf)
      actions.select_default:replace(function()
        on_select(buf, actions, state)
      end)
      return true
    end,
  }):find()
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

  picker("Results: " .. query, {
    results = results,
    entry_maker = function(result)
      return {
        value = result,
        display = result.title .. "  " .. result.url,
        ordinal = result.title .. " " .. result.url,
      }
    end,
  }, function(buf, actions, state)
    local selected = state.get_selected_entry()
    actions.close(buf)
    if selected then
      vim.ui.open(selected.value.url)
    end
  end)
end

function M.web()
  picker("Search DuckDuckGo (press Enter)", { results = {} }, function(buf, actions, state)
    local query = vim.trim(state.get_current_line())
    if query ~= "" then
      actions.close(buf)
      show_results(query)
    end
  end)
end

return M
