--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
-- vim.o.guifont = "JetBrainsMono NF:h14"
vim.o.guifont = "CaskaydiaCove NF:h12"
vim.o.fileformats = "unix,dos,mac"

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
-- lvim.builtin.telescope.extensions.fzf.override_file_sorter = false
-- lvim.builtin.telescope.extensions.fzf.override_generic_sorter = false

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

local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{
		exe = "stylua",
		filetypes = { "lua" },
	},
	{
		exe = "prettier",
		args = { "--print-with", "100" },
		filetypes = { "html", "json", "yaml" },
	},
	{
		exe = "eslint",
		filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	},
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{
		exe = "luacheck",
		filetypes = { "lua" },
	},
	{
		exe = "eslint",
		filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
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
	-- {
	-- 	"wfxr/minimap.vim",
	-- 	run = "cargo install --locked code-minimap",
	-- 	-- cmd = {"Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight"},
	-- 	config = function()
	-- 		vim.cmd("let g:minimap_width = 10")
	-- 		vim.cmd("let g:minimap_auto_start = 0")
	-- 		vim.cmd("let g:minimap_auto_start_win_enter = 0")
	-- 	end,
	-- },
	{
		"sindrets/diffview.nvim",
		event = "BufRead",
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
}

vim.cmd([[if exists('g:neovide')
            let g:neovide_cursor_animation_length=0
            let g:neovide_cursor_trail_length=0
            let g:neovide_cursor_vfx_mode = ''

            " command -nargs=0 NeovideToggleFullscreen :let g:neovide_fullscreen = !g:neovide_fullscreen
            nnoremap <a-cr> :NeovideToggleFullscreen<cr>

            " will work in neovim >= 0.6
            " for s:char in split('¶¡@£$€¥[]\±þ←đŋ©®ł¸~æœ€↓→ðħŧłß̣̣̣´|·@©ĸ»”µł“«^', '\zs')
            "  if s:char == '\'
            "      let s:expr = 'imap <M-C-Bslash> <Bslash>'
            "  elseif s:char == '|'
            "      let s:expr = 'imap <M-Bar> <Bar>'
            "  else
            "     let s:expr = printf('imap <M-C-%s> %s', s:char, s:char)
            "  endif
            "  exec s:expr
            " endfor
          endif]])

vim.cmd("set mouse=a")
vim.cmd("set winaltkeys=yes")
vim.cmd("command! WriteUnix w ++ff=unix") -- Dos-Datei in Unix speichern
vim.cmd("command! WriteDos w ++ff=dos") -- Unix-Datei in Dos speichern

-- vim.cmd("source $VIMRUNTIME/mswin.vim")
-- Lua
-- local cb = require("diffview.config").diffview_callback

-- require("diffview").setup({
-- 	diff_binaries = false, -- Show diffs for binaries
-- 	enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
-- 	use_icons = true, -- Requires nvim-web-devicons
-- 	icons = { -- Only applies when use_icons is true.
-- 		folder_closed = "",
-- 		folder_open = "",
-- 	},
-- 	signs = {
-- 		fold_closed = "",
-- 		fold_open = "",
-- 	},
-- 	file_panel = {
-- 		position = "left", -- One of 'left', 'right', 'top', 'bottom'
-- 		width = 35, -- Only applies when position is 'left' or 'right'
-- 		height = 10, -- Only applies when position is 'top' or 'bottom'
-- 		listing_style = "tree", -- One of 'list' or 'tree'
-- 		tree_options = { -- Only applies when listing_style is 'tree'
-- 			flatten_dirs = true,
-- 			folder_statuses = "always", -- One of 'never', 'only_folded' or 'always'.
-- 		},
-- 	},
-- 	file_history_panel = {
-- 		position = "bottom",
-- 		width = 35,
-- 		height = 16,
-- 		log_options = {
-- 			max_count = 256, -- Limit the number of commits
-- 			follow = false, -- Follow renames (only for single file)
-- 			all = false, -- Include all refs under 'refs/' including HEAD
-- 			merges = false, -- List only merge commits
-- 			no_merges = false, -- List no merge commits
-- 			reverse = false, -- List commits in reverse order
-- 		},
-- 	},
-- 	key_bindings = {
-- 		disable_defaults = false, -- Disable the default key bindings
-- 		-- The `view` bindings are active in the diff buffers, only when the current
-- 		-- tabpage is a Diffview.
-- 		view = {
-- 			["<tab>"] = cb("select_next_entry"), -- Open the diff for the next file
-- 			["<s-tab>"] = cb("select_prev_entry"), -- Open the diff for the previous file
-- 			["gf"] = cb("goto_file"), -- Open the file in a new split in previous tabpage
-- 			["<C-w><C-f>"] = cb("goto_file_split"), -- Open the file in a new split
-- 			["<C-w>gf"] = cb("goto_file_tab"), -- Open the file in a new tabpage
-- 			["<leader>e"] = cb("focus_files"), -- Bring focus to the files panel
-- 			["<leader>b"] = cb("toggle_files"), -- Toggle the files panel.
-- 		},
-- 		file_panel = {
-- 			["j"] = cb("next_entry"), -- Bring the cursor to the next file entry
-- 			["<down>"] = cb("next_entry"),
-- 			["k"] = cb("prev_entry"), -- Bring the cursor to the previous file entry.
-- 			["<up>"] = cb("prev_entry"),
-- 			["<cr>"] = cb("select_entry"), -- Open the diff for the selected entry.
-- 			["o"] = cb("select_entry"),
-- 			["<2-LeftMouse>"] = cb("select_entry"),
-- 			["-"] = cb("toggle_stage_entry"), -- Stage / unstage the selected entry.
-- 			["S"] = cb("stage_all"), -- Stage all entries.
-- 			["U"] = cb("unstage_all"), -- Unstage all entries.
-- 			["X"] = cb("restore_entry"), -- Restore entry to the state on the left side.
-- 			["R"] = cb("refresh_files"), -- Update stats and entries in the file list.
-- 			["<tab>"] = cb("select_next_entry"),
-- 			["<s-tab>"] = cb("select_prev_entry"),
-- 			["gf"] = cb("goto_file"),
-- 			["<C-w><C-f>"] = cb("goto_file_split"),
-- 			["<C-w>gf"] = cb("goto_file_tab"),
-- 			["i"] = cb("listing_style"), -- Toggle between 'list' and 'tree' views
-- 			["f"] = cb("toggle_flatten_dirs"), -- Flatten empty subdirectories in tree listing style.
-- 			["<leader>e"] = cb("focus_files"),
-- 			["<leader>b"] = cb("toggle_files"),
-- 		},
-- 		file_history_panel = {
-- 			["g!"] = cb("options"), -- Open the option panel
-- 			["<C-A-d>"] = cb("open_in_diffview"), -- Open the entry under the cursor in a diffview
-- 			["y"] = cb("copy_hash"), -- Copy the commit hash of the entry under the cursor
-- 			["zR"] = cb("open_all_folds"),
-- 			["zM"] = cb("close_all_folds"),
-- 			["j"] = cb("next_entry"),
-- 			["<down>"] = cb("next_entry"),
-- 			["k"] = cb("prev_entry"),
-- 			["<up>"] = cb("prev_entry"),
-- 			["<cr>"] = cb("select_entry"),
-- 			["o"] = cb("select_entry"),
-- 			["<2-LeftMouse>"] = cb("select_entry"),
-- 			["<tab>"] = cb("select_next_entry"),
-- 			["<s-tab>"] = cb("select_prev_entry"),
-- 			["gf"] = cb("goto_file"),
-- 			["<C-w><C-f>"] = cb("goto_file_split"),
-- 			["<C-w>gf"] = cb("goto_file_tab"),
-- 			["<leader>e"] = cb("focus_files"),
-- 			["<leader>b"] = cb("toggle_files"),
-- 		},
-- 		option_panel = {
-- 			["<tab>"] = cb("select"),
-- 			["q"] = cb("close"),
-- 		},
-- 	},
-- })

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }

vim.cmd("source ~/.vimrc")
