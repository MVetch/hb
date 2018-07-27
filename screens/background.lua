backgroundScreen = screen:new("background", {
	z = 0,
	active = true,
	draw = true
})

pulseArrow = animation:new("pulseArrow", {
	img = arrowUpAnimate,
	w = 400,
	h = 400,
	duration = 0.5
})

function backgroundScreen:show()
	--if powerUp.buildingUp or powerUp.active then
	love.graphics.setColor(255, 0, 0, 255 * powerUp.value / powerUp.max / 2)
	if powerUp.value < powerUp.max then
		local scale = gameScreen.w / arrowUpPic:getWidth()
		love.graphics.draw(
			arrowUpPic,
			gameScreen.w / 2,
			gameScreen.h / 2,
			0,
			scale,
			scale,
			arrowUpPic:getWidth() / 2,
			arrowUpPic:getHeight() / 2
		)
	else
		animation:draw(
			"pulseArrow", 
			0,
			gameScreen.h / 2 - gameScreen.w / 2,
			gameScreen.w,
			gameScreen.w
		)
	end
end