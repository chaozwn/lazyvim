return {
  { import = "lazyvim.plugins.extras.formatting.biome" },
  {
    "stevearc/conform.nvim",
    optional = true,
    ---@param opts ConformOpts
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}

      for ft, formatters in pairs(opts.formatters_by_ft) do
        for i, formatter in ipairs(formatters) do
          if formatter == "biome" then
            formatters[i] = "biome-check"
          end
        end
      end

      opts.formatters = opts.formatters or {}
      opts.formatters["biome-check"] = {
        require_cwd = true,
      }
    end,
  },
}
