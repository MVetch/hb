topMenu = screen:new("topMenu", {
	draw = false,
	active = false,
	z = 3,
	h = getPercent(h, 6.94)
})

button:add("pauseGame", {
	X = w - topMenu.h / 2,
	Y = topMenu.h / 2,
	height = buttonFont:getWidth("||") * 1.5,
	value = "||",
	screen = "topMenu",
	rx = 6,
	ry = 6,
	shadowX = 1,
	shadowY = 1,
	onclick = function()
		screen:get("game").active = false
		timer:pause()
		screen:get("menu").active = true
		screen:get("menu").draw = true

		button:get("pauseGame").draw   = false
		button:get("pauseGame").active = false
	end
})
button:add("rewardAdForCoins", {
	X = topMenu.h * 5 + bestFont:getWidth("Get Coins!") * 1.5 / 2,
	Y = topMenu.h - bestFont:getHeight() * 1.5 / 2 - 5,
	value = "Get Coins!",
	screen = "topMenu",
	font = bestFont,
	color = {214, 211, 11},
	onclick = function()
		if love.system.getOS() == "Android" then
			showingAd = true
			love.ads.showRewardedAd()
			love.ads.requestRewardedAd(rewardedAdId)
		else
			love.rewardUserWithReward("a", 5)
		end
	end
})

animation:new("pulseArrowButton", {
	img = arrowUpAnimate,
	w = 400,
	h = 400,
	duration = 0.5
})

button:add("activatePowerUp", {
	X = topMenu.h * 4,
	width = topMenu.h,
	height = topMenu.h,
	value = "",
	screen = "topMenu",
	color = {0,0,0,0},
	colorClicked = {0,0,0,0},
	rx = 0,
	ry = 0,
	segments = 0,
	onclick = function()
		if powerUp.value >= powerUp.max then
			powerUp.activated = true
		end
	end,
	picture = function()
		love.graphics.setColor(255, 255 * (1 - powerUp.value / powerUp.max), 255 * (1 - powerUp.value / powerUp.max))
		if powerUp.value < powerUp.max then
			love.graphics.draw(arrowUpPic, 0, 0, 0, topMenu.h / arrowUpPic:getWidth(), topMenu.h / arrowUpPic:getHeight())
		else
			animation:draw("pulseArrowButton", 0, 0, button:get("activatePowerUp").width, button:get("activatePowerUp").height)
		end
		love.graphics.setColor(255, 255, 255)
		drawable.ring(button:get("activatePowerUp").width / 2, button:get("activatePowerUp").height / 2, topMenu.h / 2, bestFont:getHeight() / 4)
		love.graphics.setColor(255, 0, 0)
		drawable.arc (button:get("activatePowerUp").width / 2, button:get("activatePowerUp").height / 2, topMenu.h / 2, -math.pi / 2, -math.pi / 2 + 2 * math.pi * powerUp.value / 100, bestFont:getHeight() / 4)
	end
})

function topMenu:show()
	if love.system.getOS() == "Android" then
		if love.ads.isRewardedAdLoaded() then
			button:get("rewardAdForCoins").color = {214, 211, 11}
			button:get("rewardAdForCoins").active = true
		else
			button:get("rewardAdForCoins").color = {100, 100, 100}
			button:get("rewardAdForCoins").active = false
		end
	end

	local height = topMenu.h
	local width = height

	love.graphics.setColor(0,0,0)
	love.graphics.polygon("fill", 0, 0, topMenu.w, 0, topMenu.w, width, 0, width)

	love.graphics.setColor(255, 255, 255)

	--drawable.border(0, 0, width * 2, height, {left = 2, right = 2, top = 2, bottom = 2})
		love.graphics.setFont(scoreFont)
		local scale = score < 10000 and 1 or 2 * width / scoreFont:getWidth(score)
		love.graphics.printf(score, 0, 0, math.max(scoreFont:getWidth(score), 2 * width), "center", 0, scale)

		love.graphics.setFont(bestFont)
		love.graphics.printf("Best:" .. scoreboard:toString(1), 0, height - bestFont:getHeight() * 2, math.max(bestFont:getWidth("Best:" .. scoreboard:toString(1)), 2 * width), "center")--, 0, scale)

	--drawable.border(width * 2, 0, width, width, {left = 2, right = 2, top = 2, bottom = 2})
		love.graphics.setFont(scoreFont)
		love.graphics.printf(level.number, width * 2, 0, width, "center", 0)

		love.graphics.setFont(bestFont)
		love.graphics.printf("Level", width * 2, height - bestFont:getHeight() * 2, width, "center", 0)
		drawable.ring(width * 2.5, height / 2, height / 2 - bestFont:getHeight() / 16, bestFont:getHeight() / 4)
		love.graphics.setColor(0, 0, 255)
		drawable.arc (width * 2.5, height / 2, height / 2 - bestFont:getHeight() / 16, -math.pi / 2, -math.pi / 2 + 2 * math.pi * level.percent, bestFont:getHeight() / 4)

	--drawable.border(width * 3.5, 0, width, width, {left = 2, right = 2, top = 2, bottom = 2})


	--drawable.border(width * 5, 0, button:get("rewardAdForCoins").width, width, {left = 2, right = 2, top = 2, bottom = 2})
		love.graphics.setColor(255, 255, 255)
		love.graphics.setFont(scoreFont)
		local scale = settings:get("coins") < 100 and 1 or (button:get("rewardAdForCoins").width - width / 2) / scoreFont:getWidth(settings:get("coins"))
		love.graphics.printf(settings:get("coins"), width * 5.5, (width - button:get("rewardAdForCoins").height - scoreFont:getHeight() * scale) / 2, math.max(scoreFont:getWidth(settings:get("coins")), button:get("rewardAdForCoins").width), "left", 0, scale)
		love.graphics.draw(coin, width * 5, (width - button:get("rewardAdForCoins").height - width / 2) / 2, 0, width / 2 / coin:getWidth())

		
	-- love.graphics.setColor(0, 255, 0)
	-- love.graphics.rectangle("fill", 0, height, topMenu.w, 5)

	-- love.graphics.setColor(255, 0, 0)
	-- love.graphics.rectangle("fill", 0, height, topMenu.w * powerUp.value / 100, 5)
end