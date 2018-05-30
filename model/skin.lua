skin = {
	s = {},
	default = {
		price = 10,
		draw = function() end
	},
	unlocked = {"blackCircle"}
}

function skin:add(name, params)
	self.s[name] = {}
	if not params then params = {} end
	for k,v in pairs(self.default) do
		self:get(name)[k] = params[k] or v
	end
	self:get(name).unlocked = params.unlocked == nil and true or params.unlocked
	self:get(name).particleColor = params.particleColor or {0, 0, 0}
	--self:get(name).sound:setLooping(true)
end

function skin:exists(name)
	return self.s[name] ~= nil
end

function skin:isUnlocked(name)
	for _,v in ipairs(self.unlocked) do
        if (v==name) then return true end
    end
    return false
end

function skin:getn()
	local n = 0
	for k, v in pairs(self.s) do
		n = n + 1
	end
	return n
end

function skin:buy(name)
	button:get(name .. "Buy").color = {100, 100, 100}
	button:get(name .. "Buy").active = false
	button:get(name .. "Switch").active = true
	button:get(name .. "Switch").color = {255, 0, 0}

	settings:set("coins", settings:get("coins") - self:get(name).price)
	self:get(name).unlocked = true

	for name, skinBody in pairs(self.s) do
		if skinBody.price > settings:get("coins") then
			button:get(name .. "Buy").color = {100, 100, 100}
			button:get(name .. "Buy").active = false
		end
	end

	table.insert(self.unlocked, name)
	love.filesystem.write("skins", json.encode(self.unlocked))
end

function skin:get(name)
	if not self:exists(name) then
		error("skin " .. name .. " doesn't exist")
	end
	return self.s[name]
end
local unlockedSkinsEncoded = love.filesystem.read("skins")
if unlockedSkinsEncoded then
	skin.unlocked = json.decode(unlockedSkinsEncoded)
end
skin:add(
	"blackCircle",
	{
		draw = function(x, y, r, c)
			if c then
				c[1] = math.max(0, math.min(c[1] + 0, 255))
				c[2] = math.max(0, math.min(c[2] + 0, 255))
				c[3] = math.max(0, math.min(c[3] + 0, 255))
			else
				c = {0, 0, 0}
			end
			love.graphics.setColor(c)
			drawable.ring(x, y, r, r / 2)
		end,
		particleColor = {0, 0, 0},
		unlocked = skin:isUnlocked("blackCircle"),
		price = 10,
	}
)
skin:add(
	"greenCircle",
	{
		draw = function(x, y, r, c)
			if c then
				c[1] = math.max(0, math.min(c[1] + 0, 255))
				c[2] = math.max(0, math.min(c[2] + 255, 255))
				c[3] = math.max(0, math.min(c[3] + 0, 255))
			else
				c = {0, 255, 0}
			end
			love.graphics.setColor(c)
			drawable.ring(x, y, r, r / 2)
		end,
		particleColor = {0, 255, 0},
		unlocked = skin:isUnlocked("greenCircle"),
		price = 10,
	}
)
skin:add(
	"blueCircle",
	{
		draw = function(x, y, r, c)
			if c then
				c[1] = math.max(0, math.min(c[1] + 0, 255))
				c[2] = math.max(0, math.min(c[2] + 0, 255))
				c[3] = math.max(0, math.min(c[3] + 255, 255))
			else
				c = {0, 0, 255}
			end
			love.graphics.setColor(c)
			drawable.ring(x, y, r, r / 2)
		end,
		particleColor = {0, 0, 255},
		unlocked = skin:isUnlocked("blueCircle"),
		price = 10,
	}
)
skin:add(
	"yellowCircle",
	{
		draw = function(x, y, r, c)
			if c then
				c[1] = math.max(0, math.min(c[1] + 214, 255))
				c[2] = math.max(0, math.min(c[2] + 211, 255))
				c[3] = math.max(0, math.min(c[3] + 11, 255))
			else
				c = {214, 211, 11}
			end
			love.graphics.setColor(c)
			drawable.ring(x, y, r, r / 2)
		end,
		particleColor = {214, 211, 11},
		unlocked = skin:isUnlocked("yellowCircle"),
		price = 10,
	}
)
skin:add(
	"purpleCircle",
	{
		draw = function(x, y, r, c)
			if c then
				c[1] = math.max(0, math.min(c[1] + 255, 255))
				c[2] = math.max(0, math.min(c[2] + 0, 255))
				c[3] = math.max(0, math.min(c[3] + 255, 255))
			else
				c = {255, 0, 255}
			end
			love.graphics.setColor(c)
			drawable.ring(x, y, r, r / 2)
		end,
		particleColor = {255, 0, 255},
		unlocked = skin:isUnlocked("purpleCircle"),
		price = 10,
	}
)
skin:add(
	"yinYang",
	{
		draw = function(x, y, r, c)
			if c then
				c[1] = math.max(0, math.min(c[1] + 255, 255))
				c[2] = math.max(0, math.min(c[2] + 255, 255))
				c[3] = math.max(0, math.min(c[3] + 255, 255))
			else
				c = {255, 255, 255}
			end
			love.graphics.setColor(c)
			love.graphics.draw(skinYinYang, x, y, ball.body:getAngle(), 2 * r / skinYinYang:getWidth(), 2 * r / skinYinYang:getHeight(), skinYinYang:getWidth()/2, skinYinYang:getHeight()/2)
		end,
		particleColor = {0, 0, 0},
		unlocked = skin:isUnlocked("yinYang"),
		price = 35,
	}
)
skin:add(
	"yellowFace",
	{
		draw = function(x, y, r, c)
			if c then
				c[1] = math.max(0, math.min(c[1] + 255, 255))
				c[2] = math.max(0, math.min(c[2] + 255, 255))
				c[3] = math.max(0, math.min(c[3] + 255, 255))
			else
				c = {255, 255, 255}
			end
			love.graphics.setColor(c)
			love.graphics.draw(skinYellowFace, x, y, ball.body:getAngle(), 2 * r / skinYinYang:getWidth(), 2 * r / skinYinYang:getHeight(), skinYinYang:getWidth()/2, skinYinYang:getHeight()/2)
		end,
		particleColor = {214, 211, 11},
		unlocked = skin:isUnlocked("yellowFace"),
		price = 50,
	}
)
skin:add(
	"footBall",
	{
		draw = function(x, y, r, c)
			if c then
				c[1] = math.max(0, math.min(c[1] + 255, 255))
				c[2] = math.max(0, math.min(c[2] + 255, 255))
				c[3] = math.max(0, math.min(c[3] + 255, 255))
			else
				c = {255, 255, 255}
			end
			love.graphics.setColor(c)
			love.graphics.draw(skinFootBall, x, y, ball.body:getAngle(), 2 * r / skinYinYang:getWidth(), 2 * r / skinYinYang:getHeight(), skinYinYang:getWidth()/2, skinYinYang:getHeight()/2)
		end,
		particleColor = {100, 100, 100},
		unlocked = skin:isUnlocked("footBall"),
		price = 20,
	}
)
skin:add(
	"basketBall",
	{
		draw = function(x, y, r, c)
			if c then
				c[1] = math.max(0, math.min(c[1] + 255, 255))
				c[2] = math.max(0, math.min(c[2] + 255, 255))
				c[3] = math.max(0, math.min(c[3] + 255, 255))
			else
				c = {255, 255, 255}
			end
			love.graphics.setColor(c)
			love.graphics.draw(skinBasketBall, x, y, ball.body:getAngle(), 2 * r / skinYinYang:getWidth(), 2 * r / skinYinYang:getHeight(), skinYinYang:getWidth()/2, skinYinYang:getHeight()/2)
		end,
		particleColor = {255, 99, 0},
		unlocked = skin:isUnlocked("basketBall"),
		price = 20,
	}
)
skin:add(
	"volleyBall",
	{
		draw = function(x, y, r, c)
			if c then
				c[1] = math.max(0, math.min(c[1] + 255, 255))
				c[2] = math.max(0, math.min(c[2] + 255, 255))
				c[3] = math.max(0, math.min(c[3] + 255, 255))
			else
				c = {255, 255, 255}
			end
			love.graphics.setColor(c)
			love.graphics.draw(skinVolleyBall, x, y, ball.body:getAngle(), 2 * r / skinYinYang:getWidth(), 2 * r / skinYinYang:getHeight(), skinYinYang:getWidth()/2, skinYinYang:getHeight()/2)
		end,
		particleColor = {214, 211, 11},
		unlocked = skin:isUnlocked("volleyBall"),
		price = 20,
	}
)
skin:add(
	"eightBall",
	{
		draw = function(x, y, r, c)
			if c then
				c[1] = math.max(0, math.min(c[1] + 255, 255))
				c[2] = math.max(0, math.min(c[2] + 255, 255))
				c[3] = math.max(0, math.min(c[3] + 255, 255))
			else
				c = {255, 255, 255}
			end
			love.graphics.setColor(c)
			love.graphics.draw(skinEightBall, x, y, ball.body:getAngle(), 2 * r / skinYinYang:getWidth(), 2 * r / skinYinYang:getHeight(), skinYinYang:getWidth()/2, skinYinYang:getHeight()/2)
		end,
		particleColor = {0, 0, 0},
		unlocked = skin:isUnlocked("eightBall"),
		price = 20,
	}
)