-- Bufferline inactive/visible highlight management
-- "Selected" groups are defined in the lush theme (theme.lua).
-- This module handles all non-selected groups, which need dynamic bg
-- updates when switching between markdown (solid bg) and code (transparent).

local M = {}

local function patch_devicons(inactive_bg, selected_bg)
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

function M.apply_inactive(palette, bufferline_selected_bg, bg)
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
  vim.api.nvim_set_hl(0, "BufferLineIndicatorVisible", { fg = palette.thin_line, bg = bg })
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

  patch_devicons(bg, sel_bg)
end

-- Set up autocmds for moon variant's markdown/code context switching.
-- Updates bufferline + window highlights when switching between filetypes.
function M.setup_context_switching(palette, bufferline_selected_bg, bufferline_bg_markdown, bufferline_bg_code)
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

  local function apply_window_context(buf)
    if not vim.api.nvim_buf_is_valid(buf) then
      return
    end
    local is_markdown = vim.bo[buf].filetype == "markdown"
    for _, win in ipairs(vim.fn.win_findbuf(buf)) do
      set_window_context_highlights(win, is_markdown)
    end
  end

  local function apply_buffer_context(buf)
    apply_window_context(buf)
    local is_markdown = vim.bo[buf].filetype == "markdown"
    local bg = is_markdown and bufferline_bg_markdown or bufferline_bg_code
    M.apply_inactive(palette, bufferline_selected_bg, bg)
  end

  local group = vim.api.nvim_create_augroup("HomesickMarkdownBackground", { clear = true })
  vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter", "BufEnter", "WinEnter" }, {
    group = group,
    callback = function(args)
      local buf = args.buf ~= 0 and args.buf or vim.api.nvim_get_current_buf()
      apply_buffer_context(buf)
    end,
  })

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    apply_window_context(vim.api.nvim_win_get_buf(win))
  end
end

return M
