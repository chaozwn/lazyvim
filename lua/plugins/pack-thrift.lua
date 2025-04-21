if true then
  return {}
end

return {
  recommended = {
    ft = "thrift",
    root = ".thrift",
  },
  { import = "lazyvim.plugins.extras.lang.thrift" },
  {},
}
