screen:new("game", {
	draw = false,
	active = false,
	h = h - (adHeight + 10) - getPercent(h, 6.94),
	Y = getPercent(h, 6.94)
})

if(screen.s.game ~= nil) then function screen.s.game.show()
	obstacle:draw()
	ground:draw()
	if not ball.dead then
		ball:draw()
		love.graphics.setColor(255, 255, 255)
		love.graphics.draw(plus1Particle)
	else
		love.graphics.setColor(skin:get(settings:get("skin")).particleColor)
		love.graphics.draw(ballParticles, ball.body:getX(), ball.body:getY())
	end
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(coinParticle)

	if bonus.exists then bonus:draw() end
	--topLeft(timer:print() .. "\n" .. score .. "\nrecord:" .. scoreboard:toString(1) .. "\n" .. level .. "\nFPS:" .. love.timer.getFPS().. "\nCoins:" .. settings:get("coins") .. debug)
	-- topLeft(
	-- 	"FPS:"    .. love.timer.getFPS() .. 
	-- 	"\n"      .. timer:print() .. 
	-- 	"\nScreen:" .. w .. "x" .. h .. 
	-- 	debug
	-- )
	-- love.graphics.setFont(bestFont)
	-- topLeft(love.filesystem.getSaveDirectory())

	--love.graphics.line(0, screen:get("game").h - heatedHeight, w, screen:get("game").h - heatedHeight)
end end