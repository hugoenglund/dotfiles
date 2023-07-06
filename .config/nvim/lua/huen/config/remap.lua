local keymap = vim.keymap.set

-- open vim file explorer
keymap("n", "<leader>pv", vim.cmd.Ex)

-- move selected block of code
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- keep cursor in place when "J"
keymap("n", "J", "mzJ`z")

-- keep cursor centered u/d navigation
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- keep searched word in centered when navigating
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- persist yanked buffer after select + paste
keymap("x", "<leader>p", '"_dP')
keymap("n", "<leader>d", '"_d')
keymap("v", "<leader>d", '"_d')

--yank to system clipboard (paste with <C-v>)
keymap("n", "<leader>y", '"+y')
keymap("v", "<leader>y", '"+y')
keymap("n", "<leader>Y", '"+Y')

-- disable "Q"
keymap("n", "Q", "<nop>")

--open directory via tmux
-- keymap("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- quickfix
-- keymap("n", "<C-k>", "<cmd>cnext<CR>zz")
-- keymap("n", "<C-j>", "<cmd>cprev<CR>zz")
-- keymap("n", "<leader>k", "<cmd>lnext<CR>zz")
-- keymap("n", "<leader>j", "<cmd>lprev<CR>zz")

-- edit all occurrences of the word under cursor
keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- edit all occurences of selected text
keymap("v", "<C-r>", [["hy:%s/<C-r>h//g<left><left><left>]])

-- make bash script executable
keymap("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- write shortcut
keymap("n", "<leader>w", ":w<CR>")

-- format shortcut
keymap("n", "<leader>f", vim.lsp.buf.format)

-- navigate panes
keymap("n", "gh", "<C-w>h")
keymap("n", "gj", "<C-w>j")
keymap("n", "gk", "<C-w>k")
keymap("n", "gl", "<C-w>l")
