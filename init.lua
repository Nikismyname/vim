vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true

vim.pack.add{
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/Tetralux/odin.vim' },
  { src = 'https://github.com/hrsh7th/nvim-cmp' },
  { src = 'https://github.com/hrsh7th/cmp-nvim-lsp' },
  { src = 'https://github.com/hrsh7th/cmp-buffer' },
  { src = 'https://github.com/hrsh7th/cmp-path' },
  { src = 'https://github.com/hrsh7th/cmp-vsnip' },
  { src = 'https://github.com/hrsh7th/vim-vsnip' }
}

vim.keymap.set('i', '<C-z>', '<Esc>u', { noremap = true, silent = true })
vim.keymap.set('i', '<C-y>', '<Esc><C-r>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-z>', 'u', { noremap = true, silent = true })
vim.keymap.set('n', '<C-y>', '<C-r>', { noremap = true, silent = true })

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

vim.cmd('syntax on')

local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'buffer' },
    { name = 'path' }
  })
})

vim.opt.clipboard:append("unnamedplus")

vim.keymap.set("v", "<C-c>", '"+y', { noremap = true, silent = true })
vim.keymap.set("n", "<C-c>", '"+y', { noremap = true, silent = true })
vim.keymap.set("i", "<C-c>", '"+y', { noremap = true, silent = true })

vim.keymap.set("n", "<C-v>", '"+p', { noremap = true, silent = true })
vim.keymap.set("i", "<C-v>", '<Esc>"+pa', { noremap = true, silent = true })
