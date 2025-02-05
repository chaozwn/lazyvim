return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = {
          prefix = "",
        },
        update_in_insert = false,
        underline = true,
      },
      -- servers = {
      --   basedpyright = {
      --     settings = {
      --       basedpyright = {
      --         analysis = {
      --           typeCheckingMode = "basic",
      --           autoImportCompletions = true,
      --           autoSearchPaths = true,
      --           diagnosticMode = "openFilesOnly",
      --           useLibraryCodeForTypes = true,
      --           reportMissingTypeStubs = false,
      --           diagnosticSeverityOverrides = {
      --             reportUnusedImport = "information",
      --             reportUnusedFunction = "information",
      --             reportUnusedVariable = "information",
      --             reportGeneralTypeIssues = "none",
      --             reportOptionalMemberAccess = "none",
      --             reportOptionalSubscript = "none",
      --             reportPrivateImportUsage = "none",
      --           },
      --         },
      --       },
      --     },
      --   },
      -- },
    },
  },
}
