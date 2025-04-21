if true then
  return {}
end

local function get_cmd(workspace_dir)
  local func = require("mason-core.functional")
  local path = require("mason-core.path")
  local platform = require("mason-core.platform")

  local append_node_modules = func.map(function(dir)
    return path.concat({ dir, "node_modules" })
  end)
  local install_dir = require("mason-registry").get_package("angular-language-server"):get_install_path()

  local cmd = {
    "ngserver",
    "--stdio",
    "--tsProbeLocations",
    table.concat(append_node_modules({ workspace_dir, install_dir }), ","),
    "--ngProbeLocations",
    table.concat(
      append_node_modules({
        workspace_dir,
        path.concat({ install_dir, "node_modules", "@angular", "language-server" }),
      }),
      ","
    ),
  }
  if platform.is.win then
    cmd[1] = vim.fn.exepath(cmd[1])
  end

  return cmd
end

return {
  recommended = function()
    return LazyVim.extras.wants({
      root = {
        "angular.json",
        "nx.json", --support for nx workspace
      },
    })
  end,
  { import = "lazyvim.plugins.extras.lang.angular" },
  {
    "chaozwn/angular-quickswitch.nvim",
    event = "VeryLazy",
    opts = {
      use_default_keymaps = false,
    },
  },
  -- LSP Servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        angularls = {
          on_new_config = function(new_config, root_dir)
            -- WARNING:remove after pr merge: https://github.com/williamboman/mason-lspconfig.nvim/pull/503
            new_config.cmd = get_cmd(root_dir)
          end,
          root_dir = function(...)
            local util = require("lspconfig.util")
            return util.root_pattern(unpack({
              "nx.json",
              "angular.json",
            }))(...)
          end,
          on_attach = function()
            vim.keymap.set(
              "n",
              "<leader>cq",
              vim.cmd.NgQuickSwitchToggle,
              { desc = "Angular quick switch toggle", noremap = true, silent = true, buffer = true }
            )
          end,
          settings = {
            angular = {
              provideAutocomplete = true,
              validate = true,
              suggest = {
                includeAutomaticOptionalChainCompletions = true,
                includeCompletionsWithSnippetText = true,
              },
              ["enable-strict-mode-prompt"] = true,
            },
          },
        },
      },
    },
  },
}
