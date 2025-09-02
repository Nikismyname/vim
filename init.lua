vim.opt.number = true
-- vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true

vim.pack.add{
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/hrsh7th/nvim-cmp' },
  { src = 'https://github.com/hrsh7th/cmp-nvim-lsp' },
  { src = 'https://github.com/hrsh7th/cmp-buffer' },
  { src = 'https://github.com/hrsh7th/cmp-path' },
  { src = 'https://github.com/hrsh7th/cmp-vsnip' },
  { src = 'https://github.com/hrsh7th/vim-vsnip' },
  { src = 'https://github.com/nvim-telescope/telescope.nvim' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
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
    { name = 'path' }
  })
})

vim.opt.clipboard:append("unnamedplus")

vim.keymap.set("v", "<C-c>", '"+y', { noremap = true, silent = true })
vim.keymap.set("n", "<C-c>", '"+y', { noremap = true, silent = true })
vim.keymap.set("i", "<C-c>", '"+y', { noremap = true, silent = true })

vim.keymap.set("n", "<C-v>", '"+p', { noremap = true, silent = true })
vim.keymap.set("i", "<C-v>", '<Esc>"+pa', { noremap = true, silent = true })
vim.keymap.set("n", "<C-e>", ':Explore<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", ':cd..<CR>', { noremap = true, silent = true })

vim.filetype.add({
  extension = {
    odin = "odin"
  }
})

vim.cmd('syntax on')

require('telescope').setup {
  defaults = {
    file_ignore_patterns = {
      "%.git/",        -- matches `.git/` anywhere
      "%.git/.*",      -- matches everything inside `.git/`
      "^.git/",        -- matches `.git/` at root
      "^./.git/",      -- matches `.git/` in current dir
    }
  }
}

local builtin = require('telescope.builtin')
local util = require('lspconfig.util')  -- for detecting project root

vim.keymap.set('n', 'ff', function()
  local root = util.root_pattern('.git')(vim.fn.expand('%:p'))
  builtin.find_files({ cwd = root or vim.loop.cwd() })
end, { desc = 'Telescope find files from project root' })

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local dir = vim.fn.expand("%:p:h")
    if vim.fn.isdirectory(dir) == 1 then
      vim.cmd("lcd " .. dir)
    end
  end
})

vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', {noremap = true})
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Show references' })

vim.opt.sessionoptions = {
  "buffers",     -- open buffers
  "curdir",      -- current directory
  "tabpages",    -- all tab pages
  "winsize",     -- window sizes
  "globals",     -- global variables
}

-- vim.keymap.set('n', '<Esc>', function()
  -- local root = util.root_pattern('.git')(vim.fn.expand('%:p'))
  -- local session_file = root .. '/.nvim-session.vim'
  -- vim.cmd('mksession! ' .. session_file)
  -- print('Session saved to ' .. session_file)
-- end, { noremap = true, silent = true, desc = 'Save session to project root' })

-- vim.keymap.set('n', '<F6>', function()
  -- local root = vim.fn.getcwd()
  -- local session_file = root .. '/.nvim-session.vim'
  -- if vim.fn.filereadable(session_file) == 1 then
    -- vim.cmd('source ' .. session_file)
    -- print('Session loaded from ' .. session_file)
  -- else
    -- print('No session file found at ' .. session_file)
  -- end
-- end, { noremap = true, silent = true, desc = 'Load session from project root' })