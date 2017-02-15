function Population(mutationRate, popmax)
	-- body
	local this={}
	this.mutationRate=mutationRate
	this.popmax=popmax
	this.population={}
	for i=1,popmax do
		this.population[i]=Snake()
	end
	this.best=1
	function this.calcFitness()
		for i=1,#this.population do
			local oldBest=this.best
			if this.population[i].fitness>this.population[this.best].fitness then
				this.best=i
			end
			
			if oldBest<this.best then 
				print(this.population[i].fitness)
			end
		end
	end


	function this.newSnake()
		local pool={}
		for i=1,#this.population do
			local quality=this.population[i].fitness
			for justIterating=0,quality do
				table.insert(pool, this.population[i])--weight the likelyness of creatures picked by their fitness
			end
		end
		print(#pool)
		table.sort(this.population, function(a, b) return a.fitness<b.fitness end)		
		return Snake(pool[math.random(1,#pool)].DNA.crossover(pool[math.random(1,#pool)].DNA))
	end

	return this
end