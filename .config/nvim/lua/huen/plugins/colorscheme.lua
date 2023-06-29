return {
	-- catppuccin
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "macchiato",
			highlight_overrides = {
				macchiato = function(macchiato)
					return {
						LineNr = { fg = macchiato.text },
						CursorLineNr = { fg = "#8f95aa" },
					}
				end,
			},
		})

		vim.cmd([[colorscheme catppuccin]])
	end,
}
