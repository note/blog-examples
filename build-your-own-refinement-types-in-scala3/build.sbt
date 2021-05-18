import Common._

lazy val root = (project in file("."))
  .commonSettings("build-your-own-refinement-types-in-scala3", "0.1.0")
  .settings(
    libraryDependencies ++= Dependencies.compileDeps ++ Dependencies.testDeps
  )
