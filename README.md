# homesick.nvim

Homesick is a Neovim colorscheme with two built-in variants:

- `moon` 
- `night` 

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

- `:colorscheme homesick` (defaults to moon)
- `:colorscheme homesick-moon`
- `:colorscheme homesick-night`

Or from Lua:

```lua
require("homesick").setup({ variant = "night" })
require("homesick").load()
```

You can also set:

```lua
vim.g.homesick_variant = "night"
```

before loading the colorscheme.
