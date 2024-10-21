return {
  {
    'preservim/nerdtree',
    config = function()
      vim.api.nvim_set_keymap('', '<Leader>w', ':NERDTreeToggle<CR>', { noremap = true })
    end
  },
  {
    'vim-scripts/bufexplorer.zip',
    config = function()
      vim.g.bufExplorerFindActive = 0
    end
  },
  {
    'mileszs/ack.vim',
    config = function()
      vim.g.ackprg = 'rg --vimgrep --smart-case'
      vim.cmd('cnoreabbrev Ack Ack!')
      vim.cmd('cnoreabbrev ack Ack!')
      vim.opt.grepprg = 'rg --vimgrep --smart-case --hidden'
    end
  },
  {
    'tpope/vim-projectionist',
    config = function()
      require('projectionist').setup()
    end
  },
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons'
    },
    config = function ()
      require('aerial').setup({
        -- optionally use on_attach to set keymaps when aerial has attached to a buffer
        on_attach = function(bufnr)
          -- Jump forwards/backwards with '{' and '}'
          vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
          vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
          vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>')
        end,
      })
    end
  },
}
