camera={}
scale, smoothScale = 1, 1
mapx, mapy, smoothMapx, smoothMapy = 0, 0, 0, 0
function camera.mousemoved( x, y, dx, dy, istouch )
	if love.mouse.isDown(1) then
		smoothMapx=smoothMapx+dx*scale
		smoothMapy=smoothMapy+dy*scale
		mapx=smoothMapx
		mapy=smoothMapy
	end
end

function camera.smooth(dt)
	-- body
	smoothScale = smoothScale - ((smoothScale - scale)*dt*10)
	smoothMapx = smoothMapx - ((smoothMapx - mapx)*dt*10)
	smoothMapy = smoothMapy - ((smoothMapy - mapy)*dt*10)
end

function camera.center(x, y, hard)
	-- body
	mapx=-x*scale
	mapy=-y*scale
end
function camera.transformation()
	-- body
	love.graphics.scale(1/smoothScale)
	love.graphics.translate(smoothMapx, smoothMapy)
end

function camera.zoom(z, y)
	-- body
	if y==1 then
		scale=scale/2
		local mouseX, mouseY = love.mouse.getPosition()
		mapx=mapx-mouseX*scale
		mapy=mapy-mouseY*scale
	elseif y==-1 then
		if scale>=2 then
		else
			scale=scale*2	
			local mouseX, mouseY = love.mouse.getPosition()
			mapx=mapx+mouseX*(scale/2)
			mapy=mapy+mouseY*(scale/2)
		end
	end
	if love.timer.getFPS() < 10 then
		smoothScale=scale
		smoothMapx=mapx
		smoothMapy=mapy
	end
end