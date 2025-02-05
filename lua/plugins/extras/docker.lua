return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = "dockerfile",
      root = { "Dockerfile", "docker-compose.yml", "compose.yml", "docker-compose.yaml", "compose.yaml" },
    })
  end,
  { import = "lazyvim.plugins.extras.lang.docker" },
}
