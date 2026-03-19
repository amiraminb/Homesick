-- Homesick highlight orchestrator
-- Sets up color context, applies lush theme, and configures bufferline.

local M = {}

function M.apply(palette, variant, scheme_name)
  vim.opt.termguicolors = true

  if vim.g.colors_name then
    vim.cmd("hi clear")
    vim.cmd("syntax reset")
  end

  vim.g.colors_name = scheme_name or ("homesick-" .. (variant or "moon"))

  local lush = require("lush")
  local is_night = variant == "night"

  vim.o.background = "dark"

  -- Terminal colors
  vim.g.terminal_color_0 = palette.bg
  vim.g.terminal_color_1 = palette.red
  vim.g.terminal_color_2 = palette.green
  vim.g.terminal_color_3 = palette.yellow
  vim.g.terminal_color_4 = palette.blue
  vim.g.terminal_color_5 = palette.magenta
  vim.g.terminal_color_6 = palette.cyan
  vim.g.terminal_color_7 = palette.white
  vim.g.terminal_color_8 = palette.brightBlack
  vim.g.terminal_color_9 = palette.brightRed
  vim.g.terminal_color_10 = palette.brightGreen
  vim.g.terminal_color_11 = palette.brightYellow
  vim.g.terminal_color_12 = palette.brightBlue
  vim.g.terminal_color_13 = palette.brightMagenta
  vim.g.terminal_color_14 = palette.brightCyan
  vim.g.terminal_color_15 = palette.brightWhite

  -- Convert palette hex strings to lush HSL objects
  local color = {}
  for key, value in pairs(palette) do
    color[key] = lush.hsl(value)
  end

  -- Moon variant accent colors
  local moon = {
    text = color.moon_text or color.text,
    love = color.moon_love or color.red,
    gold = color.moon_gold or color.yellow,
    rose = color.rose,
    pine = color.blue,
    foam = color.cyan,
    iris = color.moon_iris or color.purple,
    subtle = color.strong_text,
  }

  local use_moon_syntax = not is_night

  local function pick_syntax(night, moon)
    return use_moon_syntax and moon or night
  end

  -- Build context table for theme module
  local ctx = {
    color = color,
    moon = moon,
    pick_syntax = pick_syntax,
    use_moon_syntax = use_moon_syntax,
    is_night = is_night,
    code_bg = is_night and color.bg or color.moon_bg,
    inactive_bg = is_night and color.bg or color.inactive_bg,
    markdown_bg = color.bg,
    markdown_cursorline_bg = is_night and color.bg.lighten(4) or color.markdown_cursorline,
    cursorline_code_bg = is_night and color.bg.lighten(4) or color.markdown_cursorline,
    function_color = is_night and color.softteal or pick_syntax(color.rose, moon.rose),
    cursorcolumn_bg = is_night and color.bg.lighten(20) or (color.moon_bg or color.bg).lighten(12),
    colorcolumn_bg = is_night and color.thin_line or color.lualine_bg,
    qf_currentline_fg = is_night and color.rose or color.redrose,
    statusline_bg = is_night and color.bar_bg or color.lualine_bg,
    night_comment = is_night and color.faded_text or color.comment,
    night_identifier = is_night and color.softcream.desaturate(10).darken(5) or color.text,
    night_operator = is_night and color.rose or color.operator_alt,
    night_keyword = is_night and color.redrose or color.operator_alt,
    night_number = is_night and color.yellow or color.number,
    night_type = is_night and color.softblue or color.type_text,
    underlined_fg = use_moon_syntax and moon.iris or nil,
    bufferline_selected_bg = color.bg.lighten(8),
    bufferline_selected_fg = is_night and color.yellow or color.text,
    bufferline_selected_icon_fg = is_night and color.warmsilver or color.text,
    bufferline_selected_italic = not is_night,
  }

  -- Apply lush theme
  require("homesick.highlights.theme")(ctx)

  -- Apply bufferline inactive highlights (both variants)
  local bufferline = require("homesick.highlights.bufferline")
  local bufferline_bg_code = is_night and palette.bg or "NONE"
  bufferline.apply_inactive(palette, ctx.bufferline_selected_bg, bufferline_bg_code)

  if is_night then
    vim.api.nvim_exec_autocmds("User", { pattern = "ThemeApplied" })
    return
  end

  -- Moon variant: dynamic context switching for markdown/code backgrounds
  local bufferline_bg_markdown = palette.bg
  bufferline.setup_context_switching(palette, ctx.bufferline_selected_bg, bufferline_bg_markdown, bufferline_bg_code)

  vim.api.nvim_exec_autocmds("User", { pattern = "ThemeApplied" })
end

return M
