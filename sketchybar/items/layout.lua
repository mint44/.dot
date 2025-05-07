local colors = require("colors")
local layout = sbar.add("item", {
  position = "left",
})

local function update()
  local cmd = "yabai -m query --spaces --space | jq -r '.type'"
  sbar.exec(cmd, function(output)
    local icon = "􀟻"
    output = output:gsub("\n", ""):gsub("%s", "")
    if output == "bsp" then
      icon = "􀟻"
    elseif output == "float" then
      icon = "􁎄"
    elseif output == "stack" then
      icon = "􀏭"
    else
      icon = "?"
    end
    sbar.set(layout.name, {
        label = output,
        icon = {
            string = icon,
        },
    })

  end)

end

-- layout:subscribe("routine", update)
layout:subscribe("event_custom_layout_changed", update)
-- layout:subscribe("event_custom_windows_changed", update)
layout:subscribe("space_change", update)
layout:subscribe("forced", update)