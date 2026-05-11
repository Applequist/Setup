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

