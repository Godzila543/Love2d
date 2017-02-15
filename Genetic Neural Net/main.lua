function love.load()
	package.path="c:/Users/Colin/Google Drive/Love 2D/Live Sync/Modules/?.lua;"
	require("Functions")
	require("camera")
	require("DNA")
	require("Population")
	require("Neurons")
	math.randomseed(9)
	camera.on=true
	love.window.setMode( 800, 800)
	love.graphics.setBackgroundColor(0, 0, 50)
	height = love.graphics.getHeight()
	width = love.graphics.getWidth()
	
	layerTable={9,16,3}
	population=Population({0,1,0},0.01,1000)
	neurons=Neurons(population.population[1])
end

function love.draw()
	if camera.on then camera.transformation() end
	population.calcFitness()
	--print(population.population[1])
	neurons.draw(population.population[population.best])
end

function love.update(dt)
	delta = dt
	if camera.on then camera.smooth(dt) end
	--population.selection()
end

function love.focus(bool)
end

function love.keypressed( key, unicode )
	population.selection()
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
