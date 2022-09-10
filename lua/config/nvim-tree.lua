require('nvim-tree').setup({
    view = { adaptive_size = true }
})

vim.keymap.set("n", "<leader>pt", ":NvimTreeToggle<CR>")
