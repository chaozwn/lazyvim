return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = "toml",
      root = "*.toml",
    })
  end,
  { import = "lazyvim.plugins.extras.lang.toml" },
  {},
}
