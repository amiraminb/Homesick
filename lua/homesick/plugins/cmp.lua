local M = {}

local function resolve_variant(variant)
  local selected = variant or vim.g.homesick_variant or "night"
  if selected ~= "moon" and selected ~= "night" and selected ~= "galaxy" then
    selected = "night"
  end
  return selected
end

function M.get(variant)
  local selected = resolve_variant(variant)
  local palette = require("homesick.palette").get(selected)
  local is_dark_ui = selected == "night" or selected == "galaxy"

  local menu_bg = is_dark_ui and palette.bg or palette.pmenu_bg
  local sel_bg = is_dark_ui and palette.float_bg or palette.cyan
  local sel_fg = is_dark_ui and palette.cyan or palette.bg
  local match_fg = is_dark_ui and palette.cyan or palette.blue

  return {
    CmpItemAbbr = { fg = palette.bar_faded_text, bg = "NONE" },
    CmpItemAbbrDeprecated = { fg = palette.comment, bg = "NONE", strikethrough = true },
    CmpItemAbbrMatch = { fg = match_fg, bg = "NONE", bold = true },
    CmpItemAbbrMatchFuzzy = { fg = match_fg, bg = "NONE", bold = true },

    CmpItemKind = { fg = palette.cyan, bg = "NONE" },
    CmpItemKindFunction = { fg = palette.rose, bg = "NONE" },
    CmpItemKindMethod = { fg = palette.rose, bg = "NONE" },
    CmpItemKindConstructor = { fg = palette.rose, bg = "NONE" },
    CmpItemKindVariable = { fg = palette.text, bg = "NONE" },
    CmpItemKindClass = { fg = palette.yellow, bg = "NONE" },
    CmpItemKindInterface = { fg = palette.yellow, bg = "NONE" },
    CmpItemKindModule = { fg = palette.foam or palette.cyan, bg = "NONE" },
    CmpItemKindSnippet = { fg = palette.magenta, bg = "NONE" },
    CmpItemKindKeyword = { fg = palette.purple, bg = "NONE" },
    CmpItemKindFile = { fg = palette.blue, bg = "NONE" },
    CmpItemKindFolder = { fg = palette.blue, bg = "NONE" },

    CmpItemMenu = { fg = palette.comment, bg = "NONE", italic = true },

    PmenuSel = { fg = sel_fg, bg = sel_bg, bold = true },
    CmpPmenuSel = { fg = sel_fg, bg = sel_bg, bold = true },
  }
end

return M
