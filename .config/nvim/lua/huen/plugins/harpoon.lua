return {
	"ThePrimeagen/harpoon",
	keys = {
		{
			"<leader>ho",
			function()
				require("harpoon.ui").toggle_quick_menu()
			end,
			desc = "[H]arpoon [O]pen",
		},
		{
			"<leader>ha",
			function()
				require("harpoon.mark").add_file()
			end,
			desc = "[H]arpoon [A]dd",
		},
		{
			"<leader>a",
			function()
				require("harpoon.ui").nav_file(1)
			end,
			desc = "Go to harpoon [A]",
		},
		{
			"<leader>s",
			function()
				require("harpoon.ui").nav_file(2)
			end,
			desc = "Go to harpoon [S]",
		},
		{
			"<leader>d",
			function()
				require("harpoon.ui").nav_file(3)
			end,
			desc = "Go to harpoon [D]",
		},
		{
			"<leader>f",
			function()
				require("harpoon.ui").nav_file(4)
			end,
			desc = "Go to harpoon [F]",
		},
	},
}
