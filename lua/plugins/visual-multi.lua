---@type LazySpec
return {
  "mg979/vim-visual-multi",
  event = "LazyFile",
  config = function()
    vim.g["VM_default_mappings"] = 0
    vim.g["Find Under"] = "<C-n>"
    vim.g["Find Subword Under"] = "<C-n>"
    vim.g["Add Cursor Up"] = "<C-S-k>"
    vim.g["Add Cursor Down"] = "<C-S-j>"
    vim.g["Select All"] = "<C-S-n>"
    vim.g["Skip Region"] = "<C-x>"
  end,
}
