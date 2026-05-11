-- Entry point for Neovim configuration

-- Load all configuration modules
require("config.options")
require("config.keymaps")
require("config.diagnostics")
require("config.autocmds")

vim.cmd('colorscheme catppuccin')

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
