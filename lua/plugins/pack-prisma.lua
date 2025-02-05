if true then
  return {}
end

return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = "prisma",
    })
  end,
  { import = "lazyvim.plugins.extras.lang.prisma" },
  {},
}
