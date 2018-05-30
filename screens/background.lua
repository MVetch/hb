screen:new("background", {
	draw = false,
	active = false,
	z = 3,
	h = getPercent(h, 6.94)
})

button:add("pauseGame", {
	X = w - screen:get("background").h / 2,
	Y = screen:get("background").h / 2,
	height = buttonFont:getWidth("||") * 1.5,
	value = "||",
	screen = "background",
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
	X = screen:get("background").h * 5 + bestFont:getWidth("Get Coins!") * 1.5 / 2,
	Y = screen:get("background").h - bestFont:getHeight() * 1.5 / 2 - 5,
	value = "Get Coins!",
	screen = "background",
	font = bestFont,
	color = {214, 211, 11},
	onclick = function()
		if love.system.getOS() == "Android" then
			--if love.ads.isRewardedAdLoaded() then
				showingAd = true
				love.ads.showRewardedAd()
			--end
			love.ads.requestRewardedAd(rewardedAdId)
		else
			love.rewardUserWithReward("a", 5)
		end
	end
})

if(screen.s.background ~= nil) then function screen.s.background.show()
	local height = screen:get("background").h
	local width = height

	love.graphics.setColor(0,0,0)
	love.graphics.polygon("fill", 0, 0, screen:get("background").w, 0, screen:get("background").w, width, 0, width)

	love.graphics.setColor(255, 255, 255)

	--drawable.border(0, 0, width * 2, height, {left = 2, right = 2, top = 2, bottom = 2})
		love.graphics.setFont(scoreFont)
		local scale = score < 10000 and 1 or 2 * width / scoreFont:getWidth(score)
		love.graphics.printf(score, 0, 0, math.max(scoreFont:getWidth(score), 2 * width), "center", 0, scale)

		love.graphics.setFont(bestFont)
		love.graphics.printf("Best:" .. scoreboard:toString(1), 0, height - bestFont:getHeight() * 2, math.max(bestFont:getWidth("Best:" .. scoreboard:toString(1)), 2 * width), "center")--, 0, scale)

	--drawable.border(width * 2, 0, width, width, {left = 2, right = 2, top = 2, bottom = 2})
		love.graphics.setFont(scoreFont)
		love.graphics.printf(level, width * 2, 0, width, "center", 0)

		love.graphics.setFont(bestFont)
		love.graphics.printf("Level", width * 2, height - bestFont:getHeight() * 2, width, "center", 0)

	--drawable.border(width * 5, 0, button:get("rewardAdForCoins").width, width, {left = 2, right = 2, top = 2, bottom = 2})
		love.graphics.setFont(scoreFont)
		local scale = settings:get("coins") < 100 and 1 or (button:get("rewardAdForCoins").width - width / 2) / scoreFont:getWidth(settings:get("coins"))
		love.graphics.printf(settings:get("coins"), width * 5.5, (width - button:get("rewardAdForCoins").height - scoreFont:getHeight() * scale) / 2, math.max(scoreFont:getWidth(settings:get("coins")), button:get("rewardAdForCoins").width), "left", 0, scale)
		love.graphics.draw(coin, width * 5, (width - button:get("rewardAdForCoins").height - width / 2) / 2, 0, width / 2 / coin:getWidth())

		
	love.graphics.setColor(0, 255, 0)
	love.graphics.rectangle("fill", 0, height, screen:get("background").w, 5)

	love.graphics.setColor(255, 0, 0)
	love.graphics.rectangle("fill", 0, height, screen:get("background").w * powerUp / 100, 5)
end end