import xerial.sbt.Sonatype.autoImport._
sonatypeProfileName := "com.github.japgolly"

enablePlugins(net.virtualvoid.sbt.graph.DependencyGraphPlugin)

import com.timushev.sbt.updates.UpdatesPlugin.autoImport._
def regexFilter(r: String) = new PatternFilter(r.r.pattern)
dependencyUpdatesFilter -= moduleFilter(name = regexFilter("^jetty-(server|websocket)$"))
//dependencyUpdatesFilter -= moduleFilter(organization = regexFilter("^org.scala-lang$"))

triggeredMessage := Watched.clearWhenTriggered

addCommandAlias("c"  , "compile")
addCommandAlias("tc" , "test:compile")
addCommandAlias("t"  , "test")
addCommandAlias("to" , "test-only")
addCommandAlias("tq" , "testQuick")
addCommandAlias("cc" , ";clean;compile")
addCommandAlias("ctc", ";clean;test:compile")
addCommandAlias("ct" , ";clean;test")

//logLevel in Global in update := Level.Warn

// libraryDependencies += "com.lihaoyi" % "ammonite" % "0.8.1" % "test" cross CrossVersion.full

// initialCommands in (Test, console) := """ammonite.Main().run()"""

//import com.softwaremill.clippy.ClippySbtPlugin._ // needed in global configuration only
//clippyColorsEnabled := true
