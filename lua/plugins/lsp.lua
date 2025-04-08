return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    ---@class PluginLspOpts
    opts = {
      ---@type vim.diagnostic.Opts
      diagnostics = {
        severity_sort = true,
      },
      -- ---@type lspconfig.options
      ---@diagnostic disable: missing-fields
      servers = {
        pyright = {},
        zls = {
          mason = false,
        },
      },

      inlay_hints = {
        enabled = false,
      },
      codelens = {
        enabled = true,
      },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "gopls",
        "gofumpt",
        "goimports",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "rust",
        "go",
        "zig",
        "tsx",
        "typescript",
      })
    end,
  },

  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      formatters_by_ft = {
        sh = { "shfmt" },
        lua = { "stylua" },
        go = { "goimports", "gofmt" },
        zig = { "zigfmt" },
      },

      default_format_opts = {
        lsp_format = "fallback",
        timeout_ms = 500,
      },

      formatters = {
        zigfmt = {
          command = "/home/seanpietz/.zvm/bin/zig",
          args = { "fmt", "--stdin" },
        },
      },
    },
  },
}
