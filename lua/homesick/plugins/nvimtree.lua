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
    NvimTreeTitle = { fg = palette.faded_text, bg = "NONE" },
    NvimTreeCursorLine = { bg = palette.lighter_gray, bold = true },
    NvimTreeFocusedFile = { bg = palette.lighter_gray, bold = true },
    NvimTreeGitDirty = { fg = palette.yellow, bold = true },
    NvimTreeGitStaged = { fg = palette.green, bold = true },
    NvimTreeGitNew = { fg = palette.green },
    NvimTreeGitDeleted = { fg = palette.red },
    NvimTreeGitRenamed = { fg = palette.purple },
    NvimTreeGitMerge = { fg = palette.orange },
    NvimTreeGitIgnored = { fg = palette.faded_text },
    NvimTreeModifiedFile = { fg = palette.yellow, bold = true },
  }
end

return M
