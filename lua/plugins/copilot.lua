return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 150,
        keymap = {
          accept = "<C-;>", -- 接受建议的快捷键
          accept_line = "<C-l>", -- 接受整行建议
          next = "<M-]>", -- 下一个建议
          prev = "<M-[>", -- 上一个建议
          dismiss = "<C-]>", -- 关闭建议
        },
      },
    })
  end,
}
