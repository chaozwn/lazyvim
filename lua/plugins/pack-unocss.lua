return {
  recommended = function()
    return LazyVim.extras.wants({
      root = {
        "unocss.config.js",
        "unocss.config.ts",
        "uno.config.js",
        "uno.config.ts",
      },
    })
  end,
  {
    "williamboman/mason.nvim",
    optional = true,
    opts = { ensure_installed = { "unocss-language-server" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        unocss = {},
      },
    },
  },
}
