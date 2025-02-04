return {
  "Bekaboo/dropbar.nvim",
  event = "LazyFile",
  opts = {},
  specs = {
    {
      "rebelot/heirline.nvim",
      optional = true,
      opts = function(_, opts)
        opts.winbar = nil
      end,
    },
  },
}
