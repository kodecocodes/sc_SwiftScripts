import Foundation

public struct PseudoRandomPasswordGenerator: RandomStringGenerator {
  public var usableCharacters: UsableCharacters
  public var length: Int
  public var count: Int
  
  public init(length: Int, usableCharacters: UsableCharacters = .alphanumeric, count: Int = 1) {
    self.length = length
    self.usableCharacters = usableCharacters
    self.count = count
  }
  
  public func generate() -> [String] {
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
