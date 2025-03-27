return {
  {
    'nvimtools/none-ls.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'lukas-reineke/lsp-format.nvim',
    },
    config = function()
      local b = require('null-ls.builtins')
      local lsp_format = require('lsp-format')
      require('null-ls').setup({
        sources = {
          ----------------------
          --   Code Actions   --
          ----------------------
          -- b.code_actions.eslint,
          --b.code_actions.shellcheck,

          ----------------------
          --    Diagnostics   --
          ----------------------
          --b.diagnostics.actionlint,
          --b.diagnostics.codespell,

          b.diagnostics.credo.with {
            -- run credo in strict mode even if strict mode is not enabled in
            -- credo takes more than 5s... :(
            timeout = 10000,
            -- .credo.exs
            extra_args = { '--strict' },
            -- only register credo source if it is installed in the current project
            condition = function(_utils)
              local cmd = { 'rg', ':credo', 'mix.exs' }
              local credo_installed = ('' == vim.fn.system(cmd))
              return not credo_installed
            end,
          },
          -- b.diagnostics.eslint,
          -- b.diagnostics.yamllint,
          -- b.diagnostics.cfn_lint,
          -- require 'plugins.null-ls.commitlint',

          -- ----------------------
          -- --    Formatters    --
          -- ----------------------
          -- -- Doesn't work for heex files
          --b.formatting.mix.with {
          --extra_filetypes = {},
          --args = { 'format', '-', '--dot-formatter', '$ROOT/.formatter.exs' }
          --extra_args = function(_params)
          --local version_output = vim.fn.system 'elixir -v'
          --local minor_version = vim.fn.matchlist(version_output, 'Elixir \\d.\\(\\d\\+\\)')[2]

          --local extra_args = {}

          ---- tells the formatter the filename for the code passed to it via stdin.
          ---- This allows formatting heex files correctly. Only available for
          ---- Elixir >= 1.14
          --if tonumber(minor_version, 10) >= 14 then
          --extra_args = { '--stdin-filename', '$FILENAME' }
          --end

          --return extra_args
          --end,
          --},
          b.formatting.pg_format,
          b.formatting.prettier.with {
            filetypes = {
              'javascript',
              'javascriptreact',
              'typescript',
              'typescriptreact',
              'vue',
              'css',
              'scss',
              'less',
              'html',
              'json',
              'jsonc',
              'graphql',
              'handlebars',
            },
          },
          -- b.formatting.shfmt,
          b.formatting.stylua,

          -- python
          -- b.diagnostics.flake8.with({extra_args = {"--max-line-length","120"}}),
          --b.formatting.autoflake,
          -- b.formatting.black,
          --b.formatting.autopep8,
          --b.diagnostics.pylint,
        },
        on_attach = function(client)
          if client.supports_method 'textDocument/formatting' then
            lsp_format.on_attach(client)
          end
        end,
      })
    end
  },
  { 'mechatroner/rainbow_csv' },
  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ':TSUpdate',
    dependencies = { 'nvim-treesitter/playground' },
    event = { 'BufReadPost', 'BufNewFile' },
    cmd = { 'TSUpdateSync' },
    opts = {
      highlight = {
        enable = true,
        --disable highlighting for large files
        disable = function(lang, buf)
          local max_filesize = 500 * 1024 -- 500 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        additional_vim_regex_highlighting = true,
      },
      indent = { enable = true },
      -- A list of parser names, or 'all'
      ensure_installed = {
        'bash',
        'comment',
        'css',
        'dockerfile',
        'eex',
        'elixir',
        'erlang',
        'heex',
        'javascript',
        'json',
        'lua',
        'markdown',
        'python',
        'scss',
        'sql',
        'tsx',
        'typescript',
      },
    },
    ---@param opts TSConfig
    config = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        ---@type table<string, boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      require('nvim-treesitter.configs').setup(opts)

      if load_textobjects then
        -- PERF: no need to load the plugin, if we only need its queries for mini.ai
        if opts.textobjects then
          for _, mod in ipairs({ 'move', 'select', 'swap', 'lsp_interop' }) do
            if opts.textobjects[mod] and opts.textobjects[mod].enable then
              local Loader = require('lazy.core.loader')
              Loader.disabled_rtp_plugins['nvim-treesitter-textobjects'] = nil
              local plugin = require('lazy.core.config').plugins['nvim-treesitter-textobjects']
              require('lazy.core.loader').source_runtime(plugin.dir, 'plugin')
              break
            end
          end
        end
      end
    end,
  },
}
