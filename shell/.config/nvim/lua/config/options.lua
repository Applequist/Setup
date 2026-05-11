local opt = vim.opt

-- Some globals
vim.g.mapleader = ' '
vim.g.localmapleader = ' '
vim.g.have_nerd_font = true

-- Line number settings
opt.number = true -- Line numbers
opt.relativenumber = true -- Relative line numbers
opt.cursorline = true -- Highlight the current line
opt.wrap = false -- Don't wrap line 
opt.scrolloff = 5 -- Keep 5 lines above/below cursor


-- Indentation settings
opt.tabstop = 4 -- Tab width
opt.shiftwidth = 4 -- Indent width
opt.shiftround = true -- Round indent
opt.softtabstop = 4 -- Soft tab stop
opt.expandtab = true -- Use spaces instead of tabs
opt.smartindent = true -- Smart auto-indenting
opt.autoindent = true -- Copy indent from current line


-- Search settings
opt.ignorecase = true -- Case insensitive search
opt.smartcase = true  -- Case sensitive search if uppercase in search 
opt.hlsearch = true -- Highlight search results
opt.incsearch = true -- Show matches as you type


-- Visual settings 
opt.termguicolors = true -- Enable 24-bit colors
opt.signcolumn = "yes" -- Always show sign column
opt.showmatch = true -- Highlight matching brackets
opt.matchtime = 2 -- How long to show matching brackets
opt.cmdheight = 1 -- Command line height
opt.showmode = false -- Don't show mode in command line
opt.pumheight = 10 -- Popup menu height
opt.pumblend = 10 -- Popup menu transparency
opt.winblend = 0 -- Floating point menu transparency
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 2 -- Hide x markup for bold and italic, but not markers with substitutions
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.synmaxcol = 300 -- Syntax highlighting limit
opt.ruler = false -- Disable the default ruler
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.winminwidth = 5 -- Minimum window width


-- File handling settings
opt.backup = false -- Don't create backup files
opt.writebackup = false -- Don't create backup before writing
opt.swapfile = false -- Don't create swap files
opt.undofile = true -- Persistent undo
opt.undolevels = 10000
opt.undodir = vim.fn.expand("~/.vim/undodir") -- Undo directory
opt.updatetime = 300 -- Faster completion
opt.timeoutlen = vim.g.vscode and 1000 or 300 -- Lower than default (1000) to quickly trigger which-key
opt.ttimeoutlen = 0 -- Key code timeout
opt.autoread = true -- Auto reload files changed outside vim
opt.autowrite = false -- Don't auto save


-- Behavior settings
opt.hidden = true -- Allow hidden files
opt.errorbells = false -- No error bells
opt.autochdir = false -- Don't auto change directory
opt.iskeyword:append("-") -- Treat dash as part of word
opt.path:append("**") -- Include subdirectories in search
opt.selection = "exclusive" -- Selection behavior
opt.mouse = "" -- Disable mouse support
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Disable system clipboard when SSHing to remote server but enable it locally
opt.modifiable = true -- Allow buffer modifications
opt.encoding = "UTF-8" -- Set encoding
opt.jumpoptions = "view"


-- Folding settings
opt.smoothscroll = true
vim.wo.foldmethod = "expr"
opt.foldlevel = 99 -- Start with all folds open
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"


-- Split behavior
opt.splitbelow = true -- Horizontal split goes below
opt.splitright = true -- Vertical split goes right


-- Command-line completion
opt.wildmenu = true
opt.wildmode = "longest:full,full"
opt.wildignore:append({ "*.o", "*.obj", "*.pyc", "*.class", "*.jar" })


-- Performance improvements
opt.redrawtime = 10000
opt.maxmempattern = 20000


-- Create undo directory if it doesn't exist
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end

-- Misc settings
opt.laststatus = 3 -- Global statusline
opt.linebreak = true -- Wrap lines at convenient points
opt.list = true -- Show some invisible characters (tabs...)


-- Global settings
vim.g.autoformat = true


-- Filetype settings
vim.filetype.add({
  extension = {
    env = "dotenv",
  },
  filename = {
    [".env"] = "dotenv",
    ["env"]  = "dotenv",
  },
  pattern = {
    ["[jt]sconfig.*.json"] = "jsonc",
    ["%.env%.[%w_.-]+"] = "dotevn",
  },
})

