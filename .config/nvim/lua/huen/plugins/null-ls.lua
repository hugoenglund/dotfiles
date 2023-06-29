return {
	{
		"jose-elias-alvarez/null-ls.nvim",
		opts = {},
		config = function()
			local null_ls = require("null-ls")

			local formatting = null_ls.builtins.formatting
			local diagnostics = null_ls.builtins.diagnostics
			local code_actions = null_ls.builtins.code_actions

			-- to setup format on save
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			null_ls.setup({
				sources = {
					-- formatting
					formatting.stylua,
					formatting.yamlfmt,
					formatting.taplo,
					formatting.shellharden,
					formatting.beautysh,
					formatting.fixjson,
					formatting.black,
					formatting.isort,
					formatting.ruff,

					-- diagnostics
					diagnostics.mypy,
					diagnostics.pylint,
					diagnostics.pydocstyle,
					diagnostics.flake8,
					diagnostics.ruff,
					diagnostics.checkmake,
					diagnostics.hadolint,
					diagnostics.jsonlint,
					diagnostics.shellcheck,
					diagnostics.yamllint,
					diagnostics.alex,
					diagnostics.write_good,

					-- code actions
					code_actions.gitsigns,
					code_actions.refactoring,
					code_actions.shellcheck,
				},
				-- configure format on save
				on_attach = function(current_client, bufnr)
					if current_client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({
									filter = function(client)
										--  only use null-ls for formatting instead of lsp server
										return client.name == "null-ls"
									end,
									bufnr = bufnr,
								})
							end,
						})
					end
				end,
			})
		end,
	},

	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
		config = function()
			local mason_nls = require("mason-null-ls")

			mason_nls.setup({
				ensure_installed = {
					--lua
					"stylua",

					-- shell
					"shellcheck",
					"beautysh",
					"shellharden",

					-- yaml
					"yamllint",

					-- docker
					"hadolint",

					-- json
					"jsonlint",
					"fixjson",

					-- markdown
					"alex",
					"write_good",

					-- toml
					"taplo",

					-- python
					-- NOTE: most python services are handled locally for simplicty
					-- NOTE: use global pylint for speed improvements
					"pylint",
				},
			})
		end,
	},
}