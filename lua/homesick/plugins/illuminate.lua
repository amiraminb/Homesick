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

local function blend(fg, bg, alpha)
  local fr, fg2, fb = hex_to_rgb(fg)
  local br, bg2, bb = hex_to_rgb(bg)
  if not fr or not br then
    return bg
  end
  local r = clamp(math.floor((alpha * fr) + ((1 - alpha) * br) + 0.5))
  local g = clamp(math.floor((alpha * fg2) + ((1 - alpha) * bg2) + 0.5))
  local b = clamp(math.floor((alpha * fb) + ((1 - alpha) * bb) + 0.5))
  return string.format("#%02x%02x%02x", r, g, b)
end

local function resolve_variant(variant)
  local selected = variant or vim.g.homesick_variant or "night"
  if selected ~= "moon" and selected ~= "night" and selected ~= "galaxy" then
    selected = "night"
  end
  return selected
end

function M.get(variant)
  local selected = resolve_variant(variant)
  local palette = require("homesick.palette").get(selected)
  local is_night = selected == "night" or selected == "galaxy"

  local ref_bg = is_night and blend(palette.blue, palette.bg, 0.16) or blend(palette.cyan, palette.bg, 0.24)

  return {
    IlluminatedWordText = { bg = ref_bg, underline = false },
    IlluminatedWordRead = { bg = ref_bg, underline = false },
    IlluminatedWordWrite = { bg = ref_bg, underline = false },
  }
end

return M
