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
  local is_vintage_variant = variant == "night"

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

  -- Rosé Pine accent colors (moon variant syntax uses these)
  local rp = {
    text = color.rp_text or color.text,
    love = color.rp_love or color.red,
    gold = color.rp_gold or color.yellow,
    rose = color.rose,
    pine = color.blue,
    foam = color.cyan,
    iris = color.rp_iris or color.purple,
    subtle = color.strong_text,
  }

  local use_rosepine_syntax = not is_vintage_variant

  local function sx(legacy, rosepine)
    return use_rosepine_syntax and rosepine or legacy
  end

  -- Build context table for theme module
  local ctx = {
    color = color,
    rp = rp,
    sx = sx,
    use_rosepine_syntax = use_rosepine_syntax,
    is_vintage_variant = is_vintage_variant,
    code_bg = is_vintage_variant and color.bg or "NONE",
    markdown_bg = color.bg,
    markdown_cursorline_bg = is_vintage_variant and color.bg.lighten(4) or color.markdown_cursorline,
    cursorline_code_bg = is_vintage_variant and color.bg.lighten(4) or color.markdown_cursorline,
    function_color = is_vintage_variant and color.softteal or sx(color.rose, rp.rose),
    cursorcolumn_bg = is_vintage_variant and color.bg.lighten(20) or (color.rp_bg or color.bg).lighten(12),
    colorcolumn_bg = is_vintage_variant and color.thin_line or color.lualine_bg,
    qf_currentline_fg = is_vintage_variant and color.rose or color.redrose,
    statusline_bg = is_vintage_variant and color.bar_bg or color.lualine_bg,
    legacy_comment = is_vintage_variant and color.faded_text or color.comment,
    legacy_identifier = is_vintage_variant and color.softcream.desaturate(10).darken(5) or color.text,
    legacy_operator = is_vintage_variant and color.rose or color.operator_alt,
    legacy_keyword = is_vintage_variant and color.redrose or color.operator_alt,
    legacy_number = is_vintage_variant and color.yellow or color.number,
    legacy_type = is_vintage_variant and color.softblue or color.type_text,
    underlined_fg = use_rosepine_syntax and rp.iris or nil,
    bufferline_selected_bg = color.bg.lighten(8),
    bufferline_selected_fg = is_vintage_variant and color.yellow or color.text,
    bufferline_selected_icon_fg = is_vintage_variant and color.warmsilver or color.text,
    bufferline_selected_italic = not is_vintage_variant,
  }

  -- Apply lush theme
  require("homesick.highlights.theme")(ctx)

  -- Apply bufferline inactive highlights (both variants)
  local bufferline = require("homesick.highlights.bufferline")
  local bufferline_bg_code = is_vintage_variant and palette.bg or "NONE"
  bufferline.apply_inactive(palette, ctx.bufferline_selected_bg, bufferline_bg_code)

  if is_vintage_variant then
    vim.api.nvim_exec_autocmds("User", { pattern = "ThemeApplied" })
    return
  end

  -- Moon variant: dynamic context switching for markdown/code backgrounds
  local bufferline_bg_markdown = palette.bg
  bufferline.setup_context_switching(palette, ctx.bufferline_selected_bg, bufferline_bg_markdown, bufferline_bg_code)

  vim.api.nvim_exec_autocmds("User", { pattern = "ThemeApplied" })
end

return M
