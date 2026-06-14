-- Focus-aware dimming for whole-editor inactivity.
--
-- Neovim already dims inactive *splits* via the NormalNC highlight. But when
-- the entire Neovim instance loses focus (e.g. you jump to another tmux pane),
-- Neovim still considers its current window active, so Normal stays bright.
-- This module listens for terminal focus reports (requires the host terminal /
-- tmux to forward them, i.e. `set -g focus-events on`) and, on FocusLost,
-- repaints Normal with the same background NormalNC uses for inactive splits.
-- FocusGained restores the active background.

local M = {}

local GROUP = "HomesickFocusDim"

local cache = {
  active_bg = nil,
  inactive_bg = nil,
  dimmed = false,
}

local function hl_bg(name)
  local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
  if not ok or not hl or hl.bg == nil then
    return nil
  end
  return hl.bg
end

local function set_normal_bg(bg)
  if bg == nil then
    return
  end
  local hl = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
  hl.bg = bg
  vim.api.nvim_set_hl(0, "Normal", hl)
end

-- Re-read the themed active/inactive backgrounds. Called after every theme
-- apply so variant switches (moon/night/galaxy) are picked up automatically.
function M.refresh()
  cache.active_bg = hl_bg("Normal")
  cache.inactive_bg = hl_bg("NormalNC") or cache.active_bg
  cache.dimmed = false
end

local function dim()
  if cache.dimmed or cache.inactive_bg == nil then
    return
  end
  set_normal_bg(cache.inactive_bg)
  cache.dimmed = true
end

local function undim()
  if not cache.dimmed or cache.active_bg == nil then
    return
  end
  set_normal_bg(cache.active_bg)
  cache.dimmed = false
end

function M.setup()
  local group = vim.api.nvim_create_augroup(GROUP, { clear = true })

  M.refresh()

  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "ThemeApplied",
    callback = M.refresh,
  })

  vim.api.nvim_create_autocmd("FocusLost", {
    group = group,
    callback = dim,
  })

  vim.api.nvim_create_autocmd("FocusGained", {
    group = group,
    callback = undim,
  })
end

return M
