width = 800
height = 800

p = love.physics
g = love.graphics
k = love.keyboard

o = objects

moveaug = 4

function generatePlatforms()
	--We will use six platforms
	o.platforms = {{},{},{},{},{},{}}
	math.randomseed(os.time())

	for i = 1, 6, 1 do
		local x = math.random(50,width-50)
		local dynoWidth = math.random(50, 300)
		--local y = math.random(50, height-100)
		o.platforms[i].body = p.newBody(world, x, 750-(i*100), "static")
		o.platforms[i].shape = p.newRectangleShape(dynoWidth, 30)
		o.platforms[i].fixture = p.newFixture(o.platforms[i].body, o.platforms[i].shape)
		o.platforms[i].fixture:setUserData("Block")
	end 
end

function love.load()
	--Create World
	p.setMeter(64) --The height of a meter in our world is 64px
	world = p.newWorld(0,9.81*p.getMeter(),true)--(gravity on the x axis, gravity on the y axis, whether the bodies are allowed to sleep)
	
	--Set the image for the sprite
	image = g.newImage("robot.png")

	--body: this is what gets affected by velocity, and it holds the X and Y. It's invisible. 
	--shape: this is the shape that you see. It's used for mass control, and collision.
	--fixture: this is what attaches the shape to the body. It's like in those cartoons when someone's 
	--invisible, and they throw paint on him so you can see him!

	--Add bodies, shapes and fixture
	o = {}

	--create the ground
	o.ground = {}
		o.ground.body = p.newBody(world, width/2, height-50/2, "static")--remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
		o.ground.shape = p.newRectangleShape(width*2,50) --(width, height)
		o.ground.fixture = p.newFixture(o.ground.body, o.ground.shape)--Attach shape to body
		o.player.fixture:setUserData("Ground")

	--Create the ball
	o.player = {}
		o.player.body = p.newBody(world, width/2, height/2, "dynamic")
		o.player.body:setMass(15)
		o.player.shape = p.newRectangleShape(24,60)
		o.player.fixture = p.newFixture(o.player.body, o.player.shape) --attach body to shape with a density of one (body, shape, density)
		o.player.fixture:setRestitution(0) --A small restitution means less bouncing
		o.player.body:setFixedRotation(true)
		o.player.jumping = false
		o.player.fixture:setUserData("Player")

	generatePlatforms()
	--initial graphics setup
	g.setBackgroundColor(0, 0, 0) --set the background color to a nice blue
	love.window.setMode(width, height) --set the window dimensions to 650 by 650 with no fullscreen, vsync on, and no antialiasing
end

function love.keyreleased(key)
	if key == "space" then
		if o.player.jumping == false then
			o.player.jumping = true
			o.player.body:applyForce(0,-10000)
		end
	end

	if key == "escape" then
      love.event.quit()
   end
end

function love.update(dt)
	local pla = o.player.body

	world:update(dt)--Update the world
	--[[
	if k.isDown("up") or k.isDown("w") then
		o.player.body:applyForce(0, -300) 
	end
	]]--

	--[[if k.isDown("down") or k.isDown("s") then
		o.player.body:applyForce(0, 300)
	end]]--

	if k.isDown("left") or k.isDown("a") then

		pla:setX(pla:getX()-moveaug) 
	end

	if k.isDown("right") or k.isDown("d") then
		--move = pla:g
		pla:setX(pla:getX()+moveaug) 
		--o.player.body:applyForce(300, 0)
	end
end
function love.draw()
	local b = o.player.body
	local playerTranslation = 800 - b:getY() - 300 
	love.graphics.translate(0, playerTranslation)

	g.setColor(255, 255, 255) -- set the drawing color to green for the ground
	g.polygon("fill", o.ground.body:getWorldPoints(o.ground.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates

	g.setColor(255, 255, 255) --set the drawing color to red for the ball
	--g.circle("fill", o.player.body:getX(), o.player.body:getY(), o.player.shape:getRadius())
	--g.draw( image, o.player.body:getX(), o.player.body:getY())
	
	g.draw(image, b:getX(), b:getY(), b:getAngle(), 1, 1, image:getWidth()/2, image:getHeight()/2)
	for i=1, 6, 1 do
		g.polygon("fill", o.platforms[i].body:getWorldPoints(o.platforms[i].shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates
	end
	
	love.graphics.print(b:getY(),0 ,0 )
	
end
