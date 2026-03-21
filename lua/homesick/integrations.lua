local M = {}

local defaults = {
  cmp = true,
  blink = true,
  illuminate = true,
  telescope = true,
  nvimtree = true,
  trouble = true,
  gitsigns = true,
  snacks = true,
  diffview = true,
  render_markdown = true,
  todo_comments = true,
  flash = true,
  git_conflict = true,
  fidget = true,
  toggleterm = true,
  lspsaga = true,
  dap = true,
  rainbow_delimiters = true,
  zenmode = true,
  winshift = true,
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
  if cfg.trouble then
    apply_groups(require("homesick.plugins.trouble").get)
  end
  if cfg.gitsigns then
    apply_groups(require("homesick.plugins.gitsigns").get)
  end
  if cfg.snacks then
    apply_groups(require("homesick.plugins.snacks").get)
  end
  if cfg.diffview then
    apply_groups(require("homesick.plugins.diffview").get)
  end
  if cfg.render_markdown then
    apply_groups(require("homesick.plugins.render_markdown").get)
  end
  if cfg.todo_comments then
    apply_groups(require("homesick.plugins.todo_comments").get)
  end
  if cfg.flash then
    apply_groups(require("homesick.plugins.flash").get)
  end
  if cfg.git_conflict then
    apply_groups(require("homesick.plugins.git_conflict").get)
  end
  if cfg.fidget then
    apply_groups(require("homesick.plugins.fidget").get)
  end
  if cfg.toggleterm then
    apply_groups(require("homesick.plugins.toggleterm").get)
  end
  if cfg.lspsaga then
    apply_groups(require("homesick.plugins.lspsaga").get)
  end
  if cfg.dap then
    apply_groups(require("homesick.plugins.dap").get)
  end
  if cfg.rainbow_delimiters then
    apply_groups(require("homesick.plugins.rainbow_delimiters").get)
  end
  if cfg.zenmode then
    apply_groups(require("homesick.plugins.zenmode").get)
  end
  if cfg.winshift then
    apply_groups(require("homesick.plugins.winshift").get)
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
