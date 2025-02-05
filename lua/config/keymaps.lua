-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap

keymap.set("n", "H", "^", { desc = "Go to start without blank" })
keymap.set("n", "L", "$", { desc = "Go to end without blank" })

keymap.set("v", "K", ":move '<-2<CR>gv-gv", { desc = "Move line up", noremap = true, silent = true })
keymap.set("v", "J", ":move '>+1<CR>gv-gv", { desc = "Move line down", noremap = true, silent = true })

keymap.set("n", "n", require("utils").better_search("n"), { desc = "Next Search", noremap = true, silent = true })
keymap.set("n", "N", require("utils").better_search("N"), { desc = "Previous Search", noremap = true, silent = true })

keymap.set("n", "n", "nzz", { noremap = true, silent = true })
keymap.set("n", "N", "Nzz", { noremap = true, silent = true })

keymap.set("n", "x", '"_x', { noremap = true, silent = true })
keymap.set("n", "<leader>/", LazyVim.pick("live_grep", { root = false }), { desc = "Grep (cwd)" })

-- for mini.pairs
local map_bs = function(lhs, rhs)
  keymap.set("i", lhs, rhs, { expr = true, replace_keycodes = false })
end

map_bs("<C-h>", "v:lua.MiniPairs.bs()")
map_bs("<C-w>", 'v:lua.MiniPairs.bs("\23")')
map_bs("<C-u>", 'v:lua.MiniPairs.bs("\21")')

-- for lsp
keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
