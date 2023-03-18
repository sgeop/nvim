local packer_bootstrap = require("core.plugins.bootstrap").ensure()

-- Use a protected call so we don't error out on first use
local ok, packer = pcall(require, "packer")
if not ok then
    vim.notify "Packer not installed yet. Try closing and reopening vim..."
    return
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
--vim.cmd [[
--  augroup packer_user_config
--    autocmd!
--    autocmd BufWritePost core/plugins/init.lua source <afile> | PackerSync
--  augroup end
--]]

local packer_config = require "core.plugins.config"

-- vim.api.nvim_create_autocmd({ "User" }, {
--     pattern = { "PackerComplete" },
--     callback = function()
--         local ts = tostring(os.time())
--         local tmpfile = "packer_snapshot_tmp.json"
--         local full_tmpfile = packer_config.snapshot_path .. "/" .. tmpfile
--         local ssfile = packer_config.snapshot_path .. "/" .. "packer_snapshot_" .. ts .. ".json"
--         local cmd = "cat " .. full_tmpfile .. " | jq --sortkeys . >> " .. ssfile
--         vim.notify("making snapshot at " .. full_tmpfile, "info")
--         vim.notify("running " .. cmd, "info")
--         packer.snapshot(tmpfile)
--         os.execute(cmd)
--         vim.notify("packer complete, creating snapshot at " .. ssfile)
--     end,
-- })

-- Have packer use a popup window
-- packer.init(packer_config)

-- Install your plugins here
return packer.startup {
    function(use)
        use { "wbthomason/packer.nvim" } -- Have packer manage itself
        use { "nvim-lua/plenary.nvim" } -- Useful lua functions used by lots of plugins
        use {
            "rcarriga/nvim-notify",
            config = function()
                local notify = require "notify"
                vim.notify = notify
            end,
        }
        use { "windwp/nvim-autopairs" } -- Autopairs, integrates with both cmp and treesitter
        use { "numToStr/Comment.nvim" }
        use { "JoosepAlviste/nvim-ts-context-commentstring" }
        use { "kyazdani42/nvim-web-devicons" }
        use { "kyazdani42/nvim-tree.lua" }
        use { "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" }
        use { "moll/vim-bbye" }
        use { "nvim-lualine/lualine.nvim" }
        use { "akinsho/toggleterm.nvim" }
        use { "ahmedkhalf/project.nvim" }
        use { "lewis6991/impatient.nvim" }
        use { "lukas-reineke/indent-blankline.nvim" }
        use { "goolord/alpha-nvim" }
        use { "linty-org/key-menu.nvim" }

        use { "anuvyklack/hydra.nvim" }

        -- Colorschemes
        use { "folke/tokyonight.nvim" }
        use { "lunarvim/darkplus.nvim" }

        -- cmp plugins
        use { "hrsh7th/nvim-cmp" } -- The completion plugin
        use { "hrsh7th/cmp-buffer" } -- buffer completions
        use { "hrsh7th/cmp-path" } -- path completions
        use { "saadparwaiz1/cmp_luasnip" } -- snippet completions
        use { "hrsh7th/cmp-nvim-lsp" }
        use { "hrsh7th/cmp-nvim-lua" }
        -- use { "hrsh7th/cmp-nvim-lua-signature-help" }

        -- snippets
        use { "L3MON4D3/LuaSnip" } --snippet engine
        use { "rafamadriz/friendly-snippets" } -- a bunch of snippets to use

        -- LSP
        use { "williamboman/mason.nvim" }
        use { "williamboman/mason-lspconfig.nvim" }
        use { "neovim/nvim-lspconfig" } -- enable LSP
        use { "jose-elias-alvarez/null-ls.nvim" } -- for formatters and linters
        use { "RRethy/vim-illuminate" }

        -- Telescope
        use { "nvim-telescope/telescope.nvim" }
        -- use { "nvim-telescope/telescope-project.nvim" }
        -- use { "jvgrootveld/telescope-zoxide" }

        -- Treesitter
        use {
            "nvim-treesitter/nvim-treesitter",
        }

        -- Git
        use { "lewis6991/gitsigns.nvim" }

        -- DAP
        use { "mfussenegger/nvim-dap" }
        use { "rcarriga/nvim-dap-ui" }
        use { "ravenxrz/DAPInstall.nvim" }

        -- Productivity tools
        use { "nvim-neorg/neorg", tag = "2.0.0", run = ":Neorg sync-parsers" }
        use {
            "toppair/peek.nvim",
            run = "deno task --quiet build:fast",
            config = function()
                require("peek").setup()
            end,
        }
        use {
            "ellisonleao/glow.nvim",
            config = function()
                require("glow").setup()
            end,
        }

        -- Automatically set up your configuration after cloning packer.nvim
        -- Put this at the end after all plugins
        if packer_bootstrap then
            vim.notify "packer bootstrapping..."
            require("packer").sync()
        end
    end,
    config = packer_config,
}
