local colors = require("colors")



-- - Equivalent to the --bar domain

-- sbar.bar({
--   height = 40,
--   color = colors.bar.bg,
--   border_color = colors.bar.border,
--   shadow = true,
--   sticky = true,
--   padding_right = 10,
--   padding_left = 10,
--   blur_radius=20,
--   topmost="window",
-- })

-- -sketchybar --bar topmost=off position=top height=38 blur_radius=30 color=0xff000000  
sbar.bar({
  position = "top",
  height = 22,
  color = colors.background,
  topmost="on",
  -- color = colors.blue,
  -- border_color = colors.bar.border,
  -- shadow = true,
  -- sticky = false,
  -- padding_right = 10,
  -- padding_left = 10,
  blur_radius=30,
})