local lspconfig = require("lspconfig")

local lsp_on_attach = function(client, bufnr)
  -- disable formatting for LSP clients as this is handled by null-ls
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
  -- enable navic for displaying current code context
  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end

  local bufmap = function(mode, lhs, rhs)
    local opts = { buffer = true }
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  -- Displays hover information about the symbol under the cursor
  bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")

  -- Jump to the definition
  bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")

  -- Jump to declaration
  bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")

  -- Lists all the implementations for the symbol under the cursor
  bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")

  -- Jumps to the definition of the type symbol
  bufmap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>")

  -- Lists all the references
  bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")

  -- Displays a function's signature information
  bufmap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>")

  -- Renames all references to the symbol under the cursor
  bufmap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>")

  -- Selects a code action available at the current cursor position
  bufmap("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>")
  bufmap("x", "<F4>", "<cmd>lua vim.lsp.buf.range_code_action()<cr>")

  -- Show diagnostics in a floating window
  bufmap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")

  -- Move to the previous diagnostic
  bufmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")

  -- Move to the next diagnostic
  bufmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
end

local lsp_capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- local lsp_on_attach = require("functions").custom_lsp_attach

-- lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, lsp_defaults)

local servers = {
  "bashls",
  "dockerls",
  "jsonls",
  "yamlls",
  "pyright",
  "sumneko_lua",
  "terraformls",
  "tsserver",
  "gopls",
  "rust_analyzer",
}

for _, server in ipairs(servers) do
  lspconfig[server].setup({
    on_attach = function(client, bufnr)
      require("functions").custom_lsp_attach(client, bufnr)
    end,
    capabilities = lsp_capabilities,
    settings = {
      Lua = {
        cmd = { "lua-language-server" },
        format = {
          enable = false,
        },
        filetypes = { "lua" },
        runtime = {
          version = "LuaJIT",
        },
        completion = { enable = true, callSnippet = "Both" },
        diagnostics = {
          enable = true,
          globals = { "vim", "describe" },
        },
        workspace = {
          library = {
            vim.api.nvim_get_runtime_file("", true),
          },
          maxPreload = 2000,
          preloadFileSize = 1000,
        },
        telemetry = { enable = false },
      },
    },
  })
end
