local M = {}
local wezterm = require("wezterm")
local act = wezterm.action
local utils = require("utils")

M.split_nav = function(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "META" or "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if utils.is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { M.smart_split_direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = M.smart_split_direction_keys[key] }, pane)
				end
			end
		end),
	}
end

---------------------------------------------------------------
--- keybinds
---------------------------------------------------------------
M.tmux_keybinds = {
	{ key = "k", mods = "ALT", action = act({ SpawnTab = "CurrentPaneDomain" }) },
	{ key = "j", mods = "ALT", action = act({ CloseCurrentTab = { confirm = true } }) },
	{ key = "h", mods = "ALT", action = act({ ActivateTabRelative = -1 }) },
	{ key = "l", mods = "ALT", action = act({ ActivateTabRelative = 1 }) },
	{ key = "h", mods = "ALT|CTRL", action = act({ MoveTabRelative = -1 }) },
	{ key = "l", mods = "ALT|CTRL", action = act({ MoveTabRelative = 1 }) },
	--{ key = "k", mods = "ALT|CTRL", action = act.ActivateCopyMode },
	{
		key = "k",
		mods = "ALT|CTRL",
		action = act.Multiple({ act.CopyMode("ClearSelectionMode"), act.ActivateCopyMode, act.ClearSelection }),
	},
	{ key = "j", mods = "ALT|CTRL", action = act({ PasteFrom = "PrimarySelection" }) },
	{ key = "1", mods = "ALT", action = act({ ActivateTab = 0 }) },
	{ key = "2", mods = "ALT", action = act({ ActivateTab = 1 }) },
	{ key = "3", mods = "ALT", action = act({ ActivateTab = 2 }) },
	{ key = "4", mods = "ALT", action = act({ ActivateTab = 3 }) },
	{ key = "5", mods = "ALT", action = act({ ActivateTab = 4 }) },
	{ key = "6", mods = "ALT", action = act({ ActivateTab = 5 }) },
	{ key = "7", mods = "ALT", action = act({ ActivateTab = 6 }) },
	{ key = "8", mods = "ALT", action = act({ ActivateTab = 7 }) },
	{ key = "9", mods = "ALT", action = act({ ActivateTab = 8 }) },
	{ key = "-", mods = "ALT", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	{ key = "\\", mods = "ALT", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	{ key = "h", mods = "ALT|SHIFT", action = act({ ActivatePaneDirection = "Left" }) },
	{ key = "l", mods = "ALT|SHIFT", action = act({ ActivatePaneDirection = "Right" }) },
	{ key = "k", mods = "ALT|SHIFT", action = act({ ActivatePaneDirection = "Up" }) },
	{ key = "j", mods = "ALT|SHIFT", action = act({ ActivatePaneDirection = "Down" }) },
	{ key = "h", mods = "ALT|SHIFT|CTRL", action = act({ AdjustPaneSize = { "Left", 1 } }) },
	{ key = "l", mods = "ALT|SHIFT|CTRL", action = act({ AdjustPaneSize = { "Right", 1 } }) },
	{ key = "k", mods = "ALT|SHIFT|CTRL", action = act({ AdjustPaneSize = { "Up", 1 } }) },
	{ key = "j", mods = "ALT|SHIFT|CTRL", action = act({ AdjustPaneSize = { "Down", 1 } }) },
	{ key = "Enter", mods = "ALT", action = "QuickSelect" },
	{ key = "/", mods = "ALT", action = act.Search("CurrentSelectionOrEmptyString") },
}

M.default_keybinds = {
	{ key = "c", mods = "CTRL|SHIFT", action = act({ CopyTo = "Clipboard" }) },
	{ key = "v", mods = "CTRL|SHIFT", action = act({ PasteFrom = "Clipboard" }) },
	{ key = "Insert", mods = "SHIFT", action = act({ PasteFrom = "PrimarySelection" }) },
	{ key = "=", mods = "CTRL", action = "ResetFontSize" },
	{ key = "+", mods = "CTRL", action = "IncreaseFontSize" },
	{ key = "-", mods = "CTRL", action = "DecreaseFontSize" },
	{ key = "PageUp", mods = "ALT", action = act({ ScrollByPage = -1 }) },
	{ key = "PageDown", mods = "ALT", action = act({ ScrollByPage = 1 }) },
	{ key = "z", mods = "ALT", action = "ReloadConfiguration" },
	{ key = "z", mods = "ALT|SHIFT", action = act({ EmitEvent = "toggle-tmux-keybinds" }) },
	{ key = "e", mods = "ALT", action = act({ EmitEvent = "trigger-nvim-with-scrollback" }) },
	{ key = "q", mods = "ALT", action = act({ CloseCurrentPane = { confirm = true } }) },
	{ key = "x", mods = "ALT", action = act({ CloseCurrentPane = { confirm = true } }) },
	{ key = "a", mods = "ALT", action = wezterm.action.ShowLauncher },
	{ key = " ", mods = "ALT", action = wezterm.action.ShowTabNavigator },
	{
		key = "r",
		mods = "ALT",
		action = act({
			ActivateKeyTable = {
				name = "resize_pane",
				one_shot = false,
				timeout_milliseconds = 3000,
				replace_current = false,
			},
		}),
	},
	{ key = "s", mods = "ALT", action = act.PaneSelect({
		alphabet = "1234567890",
	}) },
	{
		key = "b",
		mods = "ALT",
		action = act.RotatePanes("CounterClockwise"),
	},
	{ key = "f", mods = "ALT", action = act.RotatePanes("Clockwise") },
	{
		key = "h",
		mods = "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if utils.is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = "h", mods = "CTRL" },
				}, pane)
			else
				win:perform_action({ ActivatePaneDirection = "Left" }, pane)
			end
		end),
	},
	{
		key = "l",
		mods = "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if utils.is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = "l", mods = "CTRL" },
				}, pane)
			else
				win:perform_action({ ActivatePaneDirection = "Right" }, pane)
			end
		end),
	},
	{
		key = "k",
		mods = "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if utils.is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = "k", mods = "CTRL" },
				}, pane)
			else
				win:perform_action({ ActivatePaneDirection = "Up" }, pane)
			end
		end),
	},
	{
		key = "j",
		mods = "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if utils.is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = "j", mods = "CTRL" },
				}, pane)
			else
				win:perform_action({ AdjustPaneSize = { "Down", 1 } }, pane)
			end
		end),
	},
}

function M.create_keybinds()
	return utils.merge_lists(M.default_keybinds, M.tmux_keybinds)
end

M.key_tables = {
	resize_pane = {
		{
			key = "LeftArrow",
			action = wezterm.action_callback(function(win, pane)
				if utils.is_vim(pane) then
					-- pass the keys through to vim/nvim
					win:perform_action({
						SendKey = { key = "h", mods = "ALT" },
					}, pane)
				else
					win:perform_action({ AdjustPaneSize = { "Left", 1 } }, pane)
				end
			end),
		},
		{
			key = "h",
			action = wezterm.action_callback(function(win, pane)
				if utils.is_vim(pane) then
					-- pass the keys through to vim/nvim
					win:perform_action({
						SendKey = { key = "h", mods = "ALT" },
					}, pane)
				else
					win:perform_action({ AdjustPaneSize = { "Left", 1 } }, pane)
				end
			end),
		},
		{
			key = "RightArrow",
			action = wezterm.action_callback(function(win, pane)
				if utils.is_vim(pane) then
					-- pass the keys through to vim/nvim
					win:perform_action({
						SendKey = { key = "l", mods = "ALT" },
					}, pane)
				else
					win:perform_action({ AdjustPaneSize = { "Right", 1 } }, pane)
				end
			end),
		},
		{
			key = "l",
			action = wezterm.action_callback(function(win, pane)
				if utils.is_vim(pane) then
					-- pass the keys through to vim/nvim
					win:perform_action({
						SendKey = { key = "l", mods = "ALT" },
					}, pane)
				else
					win:perform_action({ AdjustPaneSize = { "Right", 1 } }, pane)
				end
			end),
		},
		{
			key = "UpArrow",
			action = wezterm.action_callback(function(win, pane)
				if utils.is_vim(pane) then
					-- pass the keys through to vim/nvim
					win:perform_action({
						SendKey = { key = "k", mods = "ALT" },
					}, pane)
				else
					win:perform_action({ AdjustPaneSize = { "Up", 1 } }, pane)
				end
			end),
		},
		{
			key = "k",
			action = wezterm.action_callback(function(win, pane)
				if utils.is_vim(pane) then
					-- pass the keys through to vim/nvim
					win:perform_action({
						SendKey = { key = "k", mods = "ALT" },
					}, pane)
				else
					win:perform_action({ AdjustPaneSize = { "Up", 1 } }, pane)
				end
			end),
		},
		{
			key = "DownArrow",
			action = wezterm.action_callback(function(win, pane)
				if utils.is_vim(pane) then
					-- pass the keys through to vim/nvim
					win:perform_action({
						SendKey = { key = "j", mods = "ALT" },
					}, pane)
				else
					win:perform_action({ AdjustPaneSize = { "Down", 1 } }, pane)
				end
			end),
		},
		{
			key = "j",
			action = wezterm.action_callback(function(win, pane)
				if utils.is_vim(pane) then
					-- pass the keys through to vim/nvim
					win:perform_action({
						SendKey = { key = "j", mods = "ALT" },
					}, pane)
				else
					win:perform_action({ AdjustPaneSize = { "Down", 1 } }, pane)
				end
			end),
		},
		-- Cancel the mode by pressing escape
		{ key = "Escape", action = "PopKeyTable" },
	},
	copy_mode = {
		{
			key = "Escape",
			mods = "NONE",
			action = act.Multiple({
				act.ClearSelection,
				act.CopyMode("ClearPattern"),
				act.CopyMode("Close"),
			}),
		},
		{ key = "q", mods = "NONE", action = act.CopyMode("Close") },
		-- move cursor
		{ key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
		{ key = "LeftArrow", mods = "NONE", action = act.CopyMode("MoveLeft") },
		{ key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
		{ key = "DownArrow", mods = "NONE", action = act.CopyMode("MoveDown") },
		{ key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
		{ key = "UpArrow", mods = "NONE", action = act.CopyMode("MoveUp") },
		{ key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },
		{ key = "RightArrow", mods = "NONE", action = act.CopyMode("MoveRight") },
		-- move word
		{ key = "RightArrow", mods = "ALT", action = act.CopyMode("MoveForwardWord") },
		{ key = "f", mods = "ALT", action = act.CopyMode("MoveForwardWord") },
		{ key = "\t", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
		{ key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
		{ key = "LeftArrow", mods = "ALT", action = act.CopyMode("MoveBackwardWord") },
		{ key = "b", mods = "ALT", action = act.CopyMode("MoveBackwardWord") },
		{ key = "\t", mods = "SHIFT", action = act.CopyMode("MoveBackwardWord") },
		{ key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },
		{
			key = "e",
			mods = "NONE",
			action = act({
				Multiple = {
					act.CopyMode("MoveRight"),
					act.CopyMode("MoveForwardWord"),
					act.CopyMode("MoveLeft"),
				},
			}),
		},
		-- move start/end
		{ key = "0", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
		{ key = "\n", mods = "NONE", action = act.CopyMode("MoveToStartOfNextLine") },
		{ key = "$", mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },
		{ key = "$", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
		{ key = "e", mods = "CTRL", action = act.CopyMode("MoveToEndOfLineContent") },
		{ key = "m", mods = "ALT", action = act.CopyMode("MoveToStartOfLineContent") },
		{ key = "^", mods = "SHIFT", action = act.CopyMode("MoveToStartOfLineContent") },
		{ key = "^", mods = "NONE", action = act.CopyMode("MoveToStartOfLineContent") },
		{ key = "a", mods = "CTRL", action = act.CopyMode("MoveToStartOfLineContent") },
		-- select
		{ key = " ", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
		{ key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
		{
			key = "v",
			mods = "SHIFT",
			action = act({
				Multiple = {
					act.CopyMode("MoveToStartOfLineContent"),
					act.CopyMode({ SetSelectionMode = "Cell" }),
					act.CopyMode("MoveToEndOfLineContent"),
				},
			}),
		},
		-- copy
		{
			key = "y",
			mods = "NONE",
			action = act({
				Multiple = {
					act({ CopyTo = "ClipboardAndPrimarySelection" }),
					act.CopyMode("Close"),
				},
			}),
		},
		{
			key = "y",
			mods = "SHIFT",
			action = act({
				Multiple = {
					act.CopyMode({ SetSelectionMode = "Cell" }),
					act.CopyMode("MoveToEndOfLineContent"),
					act({ CopyTo = "ClipboardAndPrimarySelection" }),
					act.CopyMode("Close"),
				},
			}),
		},
		-- scroll
		{ key = "G", mods = "SHIFT", action = act.CopyMode("MoveToScrollbackBottom") },
		{ key = "G", mods = "NONE", action = act.CopyMode("MoveToScrollbackBottom") },
		{ key = "g", mods = "NONE", action = act.CopyMode("MoveToScrollbackTop") },
		{ key = "H", mods = "NONE", action = act.CopyMode("MoveToViewportTop") },
		{ key = "H", mods = "SHIFT", action = act.CopyMode("MoveToViewportTop") },
		{ key = "M", mods = "NONE", action = act.CopyMode("MoveToViewportMiddle") },
		{ key = "M", mods = "SHIFT", action = act.CopyMode("MoveToViewportMiddle") },
		{ key = "L", mods = "NONE", action = act.CopyMode("MoveToViewportBottom") },
		{ key = "L", mods = "SHIFT", action = act.CopyMode("MoveToViewportBottom") },
		{ key = "o", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEnd") },
		{ key = "O", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
		{ key = "O", mods = "SHIFT", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
		{ key = "PageUp", mods = "NONE", action = act.CopyMode("PageUp") },
		{ key = "PageDown", mods = "NONE", action = act.CopyMode("PageDown") },
		{ key = "b", mods = "CTRL", action = act.CopyMode("PageUp") },
		{ key = "f", mods = "CTRL", action = act.CopyMode("PageDown") },
		{
			key = "Enter",
			mods = "NONE",
			action = act.CopyMode("ClearSelectionMode"),
		},
		-- search
		{ key = "/", mods = "NONE", action = act.Search("CurrentSelectionOrEmptyString") },
		{
			key = "n",
			mods = "NONE",
			action = act.Multiple({
				act.CopyMode("NextMatch"),
				act.CopyMode("ClearSelectionMode"),
			}),
		},
		{
			key = "N",
			mods = "SHIFT",
			action = act.Multiple({
				act.CopyMode("PriorMatch"),
				act.CopyMode("ClearSelectionMode"),
			}),
		},
	},
	search_mode = {
		{ key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
		{
			key = "Enter",
			mods = "NONE",
			action = act.Multiple({
				act.CopyMode("ClearSelectionMode"),
				act.ActivateCopyMode,
			}),
		},
		{ key = "p", mods = "CTRL", action = act.CopyMode("PriorMatch") },
		{ key = "n", mods = "CTRL", action = act.CopyMode("NextMatch") },
		{ key = "r", mods = "CTRL", action = act.CopyMode("CycleMatchType") },
		{ key = "/", mods = "NONE", action = act.CopyMode("ClearPattern") },
		{ key = "u", mods = "CTRL", action = act.CopyMode("ClearPattern") },
	},
}

M.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = act({ CompleteSelection = "PrimarySelection" }),
	},
	{
		event = { Up = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = act({ CompleteSelection = "Clipboard" }),
	},
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = "OpenLinkAtMouseCursor",
	},
}

M.smart_split_direction_keys = {
	Left = "h",
	Down = "j",
	Up = "k",
	Right = "l",
	-- reverse lookup
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

return M
