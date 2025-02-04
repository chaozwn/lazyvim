return {
  "folke/ts-comments.nvim",
  event = "VeryLazy",
  opts = {
    lang = {
      thrift = { "//%s", "/*%s*/" },
      goctl = { "//%s", "/*%s*/" },
    },
  },
}
