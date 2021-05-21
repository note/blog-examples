package iteration3

import scala.compiletime.*
import scala.compiletime.ops.int.*
import scala.quoted.{Expr, Quotes}
import Pred.*

object auto:
  implicit inline def mkValidatedInt[V <: Int & Singleton, E <: Pred](v: V): Refined[V, E] =
    inline if checkPredicateInt[V, E]
    then Refined.unsafeApply(v)
    else error("Validation failed")

  implicit inline def mkValidatedString[V <: String & Singleton, E <: Pred](v: V): Refined[V, E] =
    inline if checkPredicateString[V, E]
    then Refined.unsafeApply(v)
    else error("Validation failed")

  transparent inline def checkPredicateInt[V <: Int & Singleton, E <: Pred]: Boolean =
    inline erasedValue[E] match
      case _: LowerThan[t] =>
        inline if erasedValue[V] < erasedValue[t]
          then true
          else
            error(
              "Validation failed: " + constValue[ToString[V]] + " < " + constValue[ToString[t]]
            ) // ${erasedValue[V].toString} < ${erasedValue[t].toString}
      case _: GreaterThan[t] =>
        inline if erasedValue[V] > erasedValue[t]
          then true
          else error("Validation failed: " + constValue[ToString[V]] + " < " + constValue[ToString[t]])
      case _: And[a, b] =>
        checkPredicateInt[V, a] && checkPredicateInt[V, b]

  transparent inline def checkPredicateString[V <: String & Singleton, E <: Pred]: Boolean =
    inline erasedValue[E] match
      case _: StartsWith[t] =>
        inline if StringMacros.startsWith(constValue[V], constValue[t])
          then true
          else
            inline val v = constValue[V]
            inline val p = constValue[t]
            error("Validation failed: " + v + ".startsWith(" + p + ")")
      case _: EndsWith[t] =>
        inline if StringMacros.endsWith(constValue[V], constValue[t])
        then true
        else
          inline val v = constValue[V]
          inline val p = constValue[t]
          error("Validation failed: " + v + ".endsWith(" + p + ")")
      case _: And[a, b] =>
        checkPredicateString[V, a] && checkPredicateString[V, b]


opaque type Refined[+T, Pred] = T
object Refined:
  // We cannot simply `implicit inline def mk...(): Refined` because inline and opaque types do not compose
  // Read about it here: https://github.com/lampepfl/dotty/issues/6802
  private [iteration3] def unsafeApply[T <: Int & Singleton, E <: Pred](i: T): T Refined E = i
  private [iteration3] def unsafeApply[T <: String & Singleton, E <: Pred](i: T): T Refined E = i

object Demo:
  import auto.*

  val a: String Refined StartsWith["abc"] = "abcd"
  //val x: String Refined StartsWith["abc"] = "bcd" // Validation fails with:
  // Validation failed: bcd.startsWith(abc)

  val b: String Refined And[StartsWith["abc"], EndsWith["xyz"]] = "abcdefxyz"
  // val y: String Refined And[StartsWith["abc"], EndsWith["xyz"]] = "abcdefxy"
  // Validation failed: abcdefxy.endsWith(xyz)

