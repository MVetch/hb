function beginContact(a, b, coll)
	local x,y = coll:getNormal()
	--debug = debug.."\n"..a:getUserData().." with "..b:getUserData().." vector="..string.format("%.2f", x)..", "..string.format("%.2f", y)
	if not ball.immortal and b:getUserData() == "ball" then
	--if a:getUserData() == "ball1" or b:getUserData() == "ball1" then
		local diff = ((math.deg(math.acos(x) * sign(y)) - math.deg(a:getBody():getAngle()) + 180) % 360 - 180)
		if a:getUserData() == "obstacle bottom" then
			--debug = debug.."\n".."vector="..string.format("%.2f", x)..", "..string.format("%.2f", y)..", angleV="..string.format("%.2f", (math.deg(math.acos(x) * sign(y))))..", angleB="..string.format("%.2f", math.deg(a:getBody():getAngle()))..", diff="..string.format("%.2f", diff)
		    if between(45,   diff, 135) then 
		    	die()
		    end
		elseif a:getUserData() == "obstacle top" then
			--debug = debug.."\n".."vector="..string.format("%.2f", x)..", "..string.format("%.2f", y)..", angleV="..string.format("%.2f", (math.deg(math.acos(x) * sign(y))))..", angleB="..string.format("%.2f", math.deg(a:getBody():getAngle()))..", diff="..string.format("%.2f", diff)
			if between(-135, diff, -45) then 
		    	die()
		    end
		elseif a:getUserData() == "ground" then
			--debug = debug.."\n"..a:getUserData().." with "..b:getUserData().." vector="..string.format("%.2f", x)..", "..string.format("%.2f", y)
			if y < -0.99 then
				die()
			end
		end
	end
	if a:getUserData() == "ball" then
		if b:getUserData() == "bonus" then
			settings:set("coins", settings:get("coins") + 1)
			for name, skinBody in pairs(skin.s) do
				if not skinBody.unlocked and skinBody.price <= settings:get("coins") then
					button:get(name .. "Buy").color = {255, 0, 0}
					button:get(name .. "Buy").active = true
				end
			end
			coinParticle:setPosition(bonus.body:getX(), bonus.body:getY())
			coinParticle:emit(1)
			bonus:destroy()
		end
	end
end
 
function endContact(a, b, coll)
    --debug = debug.."\n"..a:getUserData().." uncolliding with "..b:getUserData()
end
 
function preSolve(a, b, coll)
end
 
function postSolve(a, b, coll, normalimpulse, tangentimpulse)
end
world = love.physics.newWorld(xg, yg, true)
world:setCallbacks(beginContact, endContact, preSolve, postSolve)

function die()
	ball.dead = true
	screen:get("game").active = false
	screen:get("menu").draw   = true
	screen:get("menu").active = true

	button:get("pauseGame").draw   = false
	button:get("pauseGame").active = false

	timer:stop()
	scoreboard:write(score)
	button:get("continueGame").draw = false
	button:get("continueGame").active = false

	ballParticles:emit(30)

	coinParticle:setPosition(ball.body:getX(), ball.body:getY())
	coinParticle:setAreaSpread("ellipse", defaultBall.r * 5, defaultBall.r * 5)
	coinParticle:emit(math.floor(score / 50))
	settings:set("coins", settings:get("coins") + math.floor(score / 100))
	coinParticle:setAreaSpread("uniform", 0, 0)

	if love.system.getOS() == "Android" then 
		if love.ads.isInterstitialLoaded() then
			showingAd = true
			love.ads.showInterstitial()
		else
			love.ads.requestInterstitial(interstitialId)
		end
	end
end