width = 650
height = 650

p = love.physics
g = love.graphics
k = love.keyboard

o = objects

function love.load()
	--Create World
	p.setMeter(65) --The height of a meter in our world is 64px
	world = p.newWorld(0,9.81*p.getMeter(),true)--(gravity on the x axis, gravity on the y axis, whether the bodies are allowed to sleep)
	
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

	--Create the ball
	o.ball = {}
	o.ball.body = p.newBody(world, width/2, height/2, "dynamic")
	o.ball.shape = p.newCircleShape(20)--We just declare the radius, because x, y, and the world have already been set by the body
	o.ball.fixture = p.newFixture(o.ball.body, o.ball.shape) --attach body to shape with a density of one (body, shape, density)
	o.ball.fixture:setRestitution(0.8) --let the ball bounce

	--initial graphics setup
	g.setBackgroundColor(0, 0, 0) --set the background color to a nice blue
	love.window.setMode(width, height) --set the window dimensions to 650 by 650 with no fullscreen, vsync on, and no antialiasing
end

function love.update(dt)
	world:update(dt)--Update the world

	if k.isDown("up") or k.isDown("w") then
		o.ball.body:applyForce(0, -300) 
	end

	if k.isDown("down") or k.isDown("s") then
		o.ball.body:applyForce(0, 300)
	end

	if k.isDown("left") or k.isDown("a") then
		o.ball.body:applyForce(-300, 0)
	end

	if k.isDown("right") or k.isDown("d") then
		o.ball.body:applyForce(300, 0)
	end
end
function love.draw()
	g.setColor(255, 255, 255) -- set the drawing color to green for the ground
	g.polygon("fill", o.ground.body:getWorldPoints(o.ground.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates

	g.setColor(255, 255, 255) --set the drawing color to red for the ball
	--g.circle("fill", o.ball.body:getX(), o.ball.body:getY(), o.ball.shape:getRadius())
	g.draw( image, o.ball.body:getX(), o.ball.body:getY())
end
