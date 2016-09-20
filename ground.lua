	--body: this is what gets affected by velocity, and it holds the X and Y. It's invisible. 
	--shape: this is the shape that you see. It's used for mass control, and collision.
	--fixture: this is what attaches the shape to the body. It's like in those cartoons when someone's 
	--invisible, and they throw paint on him so you can see him!
	
	--create the Ground
	o.ground = {}
		o.ground.body = p.newBody(world, width/2, height-50/2, "static")--remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
		o.ground.shape = p.newRectangleShape(width*2,50) --(width, height)
		o.ground.fixture = p.newFixture(o.ground.body, o.ground.shape)--Attach shape to body
		o.ground.fixture:setUserData("Ground")