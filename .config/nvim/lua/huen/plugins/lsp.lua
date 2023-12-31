return {
	{ "folke/neodev.nvim" },

	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v1.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{ "williamboman/mason.nvim" }, -- Optional
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "hrsh7th/cmp-buffer" }, -- Optional
			{ "hrsh7th/cmp-path" }, -- Optional
			{ "saadparwaiz1/cmp_luasnip" }, -- Optional
			{ "hrsh7th/cmp-nvim-lua" }, -- Optional

			-- Snippets
			{ "L3MON4D3/LuaSnip" }, -- Required
			{ "rafamadriz/friendly-snippets" }, -- Optional
		},
		config = function()
			local keymap = vim.keymap.set
			local lsp = require("lsp-zero")

			lsp.preset("recommended")

			-- python: pyright
			lsp.configure("pyright", {
				root_dir = require("lspconfig.util").root_pattern("pyproject.toml", "pyrightconfig.json"),
				settings = {
					python = {
						analysis = {
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "openFilesOnly",
						},
					},
				},
			})

			-- python: ruff-lsp
			lsp.configure("ruff_lsp", {
				root_dir = require("lspconfig.util").root_pattern("pyproject.toml"),
				settings = {
					-- Any extra CLI arguments for `ruff` go here.
					args = { "--config", "pyproject.toml" },
				},
			})

			-- toml
			lsp.configure("taplo", {
				root_dir = require("lspconfig.util").root_pattern(".taplo.toml", "taplo.toml"),
			})

			lsp.on_attach(function(_, bufnr)
				local opts = { buffer = bufnr, remap = false }

				keymap("n", "gd", vim.lsp.buf.definition, opts)
				keymap("n", "gt", vim.lsp.buf.type_definition, opts)
				keymap("n", "gD", vim.lsp.buf.declaration, opts)
				keymap("n", "gi", vim.lsp.buf.implementation, opts)

				keymap("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
				keymap("n", "<leader>vd", vim.diagnostic.open_float, opts)
				keymap("n", "<leader>vca", vim.lsp.buf.code_action, opts)
				keymap("n", "<leader>vrn", vim.lsp.buf.rename, opts)

				keymap("n", "<C-k>", vim.lsp.buf.signature_help, opts)
				keymap("i", "<C-h>", vim.lsp.buf.signature_help, opts)

				-- Disable in favor of LSP saga
				-- keymap("n", "[d", vim.diagnostic.goto_prev, opts)
				-- keymap("n", "]d", vim.diagnostic.goto_next, opts)

				-- LSP saga keymaps
				keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
				keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
				keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
				keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
				keymap("n", "<leader>pd", "<cmd>Lspsaga peek_definition<CR>", opts)
				keymap("n", "gr", "<cmd>Lspsaga finder<CR>", opts)
			end)

			lsp.setup()

			vim.diagnostic.config({
				virtual_text = true,
				underline = { severity_limit = "Error" },
				signs = true,
				update_in_insert = false,
				severity_sort = true,
			})
		end,
	},
}
