local telescope = require('telescope')

telescope.setup({
    defaults = {
      file_ignore_patterns = {
        'node_modules',
        '.terraform',
      },
      vimgrep_arguments = {
        'rg',
        '--follow',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        '--no-ignore',
        '--trim',
      },
      color_devicons = true,
      set_env = { ["COLORTERM"] = "truecolor" },
    },
    pickers = {
      find_files = {
        theme = 'dropdown',
      }
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = 'smart_case'
      }
    }
})

telescope.load_extension('fzf')
telescope.load_extension('notify')

-- set keybindings for telescope commands
local builtin = require('telescope.builtin')

vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>fg", builtin.live_grep)
vim.keymap.set("n", "<leader>fb", builtin.buffers)
vim.keymap.set("n", "<leader>fh", builtin.help_tags)
