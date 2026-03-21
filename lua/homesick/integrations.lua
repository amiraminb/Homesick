local M = {}

local defaults = {
  cmp = true,
  blink = true,
  illuminate = true,
  telescope = true,
  nvimtree = true,
}

local function current_variant()
  return vim.g.homesick_variant or "moon"
end

local function apply_groups(getter)
  local ok, map = pcall(getter, current_variant())
  if not ok or type(map) ~= "table" then
    return
  end

  for group, spec in pairs(map) do
    vim.api.nvim_set_hl(0, group, spec)
  end
end

function M.apply(opts)
  local cfg = vim.tbl_extend("force", defaults, opts or {})

  if cfg.cmp then
    apply_groups(require("homesick.plugins.cmp").get)
  end
  if cfg.blink then
    apply_groups(require("homesick.plugins.blink").get)
  end
  if cfg.illuminate then
    apply_groups(require("homesick.plugins.illuminate").get)
  end
  if cfg.telescope then
    apply_groups(require("homesick.plugins.telescope").get)
  end
  if cfg.nvimtree then
    apply_groups(require("homesick.plugins.nvimtree").get)
  end
end

function M.setup(opts)
  local cfg = vim.tbl_extend("force", defaults, opts or {})
  local group = vim.api.nvim_create_augroup("HomesickIntegrations", { clear = true })

  vim.api.nvim_create_autocmd({ "ColorScheme", "User" }, {
    group = group,
    pattern = { "homesick", "homesick-*", "ThemeApplied" },
    callback = function()
      M.apply(cfg)
    end,
  })

  vim.schedule(function()
    M.apply(cfg)
  end)
end

return M
