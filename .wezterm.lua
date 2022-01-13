local wezterm = require("wezterm")

local launch_menu = {}
local default_prog
local set_environment_variables = {}

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
	add_wsl_distributions_to_launch_menu = false,
	font = wezterm.font("CaskaydiaCove NF"),
	color_scheme = "Ayu Mirage",
	default_prog = { "powershell.exe -NoLogo" },
	hide_tab_bar_if_only_one_tab = true,
	launch_menu = launch_menu,
	tls_clients = {
		{
			name = "wsl",
			connect_automatically = false,
			remote_address = "localhost:5000",
		},
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
			action = wezterm.action({ SplitVertical = { args = { "powershell.exe" } } }),
		},
		{ key = "n", mods = "LEADER", action = "ShowTabNavigator" },
		{ key = "l", mods = "LEADER", action = "ShowLauncher" },
	},
}
