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
  local is_night = resolve_variant(variant) == "night"

  local bg = is_night and palette.bar_bg or palette.lualine_bg
  local inactive_bg = is_night and palette.bg or palette.moon_bg
  local fg = palette.bar_text
  local muted = palette.bar_faded_text

  return {
    normal = {
      a = { fg = palette.bg, bg = palette.cyan, gui = "bold" },
      b = { fg = fg, bg = bg },
      c = { fg = muted, bg = bg },
    },
    insert = {
      a = { fg = palette.bg, bg = palette.green, gui = "bold" },
      b = { fg = fg, bg = bg },
      c = { fg = muted, bg = bg },
    },
    visual = {
      a = { fg = palette.bg, bg = palette.yellow, gui = "bold" },
      b = { fg = fg, bg = bg },
      c = { fg = muted, bg = bg },
    },
    replace = {
      a = { fg = palette.bg, bg = palette.red, gui = "bold" },
      b = { fg = fg, bg = bg },
      c = { fg = muted, bg = bg },
    },
    command = {
      a = { fg = palette.bg, bg = palette.magenta, gui = "bold" },
      b = { fg = fg, bg = bg },
      c = { fg = muted, bg = bg },
    },
    inactive = {
      a = { fg = muted, bg = inactive_bg, gui = "bold" },
      b = { fg = muted, bg = inactive_bg },
      c = { fg = muted, bg = inactive_bg },
    },
  }
end

return M
