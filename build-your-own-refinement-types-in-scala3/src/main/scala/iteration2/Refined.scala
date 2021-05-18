package iteration2

import scala.compiletime.*
import scala.compiletime.ops.int.*

sealed trait Pred
class And[A <: Pred, B <: Pred] extends Pred
class Leaf extends Pred
class LowerThan[T <: Int & Singleton] extends Leaf
class GreaterThan[T <: Int & Singleton] extends Leaf

trait Validated[E <: Pred]

implicit inline def mkValidated[V <: Int & Singleton, E <: Pred](v: V): Validated[E] =
  inline erasedValue[E] match
    case _: LowerThan[t] =>
      inline if constValue[V] < constValue[t]
        then new Validated[E] {}
        else
          inline val vs = constValue[ToString[V]]
          inline val limit = constValue[ToString[t]]
          error("Validation failed: " + vs + " < " + limit)
    case _: GreaterThan[t] =>
      inline if constValue[V] > constValue[t]
        then new Validated[E] {}
        else
          inline val vs = constValue[ToString[V]]
          inline val limit = constValue[ToString[t]]
          error("Validation failed: " + vs + " > " + limit)
    case _: And[a, b] =>
      inline mkValidated[V, a](v) match
        case _: Validated[_] =>
          inline mkValidated[V, b](v) match
            case _: Validated[_] => new Validated[E] {}


object Demo:
  val a: Validated[LowerThan[10]] = 6
  
  // val x: Validated[LowerThan[10]] = 16 // Validation fails with:
  // Validation failed: 16 < 10

  val b: Validated[GreaterThan[5] And LowerThan[10]] = 6
  // val y: Validated[GreaterThan[5] And LowerThan[10]] = 1 // Validation fails with:
  // Validation failed: 1 > 5
  // val z: Validated[GreaterThan[5] And LowerThan[10]] = 16 // Validation fails with:
  // Validation failed: 16 < 10

