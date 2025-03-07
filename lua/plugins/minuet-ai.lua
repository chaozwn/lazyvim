return {
  "milanglacier/minuet-ai.nvim",
  event = "VimEnter",
  config = function()
    require("minuet").setup({
      notify = "verbose", -- see more notifications
      request_timeout = 2, -- use 2 seconds for faster retrieval
      n_completions = 1,
      context_window = 512,
      provider = "openai_compatible",
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
      virtual_text = {
        auto_trigger_ft = { "*" },
        keymap = {
          accept = "<C-;>",
          prev = "<M-[>",
          next = "<M-]>",
          dismiss = "<C-]>",
        },
      },
    })
  end,
}
