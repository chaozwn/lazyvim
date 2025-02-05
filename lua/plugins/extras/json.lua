return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = { "json", "jsonc", "json5" },
      root = { "*.json" },
    })
  end,
  { import = "lazyvim.plugins.extras.lang.json" },
}
