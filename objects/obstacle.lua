obstacle = {
	default = {
		height = getPercent(h, 4.16), --30
		color = {love.math.random(255), love.math.random(255), love.math.random(255)},
		passed = false,
		spikesAtTop = false
	},
	s = {},
	minWidth = getPercent(w, 7.38),
	maxWidth = w - 30,
	perScreen = 10,
	holeSize = 50,
	curBlock = 1,
	toRemove = 1,
	exceeded = false
}

function obstacle:new(params)
	if not self.exceeded then
		if self.curBlock > self.perScreen then
			for j = 1, table.getn(self:get(self.toRemove).body), 1 do
				self:get(self.toRemove).body[j]:destroy()
			end
			self:get(self.toRemove).body = {}
			self:get(self.toRemove).shape = {}
			self:get(self.toRemove).fixture = {}
			--self.s[self.toRemove].leftBody:destroy()
			--self.s[self.toRemove].rightBody:destroy()
			self.curBlock = self.toRemove
			self.toRemove = self.toRemove + 1
			self.exceeded = true
		end
	else
		for j = 1, table.getn(self:get(self.toRemove).body), 1 do
			self:get(self.toRemove).body[j]:destroy()
		end
		self:get(self.toRemove).body = {}
		self:get(self.toRemove).shape = {}
		self:get(self.toRemove).fixture = {}
		--self.s[self.toRemove].leftBody:destroy()
		--self.s[self.toRemove].rightBody:destroy()
		self.curBlock = self.toRemove
		self.toRemove = self.toRemove + 1
	end
	if self.toRemove > self.perScreen then
		self.toRemove = 1
	end
	self.s[self.curBlock] = {}

	if not params then params = {} end
	for k,v in pairs(self.default) do
		self:get(self.curBlock)[k] = params[k] or v
	end
	self:get(self.curBlock).body = {}
	self:get(self.curBlock).shape = {}
	self:get(self.curBlock).fixture = {}

	local bodys = math.random(levels[level].minSides, levels[level].maxSides)
	local sideWidth = 0
	local holeSize = 0
	if bodys == 1 then
		holeSize = math.random(levels[level].minHoleSize, levels[level].maxHoleSize)
		sideWidth = math.random(self.minWidth, self.maxWidth - levels[level].maxHoleSize)
		if math.random() > 0.5 then
			self:genSide(self.curBlock, {
				x = sideWidth / 2,
				y = -self:get(self.curBlock).height / 2,
				width = sideWidth,
				height = self:get(self.curBlock).height	
			})
		else
			self:genSide(self.curBlock, {
				x = (w + holeSize + sideWidth) / 2,
				y = -self:get(self.curBlock).height / 2,
				width = w - holeSize - sideWidth,
				height = self:get(self.curBlock).height	
			})
		end
	else
		local widthUsed = 0
		for i = 1, bodys - 1, 1 do
			holeSize = math.random(levels[level].minHoleSize, levels[level].maxHoleSize)
			sideWidth = math.random(self.minWidth, w - widthUsed - (levels[level].maxHoleSize + self.minWidth) * (bodys - i))
			self:genSide(self.curBlock, {
				x = widthUsed + (sideWidth)/2,
				y = -self:get(self.curBlock).height/2,
				width = sideWidth,
				height = self:get(self.curBlock).height	
			})
			widthUsed = widthUsed + sideWidth + holeSize
		end
		sideWidth = w - widthUsed
		self:genSide(self.curBlock, {
			x = widthUsed + (sideWidth)/2,
			y = -self:get(self.curBlock).height/2,
			width = sideWidth,
			height = self:get(self.curBlock).height	
		})
	end
	self.curBlock = self.curBlock + 1
end

function obstacle:genSide(index, params)
	local pointer = table.getn(self:get(index).body) + 1
	self:get(index).body[pointer]    = love.physics.newBody(world, params.x, params.y, "dynamic")
	self:get(index).body[pointer]:setGravityScale(0)
	self:get(index).body[pointer]:setLinearVelocity(0, levels[level].velocity)

	self:get(index).shape[pointer]   = love.physics.newRectangleShape(params.width, params.height)
	self:get(index).fixture[pointer] = love.physics.newFixture(self:get(index).body[pointer], self:get(index).shape[pointer], 1e6)
	self:get(index).fixture[pointer]:setUserData("obstacle " .. (self:get(index).spikesAtTop and "top" or "bottom"))
	self:get(index).fixture[pointer]:setCategory(2)
end

function obstacle:draw()
	local lw = ball.r * 1.2
	local lwAdj = lw
	local trianglesPerObs = 0
	for i, obs in ipairs(self.s) do
		for j, b in ipairs(obs.body) do
			local x1, y1, x2, y2, x3, y3, x4, y4 = b:getWorldPoints(obs.shape[j]:getPoints())
			trianglesPerObs = math.floor(math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2) / lw)
			lwAdj = math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2) / trianglesPerObs
			love.graphics.setColor(obs.color)
			love.graphics.polygon("fill", x1, y1, x2, y2, x3, y3, x4, y4)
			love.graphics.setColor(BackgroundColor)
			--love.graphics.setColor(0, 0, 0)
			local centerX1 = b:getX() - math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2) / 2
			local centerX2 = b:getX() + math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2) / 2

			local centerY1 = b:getY() + math.sqrt((x3 - x2) ^ 2 + (y3 - y2) ^ 2) / 2
			local centerY2 = b:getY() - math.sqrt((x3 - x2) ^ 2 + (y3 - y2) ^ 2) / 2
			if self:get(i).spikesAtTop then
				for k = 1, trianglesPerObs, 1 do
					love.graphics.polygon(
						"fill", 
						centerX1 + ((x3 - lwAdj * k)             - centerX1) * math.cos(b:getAngle()) - ( y1          - centerY1) * math.sin(b:getAngle()),
						centerY1 + ((x3 - lwAdj * k)             - centerX1) * math.sin(b:getAngle()) + ( y1          - centerY1) * math.cos(b:getAngle()),
						centerX1 + ((x3 - lwAdj * k + lwAdj / 2) - centerX1) * math.cos(b:getAngle()) - ((y1 + lwAdj) - centerY1) * math.sin(b:getAngle()),
						centerY1 + ((x3 - lwAdj * k + lwAdj / 2) - centerX1) * math.sin(b:getAngle()) + ((y1 + lwAdj) - centerY1) * math.cos(b:getAngle()),
						centerX1 + ((x3 - lwAdj * k + lwAdj)     - centerX1) * math.cos(b:getAngle()) - ( y1          - centerY1) * math.sin(b:getAngle()),
						centerY1 + ((x3 - lwAdj * k + lwAdj)     - centerX1) * math.sin(b:getAngle()) + ( y1          - centerY1) * math.cos(b:getAngle())
					)
				end
			else
				for k = 1, trianglesPerObs, 1 do
					love.graphics.polygon(
						"fill", 
						centerX2 + ((x1 + lwAdj * (k - 1))             - centerX2) * math.cos(b:getAngle()) - ( y3          - centerY2) * math.sin(b:getAngle()),
						centerY2 + ((x1 + lwAdj * (k - 1))             - centerX2) * math.sin(b:getAngle()) + ( y3          - centerY2) * math.cos(b:getAngle()),
						centerX2 + ((x1 + lwAdj * (k - 1) + lwAdj / 2) - centerX2) * math.cos(b:getAngle()) - ((y3 - lwAdj) - centerY2) * math.sin(b:getAngle()),
						centerY2 + ((x1 + lwAdj * (k - 1) + lwAdj / 2) - centerX2) * math.sin(b:getAngle()) + ((y3 - lwAdj) - centerY2) * math.cos(b:getAngle()),
						centerX2 + ((x1 + lwAdj * (k - 1) + lwAdj)     - centerX2) * math.cos(b:getAngle()) - ( y3          - centerY2) * math.sin(b:getAngle()),
						centerY2 + ((x1 + lwAdj * (k - 1) + lwAdj)     - centerX2) * math.sin(b:getAngle()) + ( y3          - centerY2) * math.cos(b:getAngle())
					)
				end
			end
		end
	end
end

function obstacle:update(dt)
	if timer:get() - lastGenedBlock >= levels[level].SPB then
		lastGenedBlock = timer:get()
		if not powerUpActive then
			blocksPassed = blocksPassed + 1
		end
		obstacle:new({
			width = love.math.random(obstacle.minWidth + obstacle.holeSize, obstacle.maxWidth - obstacle.holeSize),
			color = {love.math.random(255), love.math.random(255), love.math.random(255)},
			spikesAtTop = love.math.random() >= 0.5
		})
	end

	for i, obs in ipairs(self.s) do
		if not obs.passed and ball.body:getY() < obs.body[1]:getY() then 
			obs.passed = true
			score = score + #obs.body * level

			plus1Particle:setColors(obs.color[1], obs.color[2], obs.color[3], 255,
									obs.color[1], obs.color[2], obs.color[3], 0  )
			plus1Particle:setPosition(ball.body:getX(), ball.body:getY())
			plus1Particle:setEmissionRate(#obs.body * level)
			plus1Particle:start()--emit(5)

			if not powerUpActive and levels[level].toPass and blocksPassed > levels[level].toPass then level = level + 1 end
		end
	end
end

function obstacle:exists(name)
	return self.s[name] ~= nil
end

function obstacle:get(index)
	if not obstacle:exists(index) then
		error("obstacle " .. index .. " doesn't exist")
	end
	return self.s[index]
end

function obstacle:count()
	return #self.s
end

function obstacle:clear()
	for i, obs in ipairs(self.s) do
		for j, b in ipairs(obs.body) do
			if b:isDestroyed() then error(j .. " is Destroyed") end
			b:destroy()
		end
		obs.body = {}
		obs.shape = {}
		obs.fixture = {}
	end
	self.s = {}
	self.curBlock = 1
	self.toRemove = 1
	self.exceeded = false
end