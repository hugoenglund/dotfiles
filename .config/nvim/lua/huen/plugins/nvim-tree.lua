return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"antosha417/nvim-lsp-file-operations",
		"echasnovski/mini.base16",
	},
	keys = {
		{
			"<leader>tt",
			function()
				require("nvim-tree.api").tree.toggle()
			end,
			desc = "Toggle file tree",
		},
		{
			"<leader>ft",
			function()
				require("nvim-tree.api").tree.focus()
			end,
			desc = "Focus file tree",
		},
	},
	config = function()
		require("nvim-tree").setup({})
	end,
}
