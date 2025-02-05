return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = "yaml",
    })
  end,
  { import = "lazyvim.plugins.extras.lang.yaml" },
}
