return {
  'tpope/vim-repeat',
  'tpope/vim-surround',
  'tpope/vim-unimpaired',
  {
    'FabijanZulj/blame.nvim',
    config = function()
      require("blame").setup()
      vim.api.nvim_set_keymap('', '<Leader>gb', ':BlameToggle<CR>', { noremap = true })
    end
  },
  'folke/ts-comments.nvim',
}
