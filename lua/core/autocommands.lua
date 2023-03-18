local status_ok, user_config = pcall(require, "user.config")
if not status_ok then
    vim.notify("failed loading user.config", "error")
end

-- open diagnostic float on current line
vim.api.nvim_create_autocmd({ "CursorHold" }, {
    callback = function()
        if vim.lsp.buf.server_ready() then
            vim.diagnostic.open_float()
        end
    end,
})

-- Use 'q' to quit from common plugins
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
    callback = function()
        vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]]
    end,
})

-- Remove statusline and tabline when in Alpha
vim.api.nvim_create_autocmd({ "User" }, {
    pattern = { "AlphaReady" },
    callback = function()
        vim.cmd [[
      set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
      set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
    ]]
    end,
})

-- Set wrap and spell in markdown and gitcommit
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

if user_config.autoclose_nvim_tree then
    vim.api.nvim_create_autocmd("BufEnter", {
        nested = true,
        callback = function()
            if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match "NvimTree_" ~= nil then
                vim.cmd "NvimTreeClose"
                vim.cmd "quit"
            end
        end,
    })
end

-- Fixes Autocomment
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    callback = function()
        vim.cmd "set formatoptions-=cro"
    end,
})

-- Highlight Yanked Text If configured
if user_config.hl_yanked_text then
    vim.api.nvim_create_autocmd({ "TextYankPost" }, {
        callback = function()
            vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
        end,
    })
end
