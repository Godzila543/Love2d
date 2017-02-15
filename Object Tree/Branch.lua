require("config")
function Branch(begin, back, value, length) 
	
	local this = {}
	this.begin = begin
	this.back = back
	this.smoothBack=this.begin:clone()
	this.value = value
	this.finished = false
	this.length=length

	function this.jitter() 
		this.back.x = this.back.x + random(-config.jitter, config.jitter)
		this.back.y = this.back.y + random(-config.jitter, config.jitter)
	end

	function this.angleJitter(angle)
		-- body
		--[[print(angle)
		x = this.begin.x + math.sin(math.pi-angle)*(this.begin-this.back):len()
		y = this.begin.y + math.cos(math.pi-angle)*(this.begin-this.back):len()
		this.back=Vector.new(x, y)
		]]
		this.back.x=this.back.x-this.begin.x
		this.back.y=this.back.y-this.begin.y
		local badLength=this.back:len()
		local factor=this.length/badLength
		this.back.x=this.back.x*factor
		this.back.y=this.back.y*factor
		if this.value == 3 then
			this.back:rotateInplace(angle)
		end
		this.back.x=this.back.x+this.begin.x
		this.back.y=this.back.y+this.begin.y

	end
	function this.show() 
		love.graphics.setLineWidth(map(this.value, 1, config.countCap, config.trunkThickness, 1)*smoothScale)
		love.graphics.setColor(HSL(map(this.value, 1, config.countCap, 1, 255), config.saturation, config.lightness, map(this.value, 1, count+1, 255, 30)))
		line(this.begin.x, this.begin.y, this.smoothBack.x, this.smoothBack.y)
	end

	function this.branch()
		for i=1, config.numberBranches do
			dir = this.back - this.begin
			dir = dir:rotated(branchAngle(i))
			dir = dir*len()
			newback = this.back + dir
			local b = Branch(this.smoothBack, newback, this.value+1, this.back:dist(newback))
			table.insert(tree, b)
		end
	end
	return this
end
