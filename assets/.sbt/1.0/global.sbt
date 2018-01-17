import xerial.sbt.Sonatype.autoImport._
sonatypeProfileName := "com.github.japgolly"

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
