return {
	'neovim/nvim-lspconfig',
	config = function()
		local lspconfig = require('lspconfig')
		local capabilities = require('blink.cmp').get_lsp_capabilities()

		lspconfig.ts_ls.setup {
			capabilities = capabilities
		}
		lspconfig.jedi_language_server.setup {
			capabilities = capabilities
		}
		lspconfig.clangd.setup {
			capabilities = capabilities
		}
		lspconfig.html.setup {
			capabilities = capabilities,
		}
		lspconfig.css_ls.setup {
			capabilities = capabilities,
		}
		lspconfig.lua_ls.setup {
			on_init = function(client)
				if client.workspace_folders then
					local path = client.workspace_folders[1].name
					if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
						return
					end
				end

				client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
					runtime = {
						-- Tell the language server which version of Lua you're using
						-- (most likely LuaJIT in the case of Neovim)
						version = 'LuaJIT'
					},
					-- Make the server aware of Neovim runtime files
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
							"${3rd}/luv/library",
							"${3rd}/busted/library",
						}
					}
				})
			end,
			settings = {
				Lua = {}
			},
			capabilites = capabilities,
		}

		vim.api.nvim_create_autocmd('LspAttach', {
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if not client then return end

				if client:supports_method('textDocument/formatting') then
					-- Format the current buffer on save
					vim.api.nvim_create_autocmd('BufWritePre', {
						buffer = args.buf,
						callback = function()
							vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
						end,
					})
				end
			end,
		})
	end
}
