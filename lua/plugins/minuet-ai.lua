return {
  "milanglacier/minuet-ai.nvim",
  event = "VimEnter",
  config = function()
    require("minuet").setup({
      notify = "verbose", -- see more notifications
      request_timeout = 5, -- 延长超时应对网络波动（原 2s 易超时）
      context_window = 2048, -- 扩大上下文窗口（原 512 太小）
      context_ratio = 0.7, -- 平衡光标前后内容比例
      throttle = 500, -- 新增节流控制
      debounce = 300, -- 新增防抖优化

      -- 补全质量优化
      n_completions = 2, -- 获取更多候选（原 1 个可能不够）
      after_cursor_filter_length = 25, -- 新增重复过滤
      add_single_line_entry = false, -- 关闭单行拆分

      -- provider
      provider = "openai_compatible",
      -- proxy = "127.0.0.1:7890",
      provider_options = {
        openai_compatible = {
          api_key = "OPENROUTER_API_KEY",
          model = "anthropic/claude-3.7-sonnet",
          end_point = "https://openrouter.ai/api/v1/chat/completions",
          name = "OpenRouter",
          optional = {
            max_tokens = 256,
            top_p = 0.9,
          },
        },
      },
      virtualtext = {
        auto_trigger_ft = { "*" },
        keymap = {
          accept = "<C-;>",
          accept_line = "<C-l>",
          accept_n_lines = "<C-n>",
          prev = "<M-[>",
          next = "<M-]>",
          dismiss = "<C-]>",
        },
      },
    })
  end,
}
