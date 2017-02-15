function drawinrect(img, x, y, w, h, r)
    local wid, hei = img:getDimensions()
    print(img)
    return -- tail call for a little extra bit of efficienc
    
    love.graphics.draw(img, x, y, r or 0, w / wid, h / hei)
end

function rect( mode, x, y, width, height ) -- draws rectangle
	love.graphics.rectangle( mode, x, y, width, height )
end

function line(x1, y1, x2, y2) --draws line
	love.graphics.line(x1, y1, x2, y2)
end

function random(a, b) --get random float between a and b
	-- body
	return math.random()*(b-a)+a
end

function circleCollision(circleA, circleB)
	local dist = (circleA.x - circleB.x)^2 + (circleA.y - circleB.y)^2
	return dist <= (circleA.radius + circleB.radius)^2
end


function map(v, scla1,scla2,sclb1,sclb2) --maps input between two values to another two values
	-- body
	local scale = (sclb2-sclb1) / (scla2-scla1)
	local step1 = v - scla1 
	local step2 = step1*scale
	local step3 = step2+sclb1
	return step3
end

function HSL(h, s, l, a)
	if s<=0 then return l,l,l,a end
	h, s, l = h/256*6, s/255, l/255
	local c = (1-math.abs(2*l-1))*s
	local x = (1-math.abs(h%2-1))*c
	local m,r,g,b = (l-.5*c), 0,0,0
	if h < 1     then r,g,b = c,x,0
	elseif h < 2 then r,g,b = x,c,0
	elseif h < 3 then r,g,b = 0,c,x
	elseif h < 4 then r,g,b = 0,x,c
	elseif h < 5 then r,g,b = x,0,c
	else              r,g,b = c,0,x
	end return (r+m)*255,(g+m)*255,(b+m)*255,a
end

--custom vector functions
if vector then
	function vector.fromAngle(phi)
		local temp = vector.new(0, 1)
		return temp:rotateInplace(phi)
	end
end
--custom math functions
function math.dist(p1,p2)
	if p1.x then
		return ((p1.x-p2.x)^2+(p1.y-p2.y)^2)^0.5
	else
		local sum=0
		for i=1,#p1 do
			sum=sum+(p1[i]-p2[i])^2
		end
		return sum^0.5
	end
end

function math.lerp(v0,v1,t)
	-- body
	return (1 - t) * v0 + t * v1
end

function math.sigmo(value)
	return 1/(1+math.exp(-value))
end
--custom table functions
function table.getLast(t)
	return t[#t]
end

function table.sum(t, limit)
	-- body
	local sum =0
	for i=1, limit or #t do
		sum=sum+t[i]
	end
	return sum
end