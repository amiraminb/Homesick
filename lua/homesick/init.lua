local M = {}

M.config = {
  variant = "moon",
}

function M.setup(opts)
  M.config = vim.tbl_extend("force", M.config, opts or {})
end

function M.load(variant, scheme_name)
  local palette = require("homesick.palette")
  local highlights = require("homesick.highlights")

  local selected = variant or vim.g.homesick_variant or M.config.variant or "moon"
  if selected ~= "moon" and selected ~= "night" then
    selected = "moon"
  end

  highlights.apply(palette.get(selected), selected, scheme_name or ("homesick-" .. selected))
end

M.apply = M.load

return M
