return {
  {
    'airblade/vim-gitgutter',
    config = function()
      --  -- some stupid config around gitgutter to keep line numbers showing up
      vim.cmd('highlight clear SignColumn')
      vim.cmd('highlight GitGutterAdd ctermfg=2')
      vim.cmd('highlight GitGutterChange ctermfg=3')
      vim.cmd('highlight GitGutterDelete ctermfg=1')
      vim.cmd('highlight GitGutterChangeDelete ctermfg=4')
    end
  },
  {
    'mhanberg/output-panel.nvim',
    config = function()
      require('output_panel').setup()
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({
        options = {
          icons_enabled = true,
          theme = 'auto',
        },
        sections = {
          lualine_b = { 'diff', 'diagnostics' },
          lualine_c = {
            {
              'filename',
              file_status = true, -- displays file status (readonly status, modified status)
              path = 1            -- 1 - Relative path, 2 -- absolute path
            },
          },
        },
        inactive_sections = {
          lualine_c = {
            {
              'filename',
              path = 1 -- 1 - Relative path, 2 -- absolute path
            }
          },
        },
      })
    end
  },
  {
    'folke/trouble.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      local trouble = require('trouble').setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
      vim.keymap.set('n', '<leader>xd', function() require('trouble').toggle('document_diagnostics') end)
    end
  }
}
