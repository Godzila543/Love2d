function newGene()
	return random(-1,1)
end
function DNA()
	local this={}
	this.fitness=0
	this.genes={}
	--generate Genes based on how many layers in the table
	for geneLayer=1,#layerTable-1 do --one layer of genes
		this.genes[geneLayer]={}
		for i=1,layerTable[geneLayer]*layerTable[geneLayer+1] do --individual genes
			table.insert(this.genes[geneLayer], newGene())
		end
	end

	function this.crossover(partner)
		local child=DNA()	

		for i=1,#this.genes do
			for v=1,#this.genes[i] do
				if math.random()<0.5 then
					child.genes[i][v]=this.genes[i][v]
				else
					child.genes[i][v]=partner.genes[i][v]
				end
				if math.random()<population.mutationRate then
					child.genes[i][v]=newGene()
				end
			end
		end
		return child
	end

	return this
end
