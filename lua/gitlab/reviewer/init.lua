-- This Module will pick the reviewer set in the user's
-- settings and then map all of it's functions
local state = require("gitlab.state")
local delta = require("gitlab.reviewer.delta")

local M = {
  reviewer = nil,
}

local reviewer_map = {
  delta = delta
}

M.init = function()
  local reviewer = reviewer_map[state.settings.reviewer]
  if reviewer == nil then
    vim.notify(string.format("gitlab.nvim could not find reviewer %s", state.settings.reviewer), vim.log.levels.ERROR)
    return
  end

  M.open = reviewer.open
  -- Opens the reviewer window

  M.jump = reviewer.jump
  -- Jumps to the location provided in the reviewer window
  -- Parameters:
  --   • {file_name}      The name of the file to jump to
  --   • {new_line}  The new_line of the change
  --   • {interval}  The old_lien of the change

  M.get_location = reviewer.get_location
  -- Returns the current location (based on cursor) from the reviewer window
end


return M
