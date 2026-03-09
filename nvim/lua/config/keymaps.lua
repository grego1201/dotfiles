-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("n", ",s", ":w<CR>", { desc = "Save file" })
vim.keymap.set("n", ",e", ":qa!<CR>", { desc = "Exit neovim" })
vim.keymap.set("n", ",q", ":q<CR>", { desc = "Close window" })
vim.keymap.set("n", ",d", "<Leader>bd", { remap = true, desc = "Delete buffer" })
vim.keymap.set("n", ",D", "<Leader>bD", { remap = true, desc = "Delete buffer and window" })
vim.keymap.set("n", ",b", ":Git blame<CR>", { desc = "Blame file" })
vim.keymap.set("n", ";", "gcc", { remap = true, desc = "Comment" })
vim.keymap.set("v", ";", "gc", { remap = true, desc = "Comment selection" })
vim.keymap.set("n", "t", "<Leader>e", { remap = true, desc = "Open Neotree" })
vim.keymap.set("n", "s", "cl", { remap = true, desc = "Substitute text" })
vim.keymap.set("v", "s", "c", { remap = true, desc = "Substitute text" })
vim.keymap.set("n", ",gs", "<cmd>SplitjoinSplit<CR>", { remap = true, desc = "Split text" })
vim.keymap.set("n", ",gj", "<cmd>SplitjoinJoin<CR>", { remap = true, desc = "Join text" })
vim.keymap.set("n", ",a", ":A<CR>", { remap = true, desc = "Open alternative file" })
vim.keymap.set("n", ",r", ":R<CR>", { remap = true, desc = "Open related file" })
vim.keymap.set("n", ",z", "<Leader>uz", { remap = true, desc = "Open file in zen mode" })
vim.keymap.set("n", ",t", "<Leader><tab><tab>", { remap = true, desc = "Open new tab" })
vim.keymap.set("n", "<c-p>", "<Leader><Leader>", { remap = true, desc = "Find files" })
vim.keymap.set("n", "<c-j>", ":m .+1<CR>==", { remap = true, desc = "Move line up" })
vim.keymap.set("n", "<c-k>", ":m .-2<CR>==", { remap = true, desc = "Move line down" })
vim.keymap.set("v", "<c-j>", ":m '>+1<CR>gv=gv", { remap = true, desc = "Move line up in v mode" })
vim.keymap.set("v", "<c-k>", ":m '<-2<CR>gv=gv", { remap = true, desc = "Move line down in v mode" })
vim.keymap.set("n", "<Leader>rr", ":%s/<C-r><C-w>/<C-r><C-w>/g<Left><Left>", { noremap = true, desc = "Rename" })
vim.keymap.set(
  "n",
  "<Leader>rR",
  ":%s/<C-r><C-w>/<C-r><C-w>/gc<Left><Left><Left>",
  { noremap = true, desc = "Rename with confirmation" }
)
