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
    -- color = colors.color_4,
    corner_radius = 3,
    height = 20,
  },
  y_offset = -8,  -- Move weather down
  padding_right = -90,  -- Move further to the right
  padding_left  = 2. 
})

local function update()
  local cmd = "curl -s wttr.in/boston?format=\"%t\""
  sbar.exec(cmd, function(output)
    -- set max char length to 9
    output = output:sub(1, 9)  -- Limit to 0 characters
    temp:set({
      label = output,
    })
  end)
end

temp:subscribe("routine", update)
temp:subscribe("forced", update)

-- sketchybar --add item test right \                                                         1 ↵
--   --set test scroll_texts=on \
--   max_chars=5 \
--   label="This is a long test text that should scroll"
-- -- sketchybar --set test label.max_chars=5

-- sbar.add("item", "test", {
--   position = "right",
--   scroll_texts = true,
--   label = {
--     string = "This is a long test text that should scroll",
--     max_chars = 5,
--     scroll_duration = 150,
--     width = 100,
--     highlight_color = colors.magenta,
--     highlight = true,
--   },
--   icon = {
--     string = "􀇂",
--   },
--   background = {
--     color = colors.color_background,
--     height = 20,
--     corner_radius = 3,
--     border_width = 1,
--   },
-- })