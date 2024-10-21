-- insert blank lines without going into insert mode
vim.keymap.set('n', 'go', 'o<esc>')
vim.keymap.set('n', 'gO', 'O<esc>')

-- mapping the jumping between splits. Hold control while using vim nav.
vim.keymap.set('n', 'go', 'o<esc>')
vim.keymap.set('n', '<C-J>', '<C-W>j')
vim.keymap.set('n', '<C-K>', '<C-W>k')
vim.keymap.set('n', '<C-H>', '<C-W>h')
vim.keymap.set('n', '<C-L>', '<C-W>l')

-- shortcut for =>
vim.keymap.set('i', '<C-l>', '<Space>=><Space>')

-- handy macro expansion
-- iabbrev Lidsa Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum
-- iabbrev rdebug require 'ruby-debug'; Debugger.start; Debugger.settings[:autoeval] = 1; Debugger.settings[:autolist] = 1; debugger; 0;
-- abbrev hte the

-- Yank from the cursor to the end of the line, to be consistent with C and D.
vim.keymap.set('n', 'Y', 'y$', { noremap = true })

-- clean up trailing whitespace map
local delete_trailing_ws = function()
  -- Save cursor position to later restore
  local curpos = vim.api.nvim_win_get_cursor(0)

  -- Search and replace trailing whitespace
  vim.cmd([[keeppatterns %s/\s\+$//e]])
  vim.api.nvim_win_set_cursor(0, curpos)
end

vim.api.nvim_create_user_command('DeleteWS', delete_trailing_ws, { desc = 'Delete trailing whitespace' })
vim.api.nvim_set_keymap('', '<Leader>e', ':DeleteWS<CR>', { noremap = true })

-- make tab key match bracket pairs
vim.keymap.set('n', '<tab>', '%', { noremap = true })
vim.keymap.set('v', '<tab>', '%', { noremap = true })

-- buffer resizing mappings (shift + arrow key)
vim.keymap.set('n', '<S-Up>', '<c-w>+', { noremap = true })
vim.keymap.set('n', '<S-Down>', '<c-w>-', { noremap = true })
vim.keymap.set('n', '<S-Left>', '<c-w><', { noremap = true })
vim.keymap.set('n', '<S-Right>', '<c-w>>', { noremap = true })

-- remap jj to exit visual mode
vim.keymap.set('i', 'jj', '<Esc>')

-- Clear highlighting for search
vim.keymap.set('n', '<Leader>/', ':nohls<CR>', { noremap = true })

-- Disable middle mouse click
vim.keymap.set('', '<MiddleMouse>', '<Nop>')
vim.keymap.set('i', '<MiddleMouse>', '<Nop>')

-- Save using sudo access
vim.keymap.set('c', 'w!!', '%!sudo tee > /dev/null %')

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(args)
    -- Use internal formatting for bindings like gq. null-ls or neovim messes this up somehow
    vim.bo[args.buf].formatexpr = nil
  end,
})
