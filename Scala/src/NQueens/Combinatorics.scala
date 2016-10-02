package NQueens

/**
  * Created by Elberth Adrián Garro Sánchez on 1/10/16.
  */
object Combinatorics {
	/**
	  * Finds all combinations of two in a given seq
	  * without repeated elements in increasing order.
	  */
	def combinationsOfTwo(xs: Seq[Int]): Iterator[(Int, Int)] = {
		for (x <- xs.iterator; y <- xs.iterator if y > x) yield (x, y)
	}

	/**
	  * Finds all permutations on a given seq
	  * without repeated elements.
	  */
	def permutations[T](xs: Seq[T]): Iterator[List[T]] = xs match {
		case Nil => Iterator(Nil)
		case _ => for (x <- xs.iterator; ys <- permutations(xs.filter(_ != x))) yield x :: ys
	}
}
