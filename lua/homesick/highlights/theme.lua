-- Lush theme definition for homesick
-- Receives a context table with all derived colors and flags.
-- Returns lush highlight groups.

local function build(ctx)
  local lush = require("lush")
  local color = ctx.color
  local moon = ctx.moon
  local pick_syntax = ctx.pick_syntax
  local use_moon_syntax = ctx.use_moon_syntax
  local is_night = ctx.is_night

  -- stylua: ignore start
  local theme = lush(function(fn)
    local sym = fn.sym

    return {
      Normal { fg = color.text, bg = ctx.code_bg },
      NormalNC { fg = color.text, bg = ctx.inactive_bg },
      Comment { fg = pick_syntax(ctx.night_comment, moon.subtle), italic = use_moon_syntax },

      Constant { fg = pick_syntax(color.silver, moon.gold) },
      String { fg = pick_syntax(color.purple, moon.gold) },
      Character { fg = pick_syntax(color.teal, moon.gold) },
      Number { fg = pick_syntax(ctx.night_number, moon.gold) },
      Boolean { fg = pick_syntax(color.yellow, moon.rose) },
      Float { fg = pick_syntax(color.yellow, moon.gold) },

      Identifier { fg = pick_syntax(ctx.night_identifier, moon.text) },
      Function { fg = ctx.function_color },

      Statement { fg = pick_syntax(color.purple, moon.pine), bold = use_moon_syntax },
      Operator { fg = pick_syntax(ctx.night_operator, moon.subtle) },
      Keyword { fg = pick_syntax(ctx.night_keyword, moon.pine) },

      PreProc { fg = pick_syntax(color.magenta, moon.iris) },
      Include { fg = pick_syntax(color.blue, moon.pine), bold = not use_moon_syntax },
      Macro { fg = pick_syntax(color.orange, moon.iris) },

      Type { fg = pick_syntax(ctx.night_type, moon.foam), bold = not use_moon_syntax },
      Typedef { Type },

      Special { fg = pick_syntax(color.silver, moon.foam) },
      Delimiter { fg = pick_syntax(color.faded_text, moon.subtle) },
      Underlined { fg = ctx.underlined_fg, gui = "underline" },

      sym"@comment" { Comment },
      sym"@constant" { Constant },
      sym"@constant.builtin" { fg = pick_syntax(color.yellow, moon.gold), bold = use_moon_syntax },
      sym"@constant.macro" { Constant },
      sym"@macro" { Macro },
      sym"@string" { String },
      sym"@string.escape" { fg = pick_syntax(ctx.night_operator, moon.pine) },
      sym"@character" { Character },
      sym"@number" { Number },
      sym"@boolean" { Boolean },
      sym"@float" { Float },
      sym"@function" { Function },
      sym"@function.builtin" { fg = pick_syntax(color.redrose, moon.rose), bold = use_moon_syntax },
      sym"@function.macro" { Function },
      sym"@field" { fg = pick_syntax(Identifier.fg, moon.foam) },
      sym"@property" { fg = pick_syntax(Identifier.fg, moon.foam), italic = use_moon_syntax },
      sym"@constructor" { Special },
      sym"@operator" { Operator },
      sym"@keyword" { Keyword },
      sym"@variable" { fg = pick_syntax(Identifier.fg, moon.text), italic = use_moon_syntax },
      sym"@variable.builtin" { fg = pick_syntax(color.redrose, moon.love), italic = use_moon_syntax, bold = use_moon_syntax },
      sym"@variable.parameter" { fg = pick_syntax(Identifier.fg, moon.iris), italic = use_moon_syntax },
      sym"@variable.member" { fg = pick_syntax(Identifier.fg, moon.foam) },
      sym"@type" { Type },
      sym"@type.definition" { Typedef },
      sym"@type.builtin" { fg = pick_syntax(Type.fg, moon.foam), bold = use_moon_syntax },
      sym"@type.qualifier" { Type },
      sym"@include" { Include },
      sym"@module" { fg = pick_syntax(color.redrose, moon.text) },
      sym"@namespace" { fg = pick_syntax(color.redrose, moon.text) },
      sym"@attribute" { fg = pick_syntax(color.magenta, moon.iris) },
      sym"@attribute.builtin" { fg = pick_syntax(color.magenta, moon.iris), bold = use_moon_syntax },

      Conceal { fg = color.faded_text },
      Cursor { reverse = true },
      CursorColumn { bg = ctx.cursorcolumn_bg },
      CursorLine { bg = ctx.cursorline_code_bg },
      WinBar { bg = "NONE" },
      WinBarNC { bg = "NONE" },
      QfCurrentLine { fg = ctx.qf_currentline_fg, bold = true },
      VirtColumn { fg = color.thin_line },
      ColorColumn { bg = ctx.colorcolumn_bg },
      Directory { fg = color.text },

      GitAdded { fg = color.green },
      GitChanged { fg = color.blue },
      GitDeleted { fg = color.red },
      GitUntracked { fg = color.teal },
      GitStaged { fg = color.purple },

      diffAdded { GitAdded },
      diffChanged { GitChanged },
      diffDeleted { GitDeleted },

      DiffAdd { bg = color.diff_add, fg = "NONE" },
      DiffChange { bg = color.diff_change, fg = "NONE" },
      DiffDelete { bg = color.diff_delete, fg = "NONE" },
      DiffText { bg = color.diff_text, fg = "NONE" },

      Folded { fg = color.faded_text, bg = ctx.code_bg.lighten(3) },
      FoldColumn { fg = color.text, bg = "NONE" },
      SignColumn { fg = color.text, bg = "NONE" },
      LineNr { fg = color.strong_faded_text },
      CursorLineNr { fg = color.yellow, bold = true },
      MatchParen { fg = color.white, bg = color.cyan.darken(50) },
      MsgArea { fg = color.strong_text },
      ModeMsg { MsgArea },
      NonText { fg = color.faded_text },

      NormalFloat { fg = color.text, bg = color.float_bg },
      Pmenu { fg = color.text, bg = is_night and color.bg.lighten(3) or color.pmenu_bg },
      PmenuSel {
        fg = is_night and color.text or color.bg,
        bg = is_night and color.purple.mix(color.bg, 70) or color.cyan.mix(color.bg, 20),
        bold = true,
      },
      PmenuSbar { bg = Pmenu.bg.lighten(5) },
      PmenuThumb { bg = Pmenu.bg.lighten(15) },
      SpecialKey { fg = color.faded_text },

      StatusLine { bg = ctx.statusline_bg },
      StatusLineNC { StatusLine },
      TabLine { bg = "NONE" },
      TabLineFill { bg = "NONE" },
      TabLineSel { bg = "NONE" },

      Title { fg = color.magenta, bold = true },
      VertSplit { fg = color.thin_line },
      Visual { bg = is_night and color.blue.mix(color.bg, 30) or color.markdown_cursorline },
      Whitespace { fg = color.faded_text },
      Winseparator { VertSplit },

      Search { bg = color.bg.lighten(15) },
      CurSearch { fg = color.bg, bg = color.cyan },

      LspReferenceText {
        bg = is_night and Visual.bg.darken(30) or color.cyan.mix(color.bg, 55),
      },
      LspReferenceRead { LspReferenceText },
      LspReferenceWrite { LspReferenceText },
      LspInlayHint { Comment, bold = true },
      LspCodeLens { LspInlayHint },

      DiagnosticError { fg = color.red },
      DiagnosticWarn { fg = color.yellow },
      DiagnosticInfo { fg = color.blue },
      DiagnosticHint { fg = color.silver },
      DiagnosticSignError { fg = color.red.lighten(20), bold = true },
      DiagnosticSignWarn { fg = color.yellow.lighten(20), bold = true },
      DiagnosticSignInfo { fg = color.blue.lighten(20), bold = true },
      DiagnosticSignHint { fg = color.silver.lighten(20), bold = true },
      DiagnosticVirtualTextError {
        fg = color.red.mix(color.bg, is_night and 50 or 35),
        bg = "NONE",
        italic = true,
      },
      DiagnosticVirtualTextWarn {
        fg = color.yellow.mix(color.bg, is_night and 50 or 35),
        bg = "NONE",
        italic = true,
      },
      DiagnosticVirtualTextInfo {
        fg = color.blue.mix(color.bg, is_night and 50 or 35),
        bg = "NONE",
        italic = true,
      },
      DiagnosticVirtualTextHint {
        fg = color.silver.mix(color.bg, is_night and 60 or 42),
        bg = "NONE",
        italic = true,
      },
      DiagnosticVirtualLinesError { DiagnosticVirtualTextError },
      DiagnosticVirtualLinesWarn { DiagnosticVirtualTextWarn },
      DiagnosticVirtualLinesInfo { DiagnosticVirtualTextInfo },
      DiagnosticVirtualLinesHint { DiagnosticVirtualTextHint },
      DiagnosticUnderlineError { },
      DiagnosticUnderlineWarn { },
      DiagnosticUnderlineInfo { },
      DiagnosticUnderlineHint { },
      DiagnosticFloatingErrorLabel { fg = color.float_bg, bg = DiagnosticError.fg },
      DiagnosticFloatingWarnLabel { fg = color.float_bg, bg = DiagnosticWarn.fg },
      DiagnosticFloatingInfoLabel { fg = color.float_bg, bg = DiagnosticInfo.fg },
      DiagnosticFloatingHintLabel { fg = color.float_bg, bg = DiagnosticHint.fg },

      FloatTitle { fg = color.faded_text, bg = color.float_bg, bold = true },
      FloatBorder { fg = color.faded_text, bg = color.float_bg },

      sym"@markup.raw" { fg = color.green },
      sym"@markup.raw.block" { fg = color.text },
      sym"@markup.raw.delimiter" { fg = color.faded_text },

      sym"@lsp.type.type" { Type },
      sym"@lsp.type.struct" { Type },
      sym"@lsp.type.interface" { Type },
      sym"@lsp.type.typeParameter" { Type },
      sym"@lsp.type.namespace" { fg = pick_syntax(is_night and color.rose or color.redrose, moon.text) },
      sym"@lsp.type.variable" { Identifier },
      sym"@lsp.type.property" { Identifier },
      sym"@lsp.type.parameter" { Identifier },
      sym"@lsp.type.member" { Identifier },

      sym"@punctuation.bracket" { fg = color.cyan },
    }
  end)
  -- stylua: ignore end

  lush(theme)
end

return build
