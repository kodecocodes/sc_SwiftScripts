#!/usr/bin/env swift -F Rome -lRandomStringGeneration -L RandomStringGeneration -I RandomStringGeneration -target x86_64-apple-macosx10.13

import RandomStringGeneration
import Commander

dump(CommandLine.arguments)

var count = 1
var length = 15
var safariGenerator = false

for argument in CommandLine.arguments {
  if argument.starts(with: "--length=") {
    length = Int(argument.substring(from: "--length=".endIndex)) ?? length
  } else if argument.starts(with: "--count=") {
    count = Int(argument.substring(from: "--count=".endIndex)) ?? count
  } else if argument == "--safari" {
    safariGenerator = true
  }
}

let generator: RandomStringGenerator

if safariGenerator {
  generator = SafariPasswordGenerator(count: count)
} else {
  generator = PseudoRandomPasswordGenerator(length: length, count: count)
}

print(generator.generate().joined(separator: "\n"))


