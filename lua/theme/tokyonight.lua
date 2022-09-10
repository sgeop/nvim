require("tokyonight").setup {
  style = "storm",
  transparent = false,
  terminal_colors = false,
  styles = {
    comments = "italic",
    keywords = "bold",
    sidebars = "dark",
  },
  sidebars = { "NvimTree", "terminal", "toggleterm", "packer", "qf" },
}

vim.g.tokyonight_italic_comments = true
vim.g.tokyonight_italic_keywords = false
vim.g.tokyonight_italic_functions = false
vim.g.tokyonight_italic_variables = false
vim.g.tokyonight_sidebars = { "NvimTree", "terminal", "packer" }

vim.cmd("colorscheme tokyonight")
