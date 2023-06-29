return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			config = function()
				require("telescope").load_extension("fzf")
			end,
		},
	},
	keys = {
		{
			"<leader>pf",
			function()
				require("telescope.builtin").find_files()
			end,
			desc = "Open file explorer",
		},
		{
			"<leader>ps",
			function()
				require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
			end,
			desc = "Project-wide search",
		},
		{
			"<C-p>",
			function()
				if os.execute("git") == 0 then
					require("telescope.builtin").git_files()
				else
					require("telescope.builtin").find_files()
				end
			end,
			desc = "Run git ls-files command if git repo, else list cwd",
		},
	},
	opts = {
		pickers = {
			find_files = {
				hidden = true, -- show hidden files
				theme = "dropdown", -- builtin theme
			},
		},
	},
}
