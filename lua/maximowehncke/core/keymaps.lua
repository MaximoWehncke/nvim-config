-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- if text is wrap, it goes to the next visual line, otherwise normal j-k
keymap.set('n', 'j', 'gj', { silent = true })
keymap.set('n', 'k', 'gk', { silent = true })

keymap.set("n", "<leader>sws", "<cmd>set wrap<CR>", { desc = "Wrap text" })
keymap.set("n", "<leader>swu", "<cmd>set nowrap<CR>", { desc = "Unwrap text" })
-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR><cmd>tabmove$<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tk", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<S-l>", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<S-h>", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- TIP: Disable arrow keys in normal mode
keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')
keymap.set("n", "dzz", "<cmd>%delete _<CR>i", { desc = "Delete all without yanking" })
keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })

-- Scroll
keymap.set("n", "<C-m>", "<Nop>")
keymap.set("n", "<C-n>", "<C-W><C-W><C-D><C-W><C-W>", { desc = "Scoll half page down neighbour window" })
keymap.set("n", "<C-m>", "<C-W><C-W><C-U><C-W><C-W>", { desc = "Scoll half page up neighbour window" })

-- quit all no sabe
keymap.set("n", "<leader>qq", "<cmd>qa!<CR>", { desc = "Quit everything, save nothing" })
keymap.set(
	"n",
	"<leader>ww",
	'<cmd>wa<CR><cmd>echo "you\'ve just saved everything, dude"<CR>',
	{ desc = "Save everything, for real" }
)
keymap.set("n", "<leader>rr", "<cmd>e!<CR>", { desc = "Reset buffer to as it was before saving" })

keymap.set("n", "<leader>bf", function()
	vim.lsp.buf.format()
end, { desc = "Format buffer" })
