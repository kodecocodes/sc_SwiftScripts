#!/usr/bin/env swift

import Foundation

struct UsableCharacters: OptionSet {
  let rawValue: Int
  
  static let lowercase = UsableCharacters(rawValue: 1 << 0)
  static let uppercase = UsableCharacters(rawValue: 1 << 1)
  static let numbers   = UsableCharacters(rawValue: 1 << 2)
  
  static let alphanumeric: UsableCharacters = [.lowercase, .uppercase, .numbers]
  
  var characterSet: Set<Character> {
    var characterSet = Set<Character>()
    if contains(.lowercase) {
      characterSet.formUnion("qwertyuiopasdfghjklzxcvbnm")
    }
    if contains(.uppercase) {
      characterSet.formUnion("QWERTYUIOPASDFGHJKLZXCVBNM")
    }
    if contains(.numbers) {
      characterSet.formUnion("1234567890")
    }
    return characterSet
  }
}

protocol RandomStringGenerator {
  var usableCharacters: UsableCharacters { get }
  var length: Int { get }
  var count: Int { get }
  
  func generate() -> [String]
}

struct PseudoRandomPasswordGenerator: RandomStringGenerator {
  var usableCharacters: UsableCharacters
  var length: Int
  var count: Int
  
  init(length: Int, usableCharacters: UsableCharacters = .alphanumeric, count: Int = 1) {
    self.length = length
    self.usableCharacters = usableCharacters
    self.count = count
  }
  
  func generate() -> [String] {
    return (0 ..< count).map { _ in generateSingle() }
  }
  
  private func generateSingle() -> String {
    let characters = Array(usableCharacters.characterSet)
    
    let result = (0 ..< length).map { _ in
      characters[Int(arc4random_uniform(UInt32(characters.count)))]
    }
    
    return String(result)
  }
}

struct SafariPasswordGenerator: RandomStringGenerator {
  let usableCharacters: UsableCharacters = .alphanumeric
  let length: Int = 12
  var count: Int
  
  init(count: Int = 1) {
    self.count = count
  }
  
  func generate() -> [String] {
    let generator = PseudoRandomPasswordGenerator(length: 3, usableCharacters: usableCharacters, count: length / 3)
    return (0 ..< count).map { _ in
      generator.generate().joined(separator: "-")
    }
  }
}

var count: Int = 1
var length: Int = 15
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

let passwords = generator.generate()

print(passwords.joined(separator: "\n"))


