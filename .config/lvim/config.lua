--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
vim.o.guifont = "JetBrainsMono Nerd Font:h12"
-- vim.o.guifont ="Delugia:h16"
-- vim.o.guifont ="DelugiaMono:h16"
-- vim.o.guifont ="GoMono NF:h16"
-- vim.o.guifont ="FiraCode NF:h16"
-- vim.o.guifont ="FuraCode NF:h16"
-- vim.o.guifont ="Hack Nerd Font:h16"
-- vim.o.guifont ="NotoSansMono Nerd Font:h16"
-- vim.o.guifont ="SaucecodePro Nerd Font:h16"
-- vim.o.guifont ="UbuntuMonoDerivativePowerline Nerd Font:h16"
-- vim.o.guifont = "CaskaydiaCove Nerd Font:h14"

vim.o.relativenumber = true
vim.o.cursorline = true

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "ayu-mirage"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = ""
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- lvim.builtin.telescope.on_config_done = function()
--   local actions = require "telescope.actions"
--   -- for input mode
--   lvim.builtin.telescope.defaults.mappings.i["<C-j>"] = actions.move_selection_next
--   lvim.builtin.telescope.defaults.mappings.i["<C-k>"] = actions.move_selection_previous
--   lvim.builtin.telescope.defaults.mappings.i["<C-n>"] = actions.cycle_history_next
--   lvim.builtin.telescope.defaults.mappings.i["<C-p>"] = actions.cycle_history_prev
--   -- for normal mode
--   lvim.builtin.telescope.defaults.mappings.n["<C-j>"] = actions.move_selection_next
--   lvim.builtin.telescope.defaults.mappings.n["<C-k>"] = actions.move_selection_previous
-- end

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.ensure_installed = {
	"bash",
	"c",
	"javascript",
	"json",
	"lua",
	"python",
	"typescript",
	"css",
	"rust",
	"java",
	"yaml",
}
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end
-- you can overwrite the null_ls setup table (useful for setting the root_dir function)
lvim.lsp.null_ls.setup = {
	root_dir = require("lspconfig").util.root_pattern("Makefile", ".git", "node_modules", "README.md"),
}
-- or if you need something more advanced
-- lvim.lsp.null_ls.setup.root_dir = function(fname)
--   if vim.bo.filetype == "javascript" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "node_modules")(fname)
--       or require("lspconfig/util").path.dirname(fname)
--   elseif vim.bo.filetype == "php" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "composer.json")(fname) or vim.fn.getcwd()
--   else
--     return require("lspconfig/util").root_pattern("Makefile", ".git")(fname) or require("lspconfig/util").path.dirname(fname)
--   end
-- end

-- set a formatter if you want to override the default lsp one (if it exists)
-- lvim.lang.python.formatters = {
--   {
--     exe = "black",
--   }
-- }
-- set an additional linter
-- lvim.lang.python.linters = {
--   {
--     exe = "flake8",
--   }
-- }
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{
		exe = "stylua",
		filetypes = { "lua" },
	},
	{ exe = "shfmt", filetypes = { "sh" } },
	{
		exe = "prettier",
		args = { "--print-with", "100" },
		filetypes = { "typescript", "typescriptreact", "html", "json", "yaml" },
	},
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{
		exe = "shellcheck",
		args = { "--severity", "warning" },
		filetypes = { "sh" },
	},
	{
		exe = "luacheck",
		filetypes = { "lua" },
	},
})

-- Additional Plugins
lvim.plugins = {
	{ "folke/tokyonight.nvim" },
	{ "folke/trouble.nvim", cmd = "TroubleToggle" },
	{
		"axvr/photon.vim",
		opt = true,
		config = function()
			vim.cmd("colorscheme photon")
			vim.cmd("colorscheme antiphoton")
		end,
	},
	{
		"sonph/onehalf",
		rtp = "vim/",
		opt = true,
		config = function()
			vim.cmd("colorscheme onehalfdark")
			vim.cmd("colorscheme onehalflight")
		end,
	},
	{
		"joshdick/onedark.vim",
		opt = true,
		config = function()
			vim.cmd("colorscheme onedark")
		end,
	},
	{
		"ChristianChiarulli/nvcode-color-schemes.vim",
		opt = true,
		config = function()
			vim.g.nvcode_termcolors = 256
			vim.cmd("colorscheme nvcode")
		end,
	},
	{
		"kaicataldo/material.vim",
		opt = true,
		config = function()
			vim.g.material_branch = "main"
			vim.g.material_theme_style = "default-community" -- deafualt,palenight, ocean, lighter, darker, default-community
			vim.cmd("colorscheme material")
		end,
	},
	{
		"altercation/vim-colors-solarized",
		opt = true,
		config = function()
			vim.o.background = "dark"
			vim.cmd("colorscheme solarized")
		end,
	},
	{
		"sainnhe/edge",
		opt = true,
		config = function()
			vim.g.edge_style = "aura" -- default, aura, neon, light
			vim.cmd("colorscheme edge")
		end,
	},
	{
		"Shatur/neovim-ayu",
	},
	{
		"vim-scripts/eclipse.vim",
		opt = true,
		config = function()
			vim.cmd("colorscheme eclipse")
		end,
	},
	-- {
	-- 	"akinsho/toggleterm.nvim",
	-- },
	{
		"wfxr/minimap.vim",
		run = "cargo install --locked code-minimap",
		-- cmd = {"Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight"},
		config = function()
			vim.cmd("let g:minimap_width = 10")
			vim.cmd("let g:minimap_auto_start = 0")
			vim.cmd("let g:minimap_auto_start_win_enter = 0")
		end,
	},
	{
		"sindrets/diffview.nvim",
		event = "BufRead",
	},
	{
		"kevinhwang91/nvim-bqf",
		event = { "BufRead", "BufNew" },
		config = function()
			require("bqf").setup({
				auto_enable = true,
				preview = {
					win_height = 12,
					win_vheight = 12,
					delay_syntax = 80,
					border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
				},
				func_map = {
					vsplit = "",
					ptogglemode = "z,",
					stoggleup = "",
				},
				filter = {
					fzf = {
						action_for = { ["ctrl-s"] = "split" },
						extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
					},
				},
			})
		end,
	},
	{
		"karb94/neoscroll.nvim",
		event = "WinScrolled",
		config = function()
			require("neoscroll").setup({
				-- All these keys will be mapped to their corresponding default scrolling animation
				mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
				hide_cursor = true, -- Hide cursor while scrolling
				stop_eof = true, -- Stop at <EOF> when scrolling downwards
				use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
				respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
				cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
				easing_function = nil, -- Default easing function
				pre_hook = nil, -- Function to run before the scrolling animation starts
				post_hook = nil, -- Function to run after the scrolling animation ends
			})
		end,
	},
	{
		"knubie/vim-kitty-navigator",
	},
}

vim.cmd([[if exists('g:neovide')
				let g:neovide_cursor_animation_length=0
				let g:neovide_cursor_trail_length=0
				let g:neovide_cursor_vfx_mode = ''

				" command -nargs=0 NeovideToggleFullscreen :let g:neovide_fullscreen = !g:neovide_fullscreen
				nnoremap <a-cr> :NeovideToggleFullscreen<cr>
			endif]])

-- require("toggleterm").setup({
-- 	-- size can be a number or function which is passed the current terminal
-- 	size = function(term)
-- 		if term.direction == "horizontal" then
-- 			return 15
-- 		elseif term.direction == "vertical" then
-- 			return vim.o.columns * 0.4
-- 		end
-- 	end,
-- 	open_mapping = [[<c-\>]],
-- 	hide_numbers = true, -- hide the number column in toggleterm buffers
-- 	shade_filetypes = {},
-- 	shade_terminals = true,
-- 	shading_factor = "1", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
-- 	start_in_insert = true,
-- 	insert_mappings = true, -- whether or not the open mapping applies in insert mode
-- 	persist_size = true,
-- 	direction = "horizontal", -- 'vertical' | 'horizontal' | 'window' | 'float',
-- 	close_on_exit = true, -- close the terminal window when the process exits
-- 	shell = vim.o.shell, -- change the default shell
-- 	-- This field is only relevant if direction is set to 'float'
-- 	float_opts = {
-- 		-- The border key is *almost* the same as 'nvim_open_win'
-- 		-- see :h nvim_open_win for details on borders however
-- 		-- the 'curved' border is a custom border type
-- 		-- not natively supported but implemented in this plugin.
-- 		border = "single", -- 'single' | 'double' | 'shadow' | 'curved', -- | ... other options supported by win open
-- 		width = 20,
-- 		height = 20,
-- 		winblend = 3,
-- 		highlights = {
-- 			border = "Normal",
-- 			background = "Normal",
-- 		},
-- 	},
-- })

-- local Terminal = require("toggleterm.terminal").Terminal
-- local lazygit = Terminal:new({
-- 	cmd = "lazygit",
-- 	hidden = true,
-- 	dir = "git_dir",
-- 	direction = "float",
-- 	size = 60,
-- 	width = 60,
-- 	height = 40,
-- 	float_opts = {
-- 		border = "double",
-- 	},
-- 	-- function to run on opening the terminal
-- 	on_open = function(term)
-- 		vim.cmd("startinsert!")
-- 		vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
-- 	end,
-- 	-- function to run on closing the terminal
-- 	on_close = function(term)
-- 		vim.cmd("Closing terminal")
-- 	end,
-- })

-- function _lazygit_toggle()
-- 	lazygit:toggle()
-- end

-- vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
	{ "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
}

-- set key mappings for kitty
lvim.kitty_navigator_no_mappings = 1
lvim.keys.normal_mode["<C-h>"] = ":KittyNavigateLeft<cr>"
lvim.keys.normal_mode["<C-j>"] = ":KittyNavigateDown<cr>"
lvim.keys.normal_mode["<C-k>"] = ":KittyNavigateUp<cr>"
lvim.keys.normal_mode["<C-l>"] = ":KittyNavigateRight<cr>"
-- vim.api.nvim_set_keymap("n", "<C-S-h>", "<cmd>KittyNavigateLeft<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<C-S-j>","<cmd>KittyNavigateDown<CR>" , { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<C-S-k>", "<cmd>KittyNavigateUp<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<C-S-l>", "<cmd>KittyNavigateRight<CR>", { noremap = true, silent = true })

-- This config here is for nvui
if vim.g.nvui then
-- Set gui font
  cmd [[set guifont=FiraCode\ Nerd\ Font:h9]]
  cmd [[NvuiCmdFontFamily FiraCode Nerd Font]]
  cmd [[NvuiCmdFontSize 9.0]]
  cmd [[NvuiScrollAnimationDuration 0.2]]
end

vim.cmd("source ~/.vimrc")
