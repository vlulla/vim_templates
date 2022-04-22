ThisBuild / organization := "<your organization>"
ThisBuild / scalaVersion := "3.1.2"

val scalatest = "org.scalatest" %% "scalatest" % "3.2.11"
val scalacheck = "org.scalacheck" %% "scalacheck" % "1.16.0"

ThisBuild / libraryDependencies ++= Seq( scalatest, scalacheck )

ThisBuild / scalacOptions ++= Seq(
    "-deprecation"                       // Emit warning and location for usages of deprecated APIs.
  , "-encoding", "utf-8"                 // Specify character encoding used by source files.
  , "-explaintypes"                      // Explain type errors in more detail.
  , "-feature"                           // Emit warning and location for usages of features that should be imported explicitly.
  , "-language:existentials"             // Existential types (besides wildcard types) can be written and inferred
  , "-language:experimental.macros"      // Allow macro definition (besides implementation and application)
  , "-language:higherKinds"              // Allow higher-kinded types
  , "-language:implicitConversions"      // Allow definition of implicit functions called views
  , "-unchecked"                         // Enable additional warnings where generated code depends on assumptions.
  , "-Xfatal-warnings"                   // Fail the compilation if there are any warnings.
  // , "-Xlint:by-name-right-associative"   // By-name parameter of right associative operator.
  // , "-Xlint:nullary-override"            // Warn when non-nullary `def f()' overrides nullary `def f'.
  // , "-Xlint:unsound-match"               // Pattern match may not be typesafe.
  // , "-Yno-adapted-args"                  // Do not adapt an argument list (either by inserting () or creating a tuple) to match the receiver.
  // , "-Ypartial-unification"              // Enable partial unification in type constructor inference
  // , "-Ywarn-inaccessible"                // Warn about inaccessible types in method signatures.
  // , "-Ywarn-infer-any"                   // Warn when a type argument is inferred to be `Any`.
  // , "-Ywarn-nullary-override"            // Warn when non-nullary `def f()' overrides nullary `def f'.
  // , "-Ywarn-nullary-unit"                // Warn when nullary methods return Unit.
  , "-Yno-predef" // no automatic import of Predef (remove irritating implicits) // comment if this causes too much hassle!
)

Compile / console / scalacOptions ~= (x => x.filterNot(p => List("-Xfatal-warnings", "-Yno-predef", "-Ywarn-unused:imports").contains(p)))

lazy val root = (project in file("."))
  .settings(
    name := "<your project name>"
  )
