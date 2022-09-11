-- disable v
-- local presets = require("which-key.plugins.presets")
-- presets.operators["v"] = nil
require("which-key").setup({
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  window = {
    border = "single", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 2, -- spacing between columns
    align = "center", -- align columns left, center or right
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = {
    "<silent>",
    "<cmd>",
    "<Cmd>",
    "<cr>",
    "<CR>",
    "call",
    "lua",
    "require",
    "^:",
    "^ ",
  }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
    -- n = { "<C-h>", "<C-j>", "<C-k>", "<C-l>" },
  },
})

local wk = require("which-key")
local default_options = { silent = true }

-- register non leader based mappings
wk.register({
  sa = "Add surrounding",
  sd = "Delete surrounding",
  sh = "Highlight surrounding",
  sn = "Surround update n lines",
  sr = "Replace surrounding",
  sF = "Find left surrounding",
  sf = "Replace right surrounding",
})

-- Register all leader based mappings
wk.register({
  ["<Tab>"] = { "<cmd>e#<cr>", "Prev buffer" },
  f = {
    name = "Files",
    b = { "<cmd>Telescope file_browser grouped=true<cr>", "File browser" },
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    s = { "<cmd>w<cr>", "Save Buffer" },
    p = { "<cmd>Telescope projects<cr>" },
    -- z = { "<cmd>Telescope zoxide list<CR>", "Zoxide" },
  },
  b = {
    name = "Buffers",
    b = {
      "<cmd>Telescope buffers<cr>",
      "Find buffer",
    },
    D = {
      "<cmd>%bd|e#|bd#<cr>",
      "Close all but the current buffer",
    },
    d = { "<cmd>lua MiniBufremove.delete()<CR>", "Close buffer" },
  },
  g = { "Git" },
  m = {
    name = "Misc",
    a = {
      "<cmd>lua require'telegraph'.telegraph({cmd='gitui', how='tmux_popup'})<cr>",
      "Test Telegraph",
    },
    c = { "<cmd>lua require('functions').toggle_colorcolumn()<cr>", "Toggle Colorcolumn" },
    d = { "<cmd>lua require('functions').toggle_diagnostics()<cr>", "Toggle Diagnostics" },
    i = { "<cmd>IlluminateToggle<cr>", "Toggle Illuminate" },
    l = { "<cmd>source ~/.config/nvim/snippets/*<cr>", "Reload snippets" },
    o = { "Options" },
    p = { "<cmd>PackerSync --preview<cr>", "PackerSync" },
    s = { "<cmd>SymbolsOutline<cr>", "Toggle SymbolsOutline" },
  },
  q = {
    name = "Quickfix",
    j = { "<cmd>cnext<cr>", "Next Quickfix Item" },
    k = { "<cmd>cprevious<cr>", "Previous Quickfix Item" },
    q = { "<cmd>lua require('functions').toggle_qf()<cr>", "Toggle quickfix list" },
    t = { "<cmd>TodoQuickFix<cr>", "Show TODOs" },
  },
  s = { "Search" },
  w = { "Windows" },
}, { prefix = "<leader>", mode = "n", default_options })
