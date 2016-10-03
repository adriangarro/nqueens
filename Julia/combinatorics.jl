# combinatorics.jl: Combinatorial functions.

# (c) E. Adrian Garro S. Costa Rica Institute of Technology.

"""
`combinations_of_2(xs)`
Combinations of 2 without repeated elements.
"""
function combinations_of_2(xs)
	xs_len = length(xs)
	for i = 1:xs_len
		for j = i+1:xs_len
			produce(
				(xs[i], xs[j])
			)
		end
	end
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
