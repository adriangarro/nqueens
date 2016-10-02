package NQueens

/**
  * Created by Elberth Adrián Garro Sánchez on 1/10/16.
  */
object NQueens {
	var queensQuant: Int = 0
	var solutions: List[List[Int]] = List(Nil)
	var solutionsNum: Int = 0

	def setQueensQuant(quant: Int): Unit = {
		if (quant > 3)
			queensQuant = quant
		else
			throw new Exception("Invalid number for N Queens problem.")
	}

	/**
      * Checks if a pair of queens are in the same diagonal.
      */
	def inDiag(queensRows: (Int, Int), queensCols: (Int, Int)) = {
		val (queen1Row, queen2Row) = queensRows
		val (queen1Col, queen2Col) = queensCols
		val inDiag45: Boolean = queen1Row - queen1Col == queen2Row - queen2Col
		val inDiag135: Boolean = queen1Row + queen1Col == queen2Row + queen2Col
		inDiag45 || inDiag135
	}

	/**
      * Check if a list of queens in a chessboard attack each other.
      * Example: (1, 3, 0, 2) has to return false.
      *          (0, 1, 3, 2) has to return true.
      */
	def attack(queensCols: List[Int]): Boolean =  queensCols match {
		case Nil => false
		case queenCol::Nil => false
		case _ =>
			val queensPos = queensCols.zipWithIndex
			val queensPosMap = queensPos.toMap
			def rowOf(col: Int) = queensPosMap.getOrElse(col, -1)
			def toRows(cols: (Int, Int)) = {
				val (col1, col2) = cols
				(rowOf(col1), rowOf(col2))
			}
			val pairsOfCols = Combinatorics.combinationsOfTwo(queensCols)
			val possibleAttacks = for (pairOfCols <- pairsOfCols) yield {
				inDiag(pairOfCols, toRows(pairOfCols))
			}
			possibleAttacks.contains(true)
    }

	/**
	  * Checks if a list of queens in a chessboard not attack each other.
	  */
	def notAttack(queensCols: List[Int]): Boolean = {
		!attack(queensCols)
	}

	/**
	  * Solves the N Queens Problem for a given quantity of queens.
	  */
	def solve(): Unit = {
		if (queensQuant != 0) {
			val initQueensCols = 0 until queensQuant
			val allPossibleQueensCols = Combinatorics.permutations(initQueensCols)
			val solutionsIterator = allPossibleQueensCols.filter(notAttack)
			solutions = solutionsIterator.toList
			solutionsNum = solutions.length
		}
		else
			throw new Exception("Number of queens not available.")
	}

	/**
	  * Print a specific solution.
	  */
	def printSolution(solutionNum: Int) = {
		if ((1 to solutionsNum).contains(solutionNum)) {
			val solution = solutions(solutionNum-1)
			def createBox(queenPos: Int): String = (
				"\n|"
				+ "   |" * queenPos
				+ " X |"
				+ "   |" * (queensQuant - (queenPos + 1))
			)
			val boxes = for (queensCols <- solution.iterator) yield {
				createBox(queensCols)
			}
			val chain = "\n+" + "---+" * queensQuant
			val chessboard = chain + boxes.mkString(chain) + chain
			println("\nSolution #" + solutionNum)
			println(chessboard)
		}
		else
			throw new Exception("Solution not exist.")

	}
}
