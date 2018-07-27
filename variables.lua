version = 0.2
---------------essential-----------------
if love.math then
	love.math.setRandomSeed(os.time())
end

-- bannerId = "ca-app-pub-5592532272896790/4309530586"
-- interstitialId = "ca-app-pub-5592532272896790/4331922755"
-- rewardedAdId = "ca-app-pub-5592532272896790/1073659439"

bannerId = "ca-app-pub-3940256099942544/6300978111"
interstitialId = "ca-app-pub-3940256099942544/1033173712"
rewardedAdId = "ca-app-pub-3940256099942544/5224354917"
showingAd = false

w = love.graphics.getWidth()
h = love.graphics.getHeight()
fontSize = getPercent(w, 3.125)
BackgroundColor = {255, 255, 255}

	---------------sounds---------------
-- soundCircle = love.audio.newSource("sound/wheel.wav")
	---------------/sounds---------------

	---------------pics---------------
-- soundOnPic = love.graphics.newImage("img/soundOn.png")
ballParcticlePic = love.graphics.newImage("img/ballParticle.png")
plus1            = love.graphics.newImage("img/plus1.png")
coin             = love.graphics.newImage("img/coin.png")

arrowUpPic       = love.graphics.newImage("img/arrow-up.png")

spincoinAnimate  = love.graphics.newImage("img/spincoinAnimate.png")
arrowUpAnimate   = love.graphics.newImage("img/arrow-up-animated.png")
firePic          = love.graphics.newImage("img/fire.png")
fireTopPic       = love.graphics.newImage("img/fireTop.png")

skinBlackCircle  = love.graphics.newImage("img/blackCircle.png")
skinRedCircle    = love.graphics.newImage("img/redCircle.png")
skinYinYang      = love.graphics.newImage("img/yinyang.png")
skinYellowFace   = love.graphics.newImage("img/yellowFace.png")
skinFootBall     = love.graphics.newImage("img/football.png")
skinBasketBall   = love.graphics.newImage("img/basketball.png")
skinVolleyBall   = love.graphics.newImage("img/volleyball.png")
skinEightBall    = love.graphics.newImage("img/eightBall.png")
	---------------/pics---------------
xg = 0
yg = love.physics.getMeter() * 9.81
---------------/essential-----------------

---------------fonts-----------------
buttonFont = love.graphics.newFont("fonts/joystix monospace.ttf", fontSize)
scoreFont  = love.graphics.newFont("fonts/joystix monospace.ttf", fontSize * 2)
bestFont   = love.graphics.newFont("fonts/joystix monospace.ttf", fontSize / 1.5)
titleFont  = love.graphics.newFont("fonts/joystix monospace.ttf", fontSize * 0.75)
---------------/fonts-----------------

---------------game-----------------

cursor = {}
cursor.x, cursor.y = love.mouse.getPosition()
blocksPassed = 0
blocksGenedWOutPowerUp = 0
BPL = 10--block per level
FPS = 600
SPB = 4--seconds per block
lastGenedBlock = -SPB
debug = ""
score = 0
dp = h / love.window.getPixelScale()
adHeight = dp <= 400 and 32 or (dp > 400 and dp <= 720) and 50 or 90
adHeight = adHeight * love.window.getPixelScale()

defaultBall = {
	r = getPercent(math.min(w, h), 2.25), --9..,
	x = w/2,
	y = h/2,
	dead = false
}
force = 0.7 * defaultBall.r * defaultBall.r
defaultHoleSize = defaultBall.r * 15

heatedHeight = defaultBall.r * 5


-- levels = {
-- 	{
-- 		SPB = SPB,
-- 		velocity = getPercent(h, 13.8), --100,
-- 		minSides = 1,
-- 		maxSides = 1,
-- 		movable = false,
-- 		minHoleSize = defaultHoleSize * 1,
-- 		maxHoleSize = defaultHoleSize * 1,
-- 		toPass = 5
-- 	},
-- 	{
-- 		SPB = SPB,
-- 		velocity = getPercent(h, 15.27), --110,
-- 		minSides = 1,
-- 		maxSides = 2,
-- 		movable = false,
-- 		minHoleSize = defaultHoleSize * 0.8,
-- 		maxHoleSize = defaultHoleSize * 1,
-- 		toPass = 5
-- 	},
-- 	{
-- 		SPB = SPB,
-- 		velocity = getPercent(h, 16.66), --120,
-- 		minSides = 2,
-- 		maxSides = 3,
-- 		movable = false,
-- 		minHoleSize = defaultHoleSize * 0.6,
-- 		maxHoleSize = defaultHoleSize * 0.8,
-- 		toPass = 5
-- 	},
-- 	{
-- 		SPB = SPB,
-- 		velocity = getPercent(h, 18.046), --130,
-- 		minSides = 3,
-- 		maxSides = 4,
-- 		movable = false,
-- 		minHoleSize = defaultHoleSize * 0.4,
-- 		maxHoleSize = defaultHoleSize * 0.6,
-- 		toPass = 5
-- 	},
-- 	{
-- 		SPB = SPB,
-- 		velocity = getPercent(h, 19.426), --140,
-- 		minSides = 4,
-- 		maxSides = 4,
-- 		movable = false,
-- 		minHoleSize = defaultHoleSize * 0.3,
-- 		maxHoleSize = defaultHoleSize * 0.4,
-- 		--toPass = 5
-- 	},
-- }

---------------/game-----------------