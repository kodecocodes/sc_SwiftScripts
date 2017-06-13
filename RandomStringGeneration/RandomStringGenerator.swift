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
