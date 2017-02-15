function ray(pos, angle, mode)
	-- body
	local ray={}
	ray.mode=mode
	ray.pos=snake.segments[1].pos
	ray.angleOffset=angle
	ray.dir=vector.fromAngle(snake.heading:normalized():angleTo()+ray.angleOffset)
	if ray.mode=="snake" then
		
		function ray.specialCast()
			for i=2, #snake.segments do
				if math.dist(snake.segments[i].pos, ray.point) <= snake.size then 
					return true
				end
			end
		end

	elseif ray.mode=="wall" then
		function ray.specialCast()
			if ray.point.x<0 or ray.point.x>width or ray.point.y<0 or ray.point.y>height then
				return true
			end
		end

	elseif ray.mode=="food" then
		function ray.specialCast()
			if math.dist(snake.food.pos, ray.point) <= snake.food.size then 
				return true
			end
		end
	end

	function ray.update()
		ray.dir=vector.fromAngle(snake.heading:angleTo()+ray.angleOffset)
		ray.pos=snake.segments[1].pos
	end

	function ray.draw()
		ray.update()
		love.graphics.setColor(255, 255, 255)
		love.graphics.line(ray.pos.x, ray.pos.y, ray.pos.x+ray.dir.x*1000, ray.pos.y+ray.dir.y*1000)
	end
	function ray.cast()
		
		ray.point=ray.pos:clone()
		local iteration=0
		local hit=false
		while iteration<1000 do
			if ray.specialCast() then break end
			ray.point=ray.point+ray.dir
			iteration=iteration+1
		end
		return map(iteration, 0, 1000, 1, 0)
	end

	

	return ray
end