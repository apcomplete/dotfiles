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
    "mhanberg/output-panel.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("output_panel").setup({
        max_buffer_size = 5000 -- default
      })
    end,
    cmd = { "OutputPanel" },
    keys = {
      {
        "<leader>o",
        vim.cmd.OutputPanel,
        mode = "n",
        desc = "Toggle the output panel",
      },
    }
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
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  }
}
