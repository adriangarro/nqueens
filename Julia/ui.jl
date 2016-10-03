# User interaction with N Queens Problem.

# (c) E. Adrian Garro S. Costa Rica Institute of Technology.

include("nqueens.jl")

type UI
	option::String
	problem::NQueens
end

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

function read_option(app::UI)
	println("")
	println("--------(N Queens Problem)---------")
	println("    	1) Input problem.")
	println("    	2) See solutions.")
	println("    	0) End.")
	println("----------------------------------")
	println("")
	app.option = input("Select an option to continue: ")
end

function input_problem(app::UI)
	try
		queens_quant = int_input(
			"Please write the number of queens: "
		)
		try 
			set_queens_quant!(app.problem, queens_quant)
			solve!(app.problem)
			println("Problem solve! Please see the solutions :)")
		catch e
			println(e)
		end
	catch e
		println(e)
	end
end

function see_solutions(app::UI)
	solutions_num = app.problem.solutions_num
	if solutions_num != 0
		try
			println("The number of solutions for this problem are: ", solutions_num)
			solution_num = int_input(
				"Please write the number of the solution you want to see: "
			)
			try
				print_solution(app.problem, solution_num)
			catch e
				println(e)
			end
		catch e
			println(e)
		end
	else
		println("See solutions is not available.")
	end
end

function menu(app::UI)
	if app.option == ""
		true
	elseif app.option == "1"
		input_problem(app::UI)
		true
	elseif app.option == "2"
		see_solutions(app::UI)
		true
	elseif app.option == "0"
		println("Thank you for your time. ;)")
		false
	else
		println("Pick a valid option from menu!")
		true
	end
end
	
function main()
	app = UI("", NQueens(0, [], 0))
	while menu(app::UI)
		read_option(app::UI)
	end
end

main()
