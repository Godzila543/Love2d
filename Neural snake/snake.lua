function Snake(dna)
	snake={}
	snake.fitness=0
	snake.DNA=dna or DNA()
	snake.food=Food()
	snake.speed=5
	snake.resolution=10
	snake.size=15
	snake.hunger=300
	snake.dead=false
	snake.heading=vector.new(0,snake.speed)
	snake.segments={}
	snake.segments[1]={
		pos=vector.new(width/2,height/2),
		oldPos={}
	}
	snake.rays={}
	for i=1,snake.resolution do
		table.insert(snake.rays,ray(snake.segments[1].pos, math.rad(math.lerp(-120,120,i,snake.resolution)-90), "wall"))
	end
	for i=1,snake.resolution do
		table.insert(snake.rays,ray(snake.segments[1].pos, math.rad(math.lerp(-120,120,i,snake.resolution)-90), "food"))
	end
	for i=1,snake.resolution do
		table.insert(snake.rays,ray(snake.segments[1].pos, math.rad(math.lerp(-120,120,i,snake.resolution)-90), "snake"))
	end


	-- for i=2,320 do
	-- 	snake.segments[i]={
	-- 		pos=vector.new(width/2,height/2),
	-- 		oldPos={}
	-- 	}
	-- end
	
	
	
	function snake.update()
		if not love.keyboard.isDown("space") then
			local outputs=neurons.evaluate(snake)
			snake.turn(outputs[1]-outputs[2])
			snake.updateSections()
			snake.checkEat()
			snake.hunger=snake.hunger-1
			snake.fitness=20*#snake.segments+snake.hunger/5
			if snake.checkDead() then
				snake=population.newSnake()
			end
		end
	end

	function snake.checkEat()
		if circleCollision({x=snake.segments[1].pos.x, y=snake.segments[1].pos.y, radius=snake.size},{x=snake.food.pos.x, y=snake.food.pos.y, radius=snake.food.size}) then	
			snake.food.eat()
			snake.grow(1)
			snake.hunger=snake.hunger+150
		end
	end

	function snake.checkDead()
		return snake.hunger<=0 or snake.checkWalls() or snake.checkBite()
	end

	function snake.checkWalls()
		local head=snake.segments[1]
		if head.pos.x-snake.size<0 then
			return true
		elseif head.pos.x+snake.size>width then
			return true
		elseif head.pos.y-snake.size<0 then
			return true
		elseif head.pos.y+snake.size>height then
			return true
		end
	end

	function snake.checkBite()
		for i=3,#snake.segments do
			if circleCollision({x=snake.segments[1].pos.x, y=snake.segments[1].pos.y, radius=snake.size},{x=snake.segments[i].pos.x, y=snake.segments[i].pos.y, radius=snake.size}) then
				return true
			end
		end
	end



	function snake.grow(n)
		for i=1,n do
			local newSegment={pos=table.getLast(snake.segments[#snake.segments].oldPos),oldPos={}}
			table.insert(snake.segments, newSegment)
		end
	end

	function snake.updateSections()
		--if love.keyboard.isDown("space") then
			table.insert(snake.segments[1].oldPos, 1, snake.segments[1].pos)
			snake.segments[1].oldPos[math.floor(snake.size*2/snake.speed)+1]=nil
			snake.segments[1].pos=snake.segments[1].pos+snake.heading
			for i=2,#snake.segments do
				table.insert(snake.segments[i].oldPos, 1, snake.segments[i].pos)
				snake.segments[i].oldPos[math.floor(snake.size*2/snake.speed)+1]=nil
				snake.segments[i].pos=table.getLast(snake.segments[i-1].oldPos)
			end
		--end
	end
	function snake.draw()
		for i=#snake.segments, 1, -1 do
			local segment=snake.segments[i]
			love.graphics.setColor(0, 0, 0)
			love.graphics.circle("fill", segment.pos.x, segment.pos.y, snake.size)
			love.graphics.setColor(222, 72, 22)
			love.graphics.circle("line", segment.pos.x, segment.pos.y, snake.size)
		end
		-- for i=1,#snake.rays do
		-- 	snake.rays[i].draw()
		-- end
		
		snake.food.draw()
	end

	function snake.turn(phi)
		snake.heading:rotateInplace(phi/10)
	end

	return snake
end