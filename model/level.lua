level = {
	SPB = SPB,
	dSPB = SPB,
	velocity = getPercent(h, 13.8), --100,
	dvelocity = getPercent(h, 13.8),
	minSides = 1,
	maxSides = 1,
	movable = false,
	minHoleSize = defaultHoleSize * 1,
	maxHoleSize = defaultHoleSize * 1,
	toPass = 5,
	blocksPassed = 0,
	percent = 0,
	angularSpeed = 0,
	number = 1
}

function level:up()
	self.number = self.number + 1

	self.SPB = self.SPB
	self.dSPB = self.dSPB
	self.velocity  = math.min(self.dvelocity * 1.05, getPercent(h, 34.72)) --max = 250 (h = 720)
	self.dvelocity = math.min(self.dvelocity * 1.05, getPercent(h, 34.72))
	self.angularSpeed = math.min(self.angularSpeed + math.floor(self.number / 5) * math.pi / 6, math.pi)
	self.minSides = math.min(self.minSides + 0.5  / math.ceil(self.number / 5), 6)
	self.maxSides = math.min(self.maxSides + 0.75 / math.ceil(self.number / 5), 6)
	self.movable = false
	self.minHoleSize = defaultHoleSize * math.max((10 - self.number - 2) / 10, 0.3)
	self.maxHoleSize = defaultHoleSize * math.max((10 - self.number) / 10, 0.3)
	self.toPass = 5 * math.ceil(self.number / 5)
	self.blocksPassed = 0
	self.percent = 0
end

function level:update(dt)
	if self.blocksPassed / self.toPass > self.percent then self.percent = self.percent + dt end
	if self.percent >= 1 then self:up() end
end

function level:reset()
	self.SPB = SPB
	self.velocity = getPercent(h, 13.8)
	self.dSPB = SPB
	self.dvelocity = getPercent(h, 13.8)
	self.angularSpeed = 0
	self.minSides = 1
	self.maxSides = 1
	self.movable = false
	self.minHoleSize = defaultHoleSize * 1
	self.maxHoleSize = defaultHoleSize * 1
	self.toPass = 5
	self.number = 1
	self.blocksPassed = 0
	self.percent = 0
end