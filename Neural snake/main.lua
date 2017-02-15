function love.load()
	math.randomseed(os.time())
	package.path="c:/Users/Colin/Google Drive/Love 2D/Live Sync/Modules/?.lua;"
	require("camera")
	require("shape")
	vector = require"vector"
	require("ray")
	require("snake")
	require("food")
	require("Functions")
	require("DNA")
	require("Population")
	require("Neurons")
	love.window.setMode( 800, 800)
	height = love.graphics.getHeight()
	width = love.graphics.getWidth()
	layerTable={30, 16, 16, 2}
	neurons=Neurons()
	population=Population(0.1, 5)
	camera.on=true
end

function love.draw()
	if camera.on then camera.transformation() end
	population.calcFitness()

	for i=1,#population.population do
		population.population[i].update()
		population.population[i].draw()
	end
	if population.population[1].DNA.genes[1]==population.population[2].DNA.genes[1] then print("heck") end

	love.graphics.setColor(250, 10, 10)
	love.graphics.setLineWidth(10)
	love.graphics.rectangle("line", 0, 0, width, height)
	love.graphics.setLineWidth(1)
end

function love.update(dt)
	delta = dt
	if camera.on then camera.smooth(dt) end
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
