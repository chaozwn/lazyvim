return {
  "kylechui/nvim-surround",
  version = "^4.0.0",
  event = "VeryLazy",
  init = function()
    vim.g.nvim_surround_no_insert_mappings = true
    vim.g.nvim_surround_no_visual_mappings = true
  end,
  config = function()
    require("nvim-surround").setup()
    vim.keymap.set("x", "gs", "<Plug>(nvim-surround-visual)", {
      desc = "Add a surrounding pair around a visual selection",
    })
  end,
}
