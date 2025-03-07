local codecompanion_prefix = "<leader>P"
return {
  "olimorris/codecompanion.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim",
  },
  opts = function(_, opts)
    return require("utils").extend_tbl(opts, {
      adapters = {
        deepseek = function()
          -- 从环境变量中获取 API Key
          local api_key = require("utils").get_os_env("DEEPSEEK_API_KEY")

          return require("codecompanion.adapters").extend("deepseek", {
            env = {
              api_key = api_key, -- 使用环境变量中的值
            },
          })
        end,
        openrouter_claude = function()
          local api_key = require("utils").get_os_env("OPENROUTER_API_KEY")
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              url = "https://openrouter.ai/api",
              api_key = api_key,
              chat_url = "/v1/chat/completions",
            },
            schema = {
              model = {
                default = "anthropic/claude-3.7-sonnet",
              },
            },
          })
        end,
      },
      strategies = {
        chat = {
          adapter = "openrouter_claude",
          slash_commands = {
            ["file"] = {
              opts = { provider = "telescope" },
            },
            ["buffer"] = {
              opts = { provider = "telescope" },
            },
          },
        },
        inline = { adapter = "openrouter_claude" },
        agent = { adapter = "openrouter_claude" },
      },
      opts = {
        language = "Chinese",
      },
    })
  end,
  keys = {
    { mode = { "n", "v" }, codecompanion_prefix .. "<CR>", "<cmd>CodeCompanionChat<CR>", desc = "CodeCompanionChat" },
    {
      mode = { "n", "v" },
      codecompanion_prefix .. "a",
      "<cmd>CodeCompanionActions<CR>",
      desc = "CodeCompanionActions",
    },
  },
}
