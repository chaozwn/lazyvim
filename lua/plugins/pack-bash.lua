return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = { "sh" },
    })
  end,
  {
    "williamboman/mason.nvim",
    optional = true,
    opts = { ensure_installed = { "bash-language-server", "shfmt", "shellcheck" } },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("utils").list_insert_unique(opts.ensure_installed, { "bash" })
      end
    end,
  },
  -- LSP Servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {},
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        sh = { "shfmt" },
      },
    },
  },
}
