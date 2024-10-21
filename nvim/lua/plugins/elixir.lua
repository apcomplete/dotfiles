return {
  {
    'elixir-tools/elixir-tools.nvim',
    version = "*",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local elixir = require("elixir")
      local elixirls = require("elixir.elixirls")

      elixir.setup {
        credo = {},
        elixirls = {
          enable = true,
          settings = elixirls.settings {
            -- there's a bug where formatting won't respect formatter.exs while the app is building
            -- https://github.com/elixir-lsp/elixir-ls/issues/526
            autoBuild = true,
            dialyzerEnabled = true,
            fetchDeps = true,
            enableTestLenses = false,
            suggestSpecs = false,
          },
          on_attach = function(client, bufnr)
            local bufopts = { buffer = bufnr, noremap = true }
            require('util.on_attach')(client, bufnr)
            -- remove the pipe operator
            vim.keymap.set("n", "<leader>fp", ":ElixirFromPipe<cr>", bufopts)
            -- add the pipe operator
            vim.keymap.set("n", "<leader>tp", ":ElixirToPipe<cr>", bufopts)
            vim.keymap.set("v", "<leader>em", ":ElixirExpandMacro<cr>", bufopts)
          end
        }
      }
    end
  }
}
