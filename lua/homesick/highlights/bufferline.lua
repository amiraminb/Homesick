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

return M
