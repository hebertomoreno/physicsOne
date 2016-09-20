	--body: this is what gets affected by velocity, and it holds the X and Y. It's invisible. 
	--shape: this is the shape that you see. It's used for mass control, and collision.
	--fixture: this is what attaches the shape to the body. It's like in those cartoons when someone's 
	--invisible, and they throw paint on him so you can see him!

	--Create the Player
	o.player = {}
		o.player.body = p.newBody(world, width/2, height/2, "dynamic")
		o.player.body:setMass(15)
		o.player.shape = p.newRectangleShape(24,60)
		o.player.fixture = p.newFixture(o.player.body, o.player.shape) --attach body to shape with a density of one (body, shape, density)
		o.player.fixture:setRestitution(0) --A small restitution means less bouncing
		o.player.body:setFixedRotation(true) --no rotating
		o.player.jumping = false --will help us find out if our player is jumop
		o.player.fixture:setUserData("Player") --Give our object a name