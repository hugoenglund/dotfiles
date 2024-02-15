return {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Required
		{ "williamboman/mason.nvim" }, --
		{ "williamboman/mason-lspconfig.nvim" }, -- Required
		{ "WhoIsSethDaniel/mason-tool-installer.nvim" }, -- Required
		{ "onsails/lspkind.nvim" }, -- Required

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
		local lspconfig = require("lspconfig")
		local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
		local keymap = vim.keymap.set

		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "LSP actions",
			callback = function(event)
				local opts = { buffer = event.buf }
				local client = vim.lsp.get_client_by_id(event.data.client_id)

				-- NOTE: deprecated
				-- vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
				-- vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
				-- vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
				-- vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
				-- vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
				-- vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
				-- vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
				-- vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
				-- vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
				-- vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

				keymap("n", "gd", vim.lsp.buf.definition, opts)
				keymap("n", "gt", vim.lsp.buf.type_definition, opts)
				keymap("n", "gD", vim.lsp.buf.declaration, opts)
				keymap("n", "gi", vim.lsp.buf.implementation, opts)
				keymap("n", "gw", vim.lsp.buf.document_symbol, opts)
				keymap("n", "gW", vim.lsp.buf.workspace_symbol, opts)
				keymap("n", "<leader>vd", vim.diagnostic.open_float, opts)

				-- NOTE: disable in favor of LSP saga
				-- keymap("n", "[d", vim.diagnostic.goto_prev, opts)
				-- keymap("n", "]d", vim.diagnostic.goto_next, opts)
				-- keymap("n", "<leader>vca", vim.lsp.buf.code_action, opts)
				-- keymap("n", "<leader>vrn", vim.lsp.buf.rename, opts)
				-- keymap("n", "<C-k>", vim.lsp.buf.signature_help, opts)
				-- keymap("i", "<C-h>", vim.lsp.buf.signature_help, opts)

				-- NOTE: LSP saga keymaps
				keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
				keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
				keymap("n", "<leader>ld", "<Cmd>Lspsaga show_line_diagnostics<CR>")
				keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
				keymap("n", "<leader>pd", "<cmd>Lspsaga peek_definition<CR>", opts)
				keymap("n", "gr", "<cmd>Lspsaga finder<CR>", opts)
				keymap("n", "<leader>rn", "<Cmd>Lspsaga rename<CR>", opts)

				if client.server_capabilities.codeActionProvider then
					keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
					keymap("v", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
				end

				if client.name == "tsserver" then
					keymap("n", "<Leader>oi", "<Cmd>OrganizeImports<CR>")
				end
			end,
		})

		vim.diagnostic.config({
			virtual_text = true,
			underline = { severity_limit = vim.diagnostic.severity.ERROR },
			signs = true,
			update_in_insert = false,
			severity_sort = true,
		})

		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				"prettierd",
				"eslint_d",
				"sqlfluff",
				"beautysh",
				"shellharden", -- NOTE: requires rust
				"shellcheck",
				"hadolint",
				"markdownlint",
				"jsonlint",
				"yamllint",
			},
		})

		-- LSP configs
		-- lua
		local function default_setup(server)
			lspconfig[server].setup({
				capabilities = lsp_capabilities,
			})
		end

		local function lua_ls()
			require("lspconfig").lua_ls.setup({
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = {
								vim.env.VIMRUNTIME,
							},
						},
					},
				},
			})
		end

		-- python
		local function pyright()
			require("lspconfig").pyright.setup({
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
		end

		local function ruff_lsp()
			require("lspconfig").ruff_lsp.setup({
				root_dir = require("lspconfig.util").root_pattern("pyproject.toml"),
				settings = {
					-- Any extra CLI arguments for `ruff` go here.
					args = { "--config", "pyproject.toml" },
				},
			})
		end

		-- typescript
		local function organize_imports()
			local params = {
				command = "_typescript.organizeImports",
				arguments = { vim.api.nvim_buf_get_name(0) },
				title = "Organize imports [TS]",
			}
			vim.lsp.buf.execute_command(params)
		end

		local function tsserver()
			require("lspconfig").tsserver.setup({
				commands = {
					OrganizeImports = {
						organize_imports,
						description = "Organize imports",
					},
				},
				settings = {
					typescript = { format = { semicolons = "insert" } },
					completions = {
						completeFunctionCalls = true,
					},
				},
			})
		end

		require("mason-lspconfig").setup({
			ensure_installed = {
				"tsserver",
				"eslint",
				"tailwindcss",
				"lua_ls",
				"bashls",
				"yamlls",
				"dockerls",
				"docker_compose_language_service",
				"taplo",
				"marksman",
				"pyright",
				"ruff_lsp",
				"sqlls",
				"rust_analyzer",
			},
			automatic_installation = true,
			handlers = {
				default_setup,
				lua_ls = lua_ls,
				pyright = pyright,
				ruff_lsp = ruff_lsp,
				tsserver = tsserver,
			},
		})
	end,
}
