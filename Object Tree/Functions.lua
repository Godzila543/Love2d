require("config")
function drawinrect(img, x, y, w, h, r, ox, oy, kx, ky)
    return -- tail call for a little extra bit of efficiency
    love.graphics.draw(img, x, y, r, w / img:getWidth(), h / img:getHeight(), ox, oy, kx, ky)
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

function len()
	-- body
	local var = config.lengthVariation
	local random = random(-var,var)
	return random+config.lengthPercent
end

function branchAngle(i)
	-- body
	angle=map(i, 1, config.numberBranches, -config.totalAngle, config.totalAngle)
	local var = config.angleVariation
	return random(-var,var)+angle
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
