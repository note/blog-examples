package iteration2

import scala.compiletime.testing.typeCheckErrors

class IntSpec extends munit.FunSuite:
  test("Those should not compile") {
    val errs = typeCheckErrors("val x: Validated[LowerThan[10]] = 16")
    assertEquals(errs.map(_.message), List("Validation failed: 16 < 10"))
  }
  test("Those should compile") {
    val a: Validated[LowerThan[10]] = 6
  }
