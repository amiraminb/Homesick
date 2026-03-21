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

      DiffviewStatusAdded { fg = color.green },
      DiffviewStatusModified { fg = color.blue },
      DiffviewStatusRenamed { fg = color.purple },
      DiffviewStatusDeleted { fg = color.red },
      DiffviewStatusUnmerged { fg = color.orange, bold = true },
      DiffviewFilePanelInsertions { fg = color.green },
      DiffviewFilePanelDeletions { fg = color.red },
      DiffviewFilePanelTitle { fg = color.cyan, bold = true },
      DiffviewFilePanelCounter { fg = color.faded_text },

      GitSignsAdd { GitAdded },
      GitSignsChange { GitChanged },
      GitSignsDelete { GitDeleted },
      GitSignsUntracked { GitUntracked },

      GitSignsStagedAdd { fg = GitSignsAdd.fg.mix(color.bg, 70) },
      GitSignsStagedChange { fg = GitSignsChange.fg.mix(color.bg, 70) },
      GitSignsStagedDelete { fg = GitSignsDelete.fg.mix(color.bg, 70) },
      GitSignsStagedUntracked { fg = GitSignsUntracked.fg.mix(color.bg, 70) },

      GitSignsAddPreview { fg = color.green, bg = color.diff_add_bg },
      GitSignsDeletePreview { fg = color.red, bg = color.diff_delete_bg },
      GitSignsAddInline { bg = color.green.mix(color.bg, 50) },
      GitSignsDeleteInline { bg = color.red.mix(color.bg, 50) },

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
      Visual { bg = color.blue.mix(color.bg, 30) },
      Whitespace { fg = color.faded_text },
      Winseparator { VertSplit },

      Search { bg = color.bg.lighten(15) },
      CurSearch { fg = color.bg, bg = color.cyan },

      LspReferenceText { bg = is_night and Visual.bg.darken(30) or color.cyan.mix(color.bg, 55) },
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
        bg = is_night and "NONE" or color.red.mix(color.bg, 90),
      },
      DiagnosticVirtualTextWarn {
        fg = color.yellow.mix(color.bg, is_night and 50 or 35),
        bg = is_night and "NONE" or color.yellow.mix(color.bg, 90),
      },
      DiagnosticVirtualTextInfo {
        fg = color.blue.mix(color.bg, is_night and 50 or 35),
        bg = is_night and "NONE" or color.blue.mix(color.bg, 90),
      },
      DiagnosticVirtualTextHint {
        fg = color.silver.mix(color.bg, is_night and 60 or 42),
        bg = is_night and "NONE" or color.silver.mix(color.bg, 92),
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

      FidgetNormal { fg = color.text, bg = "NONE" },
      FidgetDone { fg = color.green, bg = "NONE" },
      FidgetProgress { fg = color.yellow, bg = "NONE" },
      FidgetGroup { fg = color.text, bg = "NONE", bold = true },
      FidgetIcon { fg = color.cyan, bg = "NONE" },

      TodoComment { fg = color.purple },
      FixmeComment { fg = color.red },
      HackComment { fg = color.yellow },
      PriorityComment { fg = color.orange },

      ZenBg { fg = color.text, bg = color.bg },
      WinShiftMove { bg = color.bg.lighten(7) },

      SagaWinbar { bg = "NONE" },
      SagaWinbarFileName { fg = color.bar_text, bg = "NONE", bold = true },
      SagaWinbarFolderName { fg = color.bar_faded_text, bg = "NONE" },
      SagaWinbarSep { fg = color.bar_faded_text, bg = "NONE" },
      SagaWinbarFileIcon { bg = "NONE" },
      SagaWinbarModule { fg = color.bar_faded_text, bg = "NONE" },

      GitConflictCurrent { bg = color.blue, bold = true },
      GitConflictCurrentLabel { bg = color.blue, fg = color.cyan, bold = true },
      GitConflictIncoming { bg = color.green, bold = true },
      GitConflictIncomingLabel { bg = color.green, fg = color.bar_text, bold = true },
      GitConflictAncestor { bg = color.purple, bold = true },
      GitConflictAncestorLabel { bg = color.purple, fg = color.magenta, bold = true },

      DapStoppedLine { bg = color.diff_add_bg },

      FlashCurrent { fg = color.bg, bg = color.green, bold = true },
      FlashMatch { fg = color.bg, bg = color.cyan },
      FlashLabel { fg = color.bg, bg = color.purple, bold = true },
      FlashPrompt { bg = color.bar_bg },
      FlashPromptIcon { bg = color.bar_bg },

      SnacksIndent { fg = color.faded_text.mix(color.bg, 80) },
      SnacksIndentScope { fg = color.faded_text },

      SnacksInputNormal { bg = color.float_bg },
      SnacksInputBorder { fg = color.float_bg, bg = color.float_bg },
      SnacksInputTitle { fg = color.faded_text, bg = color.float_bg },

      SnacksPickerTitle { fg = color.faded_text, bg = color.float_bg },
      SnacksPickerBorder { fg = color.thin_line.lighten(5), bg = color.float_bg },
      SnacksPickerTotals { fg = color.faded_text },
      SnacksPickerBufNr { fg = color.faded_text },
      SnacksPickerDir { fg = color.faded_text },
      SnacksPickerRow { fg = color.faded_text },
      SnacksPickerCol { fg = color.faded_text },
      SnacksPickerTree { fg = color.float_thin_line },
      SnacksPickerSelected { fg = color.cyan },
      SnacksPickerListCursorLine { bg = color.float_bg.lighten(6) },
      SnacksPickerPreviewCursorLine { bg = color.float_bg.lighten(6) },
      SnacksPickerMatch { fg = color.bg, bg = color.cyan },
      SnacksPickerPathHidden { fg = color.text },

      SnacksPickerGitStatusAdded { GitAdded },
      SnacksPickerGitStatusModified { GitChanged },
      SnacksPickerGitStatusStaged { GitStaged },
      SnacksPickerGitStatusUntracked { GitUntracked },

      SnacksTerminal { fg = color.text, bg = "NONE" },
      SnacksTerminalHeader { bg = "NONE", fg = color.cyan, bold = true },
      SnacksTerminalHeaderNC { bg = "NONE", fg = color.faded_text, bold = true },

      ToggleTerm { bg = "NONE" },
      ToggleTermNormal { bg = "NONE" },
      ToggleTermBorder { fg = color.faded_text, bg = "NONE" },

      SnacksNotifierTrace { fg = color.text, bg = color.float_bg },
      SnacksNotifierTitleTrace { fg = color.silver, bg = color.float_bg, bold = true },
      SnacksNotifierBorderTrace { fg = color.float_thin_line, bg = color.float_bg },
      SnacksNotifierIconTrace { fg = color.silver },

      SnacksNotifierDebug { fg = color.text, bg = color.notify_debug_bg },
      SnacksNotifierTitleDebug { fg = color.purple.lighten(15), bg = color.notify_debug_bg, bold = true },
      SnacksNotifierBorderDebug { fg = color.purple.darken(20), bg = color.notify_debug_bg },
      SnacksNotifierIconDebug { fg = color.purple },

      SnacksNotifierInfo { fg = color.text, bg = color.notify_info_bg },
      SnacksNotifierTitleInfo { fg = color.blue.lighten(20), bg = color.notify_info_bg, bold = true },
      SnacksNotifierBorderInfo { fg = color.blue, bg = color.notify_info_bg },
      SnacksNotifierIconInfo { fg = color.blue.lighten(10) },

      SnacksNotifierWarn { fg = color.text, bg = color.notify_warn_bg },
      SnacksNotifierTitleWarn { fg = color.yellow.lighten(10), bg = color.notify_warn_bg, bold = true },
      SnacksNotifierBorderWarn { fg = color.yellow.darken(10), bg = color.notify_warn_bg },
      SnacksNotifierIconWarn { fg = color.yellow },

      SnacksNotifierError { fg = color.text, bg = color.notify_error_bg },
      SnacksNotifierTitleError { fg = color.red.lighten(15), bg = color.notify_error_bg, bold = true },
      SnacksNotifierBorderError { fg = color.red, bg = color.notify_error_bg },
      SnacksNotifierIconError { fg = color.red.lighten(10) },

      SnacksNotifierHistory { bg = color.float_bg },
      SnacksNotifierHistoryTitle { fg = color.cyan, bold = true },
      SnacksNotifierHistoryDateTime { fg = color.faded_text, italic = true },

      TroubleDirectory { fg = color.charcoal },
      TroubleFilename { fg = color.charcoal, bold = true },

      NvimTreeTitle { fg = color.faded_text, bg = "NONE" },
      NvimTreeCursorLine { bg = color.lighter_gray, bold = true },
      NvimTreeFocusedFile { bg = color.lighter_gray, bold = true },
      NvimTreeGitDirty { fg = color.yellow, bold = true },
      NvimTreeGitStaged { fg = color.green, bold = true },
      NvimTreeGitNew { fg = color.green },
      NvimTreeGitDeleted { fg = color.red },
      NvimTreeGitRenamed { fg = color.purple },
      NvimTreeGitMerge { fg = color.orange },
      NvimTreeGitIgnored { fg = color.faded_text },
      NvimTreeModifiedFile { fg = color.yellow, bold = true },

      TelescopeNormal { bg = color.float_bg },
      TelescopeBorder { fg = color.float_thin_line, bg = color.float_bg },
      TelescopePromptNormal { bg = color.float_bg },
      TelescopePromptBorder { fg = color.float_thin_line, bg = color.float_bg },
      TelescopePromptTitle { fg = color.faded_text, bg = color.float_bg },
      TelescopeResultsNormal { bg = color.float_bg },
      TelescopeResultsBorder { fg = color.float_thin_line, bg = color.float_bg },
      TelescopeResultsTitle { fg = color.faded_text, bg = color.float_bg },
      TelescopePreviewNormal { bg = color.float_bg },
      TelescopePreviewBorder { fg = color.float_thin_line, bg = color.float_bg },
      TelescopePreviewTitle { fg = color.faded_text, bg = color.float_bg },
      TelescopeSelection { bg = color.float_bg.lighten(8) },
      TelescopeMatching { fg = color.cyan, bold = true },
      TelescopeResultsLineNr { fg = color.yellow },
      TelescopeResultsComment { fg = color.charcoal },
      TelescopePreviewLine { bg = color.float_bg.lighten(12) },

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
      RainbowDelimiterRed { fg = color.red },
      RainbowDelimiterYellow { fg = color.yellow },
      RainbowDelimiterBlue { fg = color.blue },
      RainbowDelimiterOrange { fg = color.orange },
      RainbowDelimiterGreen { fg = color.green },
      RainbowDelimiterViolet { fg = color.purple },
      RainbowDelimiterCyan { fg = color.cyan },
    }
  end)
  -- stylua: ignore end

  lush(theme)
end

return build
