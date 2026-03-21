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
    FlashCurrent = { fg = palette.bg, bg = palette.green, bold = true },
    FlashMatch = { fg = palette.bg, bg = palette.cyan },
    FlashLabel = { fg = palette.bg, bg = palette.purple, bold = true },
    FlashPrompt = { bg = palette.bar_bg },
    FlashPromptIcon = { bg = palette.bar_bg },
  }
end

return M
