vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>')

local state = {
	floating = {
		buf = -1,
		win = -1
	}
}

local function create_floating_window(opts)
	-- Get editor dimensions
	local editor_width = vim.o.columns
	local editor_height = vim.o.lines

	-- Default dimensions to 80% of the editor size if not provided
	width = opts.width or math.floor(editor_width * 0.8)
	height = opts.height or math.floor(editor_height * 0.8)

	-- Calculate the starting position to center the window
	local col = math.floor((editor_width - width) / 2)
	local row = math.floor((editor_height - height) / 2)

	-- Create a new buffer
	local buf = opts.buf or nil
	if vim.api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf
	else
		buf = vim.api.nvim_create_buf(false, true) -- nofile, listed=false
	end
	-- Define window options
	local win_opts = {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal",
		border = "rounded",
	}

	-- Create the floating window
	local win = vim.api.nvim_open_win(buf, true, win_opts)

	-- Optional: Set keymaps to close the window
	vim.api.nvim_buf_set_keymap(buf, "n", "q", "<Cmd>close<CR>", { noremap = true, silent = true })

	-- Return buffer and window handles
	return { buf = buf, win = win }
end

local toggle_terminal = function()
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		state.floating = create_floating_window { buf = state.floating.buf }
		if vim.bo[state.floating.buf].buftype ~= "terminal" then
			vim.cmd.terminal()
		end
	else
		vim.api.nvim_win_hide(state.floating.win)
	end
end

vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})
vim.keymap.set('n', '<space>tt', toggle_terminal)
vim.keymap.set('t', '<C-t>', toggle_terminal)
