-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true

vim.pack.add{
  { src = 'https://github.com/neovim/nvim-lspconfig' },
}

-- Custom startup message
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    print("🚀 Welcome to Neovim, powered by Lua!")
  end
})


vim.keymap.set('i', '<C-z>', '<Esc>u', { noremap = true, silent = true })
vim.keymap.set('i', '<C-y>', '<Esc><C-r>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-z>', 'u', { noremap = true, silent = true })
vim.keymap.set('n', '<C-y>', '<C-r>', { noremap = true, silent = true })

-- vim.lsp.enable('pyright')

local lspconfig = require('lspconfig')
lspconfig.ols.setup {
	cmd = { "D:/Languages/odin_ols/ols.exe" },
	filetypes = { "odin" },
	root_dir = lspconfig.util.root_pattern("ols.json", ".git"),
	settings = {
		collections = {
			{ name = "CoffeeBreak", path = "D:/Repos/CoffeeBreak" }
		}
	}
}
