local status_ok, nnn = pcall(require, "nnn")
if not status_ok then
    vim.notify "failed to load nnn"
end

local builtin = nnn.builtin

nnn.setup {
    explorer = {
        width = 34,
    },
    picker = {
        cmd = "nnn -c -Pp",
        style = { border = "rounded" },
    },
    windownav = {
        left = "<C-h>",
        right = "<C-l>",
    },
    replace_netrw = "picker",
    mappings = {
        { "<C-t>", builtin.open_in_tab }, -- open file(s) in tab
        { "<C-s>", builtin.open_in_split }, -- open file(s) in split
        { "<C-v>", builtin.open_in_vsplit }, -- open file(s) in vertical split
        { "<C-p>", builtin.open_in_preview }, -- open file in preview split keeping nnn focused
        { "<C-y>", builtin.copy_to_clipboard }, -- copy file(s) to clipboard
        { "<C-w>", builtin.cd_to_path }, -- cd to file directory
        { "<C-e>", builtin.populate_cmdline }, -- populate cmdline (:) with file(s)
    },
}

vim.keymap.set("n", "<leader>ne", "<cmd>NnnExplorer<CR>")
vim.keymap.set("n", "<leader>np", "<cmd>NnnPicker<CR>")
