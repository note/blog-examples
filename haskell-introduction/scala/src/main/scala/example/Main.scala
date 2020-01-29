package example

import java.nio.file.Paths

import example.entities.{Activity, Comment}
import io.circe.syntax._
import io.circe.jawn.parseFile
import example.entities.Activity._

object Main {
  def main(args: Array[String]): Unit = {
    val commentsRes = for {
      json <- parseFile(Paths.get("../input.json").toFile)
      activities  <- json.as[List[Activity]]
      comments    = activities.collect {
        // we are interested only in comments but as Activity instances so the JSON output is "polymorphic"
        case c: Comment => c: Activity
      }
    } yield comments

    commentsRes match {
      case Right(comments) => println(comments.asJson.spaces2)
      case Left(e)         => println(s"Something went wrong: $e")
    }
  }
}
