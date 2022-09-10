local nls = require("null-ls")

nls.setup({
  sources = {
    nls.builtins.formatting.stylua,
    nls.builtins.diagnostics.eslint_d,
    nls.builtins.formatting.prettier,
    nls.builtins.formatting.terraform_fmt,
    nls.builtins.formatting.goimports,
    nls.builtins.formatting.gofumpt,
    nls.builtins.code_actions.shellcheck,
  },
  on_attach = function(client)
    if client.server_capabilities.document_formatting then
      -- autoformat on save
      local augroup = vim.api.nvim_create_augroup("LspFormattingGrp", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        command = "vim.lsp.buf.format()",
      })
    end
  end,
})
