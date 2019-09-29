package pl.msitko

object Main {
  def main(args: Array[String]): Unit = {
    println(s"readFromFilesystem: ${Reader.readFromFilesystem}")
    println(s"readAsResource: ${Reader.readAsResource}")
  }
}
