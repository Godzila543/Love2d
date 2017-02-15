function Cell(i, j)
	-- body
	local cell={}
	cell.i = i --Cols
	cell.j = j --Rows
	cell.walls={true, true, true, true}
	cell.visited=false 
	
	function cell.checkNeighbors() --Checks for valid spaces to move
		local neighbors = {}
		
		local top    = grid[index(i  , j-1)]
		local right  = grid[index(i+1, j  )]
		local bottom = grid[index(i  , j+1)]
		local left   = grid[index(i-1, j  )]

		if (top and not top.visited) then
			table.insert(neighbors, top)
			--return top
			--return top
		end

		if (right and not right.visited) then
			table.insert(neighbors, right)
			--return right
			
		end

		if (bottom and not bottom.visited) then
			table.insert(neighbors, bottom)
			--return bottom
			
		end

		if (left and not left.visited) then
			table.insert(neighbors, left)
			--return left
			
		end

		if #neighbors > 0 then
			local r = math.random(1, #neighbors)
			return neighbors[r]
		else
			--return nil
		end

	end

	function cell.highlight()
		x = cell.i*w
		y = cell.j*w
		love.graphics.setColor(255, 255, 0, 255)
		rect("fill", x, y, w, w)
	end
	function cell.show() --Function to draw the cell
		-- body
		love.graphics.setLineWidth(1*scale)
		x = cell.i*w
		y = cell.j*w
		
		if cell.visited then
			love.graphics.setColor(255, 255, 255, 255)
			if cell.walls[1] then line(x  , y  , x+w, y  ) end -- Top
			if cell.walls[2] then line(x+w, y  , x+w, y+w) end--Right
			if cell.walls[3] then line(x  , y+w, x+w, y+w) end-- Bottom
			if cell.walls[4] then line(x  , y  , x  , y+w) end --Left
		end
		if cell.visited then
			love.graphics.setColor(255, 0, 255, 100)
			rect("fill", x, y, w, w)
		end
	end


	return cell
end
