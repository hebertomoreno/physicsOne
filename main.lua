width = 800
height = 800
jumpForce = 12000

p = love.physics
g = love.graphics
k = love.keyboard

o = objects

moveaug = 4

function love.load()
	--Create World
	p.setMeter(64) --The height of a meter in our world is 64px
	world = p.newWorld(0,9.81*p.getMeter(),true)--(gravity on the x axis, gravity on the y axis, whether the bodies are allowed to sleep)
		
		--set the callbacks for collision detection
		--beginContact gets called when two fixtures start overlapping (two objects collide).
		--endContact gets called when two fixtures stop overlapping (two objects disconnect).
		--preSolve is called just before a frame is resolved for a current collision
		--postSolve is called just after a frame is resolved for a current collision.
		world:setCallbacks(beginContact, endContact, preSolve, postSolve)

	--Set the image for the sprite
	image = g.newImage("robot.png")

	--Add bodies, shapes and fixture
	require "objects"
	require "ground"
	require "player"
	require "blocks"
	--generatePlatforms()

	--initial graphics setup
	g.setBackgroundColor(0, 0, 0) --set the background color to a nice blue
	love.window.setMode(width, height) --set the window dimensions to 650 by 650 with no fullscreen, vsync on, and no antialiasing
end

function love.keyreleased(key)
	if key == "space" then
		if o.player.jumping == false then
			o.player.body:applyForce(0,-jumpForce)
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

	if pla:getX() < 0 then
		pla:setX(790) 
	elseif pla:getX() > 800 then
		pla:setX(10) 
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
	for i=1, 15, 1 do
		g.polygon("fill", o.platforms[i].body:getWorldPoints(o.platforms[i].shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates
	end
	
	love.graphics.print(b:getY(),0 ,0 )
	
end


function beginContact(a, b, coll)
	if 	a:getUserData() == "Ground" or 
		b:getUserData()== "Ground" or 
		a:getUserData() == "Block" or 
		b:getUserData() == "Block" then

		o.player.jumping = false
	end
end
 
function endContact(a, b, coll)
	o.player.jumping = true
	o.player.body:applyForce(0,-10)
end
 
function preSolve(a, b, coll)
 
end
 
function postSolve(a, b, coll, normalimpulse, tangentimpulse)
	o.player.body:applyForce(0,-10)
end
