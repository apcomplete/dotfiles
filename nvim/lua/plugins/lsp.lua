local M = {}

local get_cursor_position = function()
  local rowcol = vim.api.nvim_win_get_cursor(0)
  local row = rowcol[1] - 1
  local col = rowcol[2]

  return row, col
end

local manipulate_pipes = function(direction, client)
  local row, col = get_cursor_position()

  client.request_sync("workspace/executeCommand", {
    command = "manipulatePipes:serverid",
    arguments = { direction, "file://" .. vim.api.nvim_buf_get_name(0), row, col },
  }, nil, 0)
end

function M.from_pipe(client)
  return function()
    manipulate_pipes("fromPipe", client)
  end
end

function M.to_pipe(client)
  return function()
    manipulate_pipes("toPipe", client)
  end
end

return {
  'williamboman/mason.nvim',
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'bashls',
          'cssls',
          'dockerls',
          'eslint',
          'elixirls',
          'html',
          'jsonls',
          'lua_ls',
          'marksman', -- markdown
          'nextls',
          'sqlls',
        },
        automatic_installation = true,
      })
    end
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      vim.lsp.config('html', {})

      vim.lsp.config('elixirls', {
        cmd = { 'elixir-ls' }
      })

      vim.lsp.config('nextls', {
        cmd = { 'nextls', '--stdio' }
      })

      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            format = {
              enable = true,
              defaultConfig = {
                indent_stle = "space",
              },
            },
            runtime = {
              version = "LuaJIT",
            },
          },
        }
      })

      vim.lsp.enable('elixirls')
      vim.lsp.enable('nextls')
      vim.lsp.enable('lua_ls')

      -- Use internal formatting for bindings like gq. null-ls or neovim messes this up somehow
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
        callback = function(ev, bufopts)
          local bufnr = vim.api.nvim_get_current_buf()
          local client = vim.lsp.get_client_by_id(ev.data.client_id)

          vim.api.nvim_buf_create_user_command(bufnr, "ElixirFromPipe", M.from_pipe(client), {})
          vim.api.nvim_buf_create_user_command(bufnr, "ElixirToPipe", M.to_pipe(client), {})

          vim.bo[ev.buf].formatexpr = nil
          vim.lsp.completion.enable(true, ev.data.client_id, ev.buf)
          vim.keymap.set("n", "<leader>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
          vim.keymap.set("n", "<leader>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
          vim.keymap.set("v", "<leader>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
          vim.keymap.set("n", "<C-]>", vim.lsp.buf.definition, bufopts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
          vim.keymap.set("n", "<LEADER>wa", vim.lsp.buf.add_workspace_folder, bufopts)
          vim.keymap.set("n", "<LEADER>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
          vim.keymap.set("n", "<LEADER>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, bufopts)
          vim.keymap.set("n", "<LEADER>D", vim.lsp.buf.type_definition, bufopts)
          vim.keymap.set("n", "<LEADER>rn", vim.lsp.buf.rename, bufopts)
          vim.keymap.set("n", "<LEADER>ca", vim.lsp.buf.code_action, bufopts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
          vim.keymap.set("n", "<LEADER>p", function()
            vim.lsp.buf.format({ async = true })
          end, bufopts)
          -- run the codelens under the cursor
          vim.keymap.set("n", "<leader>r", vim.lsp.codelens.run, bufopts)
          vim.lsp.inlay_hint.enable(true, bufopts)
        end,
      })
    end
  }
}
