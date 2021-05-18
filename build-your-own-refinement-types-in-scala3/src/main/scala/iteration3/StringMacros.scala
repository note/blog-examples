package iteration3

import scala.quoted.{Expr, Quotes}

object StringMacros:
  transparent inline def startsWith(inline v: String, inline pred: String): Boolean =
    ${ startsWithCode('v, 'pred)  }

  def startsWithCode(v: Expr[String], pred: Expr[String])(using Quotes): Expr[Boolean] =
    val res = v.valueOrError.startsWith(pred.valueOrError)
    Expr(res)

  transparent inline def endsWith(inline v: String, inline pred: String): Boolean =
    ${ endsWithCode('v, 'pred)  }
  
  def endsWithCode(v: Expr[String], pred: Expr[String])(using Quotes): Expr[Boolean] =
    val res = v.valueOrError.endsWith(pred.valueOrError)
    Expr(res)
