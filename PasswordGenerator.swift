#!/usr/bin/env swift -F Rome -lRandomStringGeneration -L RandomStringGeneration -I RandomStringGeneration -target x86_64-apple-macosx10.13

import RandomStringGeneration
import Commander

command(
  Argument<String>("type", description: "Choose pseudo, atmospheric or safari"),
  Option("length", 12, description: "The length of the passwords to generate"),
  Option("count", 5, description: "The number of passwords to generate")
) { (type, length, count) in
  let generator: RandomStringGenerator
  switch type {
  case "safari":
    generator = SafariPasswordGenerator(count: count)
  case "atmospheric":
    generator = AtmosphericNoisePasswordGenerator(length: length, count: count)
  default:
    generator = PseudoRandomPasswordGenerator(length: length, count: count)
  }
  print(generator.generate().joined(separator: "\n"))
}.run()
