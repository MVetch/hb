ground = {
	body = love.physics.newBody(world, 0, 0),
 	shape = love.physics.newChainShape(true, 
 		--[[x1--]]0, 
 		--[[y1--]]0, 
 		--[[x2--]]0, 
 		--[[y2--]]screen:get("game").h, 
 		--[[x3--]]screen:get("game").w, 
 		--[[y3--]]screen:get("game").h, 
 		--[[x4--]]screen:get("game").w, 
 		--[[y4--]]0
 	)
}
ground.fixture = love.physics.newFixture(ground.body, ground.shape)
ground.fixture:setUserData("ground")
ground.fixture:setMask(2)


for i = -adHeight / 2, screen:get("game").w, adHeight / 2 do
	animation:new("fire" .. ((i + 1) / adHeight / 2), {
		w = 256, 
		h = 256,
		img = firePic,
		duration = 0.5
	})
end


function ground:draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(
		fireTopPic, 
		0,
		screen:get("game").h - heatedHeight,
		0,
		screen:get("game").w / fireTopPic:getWidth(),
		(heatedHeight + (adHeight + 10)) / fireTopPic:getHeight()
	)

	for i = -adHeight / 2, screen:get("game").w, adHeight / 2 do
		animation:draw("fire" .. ((i + 1) / adHeight / 2), i, screen:get("game").h, (adHeight + 10), (adHeight + 10))
	end
	--love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
end