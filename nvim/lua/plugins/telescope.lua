return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    branch = '0.1.x',
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<C-p>', builtin.find_files, {})
      vim.keymap.set('n', '<Leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<Leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<Leader>fh', builtin.help_tags, {})
      require('telescope').setup({
        defaults = {
          mappings = {
            i = {
              -- Use Ctrl+U to clear the search input
              ['<C-u>'] = false
            },
          },
        }
      })
    end
  }
}
