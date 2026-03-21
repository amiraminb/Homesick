local M = {}

local function clamp(v)
  if v < 0 then
    return 0
  end
  if v > 255 then
    return 255
  end
  return v
end

local function hex_to_rgb(hex)
  local r, g, b = hex:match("^#(%x%x)(%x%x)(%x%x)$")
  if not r then
    return nil
  end
  return tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)
end

local function lighten(hex, amount)
  local r, g, b = hex_to_rgb(hex)
  if not r then
    return hex
  end
  local rr = clamp(math.floor(r + (255 - r) * amount + 0.5))
  local gg = clamp(math.floor(g + (255 - g) * amount + 0.5))
  local bb = clamp(math.floor(b + (255 - b) * amount + 0.5))
  return string.format("#%02x%02x%02x", rr, gg, bb)
end

local function darken(hex, amount)
  local r, g, b = hex_to_rgb(hex)
  if not r then
    return hex
  end
  local rr = clamp(math.floor(r * (1 - amount) + 0.5))
  local gg = clamp(math.floor(g * (1 - amount) + 0.5))
  local bb = clamp(math.floor(b * (1 - amount) + 0.5))
  return string.format("#%02x%02x%02x", rr, gg, bb)
end

local function blend(fg, bg, alpha)
  local fr, fg2, fb = hex_to_rgb(fg)
  local br, bg2, bb = hex_to_rgb(bg)
  if not fr or not br then
    return fg
  end
  local r = clamp(math.floor((alpha * fr) + ((1 - alpha) * br) + 0.5))
  local g = clamp(math.floor((alpha * fg2) + ((1 - alpha) * bg2) + 0.5))
  local b = clamp(math.floor((alpha * fb) + ((1 - alpha) * bb) + 0.5))
  return string.format("#%02x%02x%02x", r, g, b)
end

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
    SnacksIndent = { fg = blend(palette.faded_text, palette.bg, 0.20) },
    SnacksIndentScope = { fg = palette.faded_text },

    SnacksInputNormal = { bg = palette.float_bg },
    SnacksInputBorder = { fg = palette.float_bg, bg = palette.float_bg },
    SnacksInputTitle = { fg = palette.faded_text, bg = palette.float_bg },

    SnacksPickerTitle = { fg = palette.faded_text, bg = palette.float_bg },
    SnacksPickerBorder = { fg = lighten(palette.thin_line, 0.05), bg = palette.float_bg },
    SnacksPickerTotals = { fg = palette.faded_text },
    SnacksPickerBufNr = { fg = palette.faded_text },
    SnacksPickerDir = { fg = palette.faded_text },
    SnacksPickerRow = { fg = palette.faded_text },
    SnacksPickerCol = { fg = palette.faded_text },
    SnacksPickerTree = { fg = palette.float_thin_line },
    SnacksPickerSelected = { fg = palette.cyan },
    SnacksPickerListCursorLine = { bg = lighten(palette.float_bg, 0.06) },
    SnacksPickerPreviewCursorLine = { bg = lighten(palette.float_bg, 0.06) },
    SnacksPickerMatch = { fg = palette.bg, bg = palette.cyan },
    SnacksPickerPathHidden = { fg = palette.text },

    SnacksPickerGitStatusAdded = { fg = palette.green },
    SnacksPickerGitStatusModified = { fg = palette.blue },
    SnacksPickerGitStatusStaged = { fg = palette.purple },
    SnacksPickerGitStatusUntracked = { fg = palette.teal },

    SnacksTerminal = { fg = palette.text, bg = "NONE" },
    SnacksTerminalHeader = { bg = "NONE", fg = palette.cyan, bold = true },
    SnacksTerminalHeaderNC = { bg = "NONE", fg = palette.faded_text, bold = true },

    SnacksNotifierTrace = { fg = palette.text, bg = palette.float_bg },
    SnacksNotifierTitleTrace = { fg = palette.silver, bg = palette.float_bg, bold = true },
    SnacksNotifierBorderTrace = { fg = palette.float_thin_line, bg = palette.float_bg },
    SnacksNotifierIconTrace = { fg = palette.silver },

    SnacksNotifierDebug = { fg = palette.text, bg = palette.notify_debug_bg },
    SnacksNotifierTitleDebug = { fg = lighten(palette.purple, 0.15), bg = palette.notify_debug_bg, bold = true },
    SnacksNotifierBorderDebug = { fg = darken(palette.purple, 0.20), bg = palette.notify_debug_bg },
    SnacksNotifierIconDebug = { fg = palette.purple },

    SnacksNotifierInfo = { fg = palette.text, bg = palette.notify_info_bg },
    SnacksNotifierTitleInfo = { fg = lighten(palette.blue, 0.20), bg = palette.notify_info_bg, bold = true },
    SnacksNotifierBorderInfo = { fg = palette.blue, bg = palette.notify_info_bg },
    SnacksNotifierIconInfo = { fg = lighten(palette.blue, 0.10) },

    SnacksNotifierWarn = { fg = palette.text, bg = palette.notify_warn_bg },
    SnacksNotifierTitleWarn = { fg = lighten(palette.yellow, 0.10), bg = palette.notify_warn_bg, bold = true },
    SnacksNotifierBorderWarn = { fg = darken(palette.yellow, 0.10), bg = palette.notify_warn_bg },
    SnacksNotifierIconWarn = { fg = palette.yellow },

    SnacksNotifierError = { fg = palette.text, bg = palette.notify_error_bg },
    SnacksNotifierTitleError = { fg = lighten(palette.red, 0.15), bg = palette.notify_error_bg, bold = true },
    SnacksNotifierBorderError = { fg = palette.red, bg = palette.notify_error_bg },
    SnacksNotifierIconError = { fg = lighten(palette.red, 0.10) },

    SnacksNotifierHistory = { bg = palette.float_bg },
    SnacksNotifierHistoryTitle = { fg = palette.cyan, bold = true },
    SnacksNotifierHistoryDateTime = { fg = palette.faded_text, italic = true },
  }
end

return M
