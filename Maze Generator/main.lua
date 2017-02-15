function love.load()
	require("Cell")
	require("camera")
	math.randomseed(os.time())
	love.window.setMode( 1600, 1000)
	width = love.graphics.getWidth()
	height = love.graphics.getHeight()
	scale = 1
	mapx, mapy = 0, 0
	w=4
	speed=1
	grid = {}
	stack = {}
	a=1
	track=true
	cols=math.floor(width/w)
	rows=math.floor(height/w)
	
	for j=0,rows-1 do
		for i=0,cols-1 do
			local cell = Cell(i, j)
			table.insert(grid, cell)
		end
	end
	current = grid[1]
	
	
	--[[while true do
		--STEP 1
		nextCell = current.checkNeighbors()
		if nextCell then
			nextCell.visited = true
			--STEP 2
			table.insert(stack, current)
			--STEP 3
			removeWalls(current, nextCell)
			--STEP 4
			current = nextCell
		elseif #stack > 0 then
			current = table.remove(stack)
		else
			break
		end
	end
	]]
end

function love.draw()
	camera.transformation()
	for i=1,#grid do
		grid[i].show()
	end

	for i=1,speed do

		current.visited=true
		current.highlight()
		--STEP 1
		nextCell = current.checkNeighbors()
		if nextCell then
			nextCell.visited = true
			--STEP 2
			table.insert(stack, current)
			--STEP 3
			removeWalls(current, nextCell)
			--STEP 4
			current = nextCell
		elseif #stack > 0 then
			current = table.remove(stack)
		end
	end
end

function love.wheelmoved( x, y )
	camera.zoom(x, y)
end

function love.mousemoved( x, y, dx, dy, istouch )
	camera.mousemoved(x, y, dx, dy, istouch)
end

function love.keypressed( key, scancode, isrepeat )
	if key =="w" then
		speed=speed*2
	elseif key=="s" then
		if speed==1 then
		else
			speed=speed/2
		end
	elseif key=="t" then
		track=not track
	end
end
function love.update(dt)
	delta = dt
	camera.smooth(dt)
	if track then
		camera.center(current.i*w, current.j*w, false)
	end
end


----------------my helpful functions---------------------
function rect( mode, x, y, width, height ) -- draws rectangle
	love.graphics.rectangle( mode, x, y, width, height )
end

function line(x1, y1, x2, y2) --draws line
	love.graphics.line(x1, y1, x2, y2)
end

function index(i, j) --gets 2d location from 1d table
	if (i < 0 or j < 0 or i > cols-1 or j > rows-1) then
		return -1
	else
		return i + j * cols+1
	end
end

function removeWalls(a, b)
	local x = a.i - b.i
	if x==1 then
		a.walls[4]=false --left wall removed
		b.walls[2]=false --right wall removed
	elseif x == -1 then
		a.walls[2]=false --right wall removed
		b.walls[4]=false -- left wall removed
	end
	local y= a.j - b.j
	if y==1 then
		a.walls[1]=false --top wall removed
		b.walls[3]=false --bottom wall removed
	elseif y == -1 then
		a.walls[3]=false --bottom wall removed
		b.walls[1]=false -- top wall removed
	end
end