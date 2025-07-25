local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Use comma as leader
vim.g.mapleader = ","

vim.o.clipboard = "unnamedplus"

local function paste()
  return {
    vim.fn.split(vim.fn.getreg(""), "\n"),
    vim.fn.getregtype(""),
  }
end

vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = paste,
    ["*"] = paste,
  },
}

vim.opt.guifont = "Inconsolata Nerd Font Regular:h12"
vim.opt.encoding = "utf-8" -- Use UTF-8 everywhere.
vim.cmd("colorscheme railscasts")
vim.cmd("set notermguicolors")

-- Recommended by nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = "*",               -- try installing the latest stable version for plugins that support semver
  },
  checker = { enabled = false }, -- automatically check for plugin updates
})

require("mappings")

vim.opt.shell = "/bin/zsh"

-- Syntax
vim.cmd("syntax enable") -- Turn on syntax highlighting.
-- vim.opt.synmaxcol=200     -- Only highlight 200 cols for performance.
--
-- How to do this in Lua?
vim.cmd("filetype plugin indent on")                             -- required

vim.opt.autoindent = true                                        -- Match indentation of previous line
vim.opt.backspace = "indent,eol,start"                           -- Make backspace work in insert mode
vim.opt.backup = false                                           -- Don't make a backup before overwriting a file.
vim.opt.cmdheight = 2                                            -- Give more space for displaying messages.
vim.opt.display = "lastline"                                     -- When lines are cropped at the screen bottom, show as much as possible
vim.opt.expandtab = true                                         -- Use spaces instead of tabs because we're not a monster
vim.opt.gdefault = true                                          -- Assume the /g flag on substitutions to replace all matches in a line
vim.opt.guicursor = "a:blinkon0"                                 -- Don't blink the cursor
vim.opt.hidden = true                                            -- Handle multiple buffers better.
vim.opt.hlsearch = true                                          -- Highlight matches.
vim.opt.ignorecase = true                                        -- Case-insensitive searching.
vim.opt.incsearch = true                                         -- Highlight matches as you type.
vim.opt.laststatus = 2                                           -- Show the status line all the time
vim.opt.linebreak = true                                         -- Be smart about wrapping
vim.opt.list = true                                              -- Show invisibles, display tabs as '▸   ', trailing spaces as '•'
vim.opt.listchars = "tab:> ,trail:-,extends:>,precedes:<,nbsp:+" -- Highlight trailing whitespace
vim.opt.mouse = "a"                                              -- Enable mouse
vim.opt.visualbell = false                                       -- Don't flash my screen
vim.opt.number = true                                            -- Show line numbers by default.
vim.opt.relativenumber = true                                    -- Relative line numbers for non-current line
vim.opt.ruler = true                                             -- Show cursor position.
vim.opt.scrolloff = 4                                            -- Show 4 lines of context around the cursor.
vim.opt.shiftwidth = 2                                           -- But doesn't mean I want everything indented to tabstop.
vim.opt.showcmd = true                                           -- Display incomplete commands.
vim.opt.showmatch = true                                         -- Highlight matching brackets
vim.opt.showmode = true                                          -- Display the mode you're in.
vim.opt.sidescrolloff = 10
vim.opt.smartcase = true                                         -- But case-sensitive if expression contains a capital letter.
vim.opt.smarttab = true                                          -- Use spaces instead of tabs because we're not a monster
vim.opt.splitbelow = true                                        -- Default split direction
vim.opt.splitright = true                                        -- Default split direction
vim.opt.softtabstop = 2                                          -- 2 space tabs
vim.opt.tabstop = 2                                              -- 2 space tabs
vim.opt.title = true                                             -- Set the terminal's title
vim.opt.ttyfast = true                                           -- smoother output, we're not on a 1200 dialup :)
vim.opt.wildmenu = true                                          -- Autocompletion list
vim.opt.wildmode = "list:longest"                                -- Complete files like a shell.
vim.opt.wrap = true
vim.opt.writebackup = false                                      -- And again.
vim.opt.textwidth = 120

vim.cmd("set directory=/tmp/")

-- Put yanked text in a global clipboard so I can copy between instances like
-- a normal person. This breaks mac though, so not there
vim.cmd("set clipboard+=unnamedplus")
vim.opt.clipboard = "unnamedplus"

-- ignore on completions, used by command-t at least, likely others
vim.opt.wildignore = vim.tbl_extend("force", vim.opt.wildignore or {}, {
  ".git",
  "venv/**",
  "vendor/bundle/**",
  "log/**",
  "tmp/**",
  "node_modules/**",
  "deps/**",
  "priv/static/**",
  "lcov-report/**",
  "coverage-ts/**",
  "cover/**",
  "doc/**",
})

vim.opt.foldmethod = "manual" -- I don't always fold code, but when I do, I do it manually

-- Show Git diff in window split when committing
vim.cmd("au FileType gitcommit DiffGitCached | wincmd L | wincmd p")

vim.api.nvim_set_hl(0, "@tag", { link = "xmlTagName" })
vim.api.nvim_set_hl(0, "@tag.attribute", { link = "Type" })
vim.api.nvim_set_hl(0, "@parameter.tsx", { link = "PreProc" })
vim.api.nvim_set_hl(0, "@constructor.tsx", { link = "Normal" })
vim.api.nvim_set_hl(0, "@variable.tsx", { link = "Normal" })
vim.api.nvim_set_hl(0, "@type.tsx", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@symbol.elixir", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@comment._identifier", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@constant.builtin.elixir", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@punctuation.special.elixir", { link = "Normal" })
vim.api.nvim_set_hl(0, "@punctuation.bracket.elixir", { link = "Normal" })
vim.api.nvim_set_hl(0, "@variable.elixir", { link = "Normal" })
vim.api.nvim_set_hl(0, "@function.elixir", { link = "Function" })
vim.api.nvim_set_hl(0, "jsxTagName", { link = "xmlTagName" })
vim.api.nvim_set_hl(0, "jsxEndComponentName", { link = "xmlTagName" })
vim.api.nvim_set_hl(0, "jsxComponentName", { link = "xmlTagName" })
vim.api.nvim_set_hl(0, "jsxTag", { link = "xmlTagName" })
-- Pmenu is the context menu background for ctrl+K
vim.api.nvim_set_hl(0, "Pmenu", { link = "Normal" })
