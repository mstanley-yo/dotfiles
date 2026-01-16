local wezterm = require("wezterm")

local config = {}

-- Start full-screen
if wezterm.config_builder then
	config = wezterm.config_builder()
end
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
	window:gui_window():toggle_fullscreen()
end)
config.enable_tab_bar = false

-- No padding
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Font
config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.font_size = 17.0

-- Colors (TokyoNight Moon–style)
config.colors = {
	background = "#222436",
	foreground = "#dbdbdb",

	cursor_bg = "#fefffe",
	cursor_fg = "#000000",
	cursor_border = "#fefffe",
}

-- Disable bells
config.audible_bell = "Disabled"
config.visual_bell = {
	fade_in_duration_ms = 0,
	fade_out_duration_ms = 0,
}

return config
