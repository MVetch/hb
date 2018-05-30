screen:new("skins", {
	z = 2
})

local k = 0
local butWidth = w / 9
for name, skinBody in pairs(skin.s) do
	button:add(name .. "Switch", {
		X = butWidth * 3 / 2 + butWidth * 2 * (k % 4),
		Y = butWidth + butWidth * 2 * math.floor(k / 4),
		value = "",
		width = butWidth,
		height = butWidth,
		--backgroundImage = skinBlackCircle,
		active = skin:get(name).unlocked,
		color = not skin:get(name).unlocked and {100, 100, 100} or (settings:get("skin") == name and {255, 100, 100} or {255, 0, 0}),
		screen = "skins",
		onclick = function()
			button:get(settings:get("skin") .. "Switch").color = {255, 0, 0}
			settings:set("skin", name)
			button:get(name .. "Switch").color = {255, 100, 100}
		end,
		picture = function()
			skin:get(name).draw(
				button:get(name .. "Switch").X + butWidth / 2, 
				button:get(name .. "Switch").Y + butWidth / 2, 
			butWidth / 3)
		end
	})

	button:add(name .. "Buy", {
		X = button:get(name .. "Switch").X,
		Y = button:get(name .. "Switch").Y + butWidth / 2 * 2,
		value = skin:get(name).price,
		width = butWidth,
		height = butWidth / 2,
		active = (not skin:get(name).unlocked and settings:get("coins") >= skin:get(name).price),
		color = (skin:get(name).unlocked or settings:get("coins") < skin:get(name).price) and {100, 100, 100} or {255, 0, 0},
		screen = "skins",
		onclick = function()
			if settings:get("coins") >= skin:get(name).price then
				skin:buy(name)
			end
		end
	})
	k = k + 1
end

button:add("fromSkinsToSettings", {
	X = "center",
	Y = h / 2 + button:get("blackCircleSwitch").height * 2,
	value = "Back",
	screen = "skins",
	onclick = function()
		screen:get("settings").active = true
		screen:get("settings").draw = true

		screen:get("skins").active = false
		screen:get("skins").draw = false
	end
})