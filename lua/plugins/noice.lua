return {
  "folke/noice.nvim",
  opts = {
    presets = {
      bottom_search = false, -- use a classic bottom cmdline for search
      command_palette = false, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
    lsp = {
      signature = {
        enabled = false,
      },
    },
    routes = {
      { filter = { event = "msg_show", find = "DB: Query%s" }, opts = { skip = true } },
      { filter = { event = "msg_show", find = "%swritten" }, opts = { skip = true } },
      { filter = { event = "msg_show", find = "%schange;%s" }, opts = { skip = true } },
      { filter = { event = "msg_show", find = "%s已写入" }, opts = { skip = true } },
      { filter = { event = "msg_show", find = ".*行发生改变.*" }, opts = { skip = true } },
      { filter = { event = "msg_show", find = ".*fewer lines" }, opts = { skip = true } },
      { filter = { event = "msg_show", find = ".*vim.tbl_islist is deprecated.*" }, opts = { skip = true } },
      { filter = { event = "msg_show", find = "No information available" }, opts = { skip = true } },
      {
        filter = { event = "msg_show", find = '.*Run ":checkhealth vim.deprecated".*' },
        opts = { skip = true },
      },
      {
        filter = { event = "msg_show", find = "%-32603: Invalid offset" },
        opts = { skip = true },
      },
    },
  },
}
