local prefix = "<leader>m"
return {
  "stevearc/overseer.nvim",
  event = "VeryLazy",
  ---@param opts overseer.Config
  opts = function(_, opts)
    local window_scaling_factor = 0.3
    local height = require("utils").size(vim.o.lines, window_scaling_factor)
    local width = require("utils").size(vim.o.columns, window_scaling_factor)

    return require("utils").extend_tbl(opts, {
      dap = false,
      templates = { "builtin" },
      task_list = {
        width = width,
        height = height,
        default_detail = 1,
        direction = "bottom",
        bindings = {
          ["<C-l>"] = false,
          ["<C-h>"] = false,
          ["<C-k>"] = false,
          ["<C-j>"] = false,
          q = "<Cmd>close<CR>",
          K = "IncreaseDetail",
          J = "DecreaseDetail",
          ["<C-p>"] = "ScrollOutputUp",
          ["<C-n>"] = "ScrollOutputDown",
        },
      },
      -- Aliases for bundles of components. Redefine the builtins, or create your own.
      component_aliases = {
        -- Most tasks are initialized with the default components
        default = {
          { "display_duration", detail_level = 2 },
          "on_output_summarize",
          "on_exit_set_status",
          { "on_complete_dispose", require_view = { "SUCCESS", "FAILURE" } },
        },
        -- Tasks from tasks.json use these components
        default_vscode = {
          "default",
          "on_result_diagnostics",
        },
      },
      bundles = {
        -- When saving a bundle with OverseerSaveBundle or save_task_bundle(), filter the tasks with
        -- these options (passed to list_tasks())
        save_task_opts = {
          bundleable = true,
        },
        -- Autostart tasks when they are loaded from a bundle
        autostart_on_load = false,
      },
    })
  end,
  specs = {
    {
      "mfussenegger/nvim-dap",
      optional = true,
      opts = function()
        require("overseer").enable_dap()
      end,
    },
    {
      "nvim-neotest/neotest",
      optional = true,
      opts = function(_, opts)
        opts = opts or {}
        opts.consumers = opts.consumers or {}
        opts.consumers.overseer = require("neotest.consumers.overseer")
      end,
    },
    {
      "folke/which-key.nvim",
      optional = true,
      opts = {
        spec = {
          { prefix, group = "overseer", icon = "" },
        },
      },
    },
    {
      "nvim-lualine/lualine.nvim",
      opts = function(_, opts)
        if LazyVim.has("overseer.nvim") then
          table.insert(opts.sections.lualine_x, { "overseer" })
        end
        return opts
      end,
    },
  },
  keys = {
    { prefix .. "t", "<cmd>OverseerToggle<cr>", desc = "Toggle Overseer" },
    { prefix .. "c", "<cmd>OverseerRunCmd<cr>", desc = "Run Command" },
    { prefix .. "r", "<cmd>OverseerRun<cr>", desc = "Run Task" },
    { prefix .. "q", "<cmd>OverseerQuickAction<cr>", desc = "Quick Action" },
    { prefix .. "a", "<cmd>OverseerTaskAction<cr>", desc = "Task Action" },
    { prefix .. "i", "<cmd>OverseerInfo<cr>", desc = "Overseer Info" },
  },
}
