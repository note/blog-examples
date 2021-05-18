package iteration1

import scala.compiletime.ops.int.*
import scala.compiletime.ops.boolean.*

trait Validated[PredRes <: Boolean]
given Validated[true] = new Validated[true] {}

trait RefinedInt[Predicate[_ <: Int] <: Boolean]
def validate[V <: Int, Predicate[_ <: Int] <: Boolean]
    (using Validated[Predicate[V]]): RefinedInt[Predicate] = new RefinedInt {}

object Demo:
  // Above structure is enough to write this:
  type LowerThan10[V <: Int] = V < 10
  val lowerThan10T: RefinedInt[LowerThan10] = validate[4, LowerThan10]

  // Equivalent with type lambdas:
  val lowerThan10: RefinedInt[[V <: Int] =>> V < 10] = validate[4, [V <: Int] =>> V < 10]

  // We can write more complex predicates:
  validate[7, [V <: Int] =>> V > 5 && V < 10]

  // The following will not compile:
  // validate[4, [V <: Int] =>> V < 10 && V > 6](4)
  // no implicit argument of type iteration1.Validated[(false : Boolean)] was found for parameter x$2 of method validate in package iteration1
  // L25:   validate[4, [V <: Int] =>> V < 10 && V > 6](4)
