--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- set fonts for GUIs
-- vim.o.guifont = "JetBrainsMono NF:h14"
-- vim.o.guifont = "CaskaydiaCove NF:h12"

-- configure auto-session plugin
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "ayu-mirage"
vim.opt.relativenumber = true

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
-- lvim.builtin.dashboard.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings
-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end
-- you can overwrite the null_ls setup table (useful for setting the root_dir function)
-- lvim.lsp.null_ls.setup = {
--   root_dir = require("lspconfig").util.root_pattern("Makefile", ".git", "node_modules"),
-- }
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
lvim.format_on_save = true
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{
		command = "stylua",
		filetypes = { "lua" },
	},
	{
		command = "uncrustify",
		filetypes = { "java" },
	},
	{ command = "shfmt", filetypes = { "sh" } },
	-- { command = "yamlfmt", args = { "/dev/stdin" }, filetypes = { "yaml", "yml" } },
	{
		command = "prettier",
		filetypes = {
			"html",
			"json",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"yaml",
			"yml",
		},
	},
	-- {
	-- 	command = "eslint",
	-- 	args = { "--fix" },
	-- 	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	-- },
	-- {
	-- 	name = "standardjs",
	-- 	args = { "--fix" },
	-- filetypes = { "javascript", "javascriptreact" },
	-- , "typescript", "typescriptreact" },
	-- },
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{
		command = "shellcheck",
		args = { "--severity", "warning" },
		filetypes = { "sh" },
	},
	{
		command = "luacheck",
		filetypes = { "lua" },
	},
	{
		command = "yamllint",
		filetypes = { "yaml", "yml" },
	},
	{
		command = "eslint",
		filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	},
	{
		name = "semgrep",
		args = {
			"--config",
			"/home/stefan/workspace/semgrep-rules/java/lang/correctness/",
			"--config",
			"/home/stefan/workspace/semgrep-rules/java/lang/security/",
			"--config",
			"/home/stefan/workspace/semgrep-rules/java/log4j/security/",
		},
		filetypes = { "java" },
	},
})

local code_actions = require("lvim.lsp.null-ls.code_actions")
code_actions.setup({
	{
		name = "proselint",
	},
})

-- Additional Plugins
lvim.plugins = {
	{ "folke/tokyonight.nvim" },
	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
	},
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
	-- {
	-- 	"sindrets/diffview.nvim",
	-- 	event = "BufRead",
	-- },
	{
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	},
	{
		"vim-pandoc/vim-pandoc",
	},
	{
		"vim-pandoc/vim-pandoc-syntax",
	},
	{
		"dhruvasagar/vim-table-mode",
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
		"nvim-telescope/telescope-project.nvim",
		event = "BufWinEnter",
		setup = function()
			vim.cmd([[packadd telescope.nvim]])
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
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		module = "persistence",
		config = function()
			require("persistence").setup({
				dir = vim.fn.expand(vim.fn.stdpath("config") .. "/session/"),
				options = { "buffers", "curdir", "tabpages", "winsize" },
			})
		end,
	},
	{ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" },
}

vim.cmd([[if exists('g:neovide')
				let g:neovide_cursor_animation_length=0
				let g:neovide_cursor_trail_length=0
				let g:neovide_cursor_vfx_mode = ''

				" command -nargs=0 NeovideToggleFullscreen :let g:neovide_fullscreen = !g:neovide_fullscreen
				nnoremap <a-cr> :NeovideToggleFullscreen<cr>
			endif]])

-- Lua
local actions = require("diffview.config").actions
require("diffview").setup({
	diff_binaries = false, -- Show diffs for binaries
	enhanced_diff_hl = false, -- See |diffview-config-enhanced_diff_hl|
	use_icons = true, -- Requires nvim-web-devicons
	icons = { -- Only applies when use_icons is true.
		folder_closed = "",
		folder_open = "",
	},
	signs = {
		fold_closed = "",
		fold_open = "",
	},
	file_panel = {
		listing_style = "tree", -- One of 'list' or 'tree'
		tree_options = { -- Only applies when listing_style is 'tree'
			flatten_dirs = true, -- Flatten dirs that only contain one single dir
			folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
		},
		win_config = { -- See |diffview-config-win_config|
			position = "left",
			width = 35,
		},
	},
	file_history_panel = {
		log_options = {
			max_count = 256, -- Limit the number of commits
			follow = false, -- Follow renames (only for single file)
			all = false, -- Include all refs under 'refs/' including HEAD
			merges = false, -- List only merge commits
			no_merges = false, -- List no merge commits
			reverse = false, -- List commits in reverse order
		},
		win_config = { -- See |diffview-config-win_config|
			position = "bottom",
			height = 16,
		},
	},
	commit_log_panel = {
		win_config = {}, -- See |diffview-config-win_config|
	},
	default_args = { -- Default args prepended to the arg-list for the listed commands
		DiffviewOpen = {},
		DiffviewFileHistory = {},
	},
	hooks = {}, -- See |diffview-config-hooks|
	keymaps = {
		disable_defaults = false, -- Disable the default keymaps
		view = {
			-- The `view` bindings are active in the diff buffers, only when the current
			-- tabpage is a Diffview.
			["<tab>"] = actions.select_next_entry, -- Open the diff for the next file
			["<s-tab>"] = actions.select_prev_entry, -- Open the diff for the previous file
			["gf"] = actions.goto_file, -- Open the file in a new split in previous tabpage
			["<C-w><C-f>"] = actions.goto_file_split, -- Open the file in a new split
			["<C-w>gf"] = actions.goto_file_tab, -- Open the file in a new tabpage
			["<leader>e"] = actions.focus_files, -- Bring focus to the files panel
			["<leader>b"] = actions.toggle_files, -- Toggle the files panel.
		},
		file_panel = {
			["j"] = actions.next_entry, -- Bring the cursor to the next file entry
			["<down>"] = actions.next_entry,
			["k"] = actions.prev_entry, -- Bring the cursor to the previous file entry.
			["<up>"] = actions.prev_entry,
			["<cr>"] = actions.select_entry, -- Open the diff for the selected entry.
			["o"] = actions.select_entry,
			["<2-LeftMouse>"] = actions.select_entry,
			["-"] = actions.toggle_stage_entry, -- Stage / unstage the selected entry.
			["S"] = actions.stage_all, -- Stage all entries.
			["U"] = actions.unstage_all, -- Unstage all entries.
			["X"] = actions.restore_entry, -- Restore entry to the state on the left side.
			["R"] = actions.refresh_files, -- Update stats and entries in the file list.
			["L"] = actions.open_commit_log, -- Open the commit log panel.
			["<tab>"] = actions.select_next_entry,
			["<s-tab>"] = actions.select_prev_entry,
			["gf"] = actions.goto_file,
			["<C-w><C-f>"] = actions.goto_file_split,
			["<C-w>gf"] = actions.goto_file_tab,
			["i"] = actions.listing_style, -- Toggle between 'list' and 'tree' views
			["f"] = actions.toggle_flatten_dirs, -- Flatten empty subdirectories in tree listing style.
			["<leader>e"] = actions.focus_files,
			["<leader>b"] = actions.toggle_files,
		},
		file_history_panel = {
			["g!"] = actions.options, -- Open the option panel
			["<C-A-d>"] = actions.open_in_diffview, -- Open the entry under the cursor in a diffview
			["y"] = actions.copy_hash, -- Copy the commit hash of the entry under the cursor
			["L"] = actions.open_commit_log,
			["zR"] = actions.open_all_folds,
			["zM"] = actions.close_all_folds,
			["j"] = actions.next_entry,
			["<down>"] = actions.next_entry,
			["k"] = actions.prev_entry,
			["<up>"] = actions.prev_entry,
			["<cr>"] = actions.select_entry,
			["o"] = actions.select_entry,
			["<2-LeftMouse>"] = actions.select_entry,
			["<tab>"] = actions.select_next_entry,
			["<s-tab>"] = actions.select_prev_entry,
			["gf"] = actions.goto_file,
			["<C-w><C-f>"] = actions.goto_file_split,
			["<C-w>gf"] = actions.goto_file_tab,
			["<leader>e"] = actions.focus_files,
			["<leader>b"] = actions.toggle_files,
		},
		option_panel = {
			["<tab>"] = actions.select_entry,
			["q"] = actions.close,
		},
	},
})

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }

vim.cmd("source ~/.vimrc")
