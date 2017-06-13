#!/usr/bin/env swift

import Foundation

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
    generatorType = .pseudoRandom
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


