package pl.msitko

import java.io.{File, InputStreamReader}
import java.net.URI
import java.nio.file.Paths
import java.nio.file.spi.FileSystemProvider

import com.github.tototoshi.csv.CSVReader

import scala.jdk.CollectionConverters._

object Reader {
  def readFromFilesystem: List[List[String]] = {
    CSVReader.open(new File("sample.csv")).all
  }

  def readAsResource: List[List[String]] = {
    val classloader = Thread.currentThread.getContextClassLoader
    val url = classloader.getResource("resource.csv")

    val file = Paths.get(url.toURI).toFile
    CSVReader.open(file).all()
  }

  // second attempt - will also not work when packaged as JAR but in different way than readAsResource
  def readAsResource2: List[List[String]] = {
    val classloader = Thread.currentThread.getContextClassLoader
    val url = classloader.getResource("resource.csv")

    val jarProvider = FileSystemProvider.installedProviders.asScala.toList.filter(_.getScheme == "jar").head
    val jarUrl = new URI("jar:file:/Users/michal/programming/blog-examples/reading-resources/target/scala-2.13/read-resource-assembly-1.0.jar")
    jarProvider.newFileSystem(jarUrl, Map.empty[String, Any].asJava)

    val file = Paths.get(url.toURI).toFile
    CSVReader.open(file).all()
  }

  def readResourceUsingReader: List[List[String]] = {
    val classloader = Thread.currentThread.getContextClassLoader
    val stream = classloader.getResourceAsStream("resource.csv")
    val reader = new InputStreamReader(stream, java.nio.charset.StandardCharsets.UTF_8)
    CSVReader.open(reader).all()
  }

}
