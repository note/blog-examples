package iteration3

import iteration3.Pred.StringLeaf

sealed trait Pred

object Pred:
  class And[A <: Pred, B <: Pred]              extends Pred
  abstract class IntLeaf                       extends Pred
  class LowerThan[T <: Int & Singleton]        extends IntLeaf
  class GreaterThan[T <: Int & Singleton]      extends IntLeaf
  abstract class StringLeaf                    extends Pred
  class StartsWith[T <: String & Singleton]    extends StringLeaf
  class EndsWith[T <: String & Singleton]      extends StringLeaf

