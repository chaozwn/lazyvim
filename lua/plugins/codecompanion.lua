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
          local api_key = os.getenv("DEEPSEEK_API_KEY")
          if not api_key then
            vim.notify("DEEPSEEK_API_KEY 环境变量未设置", vim.log.levels.ERROR)
            return
          end

          return require("codecompanion.adapters").extend("deepseek", {
            env = {
              api_key = api_key, -- 使用环境变量中的值
            },
          })
        end,
      },
      strategies = {
        chat = {
          adapter = "deepseek",
          slash_commands = {
            ["file"] = {
              opts = { provider = "telescope" },
            },
            ["buffer"] = {
              opts = { provider = "telescope" },
            },
          },
        },
        inline = { adapter = "deepseek" },
        agent = { adapter = "deepseek" },
      },
      opts = {
        language = "Chinese",
      },
    })
  end,
}
