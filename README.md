# homesick.nvim

Homesick is a Neovim colorscheme with two built-in variants:

### Moon
*Inspired by [Rosé Pine](https://github.com/rose-pine/neovim) with a darker, cooler base.*

![moon](screenshots/moon.png)

### Night
![night](screenshots/night.png)

## Install (lazy.nvim)

```lua
{
  "amiraminb/homesick.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("homesick")
  end,
}
```

## Variants

Use any of these:

- `:colorscheme homesick` (defaults to night)
- `:colorscheme homesick-moon`
- `:colorscheme homesick-night`

Or from Lua:

```lua
require("homesick").setup({ variant = "night" })
require("homesick").load()
```

`night` is the plugin default when no variant is specified.

You can also set:

```lua
vim.g.homesick_variant = "night"
```

before loading the colorscheme.

## Integrations

### Bufferline

Homesick provides a dedicated bufferline highlight map.

```lua
local variant = vim.g.homesick_variant or "moon"

require("bufferline").setup({
  highlights = require("homesick.plugins.bufferline").get(variant),
})
```

### nvim-cmp

Homesick also provides a dedicated `nvim-cmp` highlight map.

```lua
local variant = vim.g.homesick_variant or "moon"

for group, spec in pairs(require("homesick.plugins.cmp").get(variant)) do
  vim.api.nvim_set_hl(0, group, spec)
end
```

### vim-illuminate

Homesick provides an explicit illuminate integration map.

```lua
local variant = vim.g.homesick_variant or "moon"

for group, spec in pairs(require("homesick.plugins.illuminate").get(variant)) do
  vim.api.nvim_set_hl(0, group, spec)
end
```
