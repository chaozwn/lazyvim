return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- 设置为 false 以始终拉取最新代码
    opts = {
      provider = "deepseek", -- 明确指定使用 DeepSeek 作为服务提供商
      vendors = {
        deepseek = {
          -- 移除 __inherited_from = "openai"（不再继承 OpenAI 配置）
          api_key_name = "DEEPSEEK_API_KEY", -- 使用 DeepSeek 的 API 密钥环境变量
          endpoint = "https://api.deepseek.com", -- DeepSeek 官方 API 端点
          model = "deepseek-coder", -- 使用 DeepSeek 代码模型
        },
      },
    },
    build = "make", -- 保持默认构建命令（如需从源码构建可按需修改）
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- Treesitter 语法解析（必要依赖）
      "stevearc/dressing.nvim", -- 交互式提示界面（必要依赖）
      "nvim-lua/plenary.nvim", -- Lua 工具库（必要依赖）
      "MunifTanjim/nui.nvim", -- 通用 UI 组件（必要依赖）
      
      -- 以下为可选依赖（与 Copilot/OpenAI 无关，可按需保留）
      "nvim-tree/nvim-web-devicons", -- 图标支持（非必需，可移除）
      
      {
        -- 图片粘贴支持（与 AI 服务无关，可保留）
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = { insert_mode = true },
            use_absolute_path = true, -- Windows 必需配置
          },
        },
      },
      
      {
        -- Markdown 渲染支持（与 AI 服务无关，可保留）
        "MeanderingProgrammer/render-markdown.nvim",
        opts = { file_types = { "markdown", "Avante" } },
        ft = { "markdown", "Avante" }, -- 关联文件类型
      },
    },
  },
}
