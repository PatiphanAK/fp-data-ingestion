name := "DataIngestionMaster"
version := "1.0"
scalaVersion := "2.13.16"

val sparkVersion = "4.0.1"

libraryDependencies ++= Seq(
  "org.apache.spark" %% "spark-core" % sparkVersion,
  "org.apache.spark" %% "spark-sql"  % sparkVersion,
  "org.scalatest" %% "scalatest" % "3.2.18" % Test
)

run / fork := true

run / javaOptions ++= Seq(
  "--add-opens=java.base/sun.nio.ch=ALL-UNNAMED",
  "--add-opens=java.base/java.nio=ALL-UNNAMED",
  "-Dlog4j.configuration=log4j2.properties"
)

run / outputStrategy := Some(StdoutOutput)
