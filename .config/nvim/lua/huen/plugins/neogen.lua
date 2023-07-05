return {
	"danymat/neogen",
	dependencies = "nvim-treesitter/nvim-treesitter",
	config = function()
		require("neogen").setup({
			enabled = true,
			languages = {
				python = {
					template = {
						annotation_convention = "numpydoc",
					},
				},
			},
		})
	end,
	version = "*",
	keys = {
		{
			"<leader>nf",
			function()
				require("neogen").generate()
			end,
			desc = "Generate docstring in current context",
		},
	},
}
