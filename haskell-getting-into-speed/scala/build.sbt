lazy val circeVersion = "0.12.2"

lazy val root = (project in file("."))
  .settings(
    name := "scala",
    scalaVersion := "2.13.1",
    scalacOptions ++= Seq("-Ymacro-annotations"),
    libraryDependencies ++= Seq(
    	"io.circe" %% "circe-parser" 	        % "0.12.2",
    	"io.circe" %% "circe-generic" 	      % "0.12.2",
      "io.circe" %% "circe-generic-extras" 	% "0.12.2",
	)
)
