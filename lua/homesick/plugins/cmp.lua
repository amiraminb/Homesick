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

  local menu_bg = is_night and palette.bg or palette.pmenu_bg
  local menu_fg = palette.text
  local sel_bg = is_night and palette.purple or palette.cyan
  local sel_fg = is_night and palette.text or palette.bg

  return {
    CmpItemAbbr = { fg = palette.bar_faded_text, bg = menu_bg },
    CmpItemAbbrDeprecated = { fg = palette.comment, bg = menu_bg, strikethrough = true },
    CmpItemAbbrMatch = { fg = sel_fg, bg = menu_bg, bold = true },
    CmpItemAbbrMatchFuzzy = { fg = sel_fg, bg = menu_bg, bold = true },

    CmpItemKind = { fg = palette.cyan, bg = menu_bg },
    CmpItemKindFunction = { fg = palette.rose, bg = menu_bg },
    CmpItemKindMethod = { fg = palette.rose, bg = menu_bg },
    CmpItemKindConstructor = { fg = palette.rose, bg = menu_bg },
    CmpItemKindVariable = { fg = palette.text, bg = menu_bg },
    CmpItemKindClass = { fg = palette.yellow, bg = menu_bg },
    CmpItemKindInterface = { fg = palette.yellow, bg = menu_bg },
    CmpItemKindModule = { fg = palette.foam or palette.cyan, bg = menu_bg },
    CmpItemKindSnippet = { fg = palette.magenta, bg = menu_bg },
    CmpItemKindKeyword = { fg = palette.purple, bg = menu_bg },
    CmpItemKindFile = { fg = palette.blue, bg = menu_bg },
    CmpItemKindFolder = { fg = palette.blue, bg = menu_bg },

    CmpItemMenu = { fg = palette.comment, bg = menu_bg, italic = true },

    PmenuSel = { fg = sel_fg, bg = sel_bg, bold = true },
    CmpPmenuSel = { fg = sel_fg, bg = sel_bg, bold = true },
  }
end

return M
