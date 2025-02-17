local function get_icon(ctx)
  local mini_icons = require("mini.icons")
  local source = ctx.item.source_name
  local label = ctx.item.label
  local color = ctx.item.documentation

  if source == "LSP" then
    if color and type(color) == "string" and color:match("^#%x%x%x%x%x%x$") then
      local hl = "hex-" .. color:sub(2)
      if #vim.api.nvim_get_hl(0, { name = hl }) == 0 then
        vim.api.nvim_set_hl(0, hl, { fg = color })
      end
      return "󱓻", hl, false
    else
      return mini_icons.get("lsp", ctx.kind)
    end
  elseif source == "Path" then
    return (label:match("%.[^/]+$") and mini_icons.get("file", label) or mini_icons.get("directory", label))
  elseif source == "codeium" then
    return mini_icons.get("lsp", "event")
  else
    return ctx.kind_icon, "BlinkCmpKind" .. ctx.kind, false
  end
end

return {
  "saghen/blink.cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    {
      "saghen/blink.compat",
      opts = {},
      lazy = true,
      version = "*",
    },
    {
      "SergioRibera/cmp-dotenv",
    },
  },
  opts = function(_, opts)
    return require("utils").extend_tbl(opts, {
      sources = {
        min_keyword_length = function(ctx)
          -- only applies when typing a command, doesn't apply to arguments
          if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
            return 2
          end
          return 0
        end,
        compat = require("utils").list_insert_unique(opts.sources.compat or {}, { "dotenv" }),
        providers = {
          dotenv = {
            kind = "DotEnv",
            score_offset = -100,
            async = true,
          },
          lsp = {
            ---@type fun(ctx: blink.cmp.Context, items: blink.cmp.CompletionItem[])
            transform_items = function(ctx, items)
              for _, item in ipairs(items) do
                if item.kind == require("blink.cmp.types").CompletionItemKind.Snippet then
                  item.score_offset = item.score_offset - 3
                end
              end

              ---@diagnostic disable-next-line: redundant-return-value
              return vim.tbl_filter(function(item)
                local c = ctx.get_cursor()
                local cursor_line = ctx.line
                local cursor = {
                  row = c[1],
                  col = c[2] + 1,
                  line = c[1] - 1,
                }
                local cursor_before_line = string.sub(cursor_line, 1, cursor.col - 1)

                -- remove text
                if item.kind == require("blink.cmp.types").CompletionItemKind.Text then
                  return false
                end

                if vim.bo.filetype == "vue" then
                  -- For events
                  if cursor_before_line:match("(@[%w]*)%s*$") ~= nil then
                    return item.label:match("^@") ~= nil
                  -- For props also exclude events with `:on-` prefix
                  elseif cursor_before_line:match("(:[%w]*)%s*$") ~= nil then
                    return item.label:match("^:") ~= nil and not item.label:match("^:on%-") ~= nil
                  -- For slot
                  elseif cursor_before_line:match("(#[%w]*)%s*$") ~= nil then
                    return item.kind == require("blink.cmp.types").CompletionItemKind.Method
                  end
                end

                return true
              end, items)
            end,
          },
        },
      },
      signature = { enabled = true },
      cmdline = {
        enabled = true,
        sources = function()
          local type = vim.fn.getcmdtype()
          -- Search forward and backward
          if type == "/" or type == "?" then
            return { "buffer" }
          end
          -- Commands
          if type == ":" or type == "@" then
            return { "cmdline" }
          end
          return {}
        end,
      },
      completion = {
        list = { selection = { preselect = true, auto_insert = false } },
        menu = {
          scrollbar = false,
          draw = {
            components = {
              kind_icon = {
                ellipsis = true,
                text = function(ctx)
                  local icon, _, _ = get_icon(ctx)
                  return icon .. ctx.icon_gap
                end,
                highlight = function(ctx)
                  local _, hl, _ = get_icon(ctx)
                  return hl
                end,
              },
              kind = {
                ellipsis = true,
              },
            },
          },
        },
      },
      keymap = {
        preset = "super-tab",
      },
    })
  end,
}
