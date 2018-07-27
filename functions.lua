function string.width(text, fontSize)
	return utf8len(tostring(text))*(fontSize*0.835)
end

function tern ( cond , T , F )
    if cond then return T else return F end
end

function degToRad(deg)
	return deg*math.pi/180
end

function getPercent(value, percents)
	return value * percents / 100
end

function topLeft(value)
	love.graphics.setColor(0, 0, 0)
	love.graphics.print(value, 0, getPercent(h, 6.94))
end

function bottomLeft(value)
	love.graphics.setColor(255,255,255)
	love.graphics.print(value, y-50, 0)
end

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function sign(x)
  return (x<0 and -1) or 1
end

function between(a, x, b, includeL, includeR)
	return (includeL and a <= x or a < x) and (includeR and x <= b or x < b)
end