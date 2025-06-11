-- export COLOR_0=0xff211515
-- export COLOR_1=0xffaa6c6b
-- export COLOR_2=0xffaa564f
-- export COLOR_3=0xff8596aa
-- export COLOR_4=0xffa09aa9
-- export COLOR_5=0xffaa9097
-- export COLOR_6=0xffaa7f81
-- export COLOR_7=0xffc7c4c4
-- export COLOR_8=0xff584f4f
-- export COLOR_9=0xffaa6c6b
-- export COLOR_10=0xffaa564f
-- export COLOR_11=0xff8596aa
-- export COLOR_12=0xffa09aa9
-- export COLOR_13=0xffaa9097
-- export COLOR_14=0xffaa7f81



-- export FOREGROUND_COLOR=0xffffffff
-- export BACKGROUND_COLOR=0xff000000
-- export ACCENT_COLOR=0xff0000ff


--  -- black = 0xff181926,
--   -- white = 0xffffffff,
--   -- red = 0xffed8796,
--   -- green = 0xffa6da95,
--   -- blue = 0xff8aadf4,
--   -- yellow = 0xffeed49f,
--   orange = 0xfff5a97f,
--   -- magenta = 0xffc6a0f6,
--   -- grey = 0xff939ab7,
--   -- transparent = 0x00000000,
local colors = {
  black = 0xff000000,
  white = 0xffffffff,
  red = 0xffaa6c6b,
  green = 0xffaa564f,
  blue = 0xff8596aa,
  navy = 0xff000080,
  yellow = 0xffa09aa9,
  orange = 0xfff5a97f,
  magenta = 0xffaa9097,
  grey = 0x80808080,
  near_gray = 0xffDDDDDD,
  lyme = 0xff56ffbe
}

local gruvbox = {
  bg = 0xff282828,
  fg = 0xffebdbb2,
  accent = 0xffd79921,
}

return {
  foreground    = colors.near_gray,
  foreground_2  = colors.grey,
  background    =  gruvbox.bg, --colors.black,
  -- accent     = colors.lyme,
  -- accent     = colors.orange,
  accent        = gruvbox.accent --colors.lyme,
  -- bar = {
  --   bg       = 0xff000000,
  --   border   = 0xff494d64,
  -- },
  -- popup = {
  --   bg       = 0xff1e1e2e,
  --   border   = 0xffcad3f5
  -- },
  -- bg1        = 0x803c3e4f,
  -- bg2        = 0xaa494d64,
}
