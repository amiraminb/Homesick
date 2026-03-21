local M = {}

M.config = {
  variant = "night",
}

function M.setup(opts)
  M.config = vim.tbl_extend("force", M.config, opts or {})
end

function M.load(variant, scheme_name)
  local palette = require("homesick.palette")
  local highlights = require("homesick.highlights")

  local selected = variant or vim.g.homesick_variant or M.config.variant or "night"
  if selected ~= "moon" and selected ~= "night" and selected ~= "galaxy" then
    selected = "night"
  end

  vim.g.homesick_variant = selected

  highlights.apply(palette.get(selected), selected, scheme_name or ("homesick-" .. selected))
end

M.apply = M.load

return M
