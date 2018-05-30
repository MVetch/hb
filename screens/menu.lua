screen:new("menu", {
	draw = true,
	active = true,
	z = 2
})

button:add("newGame", {
	X = "center",
	Y = "center",
	value = "Start a new game",
	screen = "menu",
	onclick = function()
		screen:get("menu").draw = false
		screen:get("menu").active = false

		ball:reset()
		blocksPassed = 0
		blocksGenedWOutPowerUp = 0
		lastGenedBlock = -SPB
		timer:reset()
		ballParticles:reset()
		coinParticle:reset()
		plus1Particle:stop()
		plus1Particle:reset()
		obstacle:clear()
		debug = ""
		powerUp = 0
		score = 0
		level = 1
		ball.dead = false
		bonus.delay = love.math.random(10, 15)
		bonus.timeDied = love.timer.getTime()

		screen:get("game").active = true
		screen:get("game").draw = true
		screen:get("background").active = true
		screen:get("background").draw   = true
		button:get("pauseGame").draw   = true
		button:get("pauseGame").active = true
		screen:get("skins").Y = screen:get("game").Y

		button:get("continueGame").draw = true
		button:get("continueGame").active = true
		
		timer:start()
	end
})

button:add("continueGame", {
	X = "center",
	Y = h/2 - button:get("newGame").height * 2,
	width = button:get("newGame").width,
	value = "Continue",
	screen = "menu",
	draw = false,
	active = false,
	onclick = function()
		screen:get("menu").draw   = false
		screen:get("menu").active = false

		screen:get("background").active = true
		screen:get("background").draw   = true
		button:get("pauseGame").active = true
		button:get("pauseGame").draw   = true
		screen:get("game").active = true
		screen:get("game").draw   = true

		timer:start()
	end
})

button:add("settings", {
	X = "center",
	Y = h/2 + button:get("newGame").height * 2,
	width = button:get("newGame").width,
	value = "Settings",
	screen = "menu",
	onclick = function()
		screen:get("menu").draw   = false
		screen:get("menu").active = false

		screen:get("settings").draw   = true
		screen:get("settings").active = true
	end
})

button:add("exit", {
	X = "center",
	Y = h/2 + button:get("newGame").height * 4,
	width = button:get("newGame").width,
	value = "Quit game",
	screen = "menu",
	onclick = function()
		love.event.quit()
	end
})

if(screen.s.menu ~= nil) then function screen.s.menu.show()

end end