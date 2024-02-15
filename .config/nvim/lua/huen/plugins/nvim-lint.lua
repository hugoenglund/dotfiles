return {
	"mfussenegger/nvim-lint",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			svelte = { "eslint_d" },
			python = { "mypy" },
			sql = { "sqlfluff" },
			zsh = { "zsh" },
			sh = { "shellcheck" },
			docker = { "hadolint" },
			json = { "jsonlint" },
			markdown = { "markdownlint" },
			yaml = { "yamllint" },
			lua = { "luacheck" },
		}
		vim.api.nvim_create_autocmd({
			"BufEnter",
			"BufWritePost",
			"InsertLeave",
		}, {
			callback = function()
				lint.try_lint()
			end,
		})

		local lint_progress = function()
			local linters = lint.get_running()
			if #linters == 0 then
				print("❌ No linters running...")
			else
				print("✅ " .. table.concat(linters, ", "))
			end
		end
		vim.api.nvim_create_user_command("LinterInfo", lint_progress, {})
	end,
}
