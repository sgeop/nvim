local status_ok, mason = pcall(require, "mason")
if not status_ok then
    return
end

local mlsp_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mlsp_status_ok then
    return
end

local servers = {
    "sumneko_lua",
    "clangd",
    "cssls",
    "html",
    "terraformls",
    "tsserver",
    "pyright",
    "bashls",
    "jsonls",
    -- "yamlls",
    "gopls",
    "ansiblels",
    "dockerls",
    "rust_analyzer",
}

mason.setup()
mason_lspconfig.setup {
    ensure_installed = servers,
}

local lsp_status_ok, lspconfig = pcall(require, "lspconfig")
if not lsp_status_ok then
    return
end

local opts = {}

for _, server in pairs(servers) do
    opts = {
        on_attach = require("core.lsp.handlers").on_attach,
        capabilities = require("core.lsp.handlers").capabilities,
    }

    if server == "sumneko_lua" then
        local sumneko_opts = require "core.lsp.settings.sumneko_lua"
        opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

    if server == "pyright" then
        local pyright_opts = require "core.lsp.settings.pyright"
        opts = vim.tbl_deep_extend("force", pyright_opts, opts)
    end

    if server == "gopls" then
        local gopls_opts = require "core.lsp.settings.gopls"
        opts = vim.tbl_deep_extend("force", gopls_opts, opts)
    end

    if server == "yamlls" then
        local yamlls_opts = require "core.lsp.settings.yamlls"
        opts = vim.tbl_deep_extend("force", yamlls_opts, opts)
    end

    lspconfig[server].setup(opts)
end
