local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- bootstrap packer if not installed
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer...")
  vim.api.nvim_command("packadd packer.nvim")
end

local packer = require('packer')

-- packer.init({
--   enable = true, -- enable profiling via :PackerCompile profile=true
--   threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
--   max_jobs = 20, -- Limit the number of simultaneous jobs. nil means no limit. Set to 20 in order to prevent PackerSync form being "stuck" -> https://github.com/wbthomason/packer.nvim/issues/746
--   preview_updates = true,
--   -- Have packer use a popup window
--   display = {
--     open_fn = function()
--       return require("packer.util").float({ border = "rounded" })
--     end,
--   },
-- })

-- Install plugins
packer.startup({
  function(use)
    -- Use packer to self-manage
    use("wbthomason/packer.nvim")

    use("lewis6991/impatient.nvim")

    use("kyazdani42/nvim-web-devicons")
    -- use 'yamatsum/nvim-nonicons'

    -- nicer notifications
    use({
      "rcarriga/nvim-notify",
      config = function()
        require("config.notify")
      end,
    })

    use({
      "akinsho/nvim-toggleterm.lua",
      keys = { "<C-n>" },
      config = function()
        require("config.toggleterm")
      end
    })

    -- fuzzy finder for search
    use({
      "nvim-telescope/telescope.nvim",
      requires = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-lua/popup.nvim" },
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        { "crispgm/telescope-heading.nvim" },
        { "nvim-telescope/telescope-symbols.nvim" },
        { "nvim-telescope/telescope-file-browser.nvim" },
        { "nvim-telescope/telescope-packer.nvim" },
        { "nvim-telescope/telescope-ui-select.nvim" },
      },
      config = function()
        require("config.telescope")
      end,
    })

    use({
      "nvim-treesitter/nvim-treesitter",
      run = function()
        require("nvim-treesitter.install").update({ with_sync = true })
      end,
    })

    use("nvim-treesitter/nvim-treesitter-textobjects")

    use("RRethy/nvim-treesitter-endwise")

    use({
      "hrsh7th/nvim-cmp",
      requires = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "lukas-reineke/cmp-rg",
        "hrsh7th/cmp-nvim-lsp-signature-help",
      },
      config = function()
        require("config.cmp")
      end,
    })

    use({ "rafamadriz/friendly-snippets" })

    use({
      "L3MON4D3/LuaSnip",
      requires = "saadparwaiz1/cmp_luasnip",
      config = function()
        require("config.luasnip")
      end,
    })

    -- Git plugins --
    -- use({
    --   "TimUntersberger/neogit",
    --   requires = {
    --     "nvim-lua/plenary.nvim",
    --     {
    --       "sindrets/diffview.nvim",
    --       cmd = {
    --         "DiffviewOpen",
    --         "DiffviewClose",
    --         "DiffviewToggleFiles",
    --         "DiffviewFocusFiles",
    --       },
    --       config = function()
    --         require("config.diffview")
    --       end
    --     },
    --   },
    --   cmd = "Neogit",
    --   config = function()
    --     require("config.neogit")
    --   end
    -- })

    -- use({
    --   "lewis6991/gitsigns.nvim",
    --   requires = { "nvim-lua/plenary.nvim" },
    --   config = function()
    --     require("config.gitsigns")
    --   end
    -- })

    -----------------

    use({
      "jose-elias-alvarez/null-ls.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("config.null-ls")
      end,
    })

    -- use({
    --   "kevinhwang91/nvim-bqf",
    --   requires = {
    --     "junegunn/fzf",
    --     module = "nvim-bqf",
    --   },
    --   ft = "qf",
    --   config = function()
    --     require("config.nvim-bqf")
    --   end,
    -- })

    use({
      "williamboman/mason.nvim",
      requires = {
        {"williamboman/mason-lspconfig"},
        {"WhoIsSethDaniel/mason-tool-installer"},
      },
      config = function()
        require("config.mason")
      end,
    })

    use({
      "SmiteshP/nvim-navic",
      requires = "neovim/nvim-lspconfig",
      config = function()
        require("config.navic")
      end,
    })

    use({
      "neovim/nvim-lspconfig",
      config = function()
        require("config.lsp")
      end,
    })

    use({
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      config = function()
        require("config.lsp_lines")
      end,
    })

    -- use {
    --   'j-hui/fidget.nvim',
    --   config = function()
    --     require("fidget").setup({})
    --   end
    -- }

    use({ "onsails/lspkind-nvim", requires = { "famiu/bufdelete.nvim" } })

    use({
      "windwp/nvim-autopairs",
      config = function()
        require("config.nvim-autopairs")
      end,
    })

    -- use {
    --   'nvim-treesitter/playground',
    --   cmd = "TSPlaygroundToggle",
    --   run = "TSInstall query",
    --   config = function () require('config.playground') end
    -- }

    use({
      "kyazdani42/nvim-tree.lua",
      requires = { "kyazdani42/nvim-web-devicons" },
      config = function()
        require("config.nvim-tree")
      end,
    })

    use({
      "nvim-lualine/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
      config = function()
        require("config.lualine")
      end,
    })

    use({
      "https://gitlab.com/yorickpeterse/nvim-pqf.git",
      config = function()
        require("pqf").setup()
      end,
    })

    -- use {
    --   'declancm/cinnamon.nvim',
    --   config = function () require('config.cinnamon') end
    -- }

    use({
      "karb94/neoscroll.nvim",
      config = function()
        require("config.neoscroll")
      end,
    })

    use({
      "ahmedkhalf/project.nvim",
      config = function()
        require("config.project_nvim")
      end
    })

    -- Colorschemes
    use({ "folke/tokyonight.nvim" })
    use({ "marko-cerovac/material.nvim" })

    -- detect tabstop and shiftwidth options from file
    use("tpope/vim-sleuth")


    use({
      "folke/which-key.nvim",
      config = function()
        require("config.which-key")
      end,
    })


    -- Golang specific plugin(s)
    use({
      "ray-x/go.nvim",
      requires = "ray-x/guihua.lua",
      config = function()
        require("config.go")
      end,
      ft = { "go" },
    })
  end,
  config = {
    enable = true, -- enable profiling via :PackerCompile profile=true
    threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    max_jobs = 20, -- Limit the number of simultaneous jobs. nil means no limit. Set to 20 in order to prevent PackerSync form being "stuck" -> https://github.com/wbthomason/packer.nvim/issues/746
    -- preview_updates = true,
    -- Have packer use a popup window
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "rounded" })
      end,
    },
  },
})
