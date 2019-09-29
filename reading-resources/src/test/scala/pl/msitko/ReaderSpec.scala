package pl.msitko

import org.scalatest.{Matchers, WordSpec}

class ReaderSpec extends WordSpec with Matchers {
  "readFromFilesystem" should {
    "work" in {
      Reader.readFromFilesystem should equal (List(
        List("a", "b", "c"),
        List("d", "e", "f")
      ))
    }
  }

  "readAsResource" should {
    "work" in {
      Reader.readAsResource should equal (List(
        List("g", "h", "i"),
        List("j", "k", "l")
      ))
    }
  }
}
