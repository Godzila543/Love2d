
function love.load()
	require("Functions")
	love.window.setMode( 800, 800)
	height = love.graphics.getHeight()
	width = love.graphics.getWidth()
	maxIterations=1000
	left=-2
	right=1
	top=1.5
	bottom=-1.5
	pixels = love.image.newImageData(width, height)
	mandelbrot = love.graphics.newImage(pixels)
	
end

function love.draw()
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(mandelbrot, 0, 0)
	--[[
	for x=0,width do
		for y=0,height do
			local bright=pixels[x][y]
			if not (bright==0) then
				love.graphics.setColor(bright, bright, bright, 255)
				love.graphics.setPointSize(1)
				love.graphics.points(x, y)
			end
		end
	end
	]]
	for x=1,width do
		for y=1,height do
			local a = map(x, 0, width, left, right)
			local b = map(y, 0, height, bottom, top)
			
			local ca=a
			local cb=b
			
			local n = 0
			
			while (n<maxIterations) do
				local aa = a^2 - b^2
				local bb = 2 * a * b
				
				

				a=aa+ca
				b=bb+cb

				if (math.sqrt(a^2+b^2)>2) then
					break
				end

				n=n+1
			end
			local bright=n
			bright=map(n, 0, maxIterations, 0, 255)
		
			pixels:setPixel(x-1, y-1, bright, bright, bright, 255)
		end
	end
	mandelbrot:refresh()
end

function love.update(dt)
	delta = dt
	print(love.timer.getFPS())
	
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
end

function love.mousemoved(x, y, dx, dy, istouch)
	-- body
end

function love.quit()
end
