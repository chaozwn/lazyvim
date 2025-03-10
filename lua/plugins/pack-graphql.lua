return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = { "graphql", "typescriptreact", "javascriptreact" },
    })
  end,
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("utils").list_insert_unique(opts.ensure_installed, { "graphql" })
      end
    end,
  },
  -- Linters & formatters
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "graphql-language-service-cli" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        html = { init_options = { provideFormatter = false } },
      },
    },
  },
}
