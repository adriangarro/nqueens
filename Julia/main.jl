# User interaction with N Queens Problem.

# (c) E. Adrian Garro S. Costa Rica Institute of Technology.

include("nqueens.jl")

"""
`input(prompt::AbstractString="")`

Read a string from STDIN. The trailing newline is stripped.

The prompt string, if given, is printed to standard output without a
trailing newline before reading input.
"""
function input(prompt::AbstractString="")
	print(prompt)
	return chomp(readline())
end

"""
`int_input(prompt::AbstractString="")`

Use input function to get integers from user.
"""
function int_input(string_num::AbstractString)
	possible_int = input(string_num)
	parse(Int, possible_int)
end
		
function main()
	options = ["1", "2"]
	# create problem with default values
	problem = NQueens(0, [], 0)
	while true
		println("\n")
		println("--------(N Queens Problem)---------")
		println("---------------Menu----------------")
		println("    	1) Input problem.")
	    println("    	2) See solutions.")
		println("    	0) End.")
		println("----------------------------------")
		choice = input("Select an option to continue: ")
		if choice in options
			if choice == "1"
				try
					queens_quant = int_input(
						"Please write the number of queens: "
					)
					try 
						set_queens_quant!(problem, queens_quant)
						solve!(problem)
					catch e
						println(e)
					end
				catch e
					println(e)
				end
			end
			if choice == "2"
				solutions_num = problem.solutions_num
				if solutions_num != 0
					try
						println("The number of solutions for this problem are: ", solutions_num)
						solution_num = int_input(
							"Please write the number of the solution you want to see: "
						)
						try
							print_solution(problem, solution_num)
						catch e
							println(e)
						end
					catch e
						println(e)
					end
				else
					print("See solutions is not avaible.")
				end
			end
		elseif choice == "0"
			println("Thank you for your time. ;)")
			return
		else
			println("Pick a valid option from menu!")
		end
	end
end

main()
