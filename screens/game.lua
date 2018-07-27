gameScreen = screen:new("game", {
	draw = false,
	active = false,
	h = h - getPercent(h, 6.94),
	Y = getPercent(h, 6.94)
})

function gameScreen:show()
	obstacle:draw()
	ground:draw()
	if not ball.dead then
		ball:draw()
		love.graphics.setColor(255, 255, 255)
		love.graphics.draw(plus1Particle)

		love.graphics.setColor(255 * math.sin(love.timer.getTime() * love.timer.getDelta()), 255 * math.cos(love.timer.getTime() * love.timer.getDelta()), 0)
		love.graphics.draw(powerUp.particles)
	else
		love.graphics.setColor(skin:get(settings:get("skin")).particleColor)
		love.graphics.draw(ballParticles, ball.body:getX(), ball.body:getY())
	end
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(coinParticle)

	if bonus.exists then bonus:draw() end
end