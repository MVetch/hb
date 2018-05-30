scoreboard = {
	results = {},
	values = 5,
	filename = "records"
}

function scoreboard:load()
	local recordsEncoded = love.filesystem.read(self.filename)
	if recordsEncoded then
		self.results = json.decode(recordsEncoded)
	else
		self.results = {0}
	end
end

function scoreboard:write(value)
	table.insert(self.results, value)
	table.sort(self.results)
	if table.getn(self.results) > self.values then
		table.remove(self.results, 1)
	end
	love.filesystem.write(self.filename, json.encode(self.results))
end

function scoreboard:toString(index)
	local res = ""
	if not index then
		for i = table.getn(self.results), 1, -1 do
			res = res .. (table.getn(self.results) - i + 1) .. ". " .. self.results[i] .. "\n"
		end
	else
		if table.getn(self.results) > 0 then
			return self.results[table.getn(self.results) - index + 1]
		end
	end
	return res
end