slider = {
	s = {},
	default = {
		slideCount = 5,
		backgroundColor = {0,0,0},
		multiple = false,
		activeFrom = 1
	}
}

function slider:add(name, params)
	self.s[name] = {}
	if not params then params = {} end
	for k,v in pairs(self.default) do
		self:get(name)[k] = params[k] or v
	end
	self.s[name].slides = {}
end

function slider:exists(name)
	return slider:get(name) ~= nil
end

function slider:get(name)
	return self.s[name]
end

function slider:draw(name, X, Y, w)
	love.graphics.setColor(self:get(name).backgroundColor)
	local sliderButtonWidth = 0
	if self:get(name).slideCount < table.getn(self:get(name).slides) then
		sliderButtonWidth = 30
	end
	local w = w - 2*sliderButtonWidth
	local h = w/self:get(name).slideCount
	love.graphics.rectangle("fill", X, Y, sliderButtonWidth, h)
	love.graphics.rectangle("fill", X, Y, w, h)
	for i = self:get(name).activeFrom, math.min(self:get(name).slideCount + self:get(name).activeFrom - 1, table.getn(self:get(name).slides)), 1 do
		slide:draw(
			self:get(name).slides[i],
			X + sliderButtonWidth + (i - self:get(name).activeFrom)*h,
			Y,
			h,
			h
		)
	end
	love.graphics.setColor(self:get(name).backgroundColor)
	love.graphics.rectangle("fill", X + w + sliderButtonWidth, Y, sliderButtonWidth, h)
	if love.mouse.isDown(1) then
		if hovered(X, Y, sliderButtonWidth, h) then
			if self:get(name).activeFrom > 1 then
				self:get(name).activeFrom = self:get(name).activeFrom - 1
			end
		elseif hovered(X + w + sliderButtonWidth, Y, sliderButtonWidth, h) then
			if self:get(name).activeFrom <= table.getn(self:get(name).slides) - self:get(name).slideCount then
				self:get(name).activeFrom = self:get(name).activeFrom + 1
			end
		end
	end
end

-- function slider:getVisible(name)
-- 	local j = 1
-- 	local iter = function()
		
-- 	end
-- 	return iter
-- end