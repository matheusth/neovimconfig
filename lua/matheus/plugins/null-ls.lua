return {
	'nvimtools/none-ls.nvim',
	config = function()
		local null_ls = require('null-ls')
		null_ls.setup({
			autostart = true,
			sources = {
				null_ls.builtins.formatting.djlint,
			},
		})
	end
}
