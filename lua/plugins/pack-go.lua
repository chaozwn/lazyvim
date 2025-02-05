return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = { "go", "gomod", "gowork", "gotmpl" },
      root = { "go.work", "go.mod" },
    })
  end,
  { import = "lazyvim.plugins.extras.lang.go" },
  -- LSP Servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              analyses = {
                ST1003 = false,
                SA5008 = false,
                fieldalignment = false,
                fillreturns = true,
                nilness = true,
                nonewvars = true,
                shadow = true,
                undeclaredname = true,
                unreachable = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              codelenses = {
                gc_details = false, -- Show a code lens toggling the display of gc's choices.
                generate = true, -- show the `go generate` lens.
                regenerate_cgo = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              completeUnimported = true,
              diagnosticsDelay = "500ms",
              gofumpt = true,
              matcher = "Fuzzy",
              semanticTokens = true,
              staticcheck = true,
              symbolMatcher = "fuzzy",
              usePlaceholders = false,
            },
          },
        },
      },
    },
  },
  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = {
      {
        "Snikimonkd/cmp-go-pkgs",
        ft = "go",
        enabled = vim.fn.executable("go") == 1,
      },
    },
    opts = function(_, opts)
      return require("utils").extend_tbl(opts, {
        sources = {
          compat = require("utils").list_insert_unique(opts.sources.compat or {}, { "go_pkgs" }),
          providers = {
            go_pkgs = {
              kind = "Gopkgs",
              score_offset = 100,
              async = true,
              enabled = function()
                return vim.fn.executable("go") == 1 and require("cmp_go_pkgs")._check_if_inside_imports()
              end,
            },
          },
        },
      })
    end,
  },
}
