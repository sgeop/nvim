
-- make window movement easier
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- set up/down keys and mouse scroll to move window instead of cursor
vim.keymap.set("n", "<Up>",   "<C-y>")
vim.keymap.set("n", "<Down>", "<C-e>")
