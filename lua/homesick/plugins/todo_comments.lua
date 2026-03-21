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
    TodoComment = { fg = palette.purple },
    FixmeComment = { fg = palette.red },
    HackComment = { fg = palette.yellow },
    PriorityComment = { fg = palette.orange },
  }
end

return M
