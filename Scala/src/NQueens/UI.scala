package NQueens

import scala.io.StdIn

/**
  * Created by Elberth Adrián Garro Sánchez on 1/10/16.
  */
object UI extends App {
	var option = 0
	val problem = NQueens

	def readOption: Int = {
		println("""|
		           |--------(N Queens Problem)---------
		           |---------------Menu----------------
		           |         1) Input problem.
		           |         2) See solutions.
		           |         0) End.
			       |""".stripMargin
		)
		print("Select an option to continue: ")
		StdIn.readInt()
	}

	def menu(option: Int): Boolean = option match {
		case 1 =>
			print("Please write the number of queens: ")
			val queensQuant: Int = StdIn.readInt()
			problem.setQueensQuant(queensQuant)
			problem.solve()
			true
		case 2 =>
			val solutionsNum = problem.solutionsNum
			println("The number of solutions for this problem are: " + solutionsNum)
			print("Please write the number of the solution you want to see: ")
			val solutionNum: Int = StdIn.readInt()
			problem.printSolution(solutionNum)
			true
		case 0 =>
			println("Thank you for your time. ;)")
			false
		case _ =>
			println("Pick a valid option from menu!")
			true
	}

	do {
		option = readOption
	} while (menu(option))
}
