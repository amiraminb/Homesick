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
    GitConflictCurrent = { bg = palette.blue, bold = true },
    GitConflictCurrentLabel = { bg = palette.blue, fg = palette.cyan, bold = true },
    GitConflictIncoming = { bg = palette.green, bold = true },
    GitConflictIncomingLabel = { bg = palette.green, fg = palette.bar_text, bold = true },
    GitConflictAncestor = { bg = palette.purple, bold = true },
    GitConflictAncestorLabel = { bg = palette.purple, fg = palette.magenta, bold = true },
  }
end

return M
