local wezterm = require("wezterm")

-- local default_prog

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)

function layout_startup()
  local win, tab, pane1 = SpawnWindow(0, 0, 0, 0, true) -- new window at x,y=(0,0) r,c=(0,0) and true is "maximized"
  local pane2 = pane:SplitHorizontal( .6, .4 ) -- split, pane1 60% wide, pane2 40% wide
  local pane3 = pane2:SplitVertical(.5, .5) -- split, pane2 50% high and pane3 50% high
  local tab2 = win:SpawnTab()
  -- more splits, etc.
  local win, tab, pane1 = SpawnWindow(0, 0, r, 0, false) -- new window at x,y=(50,100) h,w=(24,80) and not "maximized"
  -- more split, tab, windows
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local pane_title = tab.active_pane.title
	local user_title = tab.active_pane.user_vars.panetitle

	if user_title ~= nil and #user_title > 0 then
		pane_title = user_title
	end

	return {
		{ Background = { Color = "blue" } },
		{ Foreground = { Color = "white" } },
		{ Text = " " .. pane_title .. " " },
	}
end)

return {
	color_scheme = "Ayu Mirage",
	default_prog = { "/usr/bin/bash" },
	hide_tab_bar_if_only_one_tab = true,
	font = wezterm.font("JetBrainsMono Nerd Font"),
	-- font = wezterm.font("CaskaydiaCove Nerd Font Mono"),
	-- font = wezterm.font("FiraCode Nerd Font Mono", { size = 12 }),
	tab_bar_style = {
		active_tab_left = wezterm.format({
			{ Background = { Color = "#0b0022" } },
			{ Foreground = { Color = "#2b2042" } },
			{ Text = SOLID_LEFT_ARROW },
		}),
		active_tab_right = wezterm.format({
			{ Background = { Color = "#0b0022" } },
			{ Foreground = { Color = "#2b2042" } },
			{ Text = SOLID_RIGHT_ARROW },
		}),
		inactive_tab_left = wezterm.format({
			{ Background = { Color = "#0b0022" } },
			{ Foreground = { Color = "#1b1032" } },
			{ Text = SOLID_LEFT_ARROW },
		}),
		inactive_tab_right = wezterm.format({
			{ Background = { Color = "#0b0022" } },
			{ Foreground = { Color = "#1b1032" } },
			{ Text = SOLID_RIGHT_ARROW },
		}),
	},
	leader = { key = "#", mods = "CTRL|ALT", timeout_milliseconds = 1000 },
	keys = {
		-- This will create a new split and run your default program inside it
		{
			key = "|",
			mods = "LEADER",
			action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
		},
		{
			key = "-",
			mods = "LEADER",
			action = wezterm.action({ SplitVertical = { args = { "/usr/bin/bash" } } }),
		},
		{ key = "n", mods = "LEADER", action = "ShowTabNavigator" },
		{ key = "l", mods = "LEADER", action = "ShowLauncher" },
		{ key = "z", mods = "LEADER", action = "TogglePaneZoomState" },
		{ key = "t", mods = "LEADER", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
		{ key = "h", mods = "LEADER|CTRL", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
		{ key = "j", mods = "LEADER|CTRL", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
		{ key = "k", mods = "LEADER|CTRL", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
		{ key = "l", mods = "LEADER|CTRL", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
		{ key = "H", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Left", 5 } }) },
		{ key = "J", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Down", 5 } }) },
		{ key = "K", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Up", 5 } }) },
		{ key = "L", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Right", 5 } }) },
		{ key = "1", mods = "LEADER", action = wezterm.action({ ActivateTab = 0 }) },
		{ key = "2", mods = "LEADER", action = wezterm.action({ ActivateTab = 1 }) },
		{ key = "3", mods = "LEADER", action = wezterm.action({ ActivateTab = 2 }) },
		{ key = "4", mods = "LEADER", action = wezterm.action({ ActivateTab = 3 }) },
		{ key = "5", mods = "LEADER", action = wezterm.action({ ActivateTab = 4 }) },
		{ key = "6", mods = "LEADER", action = wezterm.action({ ActivateTab = 5 }) },
		{ key = "7", mods = "LEADER", action = wezterm.action({ ActivateTab = 6 }) },
		{ key = "8", mods = "LEADER", action = wezterm.action({ ActivateTab = 7 }) },
		{ key = "9", mods = "LEADER", action = wezterm.action({ ActivateTab = 8 }) },
		{ key = "q", mods = "LEADER", action = wezterm.action({ CloseCurrentTab = { confirm = true } }) },
		{ key = "w", mods = "LEADER", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
		{ key = "F11", mods = "LEADER|SHIFT", action = "ToggleFullScreen" },
	},
}
