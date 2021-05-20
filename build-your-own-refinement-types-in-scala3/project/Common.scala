import com.softwaremill.SbtSoftwareMillCommon.autoImport.commonSmlBuildSettings
import org.scalafmt.sbt.ScalafmtPlugin.autoImport.scalafmtOnCompile
import sbt.Keys._
import sbt.{Project, TestFramework}

object Common {
  implicit class ProjectFrom(project: Project) {
    def commonSettings(nameArg: String, versionArg: String): Project = project.settings(
      name := nameArg,
      organization := "pl.msitko",
      version := versionArg,

      scalaVersion := "3.0.0",
      // Uncomment when scalafmt for scala 3 released: https://github.com/scalameta/scalafmt/issues/2216
      // scalafmtOnCompile := true,

      commonSmlBuildSettings,
      testFrameworks += new TestFramework("munit.Framework")
    )
  }
}
