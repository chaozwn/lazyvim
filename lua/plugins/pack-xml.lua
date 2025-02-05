return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = "xml",
    })
  end,
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("utils").list_insert_unique(opts.ensure_installed, { "xml", "html" })
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    optional = true,
    opts = { ensure_installed = { "lemminx" } },
  },
}
