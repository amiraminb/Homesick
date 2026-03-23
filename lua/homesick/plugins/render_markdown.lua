local M = {}

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
    RenderMarkdownCodeInline = { bg = palette.float_bg, fg = palette.text },
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
