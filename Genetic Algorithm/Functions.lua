function baseNodes()
	love.graphics.setColor(255, 0, 0, 255)
	love.graphics.circle(fill, x/2-100, y/2-100, 25, 50)
	love.graphics.circle(line, x/2-100, y/2-100, 25, 50)

	love.graphics.setColor(0, 255, 0, 255)
	love.graphics.circle(fill, x/2-100, y/2, 25, 50)
	love.graphics.circle(line, x/2-100, y/2, 25, 50)

	love.graphics.setColor(0, 0, 255, 255)
	love.graphics.circle(fill, x/2-100, y/2+100, 25, 50)
	love.graphics.circle(line, x/2-100, y/2+100, 25, 50)
end

function massSynapse(x2,y2,s1,s2,s3)
	love.graphics.setColor(0, 0, 0, 100)
	synapse(x/2-100, y/2-100,x2,y2,s1)
	synapse(x/2-100, y/2    ,x2,y2,s2)
	synapse(x/2-100, y/2+100,x2,y2,s3)
end

function massSynapse2(x2,y2,s1,s2,s3,s4)
	love.graphics.setColor(0, 0, 0, 100)
	synapse(x/2, y/2-150, x2,y2,s1)
	synapse(x/2, y/2-50 , x2,y2,s2)
	synapse(x/2, y/2+50 , x2,y2,s3)
	synapse(x/2, y/2+150, x2,y2,s4)
end

function synapse(x1,y1,x2,y2,s)
	love.graphics.setLineWidth(s/10)
	love.graphics.line(x1,y1, x2,y2)
	love.graphics.setLineWidth(2)
end

function Strength(i)
	b11s = creatures[i][1]
	b12s = creatures[i][2]
	b13s = creatures[i][3]
	b14s = creatures[i][4]

	b21s = creatures[i][5]
	b22s = creatures[i][6]
	b23s = creatures[i][7]
	b24s = creatures[i][8]

	b31s = creatures[i][9]
	b32s = creatures[i][10]
	b33s = creatures[i][11]
	b34s = creatures[i][12]

	n11s = creatures[i][13]
	n12s = creatures[i][14]

	n21s = creatures[i][15]
	n22s = creatures[i][16]

	n31s = creatures[i][17]
	n32s = creatures[i][18]

	n41s = creatures[i][19]
	n42s = creatures[i][20]
end

function layer1()
	massSynapse(x/2, y/2-150, b11s, b21s, b31s)
	node(255,0,0,b11s, 0,255,0,b21s, 0,0,255,b31s, x/2, y/2-150,1)

	massSynapse(x/2, y/2-50, b12s, b22s, b32s)
	node(255,0,0,b12s, 0,255,0,b22s, 0,0,255,b32s, x/2, y/2-50,2)

	massSynapse(x/2, y/2+50, b13s, b23s, b33s)
	node(255,0,0,b13s, 0,255,0,b23s, 0,0,255,b33s, x/2, y/2+50,3)

	massSynapse(x/2, y/2+150, b14s, b24s, b34s)
	node(255,0,0,b14s, 0,255,0,b24s, 0,0,255,b34s, x/2, y/2+150,4)
end

function data()
	love.graphics.setColor(0, 0, 0, 255)
	love.graphics.print("Creature: "..creature, 0, 0)
	love.graphics.print("Creature's Fitness: "..creatures[creature][21], 0, 10)
	if creatures[creature][21]<bestfit then bestfit=creatures[creature][21] end
	love.graphics.print("Best Fitness: "..bestfit, 0, 20)
	love.graphics.print("Reproductions: "..reps, 0, 30)
	love.graphics.print("Mutations: "..muts, 0, 40)
end

function fitness()
	rr1=math.abs(t1r-r5)
	gg1=math.abs(t1g-g5)
	bb1=math.abs(t1b-b5)
	
	rr2=math.abs(t2r-r6)
	gg2=math.abs(t2g-g6)
	bb2=math.abs(t2b-b6)
	creatures[creature][21]=rr1+gg1+bb1+rr2+gg2+bb2
end

function reproduce(a,b,c)
	if creatures[a][21] ~=nil and creatures[b][21] ~= nil and creatures[c][21]~= nil then
		local minT= {creatures[a][21],creatures[b][21],creatures[c][21]}
		local key, max = 1, minT[1]
		for k, v in ipairs(minT) do
    		if minT[k] > max then
    		    key, max = k, v
   	 		end
		end
		reps=reps+1
		rc=math.random(0,1)
		if key==1 then
			creatures[a]={}
			for k=1,20 do
				if rc==1 then
					creatures[a][k] = (creatures[b][k]*80+creatures[c][k]*20)/100
				else
					creatures[a][k] = (creatures[c][k]*80+creatures[b][k]*20)/100
				end
				if math.random(1,mutChance)==1 then
					creatures[a][k]=math.random(0,100)
					muts=muts+1
					print("Mutation!")
				end
			end
		elseif key==2 then
			creatures[b]={}
			for k=1,20 do
				if rc==1 then
					creatures[b][k] = (creatures[a][k]*80+creatures[c][k]*20)/100
				else
					creatures[b][k] = (creatures[c][k]*80+creatures[a][k]*20)/100
				end
				if math.random(1,mutChance)==1 then
					creatures[a][k]=math.random(0,100)
					muts=muts+1
					print("Mutation!")
				end
			end
		elseif key==3  then
			creatures[c]={}
			for k=1,20 do
				if rc==1 then
					creatures[c][k] = (creatures[a][k]*80+creatures[b][k]*20)/100
				else
					creatures[c][k] = (creatures[b][k]*80+creatures[a][k]*20)/100
				end
				if math.random(1,mutChance)==1 then
					creatures[a][k]=math.random(0,100)
					muts=muts+1
					print("Mutation!")
				end
			end
		end
		else
		end
end
function layer2()
	massSynapse2(x/2+100, y/2-75, n11s, n21s, n31s, n41s)
	node1(r1,g1,b1,n11s, r2,g2,b2,n21s, r3,g3,b3,n31s, r4,g4,b4,n41s, x/2+100, y/2-75, 5)

	massSynapse2(x/2+100, y/2+75, n12s, n22s, n32s, n42s)
	node1(r1,g1,b1,n12s, r2,g2,b2,n22s, r3,g3,b3,n32s, r4,g4,b4,n42s, x/2+100, y/2+75, 6)
end

function target()
	love.graphics.setColor(t1r, t1g, t1b, 255)
	love.graphics.circle(fill, x/2+100, y/2-75, 35, 50)
	love.graphics.circle(line, x/2+100, y/2-75, 35, 50)
	love.graphics.setColor(t2r, t2g, t2b, 255)
	love.graphics.circle(fill, x/2+100, y/2+75, 35, 50)
	love.graphics.circle(line, x/2+100, y/2+75, 35, 50)
end

function node(r1,g1,b1,s1, r2,g2,b2,s2, r3,g3,b3,s3, posx, posy, number)
	

	r1=r1*s1
	r2=r2*s2
	r3=r3*s3
	_G["r"..number] = (r1+r2+r3)/(s1+s2+s3)

	g1=g1*s1
	g2=g2*s2
	g3=g3*s3
	_G["g"..number] = (g1+g2+g3)/(s1+s2+s3)

	b1=b1*s1
	b2=b2*s2
	b3=b3*s3
	_G["b"..number]  = (b1+b2+b3)/(s1+s2+s3)

	love.graphics.setColor(_G["r"..number], _G["g"..number], _G["b"..number], 255)
	love.graphics.circle(fill, posx, posy, 25, 50)
	love.graphics.circle(line, posx, posy, 25, 50)
	
end

function node1(r1,g1,b1,s1, r2,g2,b2,s2, r3,g3,b3,s3, r4,g4,b4,s4, posx, posy, number)
	

	r1=r1*s1
	r2=r2*s2
	r3=r3*s3
	r4=r4*s4
	_G["r"..number] = (r1+r2+r3+r4)/(s1+s2+s3+s4)

	g1=g1*s1
	g2=g2*s2
	g3=g3*s3
	g4=g4*s4
	_G["g"..number] = (g1+g2+g3+g4)/(s1+s2+s3+s4)

	b1=b1*s1
	b2=b2*s2
	b3=b3*s3
	b4=b4*s4
	_G["b"..number]  = (b1+b2+b3+b4)/(s1+s2+s3+s4)

	love.graphics.setColor(_G["r"..number], _G["g"..number], _G["b"..number], 255)
	love.graphics.circle(fill, posx, posy, 25, 50)
	love.graphics.circle(line, posx, posy, 25, 50)
end