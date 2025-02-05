return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = "vue",
      root = { "vue.config.js" },
    })
  end,
  { import = "lazyvim.plugins.extras.lang.vue" },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        volar = {
          settings = {
            vue = {
              server = {
                maxOldSpaceSize = 8092,
              },
            },
          },
        },
      },
    },
  },
}
