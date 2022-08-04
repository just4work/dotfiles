local cmd = vim.cmd
local fn = vim.fn
local api = vim.api

local packer_bootstrap = false -- Indicate first time installation

-- packer.nvim configuration
local conf = {
    profile = {
        enable = true,
        threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },

    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
}

local function packer_init()
    -- Check if packer.nvim is installed
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        packer_bootstrap = fn.system({
            "git",
            "clone",
            "--depth",
            "1",
            "https://github.com/wbthomason/packer.nvim",
            install_path,
        })
        cmd([[packadd packer.nvim]])
    end

    -- Run PackerCompile if there are changes in this file
    local packerGrp = api.nvim_create_augroup("packer_user_config", { clear = true })
    api.nvim_create_autocmd(
        { "BufWritePost" },
        { pattern = "init.lua", command = "source <afile> | PackerCompile", group = packerGrp }
    )
end

-- Plugins
local function plugins(use)
    use({ "wbthomason/packer.nvim" })

    -- Performance
    use { "lewis6991/impatient.nvim" }

    -- Colorscheme
    use {
      "shaunsingh/nord.nvim",
      config = function()
        -- Example config in lua
        vim.g.nord_contrast = false
        vim.g.nord_borders = false
        vim.g.nord_disable_background = true
        vim.g.nord_italic = false
        vim.g.nord_uniform_diff_background = true

        -- Load the colorscheme
        require('nord').set()
      end,
    }

    -- Load only when required
    use { "nvim-lua/plenary.nvim", module = "plenary" }
    -- use { "nvim-lua/popup.nvim" }

    -- python black
    use({'psf/black', branch = 'stable' })

    use {
        'nvim-telescope/telescope.nvim',
        wants = {
            "plenary.nvim",
            'ripgrep',
            "telescope-fzf-native.nvim"
        },
        requires = { 
            'nvim-lua/plenary.nvim',
            'BurntSushi/ripgrep',
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        },
        config = function()
            require("config.telescope_conf")
        end,		
    }

    -- harpoon
    use({
      'ThePrimeagen/harpoon',
      module = "harpoon",
      config = function()
        require("config.harpoon").setup()
      end,      
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-lua/popup.nvim'
      }
    })

    -- refactoring
    use {
      "ThePrimeagen/refactoring.nvim",
      event = "VimEnter",
      config = function()
        require("config.refactoring").setup()
      end,
    }

    -- Coc.nvim 
    -- snippets
    use({
        'neoclide/coc.nvim', 
        branch = 'release',
        requires = {
            "rafamadriz/friendly-snippets",
            -- "honza/vim-snippets",
        },    
    })

    use({
        "kyazdani42/nvim-tree.lua",
        requires = {
                "kyazdani42/nvim-web-devicons",
        },
        cmd = { "NvimTreeToggle", "NvimTreeClose" },
        config = function()
                require("config.nvimtree").setup()
        end,
    })

    -- use({
    -- 	"echasnovski/mini.nvim",
    -- 	config = function()
    -- 		require("config.mini.base16")
    -- 		require("config.mini.starter")
    -- 		require("config.mini.statusline")
    -- 		require("config.mini.comment")
    -- 		require("config.mini.surround")
    -- 		require("config.mini.tabline")
    -- 		require("config.mini.completion")
    -- 	end,
    -- })

    -- WhichKey
    use {
      "folke/which-key.nvim",
      event = "VimEnter",
      keys = { [[<legend>]] },
      config = function()
        require("config.whichkey").setup()
      end,
      disable = false,
    }

    -- Buffer line
    use {
      "akinsho/nvim-bufferline.lua",
      event = "BufReadPre",
      wants = "nvim-web-devicons",
      config = function()
        require("config.bufferline").setup()
      end,
    }

    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      opt = true,
      event = "BufReadPre",
      run = ":TSUpdate",
      config = function()
        require("config.treesitter").setup()
      end,
    --   requires = {
    --     { "nvim-treesitter/nvim-treesitter-textobjects", event = "BufReadPre" },
    --     { "windwp/nvim-ts-autotag", event = "InsertEnter" },
    --     { "JoosepAlviste/nvim-ts-context-commentstring", event = "BufReadPre" },
    --     { "p00f/nvim-ts-rainbow", event = "BufReadPre" },
    --     { "RRethy/nvim-treesitter-textsubjects", event = "BufReadPre" },
    --     -- { "nvim-treesitter/nvim-treesitter-context", event = "BufReadPre" },
    --     -- { "yioneko/nvim-yati", event = "BufReadPre" },
    --   },
    }


    -- Debugging
    use {
      "mfussenegger/nvim-dap",
      opt = true,
      event = "BufReadPre",
      keys = { [[<leader>d]] },
      module = { "dap" },
      requires = {
        "Pocco81/DAPInstall.nvim",
        -- UI extensions 
        "theHamsta/nvim-dap-virtual-text",
        "nvim-telescope/telescope-dap.nvim",
        "rcarriga/nvim-dap-ui",
        -- python
        "mfussenegger/nvim-dap-python",
        -- go
        { "leoluz/nvim-dap-go", module = "dap-go" },
        { "jbyuki/one-small-step-for-vimkind", module = "osv" },
      },
      config = function()
        require("config.dap").setup()
      end,
      disable = false,
    }	

    -- Bootstrap Neovim
    if packer_bootstrap then
        print("Restart Neovim required after installation!")
        require("packer").sync()
    end
end

-- packer.nvim
-- vim.cmd('source /home/dphung/.config/nvim/viminit.vim')
packer_init()
local packer = require("packer")

-- Performance
pcall(require, "impatient")

packer.init(conf)
packer.startup(plugins)
