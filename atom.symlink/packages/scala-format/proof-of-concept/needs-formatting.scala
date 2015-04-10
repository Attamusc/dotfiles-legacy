package scalariform.commandline

import java.io.File
import java.util.{ ArrayList, Collection }
import scala.collection.JavaConversions._
import scala.collection.mutable.Buffer

import org.apache.commons.io._
import org.apache.commons.io.filefilter._

object ScalaFileWalker extends DirectoryWalker(TrueFileFilter.INSTANCE, FileFilterUtils.suffixFileFilter(".scala"), -1) {

  def findScalaFiles(path: String): List[File] = findScalaFiles(new File(path))

  def findScalaFiles(path: File): List[File] = {
//This block should be indented by scalariform
val results = new ArrayList[File]
walk(path, results)
results.toList
  }

}
