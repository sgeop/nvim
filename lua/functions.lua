local M = {}

M.notify = function(msg, level, title)
  local notify_options = {
    title = title,
    timeout = 2000,
  }
  require("notify")(msg, level, notify_options)
end

DIAGNOSTICS_ACTIVE = true -- must be global since the toggle function is called in which.lua
-- toggle diagnostics line
M.toggle_diagnostics = function()
  DIAGNOSTICS_ACTIVE = not DIAGNOSTICS_ACTIVE
  if DIAGNOSTICS_ACTIVE then
    vim.diagnostic.show()
  else
    vim.diagnostic.hide()
  end
end

AUTOFORMAT_ACTIVE = true
-- toggle null-ls's autoformatting
M.toggle_autoformat = function()
  M.notify("Toggling autoformatting", "info", "functions.lua")
  AUTOFORMAT_ACTIVE = not AUTOFORMAT_ACTIVE
end

--@author kikito
---@see https://codereview.stackexchange.com/questions/268130/get-list-of-buffers-from-current-neovim-instance
function M.get_listed_buffers()
  local buffers = {}
  local len = 0
  for buffer = 1, vim.fn.bufnr("$") do
    if vim.fn.buflisted(buffer) == 1 then
      len = len + 1
      buffers[len] = buffer
    end
  end

  return buffers
end

function M.bufdelete(bufnum)
  require("bufdelete").bufdelete(bufnum, true)
end

-- sets the winbar with nvim-navic location
-- inspired by https://github.com/fgheng/winbar.nvim
function M.show_winbar()
  -- prevent crashing after initial setup
  local ok, _ = pcall(require, "nvim-navic")
  if ok then
    local navic = require("nvim-navic")
    if navic.is_available() then
      -- vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
      local location = navic.get_location()
      local value = "%#WinBarSeparator#" .. "%=" .. " " .. "%*" .. location .. "%#WinBarSeparator#" .. " " .. "%*"

      vim.api.nvim_set_option_value("winbar", value, { scope = "local" })
    else
      vim.api.nvim_set_option_value("winbar", "", { scope = "local" })
    end
  end
end

function M.custom_lsp_attach(client, bufnr)
  -- disable formatting for LSP clients as this is handled by null-ls
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
  -- enable navic for displaying current code context
  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end
  local wk = require("which-key")
  local default_options = { silent = true }
  wk.register({
    l = {
      name = "LSP",
      D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go To Declaration" },
      I = {
        "<cmd>lua vim.lsp.buf.implementation()<cr>",
        "Show implementations",
      },
      R = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
      d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Go To Definition" },
      e = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Document Diagnostics" },
      -- f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
      i = { "<cmd>LspInfo<cr>", "Connected Language Servers" },
      k = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover Commands" },
      l = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Line Diagnostics" },
      n = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" },
      p = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
      q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix Diagnostics" },
      r = { "<cmd>lua vim.lsp.buf.references()<cr>", "References" },
      s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
      t = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Type Definition" },
      w = {
        name = "workspaces",
        a = {
          "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>",
          "Add Workspace Folder",
        },
        d = { "<cmd>Telescope diagnostics<cr>", "Workspace Diagnostics" },
        l = {
          "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>",
          "List Workspace Folders",
        },
        r = {
          "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>",
          "Remove Workspace Folder",
        },
        s = {
          "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
          "Workspace Symbols",
        },
      },
    },
  }, { prefix = "<leader>", mode = "n", default_options })
end

return M
