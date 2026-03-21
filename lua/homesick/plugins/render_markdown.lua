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
    return fg
  end
  local r = clamp(math.floor((alpha * fr) + ((1 - alpha) * br) + 0.5))
  local g = clamp(math.floor((alpha * fg2) + ((1 - alpha) * bg2) + 0.5))
  local b = clamp(math.floor((alpha * fb) + ((1 - alpha) * bb) + 0.5))
  return string.format("#%02x%02x%02x", r, g, b)
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
    RenderMarkdownH1Bg = { fg = palette.rose, bg = "NONE", bold = true },
    RenderMarkdownH2Bg = { fg = palette.orange, bg = "NONE", bold = true },
    RenderMarkdownH3Bg = { fg = palette.yellow, bg = "NONE", bold = true },
    RenderMarkdownH4Bg = { fg = palette.cyan, bg = "NONE", bold = true },
    RenderMarkdownH5Bg = { fg = palette.softblue, bg = "NONE", bold = true },
    RenderMarkdownH6Bg = { fg = palette.faded_text, bg = "NONE", bold = true },

    RenderMarkdownCode = { bg = palette.float_bg },
    RenderMarkdownCodeInline = { bg = blend(palette.cyan, palette.bg, 0.90), fg = palette.green },
    RenderMarkdownDash = { fg = palette.thin_line },

    RenderMarkdownQuote1 = { fg = palette.blue },
    RenderMarkdownQuote2 = { fg = palette.purple },
    RenderMarkdownQuote3 = { fg = palette.softteal },
    RenderMarkdownQuote4 = { fg = palette.faded_text },

    RenderMarkdownInfo = { fg = palette.blue },
    RenderMarkdownSuccess = { fg = palette.green },
    RenderMarkdownHint = { fg = palette.purple },
    RenderMarkdownWarn = { fg = palette.yellow },
    RenderMarkdownError = { fg = palette.red },

    RenderMarkdownChecked = { fg = palette.faded_text, strikethrough = true },
    RenderMarkdownUnchecked = { fg = palette.cyan },

    RenderMarkdownLink = { fg = palette.cyan, underline = false },
    RenderMarkdownHtmlComment = { fg = palette.comment },
    RenderMarkdownTableHead = { fg = palette.rose, bold = true },
    RenderMarkdownTableRow = { fg = palette.faded_text },

    ["@markup.link"] = { fg = palette.cyan, underline = false },
    ["@markup.link.label"] = { fg = palette.cyan, underline = false },
    ["@markup.link.url"] = { fg = palette.purple, underline = false },
  }
end

return M
