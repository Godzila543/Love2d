function Neurons()
	-- body
	this={}
	this.neurons={}
	
	for i=1,#layerTable do
		this.neurons[i]={}
	end

	function this.firstLayer(creature)
		for i=1,#creature.rays do
			this.neurons[1][i]=creature.rays[1].cast()
		end
	end

	function this.evaluate(creature)
		this.firstLayer(creature)
		local creature=creature.DNA
		for i=2,#layerTable do --Evaluate each layer of neurons
			local sums={}
			for dontWorryAboutIt=1,layerTable[i] do --add blank tables for each neuron
				sums[dontWorryAboutIt]={}
			end
			for k=1,#creature.genes[i-1] do --evaluate genes and where they should go and what they connect
				local whatIndex=((k-1)% layerTable[i])+1
				local whatValue=this.neurons[i-1][math.floor((k-1)/layerTable[i])+1] * creature.genes[i-1][k]
				table.insert(sums[whatIndex], whatValue )
			end
			for v=1,#sums do
				this.neurons[i][v]=math.sigmo(table.sum(sums[v])*2)
				--print(this.neurons[i][v+table.sum(layerTable, i-1)])
			end
		end
		return this.neurons[#layerTable]
	end
	--draw Neurons
	function this.draw(creature)
		this.evaluate(creature)
		for i=1,#layerTable do --draw one layer of neruons
			local currNeuron=1
			spacing=50
			yStart=height/2-((spacing/2)*layerTable[i])
			for v=0,layerTable[i]-1 do --draw one neuron
				local greyValue=this.neurons[i][currNeuron]*255
				love.graphics.setColor(greyValue, greyValue, greyValue)
				love.graphics.circle("fill", 50+i*100, yStart+v*spacing, 20)
				love.graphics.setColor(255, 255, 255)
				if i==1 or i==#layerTable then
					love.graphics.print(this.neurons[i][currNeuron], 100+i*100, yStart+v*spacing)
				end
				currNeuron=currNeuron+1	
			end
		end
		--draw Genes
		for geneLayer=1, #creature.genes do --draw 1 layer of genes
			for i=1,#creature.genes[geneLayer] do -- draw one gene
				local x1=50+geneLayer*100
				local y1=math.floor((i-1)/layerTable[geneLayer+1])
				local x2=150+geneLayer*100
				local y2=((i-1)% layerTable[geneLayer+1])
				y1=(height/2-((spacing/2)*layerTable[geneLayer  ])) + y1*spacing
				y2=(height/2-((spacing/2)*layerTable[geneLayer+1])) + y2*spacing
				if creature.genes[geneLayer][i]>0 then
					love.graphics.setColor(0, 255, 0,100)
				else 
					love.graphics.setColor(255, 0, 0,100)
				end
				love.graphics.setLineWidth(math.abs(creature.genes[geneLayer][i])*4)
				love.graphics.line(x1, y1, x2, y2)
			end
		end
	end
	return this
end