import xerial.sbt.Sonatype.autoImport._
sonatypeProfileName := "com.github.japgolly"

enablePlugins(net.virtualvoid.sbt.graph.DependencyGraphPlugin)

import com.timushev.sbt.updates.UpdatesPlugin.autoImport._
def regexFilter(r: String) = new PatternFilter(r.r.pattern)
dependencyUpdatesFilter -= moduleFilter(name = regexFilter("^jetty-(server|websocket)$"))
//dependencyUpdatesFilter -= moduleFilter(organization = regexFilter("^org.scala-lang$"))

triggeredMessage := Watched.clearWhenTriggered

addCommandAlias("/"  , "project root")
addCommandAlias("C"  , "root/clean")
addCommandAlias("L"  , "root/publishLocal")
addCommandAlias("c"  , "compile")
addCommandAlias("tc" , "test:compile")
addCommandAlias("t"  , "test")
addCommandAlias("to" , "testOnly")
addCommandAlias("tq" , "testQuick")
addCommandAlias("cc" , ";clean;compile")
addCommandAlias("ctc", ";clean;test:compile")
addCommandAlias("ct" , ";clean;test")

//logLevel in Global in update := Level.Warn

// https://github.com/coursier/coursier/issues/450
import coursier.Keys._
classpathTypes += "maven-plugin"
