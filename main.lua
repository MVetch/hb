--love.window.setMode(406, 720, {resizable = false})
love.window.setMode(506, 900, {resizable = false})
--love.window.setMode(0, 0, {resizable = false})
require "functions"
require "variables"
require 'json.json'
local dirs = {
	"model",
	"screens",
	"objects"
}
require "world"
for i=1, #dirs, 1 do
	local files = love.filesystem.getDirectoryItems(dirs[i])
	for k, file in ipairs(files) do
		require(dirs[i] .. "/" .. file:sub(1,-5))
	end
end

function love.load()
	love.graphics.setBackgroundColor(BackgroundColor)
	--love.mouse.setGrabbed(true)
	scoreboard:load()

	ballParticles = love.graphics.newParticleSystem(ballParcticlePic, 500)
	ballParticles:setParticleLifetime(1, 2)
	ballParticles:setAreaSpread("ellipse", defaultBall.r, defaultBall.r)
	ballParticles:setRadialAcceleration(defaultBall.r, 400)
	ballParticles:setSpin(-20, 20)
	ballParticles:setColors(255, 255, 255, 255, 
							255, 255, 255, 0  )

	plus1Particle = love.graphics.newParticleSystem(plus1, 50)
	plus1Particle:setParticleLifetime(1.5)
	plus1Particle:setEmissionRate(5)
	plus1Particle:setEmitterLifetime(1)
	plus1Particle:setAreaSpread("ellipse", defaultBall.r * 5, defaultBall.r * 5)
	plus1Particle:setLinearAcceleration(0, -100)
	plus1Particle:stop()

	coinParticle = love.graphics.newParticleSystem(coin, 50)
	coinParticle:setParticleLifetime(1.5)
	coinParticle:setLinearAcceleration(0, -100)
	coinParticle:setSpin(-20, 20)
	coinParticle:setSizes(bonus.r * 2 / coin:getWidth())
	coinParticle:setColors(255, 255, 255, 255, 
						   255, 255, 255, 0  )
	

	if love.system.getOS() == "Android" then
		love.ads.createBanner(bannerId, "bottom")
		love.ads.requestInterstitial(interstitialId)
		love.ads.requestRewardedAd(rewardedAdId)
		love.ads.showBanner()
	end
end

function love.draw()
	cursor.x, cursor.y = love.mouse.getPosition()
	for name, params in screen:orderBy("z") do
		if screen:get(name).draw then screen:show(name) end
	end
end

function love.update(dt)
	if ball.dead then
		ballParticles:update(dt)
	else
		plus1Particle:update(dt)
	end
	coinParticle:update(dt)

	if screen:get("game").active then
		world:update(dt)
		ball:update(dt)
		bonus:update(dt)
		obstacle:update(dt)
	end
end

function love.run()

	local dt = 0	

	if love.load then love.load(arg) end
 
	if love.timer then love.timer.step() end

	while true do
		if love.event then
			love.event.pump()
			for name, a,b,c,d,e,f in love.event.poll() do
				if name == "quit" then
					if not love.quit or not love.quit() then
						return a
					end
				end
				love.handlers[name](a,b,c,d,e,f)
			end
		end
 
		if love.timer then
			love.timer.step()
			dt = love.timer.getDelta()
		end
 
		-- Call update and draw
		if love.update then love.update(dt) end -- will pass 0 if love.timer is disabled
 
		if love.graphics and love.graphics.isActive() then
			love.graphics.clear(love.graphics.getBackgroundColor())
			if love.draw then love.draw() end
			love.graphics.present()
		end
 
		--if love.timer then love.timer.sleep(1/FPS) end
	end
 
end