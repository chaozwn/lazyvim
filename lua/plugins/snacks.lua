return {
  "snacks.nvim",
  opts = {
    dashboard = { enabled = false },
    terminal = {
      win = {
        wo = {
          winbar = "",
        },
      },
    },
    images = {
      enabled = true,
    },
  },
  keys = function(_, keys)
    vim.list_extend(keys, {
      {
        "<leader>nh",
        function()
          require("snacks").image.hover()
        end,
        desc = "Show images",
      },
      {
        "<leader>nn",
        function()
          Snacks.picker.notifications()
        end,
        desc = "Notification History",
      },
    })

    require("utils").remove_keys(keys, { "<leader>n" })
  end,
  specs = {
    {
      "folke/which-key.nvim",
      optional = true,
      opts = {
        spec = {
          {
            "<leader>n",
            group = "tools",
            icon = "",
            mode = { "n", "v" },
          },
        },
      },
    },
  },
}
