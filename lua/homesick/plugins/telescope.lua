local M = {}

local function clamp(v)
  if v < 0 then
    return 0
  end
  if v > 255 then
    return 255
  end
  return v
end

local function hex_to_rgb(hex)
  local r, g, b = hex:match("^#(%x%x)(%x%x)(%x%x)$")
  if not r then
    return nil
  end
  return tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)
end

local function lighten(hex, amount)
  local r, g, b = hex_to_rgb(hex)
  if not r then
    return hex
  end
  local rr = clamp(math.floor(r + (255 - r) * amount + 0.5))
  local gg = clamp(math.floor(g + (255 - g) * amount + 0.5))
  local bb = clamp(math.floor(b + (255 - b) * amount + 0.5))
  return string.format("#%02x%02x%02x", rr, gg, bb)
end

local function resolve_variant(variant)
  local selected = variant or vim.g.homesick_variant or "night"
  if selected ~= "moon" and selected ~= "night" then
    selected = "night"
  end
  return selected
end

function M.get(variant)
  local palette = require("homesick.palette").get(resolve_variant(variant))
  local is_moon = resolve_variant(variant) == "moon"
  local float_bg = palette.float_bg
  local border = palette.float_thin_line
  local match_fg = is_moon and "#dfaea8" or palette.cyan

  return {
    TelescopeNormal = { bg = float_bg },
    TelescopeBorder = { fg = border, bg = float_bg },
    TelescopePromptNormal = { bg = float_bg },
    TelescopePromptBorder = { fg = border, bg = float_bg },
    TelescopePromptTitle = { fg = palette.faded_text, bg = float_bg },
    TelescopeResultsNormal = { bg = float_bg },
    TelescopeResultsBorder = { fg = border, bg = float_bg },
    TelescopeResultsTitle = { fg = palette.faded_text, bg = float_bg },
    TelescopePreviewNormal = { bg = float_bg },
    TelescopePreviewBorder = { fg = border, bg = float_bg },
    TelescopePreviewTitle = { fg = palette.faded_text, bg = float_bg },
    TelescopeSelection = { bg = lighten(float_bg, 0.08) },
    TelescopeMatching = { fg = match_fg, bold = true },
    TelescopeResultsLineNr = { fg = palette.yellow },
    TelescopeResultsComment = { fg = palette.charcoal },
    TelescopePreviewLine = { bg = lighten(float_bg, 0.12) },
  }
end

return M
