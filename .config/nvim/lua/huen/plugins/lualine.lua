return {
	"nvim-lualine/lualine.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("lualine").setup({
			sections = {
				lualine_b = {
					"branch",
					"diff",
				},
				lualine_c = {
					"filename",
					{
						"diagnostics",
						sources = { "nvim_lsp" },
						symbols = { error = " ", warn = " ", info = " ", hint = " " },
					},
				},
			},
		})
	end,
}
