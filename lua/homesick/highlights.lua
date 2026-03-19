local M = {}

local function hi(group, spec)
  vim.api.nvim_set_hl(0, group, spec)
end

function M.apply(p, variant, scheme_name)
  vim.opt.termguicolors = true

  if vim.g.colors_name then
    vim.cmd("hi clear")
    vim.cmd("syntax reset")
  end

  vim.g.colors_name = scheme_name or "homesick"
  vim.o.background = "dark"

  vim.g.terminal_color_0 = p.bg
  vim.g.terminal_color_1 = p.red
  vim.g.terminal_color_2 = p.green
  vim.g.terminal_color_3 = p.yellow
  vim.g.terminal_color_4 = p.blue
  vim.g.terminal_color_5 = p.magenta
  vim.g.terminal_color_6 = p.cyan
  vim.g.terminal_color_7 = p.white
  vim.g.terminal_color_8 = p.brightBlack
  vim.g.terminal_color_9 = p.brightRed
  vim.g.terminal_color_10 = p.brightGreen
  vim.g.terminal_color_11 = p.brightYellow
  vim.g.terminal_color_12 = p.brightBlue
  vim.g.terminal_color_13 = p.brightMagenta
  vim.g.terminal_color_14 = p.brightCyan
  vim.g.terminal_color_15 = p.brightWhite

  local is_night = variant == "night"

  local normal_bg = is_night and p.bg or "NONE"
  local comment_fg = is_night and p.faded_text or p.comment
  local ident_fg = is_night and p.softcream or "#C7C9CC"
  local function_fg = is_night and p.softteal or p.rose
  local operator_fg = is_night and p.rose or p.strong_text
  local keyword_fg = is_night and p.redrose or p.blue
  local type_fg = is_night and p.softblue or p.cyan
  local status_bg = is_night and p.bar_bg or p.lualine_bg

  hi("Normal", { fg = p.text, bg = normal_bg })
  hi("NormalNC", { fg = p.text, bg = normal_bg })
  hi("Comment", { fg = comment_fg, italic = not is_night })

  hi("Constant", { fg = is_night and p.silver or p.yellow })
  hi("String", { fg = is_night and p.purple or p.yellow })
  hi("Character", { fg = is_night and p.teal or p.yellow })
  hi("Number", { fg = is_night and p.yellow or p.number })
  hi("Boolean", { fg = is_night and p.yellow or p.rose })
  hi("Float", { fg = p.yellow })

  hi("Identifier", { fg = ident_fg })
  hi("Function", { fg = function_fg })
  hi("Statement", { fg = is_night and p.purple or p.blue, bold = not is_night })
  hi("Operator", { fg = operator_fg })
  hi("Keyword", { fg = keyword_fg })
  hi("PreProc", { fg = p.magenta })
  hi("Include", { fg = p.blue, bold = is_night })
  hi("Macro", { fg = p.orange })
  hi("Type", { fg = type_fg, bold = is_night })
  hi("Special", { fg = p.silver })

  hi("CursorLine", { bg = is_night and "#171d24" or "#10141d" })
  hi("CursorColumn", { bg = is_night and "#212834" or "#1a2230" })
  hi("ColorColumn", { bg = is_night and p.thin_line or p.lualine_bg })
  hi("LineNr", { fg = p.strong_faded_text })
  hi("CursorLineNr", { fg = p.yellow, bold = true })
  hi("SignColumn", { fg = p.text, bg = "NONE" })

  hi("StatusLine", { bg = status_bg })
  hi("StatusLineNC", { bg = status_bg })
  hi("TabLine", { bg = "NONE" })
  hi("TabLineFill", { bg = "NONE" })
  hi("TabLineSel", { bg = "NONE" })

  hi("NormalFloat", { fg = p.text, bg = p.float_bg })
  hi("FloatBorder", { fg = p.faded_text, bg = p.float_bg })
  hi("FloatTitle", { fg = p.faded_text, bg = p.float_bg, bold = true })
  hi("Pmenu", { fg = p.text, bg = "#10141d" })
  hi("PmenuSel", { fg = p.text, bg = "#1a2230", bold = true })

  hi("DiagnosticError", { fg = p.red })
  hi("DiagnosticWarn", { fg = p.yellow })
  hi("DiagnosticInfo", { fg = p.blue })
  hi("DiagnosticHint", { fg = p.silver })

  hi("GitSignsAdd", { fg = p.green })
  hi("GitSignsChange", { fg = p.blue })
  hi("GitSignsDelete", { fg = p.red })
  hi("DiffAdd", { bg = p.diff_add_bg })
  hi("DiffChange", { bg = "#1b2f45" })
  hi("DiffDelete", { bg = p.diff_delete_bg })
  hi("DiffText", { bg = "#244a66" })

  hi("TelescopeNormal", { bg = p.float_bg })
  hi("TelescopeBorder", { fg = p.float_thin_line, bg = p.float_bg })
  hi("TelescopePromptNormal", { bg = p.float_bg })
  hi("TelescopeResultsNormal", { bg = p.float_bg })
  hi("TelescopePreviewNormal", { bg = p.float_bg })
end

return M
