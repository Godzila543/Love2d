function love.load()
	package.path="c:/Users/Colin/Google Drive/Love 2D/Live Sync/Modules/?.lua;"
	require("Functions")
	require("camera")
	camera.on=true
	vector = require"vector"
	gui = require("EasyGui")
	love.window.setMode( 800, 800)
	height = love.graphics.getHeight()
	width = love.graphics.getWidth()
	love.graphics.setBackgroundColor(250, 100, 90)
	
	round=gui.button:new({size={w=100,h=25,s=0,r=10}})
	rect=gui.button:new({pos=vector.new(0,100),size={w=100,h=25, s=0,r=10},style="rect"})
	circle=gui.button.checkbox:new({pos=vector.new(0,200),size={w=100, h=25 ,s=5}})
	split=gui.button.split:new({pos=vector.new(50,350)})
	split:insert(gui.button.checkbox:new({style="circle",pos=vector.new(0,300),size={w=100, h=25 ,s=2, r=10},color={{255,0,0},{0,0,0}},check={{150,0,0},{255,0,0}}  }  ))
	split:insert(gui.button.checkbox:new({style="circle",pos=vector.new(100,300),size={w=100, h=25 ,s=2, r=10},color={{0,255,0},{0,0,0}},check={{0,150,0},{0,255,0}}  }  ))
	split:insert(gui.button.checkbox:new({style="circle",pos=vector.new(100,400),size={w=100, h=25 ,s=2, r=10},color={{0,0,255},{0,0,0}},check={{0,0,150},{0,0,255}}  }  ))
	split:insert(gui.button.checkbox:new({style="circle",pos=vector.new(0,400),size={w=100, h=25 ,s=2, r=10},color={{0,255,255},{0,0,0}},check={{0,150,150},{0,255,255}}  }  ))

	split2=gui.button.split:new({pos=vector.new(450,350)})
	split2:insert(gui.button.checkbox:new({style="circle",pos=vector.new(400,300),size={w=100, h=25 ,s=2, r=10},color={{255,0,0},{0,0,0}},check={{150,0,0},{255,0,0}}  }  ))
	split2:insert(gui.button.checkbox:new({style="circle",pos=vector.new(500,300),size={w=100, h=25 ,s=2, r=10},color={{0,255,0},{0,0,0}},check={{0,150,0},{0,255,0}}  }  ))
	split2:insert(gui.button.checkbox:new({style="circle",pos=vector.new(500,400),size={w=100, h=25 ,s=2, r=10},color={{0,0,255},{0,0,0}},check={{0,0,150},{0,0,255}}  }  ))
	split2:insert(gui.button.checkbox:new({style="circle",pos=vector.new(400,400),size={w=100, h=25 ,s=2, r=10},color={{0,255,255},{0,0,0}},check={{0,150,150},{0,255,255}}  }  ))

	imagebut=gui.button:new({pos=vector.new(500,500),size={w=100 ,s=5},style="circle",disp="img",color= love.graphics.newImage("color.png"),love.graphics.newImage("hover.png"),love.graphics.newImage("click.png")})
end
function love.draw()
	if camera.on then camera.transformation() end
	round:draw()
	rect:draw()
	circle:draw()
	split:draw()
	split2:draw()
	imagebut:draw()
end

function love.update(dt)
	delta = dt
	if camera.on then camera.smooth(dt) end
	round:update()
	rect:update()
	circle:update()
	split:update(dt)
	split2:update(dt)
	imagebut:update()
end

function love.focus(bool)
end

function love.keypressed( key, unicode )
	print(key)
end

function love.keyreleased( key, unicode )

end

function love.mousepressed( x, y, button )
end

function love.mousereleased( x, y, button )
end

function love.wheelmoved( x, y )
	if camera.on then camera.zoom(x, y) end
end

function love.mousemoved(x, y, dx, dy, istouch)
	-- body
	if camera.on then camera.mousemoved(x, y, dx, dy, istouch) end
end

function love.quit()
end
