
function love.load()
	math.randomseed(os.time())
	require("Functions")
	require("Branch")
	require("config")
	require("gradient")
	require("camera")
	Vector = require "vector"
	love.window.setMode( 1900, 1000)
	height = love.graphics.getHeight()
	width = love.graphics.getWidth()
	--horizon stuff
	sky = gradient {
	direction = 'horizontal';
	{253,229,211};
	{67,133,166};
	{31,34,69};
	{10,11,23};
	{0, 0, 0};
	}
	local screen_width, screen_height = love.graphics.getDimensions()
	local max_stars = 400   -- how many stars we want
	stars = {}
	for i=1, max_stars do   -- generate the coords of our stars
		local x = love.math.random(-width, 2*width)   -- generate a "random" number for the x coord of this star
		local y = love.math.random(-5, -4*height-5)   -- both coords are limited to the screen size, minus 5 pixels of padding
		local bright = map(y, -5, -height-5, 100, 255)
		stars[i] = {x, y, bright}   -- stick the values into the table
	end
	--end of horizon
	tree = {}
	count = 1
	wind=0
	clicked=false
end

function love.mousepressed(x, y, button)
	if button == 2 then
		--print(#tree)
		count=count+1
		for i=#tree,1,-1 do
			if (not tree[i].finished) then
				tree[i].branch()
			end
			tree[i].finished = true;
		end
		print(#tree)
	end
	--[[elseif button == 1 then
		
		print(mapx,mapy)
		print(x,y)
		origx = x-mapx
		origy = y-mapy
		clicked = true
	end]]--

end

function love.wheelmoved( x, y )
	camera.zoom(x, y)
end

function love.mousemoved(x, y, dx, dy, istouch)
	-- body
	camera.mousemoved(x, y, dx, dy, istouch)
end
function love.keypressed(key)
	-- body
	if key=="c" then
		count=1
		tree={}
		local a = Vector.new(width / 2, height*3/4)
		local b = Vector.new(width / 2, height*3/4- config.trunkLength)
		tree[1]=Branch(a, b, 1, 0)
	elseif key=="`" then
		--do
		debug.debug()
	elseif key == "w" then
		config.sway = not config.sway
	end
end
function love.mousereleased(x,y,button)
	-- body
end


function love.draw()
	love.graphics.setColor(255, 255, 255, 255)
	camera.transformation()
	love.graphics.draw(sky, -smoothMapx, height*3/4, 0, width*smoothScale, config.horizonScale)
	--love.graphics.setColor(10,11,23, 255)
	--love.graphics.setColor(0, 0, 0)
	--love.graphics.rectangle("fill", -smoothMapx, (height*3/4)+config.horizonScale*5, width*smoothScale, -smoothMapy)
	love.graphics.setColor(255, 255, 255, 255)
	for i, star in ipairs(stars) do   -- loop through all of our stars
		love.graphics.setColor(255, 255, 255, star[3])
    	love.graphics.points(star[1], star[2])   -- draw each point
   	end

	for i=1,#tree do
		tree[i].show();
		tree[i].jitter();
		if config.sway then
			--tree[i].angleJitter(math.cos(wind)/500)
		end
	end
	
	--love.graphics.draw(drawable, x, y, r, sx, sy, ox, oy, kx, ky)
end

function love.update(dt)
	delta = dt  
	wind=wind+dt
	camera.smooth(dt)
	for i=1,#tree do
		tree[i].smoothBack.x = tree[i].smoothBack.x - ((tree[i].smoothBack.x - tree[i].back.x)*dt*10)
		tree[i].smoothBack.y = tree[i].smoothBack.y - ((tree[i].smoothBack.y - tree[i].back.y)*dt*10)
	end
	--[[if love.mouse.isDown(1) and clicked then
		local x, y = love.mouse.getPosition()
		mapx=(x-origx)/scale
		mapy=(y-origy)/scale
	end]]--
	
end
