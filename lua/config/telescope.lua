local telescope = require('telescope')
local fb_actions = require("telescope").extensions.file_browser.actions

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
      prompt_prefix = "> ",
      selection_caret = " ",
      entry_prefix = "  ",
      multi_icon = "<>",
      initial_mode = "insert",
      scroll_strategy = "cycle",
      selection_strategy = "reset",
      sorting_strategy = "descending",
      layout_strategy = "horizontal",
      layout_config = {
        width = 0.95,
        height = 0.85,
        -- preview_cutoff = 120,
        prompt_position = "top",
        horizontal = {
          preview_width = function(_, cols, _)
            if cols > 200 then
              return math.floor(cols * 0.4)
            else
              return math.floor(cols * 0.6)
            end
          end,
        },
        vertical = { width = 0.9, height = 0.95, preview_height = 0.5 },
        flex = { horizontal = { preview_width = 0.9 } },
      },
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = true,
      set_env = { ["COLORTERM"] = "truecolor" },
    },
    pickers = {
      find_files = {
        theme = 'dropdown',
      },
      buffers = {
        ignore_current_buffer = true,
        sort_lastused = true,
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = 'smart_case'
      },
      ["ui-select"] = {
        require("telescope.themes").get_dropdown({}),
      },
      file_browser = {
        theme = "ivy",
        hijack_netrw = true,
        hidden = true,
        mappings = {
          i = {
            ["<c-n>"] = fb_actions.create,
            ["<c-r>"] = fb_actions.rename,
            ["<c-h>"] = fb_actions.toggle_hidden,
            ["<c-x>"] = fb_actions.remove,
            ["<c-p>"] = fb_actions.move,
            ["<c-y>"] = fb_actions.copy,
            ["<c-a>"] = fb_actions.select_all,
          },
        },
      },
    }
})

telescope.load_extension('fzf')
telescope.load_extension('notify')
telescope.load_extension('file_browser')
telescope.load_extension('ui-select')
telescope.load_extension('projects')


-- set keybindings for telescope commands
-- local builtin = require('telescope.builtin')
--
-- vim.keymap.set("n", "<leader>ff", builtin.find_files)
-- vim.keymap.set("n", "<leader>fg", builtin.live_grep)
-- vim.keymap.set("n", "<leader>fb", builtin.buffers)
-- vim.keymap.set("n", "<leader>fh", builtin.help_tags)
