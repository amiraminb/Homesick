local M = {}

local function resolve_variant(variant)
  local selected = variant or vim.g.homesick_variant or "night"
  if selected ~= "moon" and selected ~= "night" then
    selected = "night"
  end
  return selected
end

-- nvim-bqf renders its quickfix preview in a floating window. Without these
-- groups it links BqfPreviewFloat to NormalFloat, so the preview shares the
-- editor/float background and reads as confusing. Match Telescope's preview
-- so the quickfix preview looks like the same kind of floating panel.
function M.get(variant)
  local palette = require("homesick.palette").get(resolve_variant(variant))
  local float_bg = palette.float_bg
  local border = palette.float_thin_line

  return {
    BqfPreviewFloat = { bg = float_bg },
    BqfPreviewBorder = { fg = border, bg = float_bg },
    BqfPreviewTitle = { fg = palette.faded_text, bg = float_bg },
  }
end

return M
