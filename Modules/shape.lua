function beginShape()
	-- body
	shapeVerticies={}
end

function vertex(x, y, r, g, b, a)
	-- body
	local shapeVertex = {}
	shapeVertex[1]=x
	shapeVertex[2]=y
	--shapeVertex[5]=r
	shapeVertex[6]=g
	shapeVertex[7]=b
	shapeVertex[8]=a
	if #arg == 3 then
		shapeVertex[5]=r
		shapeVertex[6]=r
		shapeVertex[7]=r
	end
	table.insert(shapeVerticies, shapeVertex)
end

function endShape(mode, draw)
	-- body
	if mode ~= "line" then 
		shape = love.graphics.newMesh(shapeVerticies, nil, mode) 
	end
	if arg.draw == nil then arg.draw=true end
	if arg.draw then 
		if mode ~= "line" then 
			love.graphics.draw(shape) 
		elseif mode == "line" then
			local linePoints = {}
			for i=1,#shapeVerticies do
				table.insert(linePoints, shapeVerticies[i][1])
				table.insert(linePoints, shapeVerticies[i][2])
			end
			table.insert(linePoints, shapeVerticies[1][1])
			table.insert(linePoints, shapeVerticies[1][2])
			love.graphics.line(linePoints)
			print("called")
		end	
	end
	return shape
end