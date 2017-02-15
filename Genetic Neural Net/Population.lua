function Population(target, mutationRate, popmax)
	-- body
	local this={}
	this.target=target
	this.mutationRate=mutationRate
	this.popmax=popmax
	this.population={}
	for i=1,popmax do
		this.population[i]=DNA()
	end
	this.best=1
	function this.calcFitness()
		for i=1,#this.population do
			local outputs=neurons.evaluate(this.population[i])
			this.population[i].fitness=math.dist(this.target, outputs)
			local oldBest=this.best
			if this.population[i].fitness<this.population[this.best].fitness then
				this.best=i
			end
			
			if oldBest>this.best then 
				print(this.population[i].fitness)
			end
		end
	end


	function this.selection()
		local pool={}
		for i=1,#this.population do
			local quality=1/this.population[i].fitness
			for justIterating=0,quality do
				table.insert(pool, this.population[i])--weight the likelyness of creatures picked exponentialy by their fitness
			end
		end
		print(#pool)
		table.sort(this.population, function(a, b) return a.fitness<b.fitness end)
		for v=popmax/2,popmax do--generate new generation.
			this.population[v]=pool[math.random(1,#pool)].crossover(pool[math.random(1,#pool)])
		end
	end

	return this
end