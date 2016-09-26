# combinatorial.jl: Combinatorial functions.

# (c) E. Adrian Garro S. Costa Rica Institute of Technology.

"""
`combinations_of_2(xs)`
Combinations of 2 without repeated elements.
"""
function combinations_of_2(xs)
	return [(x, y) for x in xs for y in xs if y > x]
end
	
"""
`permutations(xs)`
Permutations without repeated elements.
"""
function permutations(xs)
	if xs == []
		produce(Int[])
	else
		for x in xs
			temp = copy(xs)
			filter!(e -> e != x, temp)
			for ys in @task permutations(temp)
				produce(union(Int[x], ys))
			end
		end
	end
end
