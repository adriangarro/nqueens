package NQueens

import scala.io.StdIn

/**
  * Created by Elberth Adrián Garro Sánchez on 1/10/16.
  */
object UI extends App {
	var option = ""
	val problem = NQueens

	def readOption(): Unit = {
		println("""|
		           |--------(N Queens Problem)---------
		           |         1) Input problem.
		           |         2) See solutions.
		           |         0) End.
			       |""".stripMargin
		)
		print("Select an option to continue: ")
		option = StdIn.readLine()
	}

	def inputProblem(): Unit = {
		print("Please write the number of queens: ")
		try {
			val queensQuant: Int = StdIn.readInt()
			try {
				problem.setQueensQuant(queensQuant)
				problem.solve()
			} catch {
				case e: Exception => println(e)
			}
		} catch {
			case e: Exception => println(e)
		}
	}

	def seeSolutions(): Unit = {
		val solutionsNum = problem.solutionsNum
		if (solutionsNum != 0) {
			println("The number of solutions for this problem are: " + solutionsNum)
			print("Please write the number of the solution you want to see: ")
			try {
				val solutionNum: Int = StdIn.readInt()
				try {
					problem.printSolution(solutionNum)
				} catch {
					case e: Exception => println(e)
				}
			} catch {
				case e: Exception => println(e)
			}
		} else println("See solutions is not available.")
	}

	def menu(): Boolean = option match {
		case "1" =>
			inputProblem()
			true
		case "2" =>
			seeSolutions()
			true
		case "0" =>
			println("Thank you for your time. ;)")
			false
		case _ =>
			println("Pick a valid option from menu!")
			true
	}

	do {
		readOption()
	} while (menu())
}
