bonus = {
	x = 0,
	y = 0,
	lifeTime = 5,
	exists = false,
	timeSpawned = 0,
	timeDied = love.timer.getTime(),
	delay = love.math.random(10, 15),
	r = defaultBall.r * 1.5
}

animation:new("bonus", {
	w = 100,
	h = 100,
	duration = 1,
	img = spincoinAnimate
})

function bonus:draw()
	local x, y = self.body:getPosition()
	--love.graphics.setColor(0, 0, 0)
	--love.graphics.circle("fill", x, y, r)
	love.graphics.setColor(255, 255, 255)
	animation:draw("bonus", x - self.r, y - self.r, self.r * 2, self.r * 2)
end

function bonus:generate()
	self.exists = true
	self.body = love.physics.newBody(world, love.math.random(self.r, screen:get("game").w - self.r), love.math.random(self.r, screen:get("game").h - self.r), "static")
	self.shape = love.physics.newCircleShape(self.r)
	self.fixture = love.physics.newFixture(bonus.body, bonus.shape)
	self.fixture:setMask(2)
	self.fixture:setUserData("bonus")
	self.timeSpawned = love.timer.getTime()
end

function bonus:destroy()
	self.body:destroy()
	self.exists = false
	self.delay = love.math.random(10, 15)
	self.timeDied = love.timer.getTime()
end

function bonus:update()
	if self.exists then 
		if love.timer.getTime() - self.timeSpawned > self.lifeTime then
			self:destroy()
		end
	else
		if love.timer.getTime() - self.timeDied > self.delay then
			bonus:generate()
		end
	end
end