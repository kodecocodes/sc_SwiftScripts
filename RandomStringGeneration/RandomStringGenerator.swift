import Foundation

public struct UsableCharacters: OptionSet {
  public let rawValue: Int
  
  public static let lowercase = UsableCharacters(rawValue: 1 << 0)
  public static let uppercase = UsableCharacters(rawValue: 1 << 1)
  public static let numbers   = UsableCharacters(rawValue: 1 << 2)
  
  public static let alphanumeric: UsableCharacters = [.lowercase, .uppercase, .numbers]
  
  public init(rawValue: Int) {
    self.rawValue = rawValue
  }

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

public protocol RandomStringGenerator {
  var usableCharacters: UsableCharacters { get }
  var length: Int { get }
  var count: Int { get }
  
  func generate() -> [String]
}
