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
  return {
    WinShiftMove = { bg = lighten(palette.bg, 0.07) },
  }
end

return M
