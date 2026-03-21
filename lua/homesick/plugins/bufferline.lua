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

local function lighten(hex, amount)
  local r, g, b = hex:match("^#(%x%x)(%x%x)(%x%x)$")
  if not r then
    return hex
  end

  local function up(c)
    local n = tonumber(c, 16)
    return clamp(math.floor(n + (255 - n) * amount + 0.5))
  end

  return string.format("#%02x%02x%02x", up(r), up(g), up(b))
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
  local is_night = resolve_variant(variant) == "night"

  local bg = is_night and palette.bg or palette.moon_bg
  local selected_bg = lighten(bg, 0.08)
  local selected_fg = is_night and palette.yellow or palette.text
  local selected_icon_fg = is_night and palette.warmsilver or palette.text

  return {
    fill = { bg = bg },
    background = { fg = palette.bar_faded_text, bg = bg },
    buffer = { fg = palette.bar_faded_text, bg = bg },
    buffer_visible = { fg = palette.bar_faded_text, bg = bg },
    separator = { fg = palette.thin_line, bg = bg },
    separator_visible = { fg = palette.thin_line, bg = bg },
    close_button = { fg = palette.bar_faded_text, bg = bg },
    close_button_visible = { fg = palette.bar_faded_text, bg = bg },
    modified = { fg = palette.yellow, bg = bg },
    modified_visible = { fg = palette.yellow, bg = bg },
    duplicate = { fg = palette.faded_text, bg = bg, italic = true },
    duplicate_visible = { fg = palette.faded_text, bg = bg, italic = true },

    diagnostic = { fg = palette.bar_faded_text, bg = bg },
    diagnostic_visible = { fg = palette.bar_faded_text, bg = bg },
    error = { fg = palette.bar_faded_text, bg = bg },
    error_visible = { fg = palette.bar_faded_text, bg = bg },
    error_diagnostic = { fg = palette.red, bg = bg },
    error_diagnostic_visible = { fg = palette.red, bg = bg },
    warning = { fg = palette.bar_faded_text, bg = bg },
    warning_visible = { fg = palette.bar_faded_text, bg = bg },
    warning_diagnostic = { fg = palette.yellow, bg = bg },
    warning_diagnostic_visible = { fg = palette.yellow, bg = bg },
    info = { fg = palette.bar_faded_text, bg = bg },
    info_visible = { fg = palette.bar_faded_text, bg = bg },
    info_diagnostic = { fg = palette.blue, bg = bg },
    info_diagnostic_visible = { fg = palette.blue, bg = bg },
    hint = { fg = palette.bar_faded_text, bg = bg },
    hint_visible = { fg = palette.bar_faded_text, bg = bg },
    hint_diagnostic = { fg = palette.silver, bg = bg },
    hint_diagnostic_visible = { fg = palette.silver, bg = bg },

    buffer_selected = { fg = selected_fg, bg = selected_bg, bold = true, italic = true },
    duplicate_selected = { fg = selected_fg, bg = selected_bg, bold = true, italic = true },
    error_selected = { fg = selected_icon_fg, bg = selected_bg, bold = true, italic = true },
    error_diagnostic_selected = { fg = palette.red, bg = selected_bg },
    warning_selected = { fg = selected_icon_fg, bg = selected_bg, bold = true, italic = true },
    warning_diagnostic_selected = { fg = palette.yellow, bg = selected_bg },
    info_selected = { fg = selected_icon_fg, bg = selected_bg, bold = true, italic = true },
    info_diagnostic_selected = { fg = palette.blue, bg = selected_bg },
    hint_selected = { fg = selected_icon_fg, bg = selected_bg, bold = true, italic = true },
    hint_diagnostic_selected = { fg = palette.silver, bg = selected_bg },
    separator_selected = { fg = palette.thin_line, bg = selected_bg },
    modified_selected = { fg = palette.yellow, bg = selected_bg },
    close_button_selected = { fg = palette.bar_text, bg = selected_bg },
    indicator_selected = { fg = palette.cyan, bg = selected_bg },
    indicator_visible = { fg = palette.thin_line, bg = bg },
  }
end

return M
