screen = {
	default = {
		X = 0,
		Y = 0,
		w = w,
		h = h,
		draw = false,
		z = 1,
		active = false,
		show = function() end
	},
	s = {}
}

function screen:new(name, params)
	self.s[name] = {}
	if not params then params = {} end
	for k,v in pairs(screen.default) do
		self.s[name][k] = params[k] or v
	end
	self.s[name].buttons = {}
end

function screen:show(name)
	if name == nil then error("oops") end
	love.graphics.translate(screen:get(name).X, screen:get(name).Y)
	cursor.x = cursor.x - screen:get(name).X
	cursor.y = cursor.y - screen:get(name).Y
	screen:get(name):show()
	for index, b in ipairs(screen:get(name).buttons) do
		if button:get(b).draw then
			button:draw(b)
		end
	end
	love.graphics.origin()
	cursor.x = cursor.x + screen:get(name).X
	cursor.y = cursor.y + screen:get(name).Y
end

function screen:get(name)
	if not screen:exists(name) then
		error("screen " .. name .. " doesn't exist")
	end
	return self.s[name]
end

function screen:exists(name)
	return self.s[name] ~= nil
end

function screen:orderBy(key, order)
	if order then
		order = order:lower()
	else
		order = "asc"
	end
	local values = {}
	local keys = {}
	for k,v in pairs(self.s) do
		table.insert(values, v[key])
		table.insert(keys, k)
	end
	for i = 1, table.getn(values), 1 do
		for j = 1, table.getn(values), 1 do
			if((order == "asc" and values[j] > values[i]) or (order == "desc" and values[j] < values[i])) then
				temp = values[i]
				values[i] = values[j]
				values[j]= temp
				temp = keys[i]
				keys[i] = keys[j]
				keys[j]= temp
			end
		end
	end
	local k = 0
	local iter = function()   -- iterator function
		k = k + 1
		if keys[k] == nil then return nil
		else return keys[k], self.s[keys[k]]
		end
	end
	return iter
end