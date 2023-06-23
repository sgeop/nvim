local status_ok, mason = pcall(require, "mason")
if not status_ok then
    return
end

local mlsp_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mlsp_status_ok then
    return
end

local servers = {
    "lua_ls",
    "clangd",
    "cssls",
    "html",
    "terraformls",
    "tsserver",
    "pyright",
    "ruff_lsp",
    "bashls",
    "jsonls",
    "yamlls",
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

    if server == "lua_ls" then
        local lua_ls_opts = require "core.lsp.settings.lua_ls"
        opts = vim.tbl_deep_extend("force", lua_ls_opts, opts)
    end

    if server == "pyright" then
        local pyright_opts = require "core.lsp.settings.pyright"
        opts = vim.tbl_deep_extend("force", pyright_opts, opts)
    end

    if server == "ruff_lsp" then
        local ruff_opts = require "core.lsp.settings.ruff_lsp"
        opts = vim.tbl_deep_extend("force", ruff_opts, opts)
    end

    if server == "gopls" then
        local gopls_opts = require "core.lsp.settings.gopls"
        opts = vim.tbl_deep_extend("force", gopls_opts, opts)
    end

    if server == "tsserver" then
        local tsserver_opts = require "core.lsp.settings.tsserver"
        opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
    end

    if server == "yamlls" then
        local yamlls_opts = require "core.lsp.settings.yamlls"
        opts = vim.tbl_deep_extend("force", yamlls_opts, opts)
    end

    if server == "ansiblels" then
        local ansiblels_opts = require "core.lsp.settings.ansiblels"
        opts = vim.tbl_deep_extend("force", ansiblels_opts, opts)
    end

    if server == "terraformls" then
        local terraformls_opts = require "core.lsp.settings.terraformls"
        opts = vim.tbl_deep_extend("force", terraformls_opts, opts)
    end

    lspconfig[server].setup(opts)
end
