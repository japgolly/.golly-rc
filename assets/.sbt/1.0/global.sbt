import xerial.sbt.Sonatype.autoImport._
sonatypeProfileName := "com.github.japgolly"

enablePlugins(net.virtualvoid.sbt.graph.DependencyGraphPlugin)

import com.timushev.sbt.updates.UpdatesPlugin.autoImport._
def regexFilter(r: String) = new PatternFilter(r.r.pattern)
dependencyUpdatesFilter -= moduleFilter(name = regexFilter("^jetty-(server|websocket)$"))
dependencyUpdatesFilter -= moduleFilter(organization = "org.scala-lang")
dependencyUpdatesFilter -= moduleFilter(name = "utest")

Global / onChangedBuildSource := IgnoreSourceChanges

triggeredMessage := Watched.clearWhenTriggered

addCommandAlias("/"  , "project root")
addCommandAlias("L"  , "root/publishLocal")
addCommandAlias("p"  , "project")

addCommandAlias("C"  , "root/compile")
addCommandAlias("TC" , "root/test:compile")
addCommandAlias("T"  , "root/test")
addCommandAlias("TO" , "root/testOnly")
addCommandAlias("TQ" , "root/testQuick")
addCommandAlias("TS" , "root/testOnly * -- --report-slowest")
addCommandAlias("CC" , ";root/clean;root/compile")
addCommandAlias("CTC", ";root/clean;root/test:compile")
addCommandAlias("CT" , ";root/clean;root/test")

addCommandAlias("c"  , "compile")
addCommandAlias("tc" , "test:compile")
addCommandAlias("t"  , "test")
addCommandAlias("to" , "testOnly")
addCommandAlias("tq" , "testQuick")
addCommandAlias("ts" , "testOnly * -- --report-slowest")
addCommandAlias("cc" , ";clean;compile")
addCommandAlias("ctc", ";clean;test:compile")
addCommandAlias("ct" , ";clean;test")

//logLevel in Global in update := Level.Warn

update / evictionWarningOptions := EvictionWarningOptions.default.withWarnEvictionSummary(false).withWarnScalaVersionEviction(false)

import scala.concurrent.duration._
//ThisBuild / watchAntiEntropy := 1000.millis
ThisBuild / watchBeforeCommand := Watch.clearScreen


