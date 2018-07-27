click = {X = 0, Y = 0}
function love.mousepressed(clickX, clickY, buttonClick, istouch)
	click.X = clickX
	click.Y = clickY
	local buttonClicked = false
	local activeScreens = {}
	for name, s in pairs(screen.s) do
		if s.active then
			table.insert(activeScreens, name)
		end
	end
	if buttonClick == 1 then
		for _, s in ipairs(activeScreens) do
			for k,b in pairs(screen:get(s).buttons) do
				if button:get(b).active and click.inside(b) then
					button:click(b)
					buttonClicked = true
					break
				end
			end
		end
		
		if not buttonClicked and screen:get("game").active then
			if click.X > w / 2 then
				ball.body:applyLinearImpulse( force, -force/4*3, ball.body:getX() - ball.shape:getRadius() / 100, ball.body:getY() - ball.shape:getRadius() / 100)
			else
				ball.body:applyLinearImpulse(-force, -force/4*3, ball.body:getX() + ball.shape:getRadius() / 100, ball.body:getY() - ball.shape:getRadius() / 100)
			end
		end
	end
end

function love.mousereleased(clickX, clickY, buttonClick, istouch)
	local activeScreens = {}
	for name, s in pairs(screen.s) do
		if s.active then
			table.insert(activeScreens, name)
		end
	end
	if buttonClick == 1 then
		for _, s in ipairs(activeScreens) do
			for k, b in pairs(screen:get(s).buttons) do
				if button:get(b).active and click.inside(b) then
					button:release(b)
					break
				end
			end
		end
	end
end

function click.inside(name)
	return  click.X > button:get(name).X + screen:get(button:get(name).screen).X
		and click.X < button:get(name).X + screen:get(button:get(name).screen).X + button:get(name).width
		and click.Y > button:get(name).Y + screen:get(button:get(name).screen).Y
		and click.Y < button:get(name).Y + screen:get(button:get(name).screen).Y + button:get(name).height 
end

function love.keypressed( key, scancode, isrepeat )
	if screen.s.menu.active then
		if key == "escape" then 
			love.event.quit() 
			elseif key == "return" then 
				button:get("newGame"):onclick()
		end
	elseif screen.s.game.active then
		if key == "left" then 
			ball.body:applyLinearImpulse(-force, -force/4*3, ball.body:getX() + ball.shape:getRadius() / 100, ball.body:getY() - ball.shape:getRadius() / 100) 
		elseif key == "right" then 
			ball.body:applyLinearImpulse( force, -force/4*3, ball.body:getX() - ball.shape:getRadius() / 100, ball.body:getY() - ball.shape:getRadius() / 100)
		elseif key == "escape" then
			button:get("pauseGame"):onclick()
		end
	end
end

function love.focus(f)
	if not f and not showingAd then button:get("pauseGame"):onclick() end
end

function love.rewardUserWithReward(rewardType, rewardQuantity)
	settings:set("coins", settings:get("coins") + 10) --+10 coins
end

function love.rewardedAdFailedToLoad()
	love.ads.requestRewardedAd(rewardedAdId)
end

function love.interstitialFailedToLoad()
	love.ads.requestInterstitial(interstitialId)
end

function love.interstitialClosed()
	showingAd = false
end

function love.rewardedAdDidStop()
	showingAd = false
end