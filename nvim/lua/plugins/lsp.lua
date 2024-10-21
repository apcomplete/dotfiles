return {
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'bashls',
          'cssls',
          'dockerls',
          'eslint',
          --'elixirls',
          'html',
          'jsonls',
          'marksman', -- markdown
          'pyright',
          --'ruby_ls',
          'sqlls',
        },
        automatic_installation = true,
      })
    end
  },
  'williamboman/mason-lspconfig.nvim',
  {
    'neovim/nvim-lspconfig',
    opts = {
      inlay_hints = { enabled = true },
    },
    config = function(_, opts)
      -- Mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      local opts = { noremap = true, silent = true }
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
      vim.keymap.set('n', '<LEADER>q', vim.diagnostic.setloclist, opts)

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local lsp_flags = {
        debounce_text_changes = 150
      }

      -- hook up cmp_nvim_lsp for completion
      local lspconfig = require('lspconfig')
      local lsp_defaults = lspconfig.util.default_config
      local on_attach = require('util.on_attach')
      lsp_defaults.capabilities = vim.tbl_deep_extend('force', lsp_defaults.capabilities,
        require('cmp_nvim_lsp').default_capabilities())

      lspconfig.bashls.setup({ flags = lsp_flags, on_attach = on_attach })
      lspconfig.cssls.setup({ flags = lsp_flags, on_attach = on_attach })
      lspconfig.dockerls.setup({ flags = lsp_flags, on_attach = on_attach })
      lspconfig.html.setup({ flags = lsp_flags, on_attach = on_attach })
      lspconfig.jsonls.setup({ flags = lsp_flags, on_attach = on_attach })
      lspconfig.marksman.setup({ flags = lsp_flags, on_attach = on_attach }) -- markdown
      lspconfig.pyright.setup({
        settings =  {
          python = {
            analysis = {
              diagnosticMode = "openFilesOnly",
              useLibraryCodeForTypes = true,
              typeCheckingMode = 'off'
            }
          }
        },
        flags = lsp_flags, on_attach = on_attach })
      -- lspconfig.ruby_ls.setup({ flags = lsp_flags, on_attach = on_attach })
      lspconfig.sqlls.setup({ flags = lsp_flags, on_attach = on_attach })
      lspconfig.eslint.setup({
        filetypes = {
          'javascript',
          'javascriptreact',
          'typescript',
          'typescriptreact',
        },
        settings = {
          codeAction = {
            disableRuleComment = { enable = true, location = 'separateLine' },
            showDocumentation = { enable = true },
          },
          onIgnoredFiles = 'off',
          options = {
            cache = true,
            useEslintrc = true,
          },
          packageManager = 'npm',
          quiet = false,
          run = 'onSave',
          validate = 'on',
          workingDirectory = { mode = 'auto' },
        },
      })
    end
  },
  {
    'someone-stole-my-name/yaml-companion.nvim',
    dependencies = {
      { 'neovim/nvim-lspconfig' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope.nvim' },
    },
    opts = {
      format = { enable = false },
    }
  },
}
