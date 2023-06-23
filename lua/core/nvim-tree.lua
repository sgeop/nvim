local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
    return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
    return
end

local function my_on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    api.config.mappings.default_on_attach(bufnr)

    vim.keymap.set("n", "O", "", { buffer = bufnr })
    vim.keymap.del("n", "O", { buffer = bufnr })
    vim.keymap.set("n", "<2-RightMouse>", "", { buffer = bufnr })
    vim.keymap.del("n", "<2-RightMouse>", { buffer = bufnr })
    vim.keymap.set("n", "D", "", { buffer = bufnr })
    vim.keymap.del("n", "D", { buffer = bufnr })
    vim.keymap.set("n", "E", "", { buffer = bufnr })
    vim.keymap.del("n", "E", { buffer = bufnr })

    vim.keymap.set("n", "A", api.tree.expand_all, opts "Expand All")
    vim.keymap.set("n", "?", api.tree.toggle_help, opts "Help")
    vim.keymap.set("n", "C", api.tree.change_root_to_node, opts "CD")
    vim.keymap.set("n", "P", function()
        local node = api.tree.get_node_under_cursor()
        print(node.absolute_path)
    end, opts "Print Node Path")

    vim.keymap.set("n", "Z", api.node.run.system, opts "Run System")
end

nvim_tree.setup {
    on_attach = my_on_attach,
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = {
        enable = true,
        update_root = true,
    },
    renderer = {
        root_folder_modifier = ":t",
        icons = {
            glyphs = {
                default = "",
                symlink = "",
                folder = {
                    arrow_open = "",
                    arrow_closed = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
                git = {
                    unstaged = "",
                    staged = "S",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "U",
                    deleted = "",
                    ignored = "◌",
                },
            },
        },
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    view = {
        width = 30,
        side = "left",
    },
}
