vim.cmd('colorscheme catppuccin')

---------------------------------------------------------
-- Options
---------------------------------------------------------
local opt = vim.opt

-- Some globals
vim.g.mapleader = ' '
vim.g.localmapleader = ' '
vim.g.have_nerd_font = true
vim.g.autoformat = true

-- Gutter settings
opt.number = true -- Line numbers
opt.relativenumber = true -- Relative line numbers
opt.numberwidth = 5 -- default to 4 but 1 space is wasted between number and start of line
opt.signcolumn = "yes" -- Always show sign column


-- Line settings: indentation, wrapping...
opt.tabstop = 4 -- Tab width
opt.shiftwidth = 4 -- Indent width
opt.softtabstop = 4 -- Soft tab stop
opt.expandtab = false -- Keep using tabs
opt.smartindent = true -- Smart auto-indenting
opt.autoindent = true -- Copy indent from current line
opt.wrap = false -- Don't wrap line


-- Visual settings 
opt.termguicolors = true -- Enable 24-bit colors
opt.list = true -- Show some invisible characters (tabs...)
opt.cursorline = true -- Highlight the current line
opt.showmatch = true -- Highlight matching brackets
opt.matchtime = 2 -- How long to show matching brackets
opt.scrolloff = 2 -- Keep n lines above/below cursor
opt.cmdheight = 1 -- Command line height
opt.showmode = false -- Don't show mode in command line
opt.pumheight = 10 -- Popup menu height
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.winminwidth = 5 -- Minimum window width


-- Split behavior
opt.splitbelow = true -- Horizontal split goes below
opt.splitright = true -- Vertical split goes right


-- Search settings
opt.ignorecase = true -- Case insensitive search
opt.smartcase = true  -- Case sensitive search if uppercase in search
opt.hlsearch = true -- Highlight search results
opt.incsearch = true -- Show matches as you type
opt.grepprg = "rg --vimgrep" -- Use ripgrep for search
opt.grepformat = "%f:%l:%c:%m" -- Define :grep result format


-- File handling settings
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.writebackup = false -- Don't create backup before writing
opt.swapfile = false -- Don't create swap files
opt.undofile = true -- Persistent undo
opt.undolevels = 10000 -- 10x the default value!
-- Create undo directory if it doesn't exist
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end
opt.undodir = vim.fn.expand("~/.vim/undodir") -- Undo directory


-- Behavior settings
opt.mouse = "" -- Disable mouse support
opt.iskeyword:append("-") -- Treat dash as part of word
opt.path:append("**") -- Include subdirectories in search
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Disable system clipboard when SSHing to remote server but enable it locally


-- Completion
opt.completeopt = "menu,menuone,noselect"


---------------------------------------------------------
-- Keymaps
---------------------------------------------------------
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ====================================================
-- BUFFER NAVIGATION
-- ====================================================

-- Tab/Shift-Tab: Like browser tabs, feels natural
map("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", ":bprev<CR>", { desc = "Previous buffer" })

map("n", "<S-h>", ":bprev<CR>", { desc = "Previous buffer" })
map("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })


-- ====================================================
-- WINDOW MANAGEMENT (splitting and navigation)
-- ====================================================

-- Move between windows with Ctrl+hjkl (like tmux)
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize windows with Ctrl-Shift+arrows 
map("n", "<C-S-Up>", "<cmd>resize +5<CR>", opts )
map("n", "<C-S-Down>", "<cmd>resize -5<CR>", opts )
map("n", "<C-S-Left>", "<cmd>vertical resize -5<CR>", opts )
map("n", "<C-S-Right>", "<cmd>vertical resize +5<CR>", opts )

-- Split window
map("n", "<leader>-", "<C-w>s", { desc = "Split window below" })
map("n", "<leader>|", "<C-w>v", { desc = "Split window right" })

-- ===================================================
-- SEARCH AND NAVIGATION
-- ===================================================

-- Clear search highlighting 
map({ "i", "n" }, "<esc>", "<cmd>nohl<CR><esc>", { desc = "Clear hlsearch and escape" })

-- ===================================================
-- SMART TEXT EDITING
-- ===================================================

-- Better indenting (stay in visual mode)
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Smart undo "break-points" (create undo points at logical stops)
map("i", ",", ",<C-g>u")
map("i", ".", ".<C-g>u")
map("i", ";", ";<C-g>u")

-- Better paste (doesn't replace clipboard with deleted text)
map("v", "p", '"_dP', opts)

-- Copy whole file to clipboard
map("n", "<C-c>", ":%y+<CR>", opts)

-- =================================================
-- FILE OPERATIONS
-- =================================================

-- Save file (works in all mode)
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<CR><esc>", { desc = "Save file" })

-- ==================================================
-- TERMINAL INTEGRATION 
-- ==================================================

-- Terminal mode navigation
map("t", "<esc><esc>", "<C-\\><C-n>", { desc = "Enter normal mode" })
map("t", "<C-h>", "<cmd>wincmd h<CR>", { desc = "Go to left window" })
map("t", "<C-j>", "<cmd>wincmd j<CR>", { desc = "Go to lower window" })
map("t", "<C-k>", "<cmd>wincmd k<CR>", { desc = "Go to upper window" })
map("t", "<C-l>", "<cmd>wincmd l<CR>", { desc = "Go to right window" })
map("t", "<C-/>", "<cmd>close<CR>", { desc = "Hide Terminal" })

-- ================================================
-- FOLDING NAVIGATION 
-- ================================================

-- Close all folds except the current one (great for focus)
map("n", "zv", "zMzvzz", { desc = "Close all folds except the current one" })

-- Smart fold navigation (closes current, open next/previous)
map("n", "zj", "zcjzOzz", { desc = "Close current fold when open. Always open next fold" })
map("n", "zk", "zckzOzz", { desc = "Close current fold when open. Always open previous fold" })


---------------------------------------------------------
-- Autocommands
---------------------------------------------------------
local function augroup(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

-- Hightlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

-- Resize splits if window got resized
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- Auto create dir when saving a file
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})


-- LSP configuration:
-- step 1: manual config
-- vim.lsp.config() or put config in <config_dir>/lsp/<my_lang_server>/
-- vim.lsp.enable(<my_lang_server>)
vim.lsp.enable('lua_ls')

--
-- step 2: Use nvim-lspconfig plugin
-- vim.pack.add({ src = https://github.com/neovim/nvim-lspconfig })
-- vim.lsp.enable({ <lang_servers> })
-- opt: override part of a config by adding a config in lsp/<lang_server>/. Config are merged.
--
-- step 3: Use mason to install language server and mason-lspconfig to enable servers
-- using:
-- vim.pack.add(
--   { src = https://github.com/mason-org/mason.nvim },
--   { src = "https://github.comm/mason-org/mason-lspconfig.nvim" },
-- )
-- require('mason').setup({})
-- require('mason-lspconfig').setup({
--   ensure_installed = { lua_ls, ts_ls }
-- })
-- -- no more vim.lsp.enable({...}) required.
--
-- step 4: Use mason tool installer for linters
-- vim.pack.add(
--   { src = https://github.com/mason-org/mason.nvim },
--   { src = "https://github.comm/mason-org/mason-lspconfig.nvim" },
--   { src = "https://github.com/mason-org/mason-tool-installer.nvim" },
-- )
-- require('mason').setup({})
-- require('mason-lspconfig').setup({})
-- require('mason-tool-installer').setup({
--   ensure_installed = { lua_ls, ts_ls, eslint_d }
-- })
--
