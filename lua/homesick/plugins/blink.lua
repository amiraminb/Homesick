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
  local doc_bg = is_night and palette.float_bg or palette.lualine_bg
  local border_fg = palette.thin_line
  local label_fg = palette.bar_faded_text
  local match_fg = is_night and palette.text or palette.bg

  return {
    BlinkCmpMenu = { fg = palette.text, bg = menu_bg },
    BlinkCmpMenuBorder = { fg = border_fg, bg = menu_bg },
    BlinkCmpDoc = { fg = palette.text, bg = doc_bg },
    BlinkCmpDocBorder = { fg = border_fg, bg = doc_bg },
    BlinkCmpDocSeparator = { fg = border_fg, bg = doc_bg },

    BlinkCmpLabel = { fg = label_fg, bg = menu_bg },
    BlinkCmpLabelDeprecated = { fg = palette.comment, bg = menu_bg, strikethrough = true },
    BlinkCmpLabelMatch = { fg = match_fg, bg = menu_bg, bold = true },

    BlinkCmpKindText = { fg = palette.text, bg = menu_bg },
    BlinkCmpKindMethod = { fg = palette.rose, bg = menu_bg },
    BlinkCmpKindFunction = { fg = palette.rose, bg = menu_bg },
    BlinkCmpKindConstructor = { fg = palette.rose, bg = menu_bg },
    BlinkCmpKindField = { fg = palette.cyan, bg = menu_bg },
    BlinkCmpKindVariable = { fg = palette.text, bg = menu_bg },
    BlinkCmpKindClass = { fg = palette.yellow, bg = menu_bg },
    BlinkCmpKindInterface = { fg = palette.yellow, bg = menu_bg },
    BlinkCmpKindModule = { fg = palette.blue, bg = menu_bg },
    BlinkCmpKindProperty = { fg = palette.cyan, bg = menu_bg },
    BlinkCmpKindUnit = { fg = palette.yellow, bg = menu_bg },
    BlinkCmpKindValue = { fg = palette.orange, bg = menu_bg },
    BlinkCmpKindKeyword = { fg = palette.purple, bg = menu_bg },
    BlinkCmpKindSnippet = { fg = palette.magenta, bg = menu_bg },
    BlinkCmpKindFile = { fg = palette.blue, bg = menu_bg },
    BlinkCmpKindReference = { fg = palette.cyan, bg = menu_bg },
    BlinkCmpKindFolder = { fg = palette.blue, bg = menu_bg },
    BlinkCmpKindEnum = { fg = palette.yellow, bg = menu_bg },
    BlinkCmpKindEnumMember = { fg = palette.cyan, bg = menu_bg },
    BlinkCmpKindConstant = { fg = palette.orange, bg = menu_bg },
    BlinkCmpKindStruct = { fg = palette.yellow, bg = menu_bg },
    BlinkCmpKindEvent = { fg = palette.cyan, bg = menu_bg },
    BlinkCmpKindOperator = { fg = palette.purple, bg = menu_bg },
    BlinkCmpKindTypeParameter = { fg = palette.cyan, bg = menu_bg },

    BlinkCmpGhostText = { fg = palette.comment, bg = "NONE", italic = true },
  }
end

return M
