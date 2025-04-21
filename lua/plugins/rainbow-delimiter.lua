---@type LazySpec
return {
  "HiPhish/rainbow-delimiters.nvim",
  enabled = false,
  dependencies = "nvim-treesitter/nvim-treesitter",
  event = "LazyFile",
  main = "rainbow-delimiters.setup",
}
