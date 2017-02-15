camera={}
camera.on=false
camera.scale, camera.smoothScale = 1, 1
camera.mapx, camera.mapy, camera.smoothMapx, camera.smoothMapy = 0, 0, 0, 0
function camera.mousemoved( x, y, dx, dy, istouch )
	if love.mouse.isDown(1) then
		camera.smoothMapx=camera.smoothMapx+dx*camera.scale
		camera.smoothMapy=camera.smoothMapy+dy*camera.scale
		camera.mapx=camera.smoothMapx
		camera.mapy=camera.smoothMapy
	end
end

function camera.smooth(dt)
	-- body
	camera.smoothScale = camera.smoothScale - ((camera.smoothScale - camera.scale)*dt*10)
	camera.smoothMapx = camera.smoothMapx - ((camera.smoothMapx - camera.mapx)*dt*10)
	camera.smoothMapy = camera.smoothMapy - ((camera.smoothMapy - camera.mapy)*dt*10)
end

function camera.center(x, y, hard)
	-- body
	camera.mapx=-x*camera.scale
	camera.mapy=-y*camera.scale
end
function camera.transformation()
	-- body
	love.graphics.scale(1/camera.smoothScale)
	love.graphics.translate(camera.smoothMapx, camera.smoothMapy)
end

function camera.zoom(z, y)
	-- body
	if y==1 then
		camera.scale=camera.scale/2
		local mouseX, mouseY = love.mouse.getPosition()
		camera.mapx=camera.mapx-mouseX*camera.scale
		camera.mapy=camera.mapy-mouseY*camera.scale
	elseif y==-1 then
		if camera.scale>=2 then
		else
			camera.scale=camera.scale*2	
			local mouseX, mouseY = love.mouse.getPosition()
			camera.mapx=camera.mapx+mouseX*(camera.scale/2)
			camera.mapy=camera.mapy+mouseY*(camera.scale/2)
		end
	end
	if love.timer.getFPS() < 10 then
		camera.smoothScale=camera.scale
		camera.smoothMapx=camera.mapx
		camera.smoothMapy=camera.mapy
	end
end

function camera.getMouse()
	local x,y=love.mouse.getPosition()
	x=x*camera.smoothScale
	y=y*camera.smoothScale
	x=x-camera.smoothMapx
	y=y-camera.smoothMapy
	return x,y
end