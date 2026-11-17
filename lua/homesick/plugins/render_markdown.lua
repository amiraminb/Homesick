local M = {}

local function resolve_variant(variant)
  local selected = variant or vim.g.homesick_variant or "night"
  if selected ~= "moon" and selected ~= "night" then
    selected = "night"
  end
  return selected
end

function M.get(variant)
  local selected = resolve_variant(variant)
  local palette = require("homesick.palette").get(selected)
  local is_moon = selected == "moon"
  local markdown_text = palette.text
  local markdown_muted = is_moon and palette.warmsilver or palette.faded_text
  local heading_colors = {
    palette.red,
    palette.orange,
    palette.green,
    palette.softblue,
    palette.purple,
    palette.cyan,
  }

  local groups = {
    RenderMarkdownCode = { bg = palette.float_bg },
    RenderMarkdownCodeInline = { bg = palette.float_bg, fg = palette.red },
    RenderMarkdownDash = { fg = palette.thin_line },
    RenderMarkdownBullet = { fg = palette.charcoal },

    RenderMarkdownQuote1 = { fg = markdown_muted },
    RenderMarkdownQuote2 = { fg = markdown_muted },
    RenderMarkdownQuote3 = { fg = markdown_muted },
    RenderMarkdownQuote4 = { fg = markdown_muted },

    RenderMarkdownInfo = { fg = markdown_muted },
    RenderMarkdownSuccess = { fg = markdown_muted },
    RenderMarkdownHint = { fg = markdown_muted },
    RenderMarkdownWarn = { fg = markdown_muted },
    RenderMarkdownError = { fg = markdown_muted },

    RenderMarkdownChecked = { fg = markdown_muted, strikethrough = true },
    RenderMarkdownUnchecked = { fg = markdown_muted },

    RenderMarkdownLink = { fg = palette.cyan, underline = false },
    RenderMarkdownHtmlComment = { fg = palette.comment },
    RenderMarkdownTableHead = { fg = markdown_text, bold = true },
    RenderMarkdownTableRow = { fg = markdown_muted },

    ["@markup.heading"] = { fg = markdown_text, bold = true },
    ["@markup.strong"] = { fg = markdown_text, bold = true },
    ["@markup.italic"] = { fg = markdown_text, italic = true },
    ["@markup.quote"] = { fg = markdown_muted },
    ["@markup.list"] = { fg = palette.charcoal },
    ["@markup.raw"] = { fg = palette.red },
    ["@markup.link"] = { fg = palette.cyan, underline = false },
    ["@markup.link.label"] = { fg = palette.cyan, underline = false },
    ["@markup.link.url"] = { fg = palette.yellow, underline = false },
  }

  for level, fg in ipairs(heading_colors) do
    groups["RenderMarkdownH" .. level .. "Bg"] = { fg = fg, bg = "NONE", bold = true }
    groups["@markup.heading." .. level] = { fg = fg, bold = true }
  end

  return groups
end

return M
