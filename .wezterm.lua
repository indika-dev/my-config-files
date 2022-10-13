local wezterm = require("wezterm")

local launch_menu = {}
local default_prog
local set_environment_variables = {}

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	table.insert(launch_menu, {
		label = "PowerShell",
		args = { "powershell.exe", "-NoLogo" },
	})
	table.insert(launch_menu, {
		label = "PowerShell(Admin)",
		args = { "C:/ProgramData/chocolatey/lib/gsudo/bin/gsudo.exe", "powershell.exe" },
	})

	-- Use OSC 7 as per the above example
	set_environment_variables["prompt"] = "$E]7;file://localhost/$P$E\\$E[32m$T$E[0m $E[35m$P$E[36m$_$G$E[0m "
	-- use a more ls-like output format for dir
	set_environment_variables["DIRCMD"] = "/d"
	-- And inject clink into the command prompt
	table.insert(launch_menu, {
		label = "Clink Dosshell",
		args = {
			"cmd.exe",
			"/s",
			"/k",
			"C:/Lokales/clink/1.3.0.f070e4/clink_x64.exe",
			"inject",
			"-q",
		},
	})

	-- Enumerate any WSL distributions that are installed and add those to the menu
	local success, wsl_list, wsl_err = wezterm.run_child_process({ "wsl.exe", "-l" })
	-- `wsl.exe -l` has a bug where it always outputs utf16:
	-- https://github.com/microsoft/WSL/issues/4607
	-- So we get to convert it
	wsl_list = wezterm.utf16_to_utf8(wsl_list)

	for idx, line in ipairs(wezterm.split_by_newlines(wsl_list)) do
		-- Skip the first line of output; it's just a header
		if idx > 1 then
			-- Remove the "(Default)" marker from the default line to arrive
			-- at the distribution name on its own
			local distro = line:gsub(" %(Standard%)", "")

			-- Add an entry that will spawn into the distro with the default shell
			table.insert(launch_menu, {
				label = distro .. " (WSL default shell)",
				args = { "wsl.exe", "--distribution", distro },
			})

			-- Here's how to jump directly into some other program; in this example
			-- its a shell that probably isn't the default, but it could also be
			-- any other program that you want to run in that environment
			-- table.insert(launch_menu, {
			--   label = distro .. " (WSL zsh login shell)",
			--   args = {"wsl.exe", "--distribution", distro, "--exec", "/bin/zsh", "-l"},
			-- })
		end
	end
end

return {
	add_wsl_distributions_to_launch_menu = true,
	font = wezterm.font("FiraCode NF", {weight=450}),
    font_size = 12,
	color_scheme = "Ayu Mirage",
	-- color_scheme = "Gruvbox (Gogh)",
	-- color_scheme = "ayu_light",
	default_prog = { "wsl", "--cd", "~" },
	hide_tab_bar_if_only_one_tab = true,
	launch_menu = launch_menu,
	tls_clients = {
		{
			name = "wsl",
			connect_automatically = false,
			remote_address = "localhost:5000",
		},
	},
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
	-- unix_domains = {
	-- 	{
	-- 		name = "local",
	-- 		-- Override the default path to match the default on the host win32
	-- 		-- filesystem.  This will allow the host to connect into the WSL
	-- 		-- container.
	-- 		socket_path = "C:/Users/maassens/.local/share/wezterm/sock",
	-- 		-- NTFS permissions will always be "wrong", so skip that check
	-- 		skip_permissions_check = true,
	-- 		connect_automatically = true,
	-- 	},
	-- },
	-- timeout_milliseconds defaults to 1000 and can be omitted
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
			action = wezterm.action({ SplitVertical = { args = { "wsl", "--cd", "~" } } }),
		},
		{ key = "n", mods = "LEADER", action = "ShowTabNavigator" },
		{ key = "l", mods = "LEADER", action = "ShowLauncher" },
		{ key = "z", mods = "LEADER", action = "TogglePaneZoomState" },
		{ key = "c", mods = "LEADER", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
		{ key = "h", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
		{ key = "j", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
		{ key = "k", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
		{ key = "l", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
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
		{ key = "&", mods = "LEADER|SHIFT", action = wezterm.action({ CloseCurrentTab = { confirm = true } }) },
		{ key = "x", mods = "LEADER", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
		{ key = "n", mods = "SHIFT|CTRL", action = "ToggleFullScreen" },
	},
}
