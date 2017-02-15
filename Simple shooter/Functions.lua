function testMap(x, y,table)
	if map[((table.grid_y / 32) + y)+1][((table.grid_x / 32) + x)+1] == 1 then
		return false
	end
	return true
end
function testMap2(x,y)
	if map[y+1][x+1] == 1 then
		return false
	end
	return true
end
function cleanUp()
	for i = #bullets, 1, -1 do
    	if bullets[i].flagClean then
  	    table.remove( bullets, i )
 	   end
 	end
    for i = #enemies, 1, -1 do
  	    if enemies[i].flagClean then
   		   table.remove( enemies, i )
    	end
	end
end
function SpawnEnemy()
	-- body
	testSpawn=false
	while not testSpawn do
		local y = math.random(2,18)
		local x = math.random(2,24)
		if testMap2(x,y) then
			testSpawn=true
			table.insert(enemies, {grid_x=x*32, grid_y=y*32, act_x=x*32, act_y=y*32, speed=10})
		else
		end
	end
end


function moveEnemies()
	for i,v in ipairs(enemies) do
		local direct = math.random(1,4)
		if direct==1 then
			if testMap(0, -1, v) then
				v.grid_y = v.grid_y - 32
			end
		elseif direct==2 then
			if testMap(0, 1, v) then
				v.grid_y = v.grid_y + 32
			end
		elseif direct==3 then
			if testMap(-1, 0, v) then
				v.grid_x = v.grid_x - 32
			end
		elseif direct==4 then
			if testMap(1, 0, v) then
				v.grid_x = v.grid_x + 32
			end
		end
	end
end

function timerFunc()
	for i,v in ipairs(bullets) do
		local mapx = v.dx/32
		local mapy = v.dy/32
		if testMap(mapx, mapy, v) then
			v.grid_x = v.grid_x + v.dx
			v.grid_y = v.grid_y + v.dy
		else
			v.flagClean = true
		end
	end
	cleanUp()
	SpawnEnemy()
	moveEnemies()
end
function keyPress()
	if  love.keyboard.isDown("w") then
		if testMap(0, -1, player) then
			player.grid_y = player.grid_y - 32
		end
	elseif  love.keyboard.isDown("s") then
		if testMap(0, 1, player) then
			player.grid_y = player.grid_y + 32
		end
	elseif  love.keyboard.isDown("a") then
		if testMap(-1, 0, player) then
			player.grid_x = player.grid_x - 32
		end
	elseif  love.keyboard.isDown("d") then
		if testMap(1, 0, player) then
			player.grid_x = player.grid_x + 32
		end
	end
end

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end