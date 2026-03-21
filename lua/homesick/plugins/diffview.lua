local M = {}

local function resolve_variant(variant)
  local selected = variant or vim.g.homesick_variant or "night"
  if selected ~= "moon" and selected ~= "night" then
    selected = "night"
  end
  return selected
end

function M.get(variant)
  local palette = require("homesick.palette").get(resolve_variant(variant))

  return {
    DiffviewStatusAdded = { fg = palette.green },
    DiffviewStatusModified = { fg = palette.blue },
    DiffviewStatusRenamed = { fg = palette.purple },
    DiffviewStatusDeleted = { fg = palette.red },
    DiffviewStatusUnmerged = { fg = palette.orange, bold = true },
    DiffviewFilePanelInsertions = { fg = palette.green },
    DiffviewFilePanelDeletions = { fg = palette.red },
    DiffviewFilePanelTitle = { fg = palette.cyan, bold = true },
    DiffviewFilePanelCounter = { fg = palette.faded_text },
  }
end

return M
