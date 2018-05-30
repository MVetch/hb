local settingsEncoded = love.filesystem.read("settings")
if settingsEncoded then
	settings = json.decode(settingsEncoded)
	if settings.soundOn == nil then
		settings.soundOn = true
	end
	if not settings.skin then
		settings.skin = "blackCircle"
	end
	if not settings.coins then
		settings.coins = 0
	end
else
	settings = {
		soundOn = true,
		skin = "blackCircle",
		coins = 0
	}
end

function settings:set(key, value)
	self[key] = value
	love.filesystem.write("settings", json.encode(settings))
end

function settings:get(key)
	return self[key]
end