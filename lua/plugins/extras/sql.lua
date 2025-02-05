local sql_ft = { "sql", "mysql", "plsql" }

return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = sql_ft,
    })
  end,
  { import = "lazyvim.plugins.extras.lang.sql" },
}
