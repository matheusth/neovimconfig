require('matheus.lazy')
require('matheus.opts')


vim.keymap.set('n', '<space><space>x', '<cmd>source %<CR>')
vim.keymap.set('n', '<space>x', ':.lua<CR>')
vim.keymap.set('n', '<M-j>', '<cmd>cnext<CR>')
vim.keymap.set('n', '<M-k>', '<cmd>cprev<CR>')
vim.keymap.set('n', '<leader>k', '<cmd>bp<CR>')
vim.keymap.set('n', '<leader>j', '<cmd>bn<CR>')

vim.keymap.set('v', '<space>x', ':lua<CR>')


vim.api.nvim_create_autocmd('TextYankPost', {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end
})

vim.api.nvim_create_autocmd('TermOpen', {
	desc = "Terminal Open",
	group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
	callback = function()
		vim.opt.number = false
		vim.opt.relativenumber = false
	end,
})

vim.keymap.set('n', '<space>st', function()
	vim.cmd.vnew()
	vim.cmd.term()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 15)
end)
