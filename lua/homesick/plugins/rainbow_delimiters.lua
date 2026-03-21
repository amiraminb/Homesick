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
    RainbowDelimiterRed = { fg = palette.red },
    RainbowDelimiterYellow = { fg = palette.yellow },
    RainbowDelimiterBlue = { fg = palette.blue },
    RainbowDelimiterOrange = { fg = palette.orange },
    RainbowDelimiterGreen = { fg = palette.green },
    RainbowDelimiterViolet = { fg = palette.purple },
    RainbowDelimiterCyan = { fg = palette.cyan },
  }
end

return M
