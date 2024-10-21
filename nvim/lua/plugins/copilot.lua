return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          typescriptreact = true,
          typescript = true,
          javascript = true,
          python = true,
          ['.'] = false,
        },
        copilot_node_command = 'node', -- Node.js version must be > 18.x
        server_opts_overrides = {},      
      })
    end
  },
  {
    -- copilot as completion for the lsp
    'zbirenbaum/copilot-cmp',
    config = function ()
      require('copilot_cmp').setup()
    end
  },
}
