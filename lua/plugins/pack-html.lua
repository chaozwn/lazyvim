return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = { "css", "html" },
      root = { "*.html", "*.css", "*.less", "*.scss" },
    })
  end,
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("utils").list_insert_unique(opts.ensure_installed, { "html", "css", "scss" })
      end
      vim.treesitter.language.register("scss", "less")
      vim.treesitter.language.register("scss", "postcss")
    end,
  },
  -- Linters & formatters
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "html-lsp", "cssmodules-language-server", "css-lsp" },
    },
  },
  {
    "echasnovski/mini.icons",
    optional = true,
    opts = {
      filetype = {
        postcss = { glyph = "󰌜", hl = "MiniIconsOrange" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        html = { init_options = { provideFormatter = false } },
        cssls = {
          init_options = { provideFormatter = false },
          settings = {
            css = {
              lint = {
                unknownAtRules = "ignore",
              },
            },
            less = {
              lint = {
                unknownAtRules = "ignore",
              },
            },
            scss = {
              validate = false,
              lint = {
                unknownAtRules = "ignore",
              },
            },
          },
        },
      },
    },
  },
}
