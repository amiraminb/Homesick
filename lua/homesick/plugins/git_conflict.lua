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
    GitConflictCurrent = { bg = palette.diff_add },
    GitConflictCurrentLabel = { bg = palette.diff_add_bg, fg = palette.green, bold = true },
    GitConflictIncoming = { bg = palette.diff_change },
    GitConflictIncomingLabel = { bg = palette.diff_text, fg = palette.softblue, bold = true },
    GitConflictAncestor = { bg = palette.diff_delete },
    GitConflictAncestorLabel = { bg = palette.diff_delete_bg, fg = palette.red, bold = true },
  }
end

return M
