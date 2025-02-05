local prefix_diff_view = "<leader>g"

return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen" },
  keys = {
    {
      prefix_diff_view .. "d",
      function()
        vim.cmd([[DiffviewOpen]])
      end,
      desc = "Open Git Diffview",
    },
    {
      prefix_diff_view .. "h",
      function()
        vim.cmd([[DiffviewFileHistory]])
      end,
      desc = "Open current branch git history",
    },
    {
      prefix_diff_view .. "H",
      function()
        vim.cmd([[DiffviewFileHistory %]])
      end,
      desc = "Open current file git history",
    },
  },
  opts = {
    enhanced_diff_hl = true,
    view = {
      default = { winbar_info = false, disable_diagnostics = true },
      file_history = { winbar_info = false, disable_diagnostics = true },
    },
    file_panel = {
      win_config = { -- See |diffview-config-win_config|
        position = "bottom",
        height = require("utils").size(vim.o.lines, 0.25),
      },
    },
    hooks = {
      view_enter = function()
        vim.keymap.set("n", prefix_diff_view .. "d", function()
          vim.cmd([[DiffviewClose]])
        end, { desc = "Close Git Diffview", noremap = true, silent = true })
      end,
      view_leave = function()
        vim.keymap.set("n", prefix_diff_view .. "d", function()
          vim.cmd([[DiffviewOpen]])
        end, { desc = "Open Git Diffview", noremap = true, silent = true })
      end,
    },
  },
}
