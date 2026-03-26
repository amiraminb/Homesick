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
  local is_moon = selected == "moon"

  local menu_bg = is_dark_ui and palette.bg or palette.pmenu_bg
  local option_fg = is_moon and palette.softcream or palette.bar_faded_text
  local match_fg = is_moon and palette.white or (is_dark_ui and palette.cyan or palette.blue)

  local kind_default = is_moon and option_fg or palette.cyan
  local kind_function = is_moon and option_fg or palette.rose
  local kind_variable = is_moon and option_fg or palette.text
  local kind_class = is_moon and option_fg or palette.yellow
  local kind_module = is_moon and option_fg or (palette.foam or palette.cyan)
  local kind_snippet = is_moon and option_fg or palette.magenta
  local kind_keyword = is_moon and option_fg or palette.purple
  local kind_file = is_moon and option_fg or palette.blue

  return {
    CmpItemAbbr = { fg = option_fg, bg = "NONE" },
    CmpItemAbbrDeprecated = { fg = palette.comment, bg = "NONE", strikethrough = true },
    CmpItemAbbrMatch = { fg = match_fg, bg = "NONE", bold = true },
    CmpItemAbbrMatchFuzzy = { fg = match_fg, bg = "NONE", bold = true },

    CmpItemKind = { fg = kind_default, bg = "NONE" },
    CmpItemKindFunction = { fg = kind_function, bg = "NONE" },
    CmpItemKindMethod = { fg = kind_function, bg = "NONE" },
    CmpItemKindConstructor = { fg = kind_function, bg = "NONE" },
    CmpItemKindVariable = { fg = kind_variable, bg = "NONE" },
    CmpItemKindClass = { fg = kind_class, bg = "NONE" },
    CmpItemKindInterface = { fg = kind_class, bg = "NONE" },
    CmpItemKindModule = { fg = kind_module, bg = "NONE" },
    CmpItemKindSnippet = { fg = kind_snippet, bg = "NONE" },
    CmpItemKindKeyword = { fg = kind_keyword, bg = "NONE" },
    CmpItemKindFile = { fg = kind_file, bg = "NONE" },
    CmpItemKindFolder = { fg = kind_file, bg = "NONE" },

    CmpItemMenu = { fg = is_moon and option_fg or palette.comment, bg = "NONE", italic = true },

    CmpPmenuSel = { link = "PmenuSel" },
  }
end

return M
