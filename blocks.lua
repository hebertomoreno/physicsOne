	--We will use fifteen platforms
	o.platforms = {{},{},{},{},{},{},{},{},{},{},{},{},{},{},{}}
	math.randomseed(os.time())

	for i = 1, 15, 1 do
		local x = math.random(50,width-50)
		local dynoWidth = math.random(50, 300)
		--local y = math.random(50, height-100)
		o.platforms[i].body = p.newBody(world, x, 750-(i*100), "static")
		o.platforms[i].shape = p.newRectangleShape(dynoWidth, 30)
		o.platforms[i].fixture = p.newFixture(o.platforms[i].body, o.platforms[i].shape)
		o.platforms[i].fixture:setUserData("Block")
	end 