function Food()
	food={}
	food.size=25
	food.pos=vector.new(math.random(0,width), math.random(0, height))
	function food.draw()
		love.graphics.setColor(10, 10, 30)
		love.graphics.circle("fill", food.pos.x, food.pos.y, food.size)
		love.graphics.setColor(240, 0, 255)
		love.graphics.circle("line", food.pos.x, food.pos.y, food.size)
	end

	function food.eat()
		food.pos=vector.new(math.random(0,width), math.random(0, height))
	end
	return food
end