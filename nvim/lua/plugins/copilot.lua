return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    dependencies = {
      { 'zbirenbaum/copilot.lua' },   -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim' },    -- for curl, log wrapper
    },
    build = 'make tiktoken',          -- Only on MacOS or Linux
    opts = {
      debug = true,                   -- Enable debugging
      -- See Configuration section for rest
      question_header = '  ' .. vim.env.USER .. ' ',
      answer_header = '  Copilot ',
      selection = function(source)
        local select = require 'CopilotChat.select'
        return select.visual(source) or select.buffer(source)
      end,
      -- window = {
      --   width = 0.4,
      -- },
      -- Enhance the UI
      window = {
        layout = 'float',
        relative = 'editor',   -- Change to editor for consistent positioning
        width = 0.8,
        height = 0.8,
        border = 'rounded',   -- Add rounded borders
        win_options = {
          winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
        },
      },
    },

    keys = {
      { '<c-s>',     '<CR>',  ft = 'copilot-chat', desc = 'Submit Prompt', remap = true },
      -- { '<leader>a', '', desc = '+ai', mode = { 'n', 'v' } },
      { '<leader>a', '<nop>', desc = 'ai menu',    mode = { 'n', 'v' } },

      {
        '<leader>aa',
        function()
          return require('CopilotChat').toggle()
        end,
        desc = 'Toggle (CopilotChat)',
        mode = { 'n', 'v' },
      },
      {
        '<leader>ax',
        function()
          return require('CopilotChat').reset()
        end,
        desc = 'Clear (CopilotChat)',
        mode = { 'n', 'v' },
      },
      {
        '<leader>aq',
        function()
          local input = vim.fn.input 'Quick Chat: '
          if input ~= '' then
            require('CopilotChat').ask(input)
          end
        end,
        desc = 'Quick Chat (CopilotChat)',
        mode = { 'n', 'v' },
      },
      -- Show help actions with telescope
      -- { '<leader>ad', M.pick 'help', desc = 'Diagnostic Help (CopilotChat)', mode = { 'n', 'v' } },
      -- Show prompts actions with telescope
      -- { '<leader>ap', M.pick 'prompt', desc = 'Prompt Actions (CopilotChat)', mode = { 'n', 'v' } },

      {
        '<leader>ad',
        function()
          local actions = require 'CopilotChat.actions'
          require('CopilotChat.integrations.telescope').pick(actions.help_actions())
        end,
        desc = 'Diagnostic Help (CopilotChat)',
      },
      -- Show prompts actions with telescope
      {
        '<leader>ap',
        function()
          local actions = require 'CopilotChat.actions'
          require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
        end,
        desc = 'Prompt Actions (CopilotChat)',
      },

      {
        '<leader>ae',
        function()
          require('CopilotChat').ask 'Explain this code'
        end,
        desc = 'Explain Code',
        mode = { 'n', 'v' },
      },
      {
        '<leader>ar',
        function()
          require('CopilotChat').ask 'Review this code and suggest improvements'
        end,
        desc = 'Review Code',
        mode = { 'n', 'v' },
      },
      {
        '<leader>at',
        function()
          require('CopilotChat').ask 'Generate tests for this code'
        end,
        desc = 'Generate Tests',
        mode = { 'n', 'v' },
      },
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
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
        copilot_node_command = 'node',   -- Node.js version must be > 18.x
        server_opts_overrides = {},
      })
    end
  },
  {
    -- copilot as completion for the lsp
    'zbirenbaum/copilot-cmp',
    config = function()
      require('copilot_cmp').setup()
    end
  },
}
