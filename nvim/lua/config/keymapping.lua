-- clipboard --
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], { desc = "Copy to clipboard" })
vim.keymap.set({"n", "v"}, "<leader>y", [["+p]], { desc = "Paste from clipboard" })

-- splits --
vim.keymap.set("n", "<leader>sv", [[<C-w>v]], { desc = "Split window vertically" }) 
vim.keymap.set("n", "<leader>sh", [[<C-w>s]], { desc = "Split window horizontally" }) 
vim.keymap.set("n", "<leader>se", [[<C-w>=]], { desc = "Reset split size to default" }) 
vim.keymap.set("n", "<leader>sw", [[close]], { desc = "Close current split" }) 

-- tabs --
vim.keymap.set("n", "<leader>to", [[tabnew]], { desc = "Open new tab" }) 
vim.keymap.set("n", "<leader>tw", [[tabclose]], { desc = "Close current tab" }) 
vim.keymap.set("n", "<leader>tl", [[tabn]], { desc = "Go to next tab" }) 
vim.keymap.set("n", "<leader>th", [[tabp]], { desc = "Go to previous tab" }) 
vim.keymap.set("n", "<leader>t%", [[tabnew %]], { desc = "Open current buffer in new tab" }) 
