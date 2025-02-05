return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = "rust",
      root = { "Cargo.toml", "rust-project.json" },
    })
  end,
  { import = "lazyvim.plugins.extras.lang.rust" },
  {},
}
