package example.entities

import io.circe.generic.extras.{Configuration, ConfiguredJsonCodec}

@ConfiguredJsonCodec
sealed trait Activity
object Activity {
  implicit val config: Configuration =
    Configuration.default.withDiscriminator("tag")
}

final case class BlogPost(id: Int, title: String, summary: String) extends Activity
final case class Comment(blogPostId: Int, content: String) extends Activity
