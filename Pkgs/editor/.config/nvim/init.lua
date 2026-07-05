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
opt.expandtab = false -- Do not expand tab
opt.smartindent = true -- Smart auto-indenting
opt.wrap = false -- Don't wrap line

-- Visual settings
opt.conceallevel = 0 -- Never conceal
opt.concealcursor = "nc" -- conceal at cursor lines in normal and command line editingi mode
opt.list = true -- Show some invisible characters (tabs...)
opt.listchars = 'tab:^ ,nbsp:¬,extends:»,precedes:«,trail:•'
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
opt.grepprg = "rg --vimgrep" -- Use ripgrep for search
opt.grepformat = "%f:%l:%c:%m" -- Define :grep result format

-- File handling settings
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.writebackup = false -- Don't create backup before writing
opt.swapfile = false -- Don't create swap files
opt.undofile = true -- Persistent undo
opt.undolevels = 10000 -- 10x the default value!

-- Behavior settings
opt.mouse = "" -- Disable mouse support
opt.iskeyword:append("-") -- Treat dash as part of word
opt.path:append("**") -- Include subdirectories in search
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Disable system clipboard when SSHing to remote server but enable it locally

-- Completion
opt.completeopt = "fuzzy,menuone,noinsert,popup"
opt.wildoptions = "fuzzy,pum"

---------------------------------------------------------
-- Keymaps
---------------------------------------------------------
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Disable arrow keys to force ourselves to use home row keys
map({ 'n', 'i' }, '<Up>', '<nop>')
map({ 'n', 'i' }, '<Down>', '<nop>')
map('i', '<Left>', '<nop>') -- mapped to :bp in normal mode below
map('i', '<Right>', '<nop>') -- mapped to :bn in normal mode below

-- Split window
map("n", "<leader>-", "<C-w>s", { desc = "Split window below" })
map("n", "<leader>|", "<C-w>v", { desc = "Split window right" })

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

-- Navigate buffers in current window
map("n", "<S-h>", ":bp<CR>", { desc = "Previous buffer" })
map("n", "<Left>", ":bp<CR>", { desc = "Previous buffer" })
map("n", "<S-l>", ":bn<CR>", { desc = "Next buffer" })
map("n", "<Right>", ":bn<CR>", { desc = "Next buffer" })

-- Search
-- Always center next match vertically
map('n', 'n', 'nzz', { silent = true })
map('n', 'N', 'Nzz', { silent = true })
map('n', '*', '*zz', { silent = true })
map('n', '#', '#zz', { silent = true })
map('n', 'g*', 'g*zz', { silent = true })
-- Clear highlight
map({ "i", "n" }, "<esc>", "<cmd>nohl<CR><esc>", { desc = "Clear hlsearch and escape" })

-- Better visual block indenting (stay in visual mode)
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Smart undo "break-points" (create undo points at logical stops)
map("i", ",", ",<C-g>u")
map("i", ".", ".<C-g>u")
map("i", ";", ";<C-g>u")

-- Better paste (doesn't replace clipboard with deleted text)
map("v", "p", '"_dP', opts)

-- Terminal mode navigation
map("t", "<esc><esc>", "<C-\\><C-n>", { desc = "Enter normal mode" })
map("t", "<C-h>", "<cmd>wincmd h<CR>", { desc = "Go to left window" })
map("t", "<C-j>", "<cmd>wincmd j<CR>", { desc = "Go to lower window" })
map("t", "<C-k>", "<cmd>wincmd k<CR>", { desc = "Go to upper window" })
map("t", "<C-l>", "<cmd>wincmd l<CR>", { desc = "Go to right window" })
map("t", "<C-/>", "<cmd>close<CR>", { desc = "Hide Terminal" })

---------------------------------------------------------
-- Diagnostics
---------------------------------------------------------
-- * If multiple diagnostic on a line, show sign for highest severity,
-- * Disable diagnostic messages at the end of line ('virtual_text')
-- * Enable 'virtual_lines' but only for the current line
vim.diagnostic.config({
	severity_sort = true,
	virtual_text = false,
	virtual_lines = { current_line = true },
})

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


---------------------------------------------------------
-- Plugins
---------------------------------------------------------
vim.pack.add({
	'https://github.com/nvim-tree/nvim-web-devicons',
	'https://github.com/nvim-lualine/lualine.nvim',
	'https://github.com/nvim-treesitter/nvim-treesitter',
	{
		src = 'https://github.com/nvim-mini/mini.pick', version = 'stable',
	},
	{
		src = 'https://github.com/nvim-mini/mini.extra', version = 'stable',
	}
})

require('lualine').setup()
-- Nvim already includes these parsers: C, Lua, Markdown...
-- See ':h treesitter'
require('nvim-treesitter').install({'go', 'rust'})

---------------------------------------------------------
-- Mini.Pick 
---------------------------------------------------------
vim.pack.add({
	{
		src = 'https://github.com/nvim-mini/mini.pick', version = 'stable',
	},
	{
		src = 'https://github.com/nvim-mini/mini.extra', version = 'stable',
	}
})
-- Center mini.pick window
local win_config = function() 
	local height = math.floor(0.618 * vim.o.lines)
	local width = math.floor(0.618 * vim.o.columns)
	return {
		anchor = 'NW',
		row = math.floor(0.5 * (vim.o.lines - height)),
		col = math.floor(0.5 * (vim.o.columns - width)),
		border = 'none',
	}
end

require('mini.pick').setup({
	window = {
		config = win_config
	}
})
require('mini.extra').setup()

-- Find files
map('n', '<Leader>ff', '<Cmd>Pick files<CR>', { desc = "Find files" })
map('n', '<Leader>fg', '<Cmd>Pick grep_live<CR>', { desc = "Find files using pattern" })
map('n', '<Leader>fr', '<Cmd>Pick git_files<CR>', { desc = "Find files in repository" })

-- Find buffers
map('n', '<Leader>fb', '<Cmd>Pick buffers<CR>', { desc = "Find buffers" })

-- Find in buffer
map('n', '<Leader>f/', '<Cmd>Pick buf_lines<CR>', { desc = "Find lines matching pattern in buffer" })

-- Find code structures
-- Add missing default LSP binding matching the one below: grd, grv
map('n', '<Leader>gS', "<Cmd>Pick lsp scope='workspace_symbol_live'<CR>", { desc = "Find workspace symbol" })
map('n', '<Leader>gO', "<Cmd>Pick lsp scope='document_symbol'<CR>", { desc = "Find document symbol" })
map('n', '<Leader>grt', "<Cmd>Pick lsp scope='type_definition'<CR>", { desc = "Find type definition" })
map('n', '<Leader>grd', "<Cmd>Pick lsp scope='definition'<CR>", { desc = "Find definition" })
map('n', '<Leader>gri', "<Cmd>Pick lsp scope='implementation'<CR>", { desc = "Find implementation" })
map('n', '<Leader>grv', "<Cmd>Pick lsp scope='declaration'<CR>", { desc = "Find declaration" })
map('n', '<Leader>grr', "<Cmd>Pick lsp scope='reference'<CR>", { desc = "Find reference" })

-- Find help 
map('n', '<Leader>fh', "<Cmd>Pick help<CR>", { desc = "Find help" })

-- Find keymaps
map('n', '<Leader>fm', '<Cmd>Pick keymaps<CR>', { desc = "Find keymaps" })


---------------------------------------------------------
-- LSP
---------------------------------------------------------
-- step 1: manual config
-- vim.lsp.config() or put config in <config_dir>/lsp/<my_lang_server>/
-- vim.lsp.enable(<my_lang_server>)
vim.lsp.enable {
	'gopls',
	'lua_ls',
	'rust_analyzer',
}

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

