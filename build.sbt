ThisBuild / name := "<your project name>"
ThisBuild / organization := "<your organization>"
ThisBuild / scalaVersion := "2.13.8"

ThisBuild / libraryDependencies ++= Seq(
    "org.scalatest" %% "scalatest" % "3.2.11"
    , "org.scalacheck" %% "scalacheck" % "1.16.0" 
  )

ThisBuild / scalacOptions ++= Seq(
    "-deprecation"
  , "-encoding", "UTF-8" // yes, this is 2 args!
  , "-feature"
  , "-language:existentials"
  , "-language:higherKinds"
  , "-language:implicitConversions"
  , "-unchecked"
  , "-Xfatal-warnings"
  , "-Xlint"
  // , "-Yno-adapted-args"
  , "-Ywarn-dead-code"
  , "-Ywarn-numeric-widen"
  , "-Ywarn-value-discard"
  , "-Xfuture"
  , "-Yno-predef" // no automatic import of Predef (remove irritating implicits) // comment if this causes too much hassle!
)
