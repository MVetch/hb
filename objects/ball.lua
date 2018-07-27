ball = {
	r = getPercent(w*h, 0.0017),
	x = w/2,
	y = h/2,
	dead = false,
	immortal = false
}
ball.body = love.physics.newBody(world, ball.x, ball.y, "dynamic")
ball.shape = love.physics.newCircleShape(ball.r)
ball.fixture = love.physics.newFixture(ball.body, ball.shape)
ball.fixture:setRestitution(0.5)
ball.fixture:setUserData("ball")

-- ball.particles = love.graphics.newParticleSystem(ballParcticlePic, 500)
-- ball.particles:setParticleLifetime(0.1, 0.2)
-- ball.particles:setAreaSpread("ellipse", defaultBall.r, defaultBall.r)
-- ball.particles:setRadialAcceleration(defaultBall.r, 2)
-- ball.particles:setColors(255, 255, 255, 255, 
-- 				  255, 255, 255, 0)

function ball:update(dt)
	
	-- ball.particles:update(dt)
	-- ball.particles:emit(1)
end

function ball:draw()
	skin:get(
		settings:get("skin")
	).draw(
		self.body:getX(), 
		self.body:getY(), 
		self.shape:getRadius(), 
		{255 * powerUp.value / 100, -255 * powerUp.value / 100, -255 * powerUp.value / 100}
	)
end

function ball:reset()
	self.body:destroy()
	self.r = defaultBall.r
	self.x = defaultBall.x
	self.y = defaultBall.y
	self.dead = defaultBall.dead
	self.body = love.physics.newBody(world, self.x, self.y, "dynamic")
	self.shape = love.physics.newCircleShape(self.r)
	self.fixture = love.physics.newFixture(self.body, self.shape)
	self.fixture:setRestitution(0.5)
	self.fixture:setUserData("ball")
end