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
  local markdown_text = is_moon and palette.text or palette.rose
  local markdown_muted = is_moon and palette.warmsilver or palette.faded_text

  return {
    RenderMarkdownH1Bg = { fg = markdown_text, bg = "NONE", bold = true },
    RenderMarkdownH2Bg = { fg = markdown_text, bg = "NONE", bold = true },
    RenderMarkdownH3Bg = { fg = markdown_text, bg = "NONE", bold = true },
    RenderMarkdownH4Bg = { fg = markdown_text, bg = "NONE", bold = true },
    RenderMarkdownH5Bg = { fg = markdown_text, bg = "NONE", bold = true },
    RenderMarkdownH6Bg = { fg = markdown_muted, bg = "NONE", bold = true },

    RenderMarkdownCode = { bg = palette.float_bg },
    RenderMarkdownCodeInline = { bg = palette.float_bg, fg = palette.text },
    RenderMarkdownDash = { fg = palette.thin_line },

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

    RenderMarkdownLink = { fg = markdown_text, underline = false },
    RenderMarkdownHtmlComment = { fg = palette.comment },
    RenderMarkdownTableHead = { fg = markdown_text, bold = true },
    RenderMarkdownTableRow = { fg = markdown_muted },

    ["@markup.heading"] = { fg = markdown_text, bold = true },
    ["@markup.heading.1"] = { fg = markdown_text, bold = true },
    ["@markup.heading.2"] = { fg = markdown_text, bold = true },
    ["@markup.heading.3"] = { fg = markdown_text, bold = true },
    ["@markup.heading.4"] = { fg = markdown_text, bold = true },
    ["@markup.heading.5"] = { fg = markdown_text, bold = true },
    ["@markup.heading.6"] = { fg = markdown_muted, bold = true },
    ["@markup.strong"] = { fg = markdown_text, bold = true },
    ["@markup.italic"] = { fg = markdown_text, italic = true },
    ["@markup.quote"] = { fg = markdown_muted },
    ["@markup.list"] = { fg = markdown_muted },
    ["@markup.raw"] = { fg = markdown_text },
    ["@markup.link"] = { fg = markdown_text, underline = false },
    ["@markup.link.label"] = { fg = markdown_text, underline = false },
    ["@markup.link.url"] = { fg = markdown_muted, underline = false },
  }
end

return M
