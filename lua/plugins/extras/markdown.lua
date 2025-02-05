local markdown_table_change = function()
  vim.ui.input({ prompt = "Separate Char: " }, function(input)
    if not input or #input == 0 then
      return
    end
    local execute_command = ([[:'<,'>MakeTable! ]] .. input)
    vim.cmd(execute_command)
  end)
end

vim.g.mkdp_auto_close = 0
vim.g.mkdp_combine_preview = 1

return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = { "markdown", "markdown.mdx" },
      root = "README.md",
    })
  end,
  { import = "lazyvim.plugins.extras.lang.markdown" },
  {
    "mattn/vim-maketable",
    cmd = "MakeTable",
    ft = { "markdown", "markdown.mdx" },
  },
  {
    "HakonHarnes/img-clip.nvim",
    cmd = { "PasteImage", "ImgClipDebug", "ImgClipConfig" },
    opts = {
      default = {
        prompt_for_file_name = false,
        embed_image_as_base64 = false,
        drag_and_drop = {
          enabled = true,
          insert_mode = true,
        },
        use_absolute_path = vim.fn.has("win32") == 1,
        relative_to_current_file = true,
        show_dir_path_in_prompt = true,
        dir_path = "assets/imgs/",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = {
          on_attach = function()
            vim.keymap.set(
              "n",
              "<leader>cP",
              "<cmd>PasteImage<cr>",
              { desc = "Paste image from system clipboard", noremap = true, silent = true, buffer = true }
            )
            vim.keymap.set(
              "n",
              "<leader>ct",
              [[:'<,'>MakeTable! \t<CR>]],
              { desc = "Markdown csv to table(Default:\\t)", noremap = true, silent = true, buffer = true }
            )
            vim.keymap.set(
              "n",
              "<leader>cT",
              markdown_table_change,
              { desc = "Markdown csv to table with separate char", noremap = true, silent = true, buffer = true }
            )
          end,
        },
      },
    },
  },
}
