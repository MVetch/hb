timer = {
	timeStart = 0,
	timeEnd = 0,
	time = 0,
	isGoing = false,
	paused = false
}

function timer:start()
	if self.paused then
		self.paused = false
		self.timeStart = self.timeStart + love.timer.getTime() - self.timeEnd
	else
		self.timeStart = love.timer.getTime()
	end
	self.isGoing = true
end

function timer:pause()
	self.paused = true
	self.isGoing = false
	self.timeEnd = love.timer.getTime()
end

function timer:stop()
	self.timeEnd = love.timer.getTime()
	self.time = timer:get()
	self.isGoing = false
	self.paused = false
end

function timer:print()
	if self.isGoing then
		return string.format("%.2f", love.timer.getTime() - self.timeStart)
	end
	return string.format("%.2f", self.timeEnd - self.timeStart)
end
function timer:get()
	if self.isGoing then
		return love.timer.getTime() - self.timeStart
	end
	return self.timeEnd - self.timeStart
end

function timer:reset()
	self.timeStart = self.timeEnd
	self.isGoing = false
end