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

  local color = {}
  for key, value in pairs(palette) do
    color[key] = lush.hsl(value)
  end

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
  local rp_bg = color.rp_bg or color.bg
  local code_bg = is_vintage_variant and color.bg or "NONE"
  local markdown_bg = color.bg
  local markdown_cursorline_bg = is_vintage_variant and color.bg.lighten(4) or color.markdown_cursorline
  local cursorline_code_bg = markdown_cursorline_bg
  local bufferline_selected_bg = color.bg.lighten(8)
  local bufferline_bg_markdown = palette.bg
  local bufferline_bg_code = is_vintage_variant and palette.bg or "NONE"

  local use_rosepine_syntax = not is_vintage_variant
  local legacy_comment = is_vintage_variant and color.faded_text or color.comment
  local legacy_identifier = is_vintage_variant and color.softcream.desaturate(10).darken(5) or color.text
  local legacy_operator = is_vintage_variant and color.rose or color.operator_alt
  local legacy_keyword = is_vintage_variant and color.redrose or legacy_operator
  local legacy_number = is_vintage_variant and color.yellow or color.number
  local legacy_type = is_vintage_variant and color.softblue or color.type_text
  local underlined_fg = use_rosepine_syntax and rp.iris or nil

  local function sx(legacy, rosepine)
    return use_rosepine_syntax and rosepine or legacy
  end

  local function_color = is_vintage_variant and color.softteal or sx(color.rose, rp.rose)
  local cursorcolumn_bg = is_vintage_variant and color.bg.lighten(20) or rp_bg.lighten(12)
  local colorcolumn_bg = is_vintage_variant and color.thin_line or color.lualine_bg
  local qf_currentline_fg = is_vintage_variant and color.rose or color.redrose
  local statusline_bg = is_vintage_variant and color.bar_bg or color.lualine_bg
  local bufferline_selected_fg = is_vintage_variant and color.yellow or color.text
  local bufferline_selected_icon_fg = is_vintage_variant and color.warmsilver or color.text
  local bufferline_selected_italic = not is_vintage_variant

  -- stylua: ignore start
  local theme = lush(function(fn)
    local sym = fn.sym

    return {
      Normal { fg = color.text, bg = code_bg },
      NormalNC { fg = color.text, bg = code_bg },
      HyperMarkdownNormal { fg = color.text, bg = markdown_bg },
      HyperMarkdownNormalNC { fg = color.text, bg = markdown_bg },
      HyperMarkdownCursorLine { bg = markdown_cursorline_bg },
      Comment { fg = sx(legacy_comment, rp.subtle), italic = use_rosepine_syntax },

      Constant { fg = sx(color.silver, rp.gold) },
      String { fg = sx(color.purple, rp.gold) },
      Character { fg = sx(color.teal, rp.gold) },
      Number { fg = sx(legacy_number, rp.gold) },
      Boolean { fg = sx(color.yellow, rp.rose) },
      Float { fg = sx(color.yellow, rp.gold) },

      Identifier { fg = sx(legacy_identifier, rp.text) },
      Function { fg = function_color },

      Statement { fg = sx(color.purple, rp.pine), bold = use_rosepine_syntax },
      Operator { fg = sx(legacy_operator, rp.subtle) },
      Keyword { fg = sx(legacy_keyword, rp.pine) },

      PreProc { fg = sx(color.magenta, rp.iris) },
      Include { fg = sx(color.blue, rp.pine), bold = not use_rosepine_syntax },
      Macro { fg = sx(color.orange, rp.iris) },

      Type { fg = sx(legacy_type, rp.foam), bold = not use_rosepine_syntax },
      Typedef { Type },

      Special { fg = sx(color.silver, rp.foam) },
      Delimiter { fg = sx(color.faded_text, rp.subtle) },
      Underlined { fg = underlined_fg, gui = "underline" },

      sym"@comment" { Comment },
      sym"@constant" { Constant },
      sym"@constant.builtin" { fg = sx(color.yellow, rp.gold), bold = use_rosepine_syntax },
      sym"@constant.macro" { Constant },
      sym"@macro" { Macro },
      sym"@string" { String },
      sym"@string.escape" { fg = sx(legacy_operator, rp.pine) },
      sym"@character" { Character },
      sym"@number" { Number },
      sym"@boolean" { Boolean },
      sym"@float" { Float },
      sym"@function" { Function },
      sym"@function.builtin" { fg = sx(color.redrose, rp.rose), bold = use_rosepine_syntax },
      sym"@function.macro" { Function },
      sym"@field" { fg = sx(Identifier.fg, rp.foam) },
      sym"@property" { fg = sx(Identifier.fg, rp.foam), italic = use_rosepine_syntax },
      sym"@constructor" { Special },
      sym"@operator" { Operator },
      sym"@keyword" { Keyword },
      sym"@variable" { fg = sx(Identifier.fg, rp.text), italic = use_rosepine_syntax },
      sym"@variable.builtin" { fg = sx(color.redrose, rp.love), italic = use_rosepine_syntax, bold = use_rosepine_syntax },
      sym"@variable.parameter" { fg = sx(Identifier.fg, rp.iris), italic = use_rosepine_syntax },
      sym"@variable.member" { fg = sx(Identifier.fg, rp.foam) },
      sym"@type" { Type },
      sym"@type.definition" { Typedef },
      sym"@type.builtin" { fg = sx(Type.fg, rp.foam), bold = use_rosepine_syntax },
      sym"@type.qualifier" { Type },
      sym"@include" { Include },
      sym"@module" { fg = sx(color.redrose, rp.text) },
      sym"@namespace" { fg = sx(color.redrose, rp.text) },
      sym"@attribute" { fg = sx(color.magenta, rp.iris) },
      sym"@attribute.builtin" { fg = sx(color.magenta, rp.iris), bold = use_rosepine_syntax },

      Conceal { fg = color.faded_text },
      Cursor { reverse = true },
      CursorColumn { bg = cursorcolumn_bg },
      CursorLine { bg = cursorline_code_bg },
      WinBar { bg = "NONE" },
      WinBarNC { bg = "NONE" },
      QfCurrentLine { fg = qf_currentline_fg, bold = true },
      VirtColumn { fg = color.thin_line },
      ColorColumn { bg = colorcolumn_bg },
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

      Folded { fg = color.faded_text, bg = color.bg.lighten(3) },
      FoldColumn { fg = color.text, bg = "NONE" },
      SignColumn { fg = color.text, bg = "NONE" },
      LineNr { fg = color.strong_faded_text },
      CursorLineNr { fg = color.yellow, bold = true },
      MatchParen { fg = color.white, bg = color.cyan.darken(50) },
      MsgArea { fg = color.strong_text },
      ModeMsg { MsgArea },
      NonText { fg = color.faded_text },

      NormalFloat { fg = color.text, bg = color.float_bg },
      Pmenu { fg = color.text, bg = is_vintage_variant and color.bg.lighten(3) or color.pmenu_bg },
      PmenuSel { fg = color.text, bg = color.purple.mix(color.bg, 70), bold = true },
      PmenuSbar { bg = Pmenu.bg.lighten(5) },
      PmenuThumb { bg = Pmenu.bg.lighten(15) },
      SpecialKey { fg = color.faded_text },

      StatusLine { bg = statusline_bg },
      StatusLineNC { StatusLine },
      TabLine { bg = "NONE" },
      TabLineFill { bg = "NONE" },
      TabLineSel { bg = "NONE" },

      BufferLineBufferSelected { fg = bufferline_selected_fg, bg = bufferline_selected_bg, bold = true, italic = bufferline_selected_italic },
      BufferLineDuplicateSelected { fg = bufferline_selected_fg, bg = bufferline_selected_bg, bold = true, italic = true },
      BufferLineDuplicate { fg = color.faded_text, bg = "NONE", italic = true },
      BufferLineDuplicateVisible { fg = color.faded_text, bg = "NONE", italic = true },
      BufferLineErrorSelected { fg = bufferline_selected_icon_fg, bg = bufferline_selected_bg, bold = true, italic = bufferline_selected_italic },
      BufferLineErrorDiagnostic { fg = color.red, bg = "NONE" },
      BufferLineErrorDiagnosticVisible { fg = color.red, bg = "NONE" },
      BufferLineErrorDiagnosticSelected { fg = color.red, bg = bufferline_selected_bg },
      BufferLineWarningSelected { fg = bufferline_selected_icon_fg, bg = bufferline_selected_bg, bold = true, italic = bufferline_selected_italic },
      BufferLineWarningDiagnostic { fg = color.yellow, bg = "NONE" },
      BufferLineWarningDiagnosticVisible { fg = color.yellow, bg = "NONE" },
      BufferLineWarningDiagnosticSelected { fg = color.yellow, bg = bufferline_selected_bg },
      BufferLineInfoSelected { fg = bufferline_selected_icon_fg, bg = bufferline_selected_bg, bold = true, italic = bufferline_selected_italic },
      BufferLineInfoDiagnostic { fg = color.blue, bg = "NONE" },
      BufferLineInfoDiagnosticVisible { fg = color.blue, bg = "NONE" },
      BufferLineInfoDiagnosticSelected { fg = color.blue, bg = bufferline_selected_bg },
      BufferLineHintSelected { fg = bufferline_selected_icon_fg, bg = bufferline_selected_bg, bold = true, italic = bufferline_selected_italic },
      BufferLineHintDiagnostic { fg = color.silver, bg = "NONE" },
      BufferLineHintDiagnosticVisible { fg = color.silver, bg = "NONE" },
      BufferLineHintDiagnosticSelected { fg = color.silver, bg = bufferline_selected_bg },

      BufferLineBufferVisible { fg = color.bar_faded_text, bg = "NONE" },

      BufferLineSeparator { fg = color.thin_line, bg = "NONE" },
      BufferLineSeparatorSelected { fg = color.thin_line, bg = bufferline_selected_bg },
      BufferLineSeparatorVisible { fg = color.thin_line, bg = "NONE" },

      BufferLineModified { fg = color.yellow, bg = "NONE" },
      BufferLineModifiedSelected { fg = color.yellow, bg = bufferline_selected_bg },
      BufferLineModifiedVisible { fg = color.yellow, bg = "NONE" },

      BufferLineCloseButton { fg = color.bar_faded_text, bg = "NONE" },
      BufferLineCloseButtonSelected { fg = color.bar_text, bg = bufferline_selected_bg },
      BufferLineCloseButtonVisible { fg = color.bar_faded_text, bg = "NONE" },

      BufferLineIndicatorSelected { fg = color.cyan, bg = bufferline_selected_bg },
      BufferLineIndicatorVisible { fg = color.thin_line, bg = "NONE" },

      Title { fg = color.magenta, bold = true },
      VertSplit { fg = color.thin_line },
      Visual { bg = color.blue.mix(color.bg, 30) },
      Whitespace { fg = color.faded_text },
      Winseparator { VertSplit },

      Search { bg = color.bg.lighten(15) },
      CurSearch { fg = color.bg, bg = color.cyan },

      LspReferenceText { bg = Visual.bg.darken(30) },
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
      DiagnosticVirtualTextError { fg = color.red.mix(color.bg, 50) },
      DiagnosticVirtualTextWarn { fg = color.yellow.mix(color.bg, 50) },
      DiagnosticVirtualTextInfo { fg = color.blue.mix(color.bg, 50) },
      DiagnosticVirtualTextHint { fg = color.silver.mix(color.bg, 60) },
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
      sym"@lsp.type.namespace" { fg = sx(is_vintage_variant and color.rose or color.redrose, rp.text) },
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

  if is_vintage_variant then
    vim.api.nvim_exec_autocmds("User", { pattern = "ThemeApplied" })
    return
  end

  local function set_window_context_highlights(win, is_markdown)
    if not vim.api.nvim_win_is_valid(win) then
      return
    end

    local cfg = vim.api.nvim_win_get_config(win)
    local is_floating = cfg and cfg.relative and cfg.relative ~= ""

    local current = vim.wo[win].winhighlight or ""
    local items = {}

    for item in string.gmatch(current, "[^,]+") do
      local from = item:match("^([^:]+):")
      if from ~= "Normal" and from ~= "NormalNC" and from ~= "CursorLine" then
        table.insert(items, item)
      end
    end

    if is_markdown and not is_floating then
      table.insert(items, "Normal:HyperMarkdownNormal")
      table.insert(items, "NormalNC:HyperMarkdownNormalNC")
      table.insert(items, "CursorLine:HyperMarkdownCursorLine")
    end

    vim.wo[win].winhighlight = table.concat(items, ",")
  end

  local function apply_window_context_for_buffer(buf)
    if not vim.api.nvim_buf_is_valid(buf) then
      return
    end

    local is_markdown = vim.bo[buf].filetype == "markdown"
    for _, win in ipairs(vim.fn.win_findbuf(buf)) do
      set_window_context_highlights(win, is_markdown)
    end
  end

  local function patch_bufferline_devicons(inactive_bg, selected_bg)
    local all_hls = vim.api.nvim_get_hl(0, {})
    for name, hl in pairs(all_hls) do
      if name:match("^BufferLineDevIcon") then
        local is_selected = name:match("Selected$")
        local target_bg = is_selected and selected_bg or inactive_bg
        if hl.fg then
          vim.api.nvim_set_hl(0, name, { fg = hl.fg, bg = target_bg, bold = hl.bold, italic = hl.italic })
        end
      end
    end
  end

  local function apply_bufferline_context_for_buffer(buf)
    local is_markdown = vim.bo[buf].filetype == "markdown"
    local bg = is_markdown and bufferline_bg_markdown or bufferline_bg_code
    local sel_bg = tostring(bufferline_selected_bg)

    vim.api.nvim_set_hl(0, "BufferLineFill", { bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineBackground", { bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineBufferVisible", { fg = palette.bar_faded_text, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineSeparator", { fg = palette.thin_line, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineSeparatorVisible", { fg = palette.thin_line, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineModified", { fg = palette.yellow, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineModifiedVisible", { fg = palette.yellow, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineCloseButton", { fg = palette.bar_faded_text, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineCloseButtonVisible", { fg = palette.bar_faded_text, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineError", { fg = palette.bar_faded_text, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineErrorVisible", { fg = palette.bar_faded_text, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineWarning", { fg = palette.bar_faded_text, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineWarningVisible", { fg = palette.bar_faded_text, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineInfo", { fg = palette.bar_faded_text, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineInfoVisible", { fg = palette.bar_faded_text, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineHint", { fg = palette.bar_faded_text, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineHintVisible", { fg = palette.bar_faded_text, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineErrorDiagnostic", { fg = palette.red, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineErrorDiagnosticVisible", { fg = palette.red, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineWarningDiagnostic", { fg = palette.yellow, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineWarningDiagnosticVisible", { fg = palette.yellow, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineInfoDiagnostic", { fg = palette.blue, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineInfoDiagnosticVisible", { fg = palette.blue, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineHintDiagnostic", { fg = palette.silver, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineHintDiagnosticVisible", { fg = palette.silver, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineDuplicate", { fg = palette.faded_text, bg = bg, italic = true })
    vim.api.nvim_set_hl(0, "BufferLineDuplicateVisible", { fg = palette.faded_text, bg = bg, italic = true })

    patch_bufferline_devicons(bg, sel_bg)
  end

  local function apply_buffer_context(buf)
    apply_window_context_for_buffer(buf)
    apply_bufferline_context_for_buffer(buf)
  end

  local md_bg_group = vim.api.nvim_create_augroup("HomesickMarkdownBackground", { clear = true })
  vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter", "BufEnter", "WinEnter" }, {
    group = md_bg_group,
    callback = function(args)
      local buf = args.buf ~= 0 and args.buf or vim.api.nvim_get_current_buf()
      apply_buffer_context(buf)
    end,
  })

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    apply_window_context_for_buffer(vim.api.nvim_win_get_buf(win))
  end
  apply_bufferline_context_for_buffer(vim.api.nvim_get_current_buf())

  vim.api.nvim_exec_autocmds("User", { pattern = "ThemeApplied" })
end

return M
