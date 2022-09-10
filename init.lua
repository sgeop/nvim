local conf = require("userconf")

vim.g.mapleader = conf.leader_key

-- colorscheme
require("plugins")
require("mappings")
require("autocmd")

require("theme" .. "." .. conf.theme)

-- General settings
vim.o.termguicolors = true
vim.o.syntax = 'on'
vim.o.swapfile = conf.swapfile
vim.o.clipboard = "unnamedplus"
vim.o.mouse = conf.mouse
vim.o.number = conf.numbered_lines

vim.bo.autoindent = true
vim.bo.smartindent = true

vim.o.fillchars = conf.fillchars
