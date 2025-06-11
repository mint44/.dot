local colors = require("colors")
local default = require("default")
local settings = require("settings")
local appicons = require("../items/appicons")

local apps = sbar.add("bracket", "apps", {}, {
  position = "left",
  label = {
    -- font = {
    --   style = settings.font.style_map["Black"],
    --   size = 12.0,
    -- },
  },
--   padding_left = -80
})

local function get_app_icon(app_name)
  return appicons[app_name] or appicons.default
end

local function focus_window(env)
  sbar.exec("yabai -m query --windows id,has-focus", function(output)
    for _, line in ipairs(output) do
      sbar.set("apps." .. line.id, {
        label = {
          highlight = line['has-focus'],
        }
      })
    end
  end)
end

local function update_windows(windows)
  -- need to check if exists
  sbar.remove("/apps.\\.*/")
  for _, line in ipairs(windows) do
    width = math.min(100, 300 / #windows)
    sbar.add("item", "apps." .. line['id'], {
      label = {
        string = line['app'] .. ": " .. line['title'],
        max_chars = width,
        scroll_duration = 150,
        width = width,
        highlight_color = colors.magenta,
        highlight = line['has-focus'],
      },
      icon = {
        -- string = get_app_icon(line['app']),
        string = get_app_icon(line['app']),
        font = "Hack Nerd Font Mono:Regular:18.0",
        -- use nerd font
        -- padding_left = 4,
        -- padding_right = 4,
        -- color = colors.white,
        -- font = {
        --   style = "Black",
        --   size = 12.0,
        -- }, 
      },
      padding_right = 2,
      click_script = "yabai -m window --focus " .. line['id'],
      background = {
        color = colors.color_background,
        height = 20,
        corner_radius = 3,
        border_width = 1,
        border_color = colors.cyan
      },
    })
  end
end

local function get_apps(env)
  sbar.exec("yabai -m query --windows id,title,app,has-focus --space", update_windows)
end

event_custom_windows_changed
apps:subscribe("space_change", get_apps)
apps:subscribe("event_custom_windows_changed", get_apps)
-- apps:subscribe("front_app_switched", get_apps)
apps:subscribe("front_app_switched", focus_window)

