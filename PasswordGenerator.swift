#!/usr/bin/env swift -lRandomStringGeneration -L RandomStringGeneration -I RandomStringGeneration -target x86_64-apple-macosx10.13

import Foundation
import RandomStringGeneration

enum PasswordGeneratorType {
  case pseudoRandom
  case atmospheric
  case safari
}

var count: Int = 1
var length: Int = 15
var generatorType: PasswordGeneratorType = .pseudoRandom

for argument in CommandLine.arguments {
  if argument.starts(with: "--length=") {
    length = Int(argument.substring(from: "--length=".endIndex)) ?? length
  } else if argument.starts(with: "--count=") {
    count = Int(argument.substring(from: "--count=".endIndex)) ?? count
  } else if argument == "--safari" {
    generatorType = .safari
  } else if argument == "--atmospheric" {
    generatorType = .atmospheric
  }
}

var generator: RandomStringGenerator? = nil

switch generatorType {
case .pseudoRandom:
  generator = PseudoRandomPasswordGenerator(length: length, count: count)
case .atmospheric:
  generator = AtmosphericNoisePasswordGenerator(length: length, count: count)
case .safari:
  generator = SafariPasswordGenerator(count: count)
}

let passwords = generator!.generate()

print(passwords.joined(separator: "\n"))


