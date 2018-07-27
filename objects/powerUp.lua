powerUp = {
	value = 0,
	active = false,
	activeFor = 5,
	max = 100,
	buildingUp = false,
	activated = false,
	particles = love.graphics.newParticleSystem(ballParcticlePic, 500000)
}

powerUp.particles:setEmitterLifetime(-1)--powerUp.activeFor * 9 / 10)
powerUp.particles:setParticleLifetime(powerUp.activeFor / 20)
powerUp.particles:setEmissionRate(0)
powerUp.particles:setDirection(math.pi / 2)
powerUp.particles:setAreaSpread("ellipse", defaultBall.r * 3, defaultBall.r * 3)
powerUp.particles:setRadialAcceleration(defaultBall.r, 10)
powerUp.particles:setSpin(-20, 20)
powerUp.particles:setColors(255, 255, 255, 255, 
							255, 255, 255, 0  )
powerUp.particles:setSpeed(0, level.dvelocity)
powerUp.particles:start()

function powerUp:reset()
	self.value = 0
	self.active = false
	self.buildingUp = false
	self.particles:reset()
end

function powerUp:update(dt)
	self.particles:update(dt)
	self.particles:setPosition(ball.body:getX(), ball.body:getY())
	if self.active then
		self.value = self.value - self.max / self.activeFor * dt
		local mv = level.dvelocity * 10
		local d = 10-- on 1/d part from the end of power up the velocity starts to go down quadratically
		d = d / (d - 1)
		local c = mv
		local b = (level.dvelocity - mv) / ((1 - d) * self.activeFor)
		local a = (-level.dvelocity - mv - b * self.activeFor) / (self.activeFor * self.activeFor)
		local t = self.activeFor * (self.max - self.value) / self.max
		level.velocity = math.max(math.min(a * t * t + b * t + c, mv), level.dvelocity)
		level.SPB = level.dvelocity * level.dSPB / level.velocity

		if self.value <= 0 then
			self.value = 0
			--self.particles:stop()
			--self.particles:reset()
			self.particles:setEmissionRate(0)
			self.active = false
			ball.body:resetMassData()
			force = force / 1e16 * ball.body:getMass()
			ball.immortal = false
			self.particles:setSpeed(0, level.dvelocity)

			for i, obs in ipairs(obstacle.s) do
				for j, b in ipairs(obs.body) do
					b:setLinearVelocity(0, level.velocity)
				end
			end
		end
	else
		self.particles:setEmissionRate(self.value)
		if self.value < self.max then
			if ball.body:getY() > screen:get("game").h - (adHeight + 10) - heatedHeight then
				self.value = self.value + self.max / self.activeFor * dt
				self.buildingUp = true
			else
				self.buildingUp = false
			end
		elseif self.activated then
			self.activated = false
			self.active = true
			self.buildingUp = false
			force = force * 1e16 / ball.body:getMass()
			ball.body:setMass(1e16)
			ball.immortal = true

			local mv = level.dvelocity * 10
			local d = 10
			d = d / (d - 1)
			local c = mv
			local b = (level.dvelocity - mv) / ((1 - d) * self.activeFor)
			local a = (-level.dvelocity - mv - b * self.activeFor) / (self.activeFor * self.activeFor)
			local t = self.activeFor * (self.max - self.value) / self.max
			level.velocity = math.max(math.min(a * t * t + b * t + c, mv), level.dvelocity)
			level.SPB = level.dvelocity * level.dSPB / level.velocity
			self.particles:setSpeed(0, mv)
			self.particles:setEmissionRate(self.value * 10)

			for i, obs in ipairs(obstacle.s) do
				for j, b in ipairs(obs.body) do
					b:setLinearVelocity(0, level.velocity)
				end
			end
		end
	end
end