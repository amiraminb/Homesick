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
    SagaWinbar = { bg = "NONE" },
    SagaWinbarFileName = { fg = palette.bar_text, bg = "NONE", bold = true },
    SagaWinbarFolderName = { fg = palette.bar_faded_text, bg = "NONE" },
    SagaWinbarSep = { fg = palette.bar_faded_text, bg = "NONE" },
    SagaWinbarFileIcon = { bg = "NONE" },
    SagaWinbarModule = { fg = palette.bar_faded_text, bg = "NONE" },
  }
end

return M
