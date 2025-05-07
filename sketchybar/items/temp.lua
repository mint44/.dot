-- TEMP=$(curl -s wttr.in/boston?format="%t")
-- sketchybar --set "temp" label="Boston: $TEMP"
local colors = require("colors")

local temp = sbar.add("item", {
  icon = {
    string = "􀇂",
  },
  label = {
  },
  position = "right",
  update_freq = 60,
  background = {
    color = colors.color_4,
    corner_radius = 3,
    height = 20,
  },
})

local function update()
  local cmd = "curl -s wttr.in/boston?format=\"%t\""
  sbar.exec(cmd, function(output)
    temp:set({
      label = "Boston: " .. output,
    })
  end)
end

temp:subscribe("routine", update)
temp:subscribe("forced", update)