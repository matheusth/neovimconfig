return {
	-- init.lua:
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		-- or                              , branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim', { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' } },
		config = function()
			require('telescope').setup({
				extensions = {
					fzf = {}
				}
			})
			require('telescope').load_extension('fzf')
			vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags)
			vim.keymap.set('n', '<leader>fd', require('telescope.builtin').find_files)
			vim.keymap.set('n', '<leader>en', function()
				require('telescope.builtin').find_files {
					cwd = vim.fn.stdpath("config")
				}
			end)
			vim.keymap.set('n', '<leader>ep', function()
				require('telescope.builtin').find_files {
					cwd = vim.fs.joinpath(vim.fn.stdpath("data"), lazy)
				}
			end)
			require "matheus.telescope.multigrep".setup()
		end
	}
}
