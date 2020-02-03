package example

import java.nio.file.Paths

import example.entities.{Activity, Comment}
import io.circe.syntax._
import io.circe.jawn.parseFile
import example.entities.Activity._

object Main {
  def main(args: Array[String]): Unit = {
    val activitiesEither = parseFile(Paths.get("../input.json").toFile).flatMap(_.as[List[Activity]])
    val output = activitiesEither match {
      case Right(activities) => process(activities)
      case Left(e)           => s"Something went wrong: $e"
    }
    println(output)
  }

  def process(activities: List[Activity]): String =
    onlyComments(activities).asJson.spaces2

  def onlyComments(activities: List[Activity]): List[Activity] =
    activities.filter(isComment)

  def isComment(a: Activity): Boolean = a match {
    case Comment(_, _) => true
    case _             => false
  }
}
