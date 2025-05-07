-- TIME=$(curl -s "https://maps.trilliumtransit.com/gtfsmap-realtime/feed/dartmouth-vt-us/arrivals?stopCode=4206789&stopID=4206789" | jq -r '.data[] | select(.route_id == "76431") | .formattedTime' | head -n 1)
-- sketchybar --set "bus_track" label="Sachem: $TIME"

-- local cal = sbar.add("item", {
--   icon = {
--     -- padding_right = 0,
--     -- font = {
--     --   style = "Black",
--     --   size = 12.0,
--     -- },
--   },
--   -- label = {
--   --   width = 45,
--   --   align = "right",
--   -- },
--   position = "right",
--   update_freq = 15,
-- })

-- local function update()
--   local date = os.date("%a. %d %b.")
--   local time = os.date("%H:%M")
--   cal:set({ icon = date, label = time })
-- end

-- cal:subscribe("routine", update)
-- cal:subscribe("forced", update)


--set bus_track  icon=􀝉 script="$PLUGIN_DIR/bus_track.sh" "${background[@]}" update_freq=60 background.color=${COLOR_5} \
local bus = sbar.add("item", {
  icon = {
    string = "􀝉",
  },
  label = {
    string = "Sachem: $TIME",
    width = 45,
    align = "right",
  },
  position = "right",
  update_freq = 15,
})

bus:subscribe("routine", function()
  sbar.exec("curl -s \"https://maps.trilliumtransit.com/gtfsmap-realtime/feed/dartmouth-vt-us/arrivals?stopCode=4206789&stopID=4206789\" | jq -r '.data[] | select(.route_id == \"76431\") | .formattedTime' | head -n 1", function(output)
    sbar.set(bus.name, {
      label = output,
    })
  end)
end)