return function(client, bufnr)
  local bufopts = { buffer = bufnr, noremap = true }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<LEADER>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<LEADER>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<LEADER>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
  bufopts)
  vim.keymap.set('n', '<LEADER>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<LEADER>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<LEADER>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<LEADER>p', function() vim.lsp.buf.format { async = true } end, bufopts)
  -- run the codelens under the cursor
  vim.keymap.set("n", "<leader>r", vim.lsp.codelens.run, bufopts)
  vim.lsp.inlay_hint.enable(true, bufopts)
end
