scalaVersion := "2.13.1"

name := "read-resource"
version := "1.0"

libraryDependencies ++= Seq(
  "com.github.tototoshi" %% "scala-csv" % "1.3.6",
  "org.scalatest" %% "scalatest" % "3.0.8" % Test
)
