return {
 {
	 'echasnovski/mini.nvim',
	 enable = true,
	 config = function()
		 local statusline = require('mini.statusline')
		 statusline.setup({ use_icons = true})
	 end
 }
}
