package NQueens

/**
  * Created by Elberth Adrián Garro Sánchez on 1/10/16.
  */
object NQueens {
	var queensQuant: Int = 0
	var solutions: List[List[Int]] = List(Nil)
	var solutionsNum: Int = 0

	/**
	  * Finds all permutations on a given seq
	  * without repeated elements.
	  */
	def permutations[T](xs: Seq[T]): Iterator[List[T]] = xs match {
		case Nil => Iterator(Nil)
		case _ => for (x <- xs.iterator; ys <- permutations(xs.filter(_ != x))) yield x :: ys
	}

	def setQueensQuant(quant: Int): Unit = {
		if (quant > 3)
			queensQuant = quant
		else
			throw new Exception("Invalid number for N Queens problem.")
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
			val sumOfPos = for (pos <- queensPos) yield {
				// row + col
				pos._2 + pos._1
			}
			val diffOfPos = for (pos <- queensPos) yield {
				// row - col
				pos._2 - pos._1
			}
			// all results are different?
			val inDiag45 = sumOfPos.size > sumOfPos.toSet.size
			val inDiag135 = diffOfPos.size > diffOfPos.toSet.size
			inDiag45 || inDiag135
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
			val allPossibleQueensCols = permutations(initQueensCols)
			val solutionsIterator = allPossibleQueensCols.filter(notAttack)
			solutions = solutionsIterator.toList
			solutionsNum = solutions.size
		}
		else
			throw new Exception("Number of queens not available.")
	}

	/**
	  * Print a specific solution.
	  */
	def printSolution(solutionNum: Int) = {
		if ((1 to solutionsNum).contains(solutionNum)) {
			val solution = solutions(solutionNum - 1)
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
