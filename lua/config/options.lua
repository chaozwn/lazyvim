-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.showbreak = "↪ "
vim.opt.wrap = true
vim.g.lazyvim_picker = "fzf"
vim.g.lazyvim_cmp = "blink.cmp"
vim.g.ai_cmp = false
vim.g.lazyvim_check_order = false

-- filetypes
LazyVim.on_very_lazy(function()
  vim.filetype.add({
    extension = {
      mdx = "markdown.mdx",
      qmd = "markdown",
      yml = require("utils").yaml_ft,
      yaml = require("utils").yaml_ft,
      json = "jsonc",
      MD = "markdown",
      tpl = "gotmpl",
    },
    filename = {
      [".eslintrc.json"] = "jsonc",
      ["vimrc"] = "vim",
    },
    pattern = {
      ["/tmp/neomutt.*"] = "markdown",
      ["tsconfig*.json"] = "jsonc",
      [".*/%.vscode/.*%.json"] = "jsonc",
      [".*/waybar/config"] = "jsonc",
    },
  })
end)
