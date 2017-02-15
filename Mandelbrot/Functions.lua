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
function map(v, scla1,scla2,sclb1,sclb2) --maps input between two values to another two values
	-- body
	local scale = (sclb2-sclb1) / (scla2-scla1)
	local step1 = v - scla1 
	local step2 = step1*scale
	local step3 = step2+sclb1
	return step3
end
