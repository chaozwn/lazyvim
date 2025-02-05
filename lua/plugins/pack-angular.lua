return {
  { import = "lazyvim.plugins.extras.lang.angular" },
  {
    "chaozwn/angular-quickswitch.nvim",
    event = "VeryLazy",
    opts = {
      use_default_keymaps = false,
    },
  },
  -- LSP Servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        angularls = {
          on_attach = function()
            vim.keymap.set(
              "n",
              "<leader>cq",
              vim.cmd.NgQuickSwitchToggle,
              { desc = "Angular quick switch toggle", noremap = true, silent = true, buffer = true }
            )
          end,
          settings = {
            angular = {
              provideAutocomplete = true,
              validate = true,
              suggest = {
                includeAutomaticOptionalChainCompletions = true,
                includeCompletionsWithSnippetText = true,
              },
            },
          },
        },
      },
    },
  },
}
