local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
  git = {
    clone_timeout = 300, -- Timeout, in seconds, for git clones
  },
}

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- colorscheme
  use {'ellisonleao/gruvbox.nvim', config = function()
      require("gruvbox").setup({
          transparent_mode = true
      })
  end}
  use 'sainnhe/gruvbox-material'

  -- LSP
  use {
    'neoclide/coc.nvim',
    branch = 'release'
  }

  -- Autopairs
  use {
	"windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }

  -- Comment
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  use {'nvim-treesitter/nvim-treesitter', config = function()
    require('nvim-treesitter').setup {
        indent = { enable = true }
    }
  end}

  --Search
  use 'dyng/ctrlsf.vim'
  use { "junegunn/fzf", run = "./install --all" }
  use { "junegunn/fzf.vim" }

  --Terminal
  use {"akinsho/toggleterm.nvim", tag = '*', config = function()
    require("toggleterm").setup()
  end}

  -- nvimtree
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly', -- optional, updated every week. (see issue #1193)
    config = function()
      require('nvim-tree').setup()
    end  
  }

  -- multiple-cursors
  use 'mg979/vim-visual-multi'

  -- tabs
   use 'nvim-tree/nvim-web-devicons'
   use {'romgrk/barbar.nvim', requires = 'nvim-web-devicons'}

  -- lines
   use {"lukas-reineke/indent-blankline.nvim", config = function()
        require('indent_blankline').setup{
            show_end_of_line = true,
            space_char_blankline = " ",
            show_trailing_blankline_indent = false
        }
   end}

    use {
      "startup-nvim/startup.nvim",
      requires = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
      config = function()
        require"startup".setup()
      end
    }

    use {'norcalli/nvim-colorizer.lua', config = function()
        require('colorizer').setup()
    end}

    use {'lewis6991/gitsigns.nvim', config = function()
        require('gitsigns').setup()
    end}
end)
