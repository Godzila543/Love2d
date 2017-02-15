function love.load()
	require("Functions")
	require("simple-slider")
	love.window.setMode( 800, 800)
	angleSlide = newSlider(400, 50, 400, 0.618, 0, 2*math.pi, function (v) angle=v end)
end

function love.draw()
	love.graphics.setLineWidth(2)
    love.graphics.setColor(254, 67, 50)
	angleSlide:draw()
	love.graphics.translate(400, 800)
	love.graphics.setLineWidth(1)
	love.graphics.setColor(255, 255, 255)
	math.randomseed(90)
	branch(200)

end

function love.update(dt)
	delta = dt
	angleSlide:update()
	print(angleSlide:getValue())   
end

function branch(len)
	line(0, 0, 0, -len)
	love.graphics.translate(0, -len)
	if len > 1 then
		love.graphics.push()
		love.graphics.rotate(angle)
		branch(len*0.67)
		love.graphics.pop()
		love.graphics.push()
		love.graphics.rotate(-angle)
		branch(len*0.67)
		love.graphics.pop()
	end
end