-- Import the wezterm API
local wezterm = require("wezterm")

wezterm.on("user-var-changed", function(window, pane, name, value)
  local overrides = window:get_config_overrides() or {}
  if name == "ZEN_MODE" then
    local incremental = value:find("+")
    local number_value = tonumber(value)
    if incremental ~= nil then
      while number_value > 0 do
        window:perform_action(wezterm.action.IncreaseFontSize, pane)
        number_value = number_value - 1
      end
      overrides.enable_tab_bar = false
    elseif number_value < 0 then
      window:perform_action(wezterm.action.ResetFontSize, pane)
      overrides.font_size = nil
      overrides.enable_tab_bar = true
    else
      overrides.font_size = number_value
      overrides.enable_tab_bar = false
    end
  end
  window:set_config_overrides(overrides)
end)

local function isModuleAvailable(name)
  if package.loaded[name] then
    return true
  else
    for _, searcher in ipairs(package.searchers or package.loaders) do
      local loader = searcher(name)
      if type(loader) == "function" then
        package.preload[name] = loader
        return true
      end
    end
    return false
  end
end

-- Initialize an empty configuration table
local config = {}

--  Import background module
if isModuleAvailable("background") then
  local set_background = require("background")
  set_background(config)
end

config.color_scheme = "tokyonight_night"

config.window_padding = {
  top = 0,
  right = 0,
  left = 0,
  bottom = 0,
}
config.initial_cols = 140 --- 1.75*default
config.initial_rows = 42 --- 1.75*default

-- Set the terminal font
config.font = wezterm.font({
  family = "FiraCode Nerd Font",
  harfbuzz_features = { "zero", "onum", "ss03", "ss05", "ss07", "ss08", "ss09", "cv14", "cv18" },
})
-- Font Size
config.font_size = 10.0

-- Hide the tab bar if only one tab is open
config.hide_tab_bar_if_only_one_tab = true

-- Smooth hack
config.max_fps = 240

-- Enable Kitty Graphics
config.enable_kitty_graphics = true

-- Disable Scroll Bar
config.enable_scroll_bar = false

-- activate ONLY if windows --

-- config.default_domain = 'WSL:Ubuntu'
-- config.front_end = "OpenGL"
-- local gpus = wezterm.gui.enumerate_gpus()
-- if #gpus > 0 then
--   config.webgpu_preferred_adapter = gpus[1] -- only set if there's at least one GPU
-- else
--   -- fallback to default behavior or log a message
--   wezterm.log_info("No GPUs found, using default settings")
-- end

-- and finally, return the configuration to wezterm

return config
