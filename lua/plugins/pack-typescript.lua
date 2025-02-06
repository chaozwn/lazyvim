return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
      },
      root = { "tsconfig.json", "package.json", "jsconfig.json" },
    })
  end,
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.formatting.prettier" },
  {},
}
