screen:new("settings", {
	z = 2
})

button:add("soundSwitch", {
	X = "center",
	Y = "center",
	value = settings:get("soundOn") and "Disable Sound" or "Enable Sound",
	screen = "settings",
	onclick = function()
		settings:set("soundOn", not settings:get("soundOn"))
		button:get("soundSwitch").value = settings:get("soundOn") and "Disable Sound" or "Enable Sound"
	end
})

button:add("skinSwitch", {
	X = "center",
	Y = h / 2 + button:get("soundSwitch").height * 2,
	width = button:get("soundSwitch").width,
	value = "Skin",
	screen = "settings",
	onclick = function()
		screen:get("settings").active = false
		screen:get("settings").draw = false

		screen:get("skins").active = true
		screen:get("skins").draw = true
	end
})
button:add("fromSettingsToMenu", {
	X = "center",
	Y = h / 2 + button:get("soundSwitch").height * 4,
	width = button:get("soundSwitch").width,
	value = "Back",
	screen = "settings",
	onclick = function()
		screen:get("settings").active = false
		screen:get("settings").draw = false

		screen:get("menu").active = true
		screen:get("menu").draw = true
	end
})