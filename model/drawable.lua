drawable = {

	ring = function(x, y, radius, width)
		width = width or 1
		love.graphics.setLineWidth(width)
		love.graphics.circle("line", x, y, radius - math.floor(width / 2))
		love.graphics.setLineWidth(1)
	end,

	arc = function(x, y, radius, angle1, angle2, width)
		width = width or 1
		love.graphics.setLineWidth(width)
		love.graphics.arc("line", "open", x, y, radius - math.floor(width / 2), angle1, angle2)
		love.graphics.setLineWidth(1)
	end,

	border = function(x, y, w, h, b)
		love.graphics.rectangle("fill", x, y, b.left, h)
		love.graphics.rectangle("fill", x, y, w, b.top)
		love.graphics.rectangle("fill", x + w-b.right, y, b.right, h)
		love.graphics.rectangle("fill", x, y + h-b.bottom, w, b.bottom)
	end,

	circle = function(x, y, radius)
		love.graphics.circle("fill", x, y, radius)
	end,

	triangle = function(leftSideX, leftSideY, centerX, centerY, rightSideX, rightSideY)
		love.graphics.polygon(
			"fill", 
			leftSideX,
			leftSideY,
			centerX,
			centerY,
			rightSideX,
			rightSideY
		)
	end
}