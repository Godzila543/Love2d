function love.load()
	require("SaveLoadMap")
	require("Functions")
	player={
		grid_x=256,
		grid_y=256,
		act_x=256,
		act_y=256,
		speed=10
	}
	enemies=
	{ 
	{grid_x=256, grid_y=256, act_x=256, act_y=256, speed=10},
	{grid_x=256, grid_y=256, act_x=256, act_y=256, speed=10},
	{grid_x=256, grid_y=256, act_x=256, act_y=256, speed=10},
	{grid_x=256, grid_y=256, act_x=256, act_y=256, speed=10}
	}
	map = table.load("map1")
	myTimer=0
	lastpress=0
	timerSpeed=0.25
	bullets={}
	bulletSpeed=10
end

function love.draw()
	love.graphics.setColor(0, 255, 0, 255)
	love.graphics.rectangle("fill", player.act_x, player.act_y, 32, 32)
	
	

	for i,v in ipairs(bullets) do
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.rectangle("fill", v.act_x+8, v.act_y+8, 16, 16)
		love.graphics.setColor(150, 150, 150, 255)
		love.graphics.rectangle("line", v.act_x+8, v.act_y+8, 16, 16)
		for i,k in ipairs(enemies) do
			if CheckCollision(v.act_x+8, v.act_y+8, 16, 16, k.act_x, k.act_y, 32, 32) then 
				v.flagClean=true
				k.flagClean=true
			end
		end
	end
	for i,v in ipairs(enemies) do
		love.graphics.setColor(255, 0, 0, 255)
		love.graphics.rectangle("fill", v.act_x, v.act_y, 32, 32)
		love.graphics.setColor(50, 50, 50, 255)
		love.graphics.rectangle("line", v.act_x, v.act_y, 32, 32)
	end
	love.graphics.setLineWidth(2)
	love.graphics.setColor(150, 150, 150, 255)
	for y=1, #map do
		for x=1, #map[y] do
			if map[y][x] == 1 then
				love.graphics.rectangle("line", (x-1) * 32, (y-1) * 32, 32, 32)
			end
		end
	end
end

function love.update(dt)
	player.act_y = player.act_y - ((player.act_y - player.grid_y)*dt*player.speed)
	player.act_x = player.act_x - ((player.act_x - player.grid_x)*dt*player.speed)
	
	for i,v in ipairs(enemies) do
		v.act_y = v.act_y - ((v.act_y - v.grid_y)*dt*v.speed)
		v.act_x = v.act_x - ((v.act_x - v.grid_x)*dt*v.speed)
	end
	for i,v in ipairs(bullets) do
		
		v.act_y = v.act_y - ((v.act_y - v.grid_y)*dt*10)
		v.act_x = v.act_x - ((v.act_x - v.grid_x)*dt*10)
	end
	myTimer=myTimer+dt
	if myTimer > timerSpeed then 
       timerFunc()
		myTimer=myTimer-timerSpeed 	
   	end

   	lastpress=lastpress-dt
	if lastpress <= 0 then 
       keyPress()
		lastpress=lastpress+0.25 	
   	end

end

function love.focus(bool)
end

function love.keypressed( key, unicode )
	--[[

	if key == "w" then
		if testMap(0, -1, player) then
			player.grid_y = player.grid_y - 32
		end
	elseif key == "s" then
		if testMap(0, 1, player) then
			player.grid_y = player.grid_y + 32
		end
	elseif key == "a" then
		if testMap(-1, 0, player) then
			player.grid_x = player.grid_x - 32
		end
	elseif key == "d" then
		if testMap(1, 0, player) then
			player.grid_x = player.grid_x + 32
		end
	end
	]]
	if key=="w" or key=="s" or key=="a" or key=="d" then
		lastpress=0
	end
	if key=="up" then
		local startX = player.grid_x
		local startY = player.grid_y
		table.insert(bullets, {grid_x = startX, act_x = startX, grid_y = startY, act_y = startY, dx = 0, dy = -32})
	elseif key =="down" then
		local startX = player.grid_x
		local startY = player.grid_y
		table.insert(bullets, {grid_x = startX, act_x = startX, grid_y = startY, act_y = startY, dx = 0, dy = 32})
	elseif key == "left" then
		local startX = player.grid_x
		local startY = player.grid_y
		table.insert(bullets, {grid_x = startX, act_x = startX, grid_y = startY, act_y = startY, dx = -32, dy = 0})
	elseif key == "right" then
		local startX = player.grid_x
		local startY = player.grid_y
		table.insert(bullets, {grid_x = startX, act_x = startX, grid_y = startY, act_y = startY, dx = 32, dy = 0})
	end


end

function love.keyreleased( key, unicode )
end

function love.mousepressed( x, y, button )
end

function love.mousereleased( x, y, button )
end

function love.quit()
end
