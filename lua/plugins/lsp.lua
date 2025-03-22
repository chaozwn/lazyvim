return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = {
          prefix = "",
        },
        update_in_insert = false,
        underline = true,
      },
      inlay_hints = {
        enabled = false,
      }
    },
  },
}
