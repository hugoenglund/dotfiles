return {
	"glepnir/lspsaga.nvim",
	event = "LspAttach",
	config = function()
		require("lspsaga").setup({
			lightbulb = { enable = false },
			ui = {
				kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
			},
		})
	end,
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
		--Please make sure you install markdown and markdown_inline parser
		{ "nvim-treesitter/nvim-treesitter" },
	},
}
