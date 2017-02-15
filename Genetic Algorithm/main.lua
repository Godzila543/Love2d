love.graphics.setBackgroundColor(255, 255, 255)
math.randomseed(os.time())
t1r = math.random(0,255)
t1g = math.random(0,255)
t1b = math.random(0,255)
t2r = math.random(0,255)
t2g = math.random(0,255)
t2b = math.random(0,255)
pop = 500
mutChance=500
bestfit=1000
muts=0
reps=0
x = love.graphics.getWidth()
y = love.graphics.getHeight()
creature=1
fill="fill"
line="line"
creatures = {}
for i=1,pop do
	creatures[i]={}
	for k=1,20 do
		creatures[i][k]=math.random()*(20)-10
	end
end
for i,v in ipairs(creatures) do
	for k=1,20 do
		print(i,v[k])
	end
	
end

function love.load()
	require("Functions")
end

function love.draw()
	target()
	layer1()
	layer2()
	baseNodes()
	fitness()
	data()
end

function love.update(dt)
	delta = dt
	
	
	creature=creature+1 
	
	if creature==pop then creature=1 end
	Strength(creature)
	local a = math.random(1,pop)
	local b = math.random(1,pop)
	local c = math.random(1,pop)
	if a~=b and b~=c and c~=a then
		reproduce(a,b,c)
	end
end

function love.focus(bool)
end

function love.keypressed( key, unicode )
	if key=="i" then
		creature=creature+1
	elseif key=="k" then
		creature=creature-1
	end
end

function love.keyreleased( key, unicode )
end

function love.mousepressed( x, y, button )
end

function love.mousereleased( x, y, button )
end

function love.quit()
end
