return {
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    settings = {
      tsserver_file_preferences = {
        includeInlayParameterNameHints = "all",
        includeCompletionsForModuleExports = true,
        quotePreference = "single",
      },
    },
    opts = {
      on_attach = function(client, bufnr)
        require('util.on_attach')(client, bufnr)
      end
    }
  },
}
