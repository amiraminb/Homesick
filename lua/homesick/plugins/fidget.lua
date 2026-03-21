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
    FidgetNormal = { fg = palette.text, bg = "NONE" },
    FidgetDone = { fg = palette.green, bg = "NONE" },
    FidgetProgress = { fg = palette.yellow, bg = "NONE" },
    FidgetGroup = { fg = palette.text, bg = "NONE", bold = true },
    FidgetIcon = { fg = palette.cyan, bg = "NONE" },
  }
end

return M
