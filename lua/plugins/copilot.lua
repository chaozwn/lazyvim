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
          next = "<M-]>", -- 下一个建议
          prev = "<M-[>", -- 上一个建议
          dismiss = "<C-]>", -- 关闭建议
        },
      },
    })
  end,
}
