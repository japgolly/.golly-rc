//enablePlugins(net.virtualvoid.sbt.graph.DependencyGraphPlugin)

//import com.timushev.sbt.updates.UpdatesPlugin.autoImport._
//def regexFilter(r: String) = new PatternFilter(r.r.pattern)
//dependencyUpdatesFilter -= moduleFilter(name = regexFilter("^jetty-(server|websocket)$"))
//dependencyUpdatesFilter -= moduleFilter(organization = "org.scala-lang")
//dependencyUpdatesFilter -= moduleFilter(name = "utest")

Global / onChangedBuildSource := IgnoreSourceChanges

triggeredMessage := Watched.clearWhenTriggered

addCommandAlias("/"  , "project root")
addCommandAlias("PL" , "root/publishLocal")
addCommandAlias("CPL", ";root/clean;root/publishLocal")
addCommandAlias("p"  , "project")

addCommandAlias("C"  , "root/compile")
addCommandAlias("TC" , "root/test:compile")
addCommandAlias("T"  , "root/test")
addCommandAlias("TO" , "root/testOnly")
addCommandAlias("TQ" , "root/testQuick")
addCommandAlias("CC" , ";root/clean;root/compile")
addCommandAlias("CTC", ";root/clean;root/test:compile")
addCommandAlias("CT" , ";root/clean;root/test")
addCommandAlias("SF" , "root/scalafixAll")

addCommandAlias("c"  , "compile")
addCommandAlias("tc" , "test:compile")
addCommandAlias("t"  , "test")
addCommandAlias("to" , "testOnly")
addCommandAlias("tq" , "testQuick")
addCommandAlias("cc" , ";clean;compile")
addCommandAlias("ctc", ";clean;test:compile")
addCommandAlias("ct" , ";clean;test")
addCommandAlias("sf" , "scalafixAll")

addCommandAlias("SLOWEST" , "root/testOnly * -- --report-slowest")
addCommandAlias("slowest" , "testOnly * -- --report-slowest")

// See https://github.com/rtimush/sbt-updates#usage-as-project-plugin
addCommandAlias("deps", ";dependencyUpdates; reload plugins; dependencyUpdates; reload return")

//logLevel in Global in update := Level.Warn

import scala.concurrent.duration._
ThisBuild / watchAntiEntropy := 500.millis
ThisBuild / watchDeletionQuarantinePeriod := 500.milliseconds
ThisBuild / watchBeforeCommand := Watch.clearScreen

Global / evictionWarningOptions := EvictionWarningOptions.empty
// Global / excludeLintKeys += mainClass
// ThisBuild / usePipelining := true

