return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local theme = require("alpha.themes.theta")
		theme.buttons.val = {}
		require("alpha").setup(theme.config)
	end,
}
