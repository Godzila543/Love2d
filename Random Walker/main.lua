function love.load()
	package.path="c:/Users/Colin/Google Drive/Love 2D/Live Sync/Modules/?.lua;"
	require("camera")
	camera.on=false
	require("shape")
	vector = require"vector"
	require("Functions")
	love.window.setMode( 800, 800)
	height = love.graphics.getHeight()
	width = love.graphics.getWidth()
	canvas = love.graphics.newCanvas()
	clear=false
	walker=vector.new(width/2,height/2)
	speed=10000
end

function love.draw()
	if camera.on then camera.transformation() end
	love.graphics.setColor(255, 255, 255, 50)
	love.graphics.draw( canvas )
end

function love.update(dt)
	delta = dt
	if camera.on then camera.smooth(dt) end
    for i=1,speed do
	    	
	    canvas:renderTo(function()
	        love.graphics.rectangle("fill",walker.x, walker.y,1,1)
	    end)
	    walker=walker+vector.fromAngle(random(0,2*math.pi))
	    if walker.x>width then walker.x=width end
	    if walker.x<0 then walker.x=0 end
	    if walker.y>height then walker.y=height end
	    if walker.y<0 then walker.y=0 end
	end
end

function love.focus(bool)
end

function love.keypressed( key, unicode )
	print(key)
end

function love.keyreleased( key, unicode )
end

function love.mousepressed( x, y, button )
end

function love.mousereleased( x, y, button )
end

function love.wheelmoved( x, y )
	if camera.on then camera.zoom(x, y) end
end

function love.mousemoved(x, y, dx, dy, istouch)
	-- body
	if camera.on then camera.mousemoved(x, y, dx, dy, istouch) end
end

function love.quit()
end
